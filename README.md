BASE CONVERTER
	
Proiectul realizeaza transformarea unor numere intregi, pozitive, pe 32 de biti,
intr-o alta baza din intervalul [2, 16]. In cadrul temei au fost folosite doar
registre extended (deoarece toate numerele, atat dimensiunile vectorilor, cat si
vectorii in sine, sunt de tip double word -dd).
	Lucrarea debuteaza cu setarea ecx-ului la 0. Urmeaza eticheta vector_run, ce 
reprezinta trecerea efectiva prin vectorul de numere intregi. La inceput, sunt 
initializate registrele eax, ebx si edx cu 0, dupa care sunt mutate in registrele
 eax si ebx, deimpartitul, respectiv impartitorul, astfel:

	dword [nums_array + 4*ecx]
	dword [base_array + 4*ecx]

    - dword se refera la dimensiunea de double word a valorii;
    - base_array/nums_array sunt vectorii respectivi;
    - 4 este dimensiunea fiecarui element din vector, respectiv 4 bytes;
    - ecx deoarece se porneste de pe pozitia 0 pana la n-1 => n numere.

In continuare, se verifica daca ebx apartine intervalului [2, 16]. Daca nu,
se sare la eticheta not_valid_base, unde se decrementeaza ecx-ul (am scapat de un
element din vector) si se afiseaza mesajul "Baza incorecta". Daca este ultimul
element, se va trece la return, altfel, se va intoarce la vector_run.
	Intrucat sunt doar 4 registre cu care ne putem juca, si trebuie sa vedem
si cate elemente trebuie sa adaugam pe stiva pentru, se efectueaza un push pe
registrul ecx, pentru a tine minte mai incolo la ce pozitie din vector am ajuns.
De acum, vom folosi ecx drept count pentru a stabiliza egalitatea dintre
numarul de pus-uri si numarul de pop-uri.
	Asadar, am intrat in eticheta base_converter in care se face conversia
propriu-zisa a numerelor. Se incepe prin impartirea lui eax la ebx, prin inter-
mediul instructiunii div, se incrementeaza ecx (pentru a sti ca am efectuat
un push), urmand sa-l bagam in stiva pe edx (restul dupa div). Se sterge va-
loarea edx-ului, deoarece am incarcat-o deja pe stiva si este nefolositoare
in continuare + trebuie setata partea high a deimpartitului la 0 pentru o buna
functionare a instructiunii div. Se va trece prin eticheta de convertire atata
timp cat eax este mai mare sau egal decat ebx, practic, pana cand catul impar-
tirii va fi egal cu 0 (inainte de asta). La final, trebuie push-at eax, 
deoarece ultimul cat va fi un rest, fiind mai mic decat baza in care va ajunge.
	Urmeaza sectiunea de pop_and_print, unde se vor scoate din stiva, pe rand,
elementele care au fost adaugate, urmand sa fie printate in ordine inversa, in
format hexazecimal. Printarea va avea loc pana cand ecx-ul va avea valoarea 0.
Asadar, dupa fiecare pereche de pop/print, ecx va fi decrementat cu 1 pentru a
marca o eliminare a unei instructiuni push precedente.
	Dupa eticheta pop_and_print se va executa un NEWLINE, pentru a separa
numerele, dand din nou pop, de data aceasta inapoi in ecx, pentru a relua
vectorul de unde am ramas. Il vom incrementa pentru a sti ca am trecut peste un
element si-l vom compara cu numarul de elemente initial (nums), pentru a sti daca
vom continua sau nu. Daca vom continua, ne intoarcem la vector_run. In caz contrar,
ne ducem la return, unde se va termina programul.

	MENTIUNI/ADAUGARI ULTERIOARE:

- se va face o verificare in vector_run daca deimpartitul va fi mai mare
strict decat impartitorul. In caz contrar, se va trimite pe stiva valoarea
fara a intra in algoritm, deoarece ar aparea cu un 0 inainte (realizata prin
eticheta simple);
	- pentru afisarea cu macro-ul PRINT_CHAR (impus in implementarea temei), 
se va face in pop_and_print o verificare corespunzatoare codului ASCII al
intregilor primiti de pe stiva. In functie de intervalul in care se afla (0-9 sau
a-f), li se vor adauga valorile 48, respectiv 87, urmand sa fie trimisi mai departe
la eticheta just_print;
	- analog pentru simple, deoarece si acolo este necesara utilizarea macro-ului
PRINT_CHAR;
	- (IMPORTANT) Datorita faptului ca numerele mai mari de 2^31 - 1 sunt 
negative, eticheta simple poate fi accesata cand nu este cazul. De aceea, il
vom compara pe eax cu 0 mai intai, si daca este negativ vom trece peste
simple, accesand eticheta nevermind.
	
