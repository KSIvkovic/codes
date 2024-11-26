#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
int min_velicina_reda=3;

struct gomila;
typedef struct gomila* red;

struct gomila
{
	int kapacitet; // najveæi moguæi broj elemenata u gomili 
	int velicina; // trenutan broj elemenata u gomili
	int *el; // tip elemenata u gomili*/
};

red Stvori_rsp(int max_el); 
int JeLiPrazan (red H);
int JeLiPun (red H);
void Ubaci (red H);
int Izbrisi_min (red H);
void Ispis (red H);
void Isprazni (red H);
void Umanji_kljuc (int x, int d, red H);
void Izbrisi (int x, red H);
void Heapsort (red H);

void main()
{
	int max_el=0;
	printf("\nUnesite velicinu gomile (min. 3): ");
	do{
		scanf("%d", &max_el);
		if(max_el<min_velicina_reda)
			printf("\nPremala velicina! Ponovite unos: ");
	}while (max_el<min_velicina_reda);
	red Q = Stvori_rsp(max_el);

	char c = 0;
	int el, i, d;
	while(c!='k')
	{
		printf("\t\n\nIzbornik");
		printf("\t\n1.Ubaci u gomilu");
		printf("\t\n2.Izbrisi minimum");
		printf("\t\n3.Ispisi gomilu kao red s prioritetom");
		printf("\t\n4.Isprazni gomilu");
		printf("\t\n5.Umanji kljuc nekog cvora");
		printf("\t\n6.Izbrisi neki cvor");
		printf("\t\n7.Ispisi sortirani red");
		
		printf("\t\nk.Kraj");
		printf("\t\n\nIzbor: ");
		scanf(" %c", &c);
		printf("\n");

		switch(c)
		{
		case '1':
			Ubaci(Q);
			break;
		case '2':
			el=Izbrisi_min(Q);
			if(el!=0)
				printf("\nMinimum %d je obrisan iz gomile.", el);
			break;
		case '3':
			Ispis(Q);
			break;
		case '4':
			Isprazni(Q);
			break;
		case '5':
			printf("\nUpisite broj cvora ciji kljuc zelite umanjiti: ");
			scanf("%d", &i);
			printf("\nZa koliko zelite umanjiti? : ");
			scanf("%d", &d);
			Umanji_kljuc(i, d, Q);
			break;
		case '6':
			printf("\nUnesite broj cvora koji zelite izbrisati: ");
			scanf("%d", &i);
			Izbrisi(i, Q);
			break;
		case '7': 
			Heapsort(Q); //funkcija sortira red, èime se gubi svojstvo prioriteta i uništava gomila
			break;

		default:
			printf("\nKrivi unos! Unesite ponovno.");
			break;
		}
	}
}

red Stvori_rsp(int max_el)
{
	red H;
	H = (red) malloc (sizeof (struct gomila));

	if(H == NULL)
		printf("\nNema dovoljno slobodnog prostora!");
	H->el = (int *) malloc(( max_el+1) * sizeof (int));// Alociraj polja za elemente + 1 za stražara

	if(H->el == NULL)
		printf("\nNema dovoljno slobodnog prostora!");
	H->kapacitet = max_el;
	H->velicina = 0;
	H->el[0] = NULL;//polje stražar (sentinel)
	return H;
}

int JeLiPrazan (red H)
{
	if(H->velicina == 0) // sadrži li gomila ikoji element
		return 1;
	else
		return 0;
}

int JeLiPun (red H)
{
	if(H->velicina == H->kapacitet) // je li gomila potpuno popunjena
		return 1;
	else
		return 0;
}

void Ubaci (red H){
	int i, x;
	if(JeLiPun(H))
	{
		printf("\nGomila je puna i ne mogu se dodavati novi elementi!");
		return;
	}

	printf("\nUnesite element za ubacivanje u gomilu: ");
			scanf("%d", &x);

	for(i=++H->velicina; H->el[i/2]>x; i /= 2) //petlja traži odgovarajuæe mjesto za unos novog elementa
		H->el[i] = H->el[i/2];
	H->el[i] = x; // novi element se unosi na pronaðeno mjesto
}

void Ispis (red H)
{
	if(JeLiPrazan(H))
	{
		printf("\nGomila je prazna i nema elemenata za ispis!");
		return;
	}

	for(int i=1; i<=H->velicina; i++)//slijedni ispis reda s prioritetom
		printf(" %d", H->el[i]);
}

int Izbrisi_min (red H)
{
	int i, dijete, minEl, zadnjiEl;

	if(JeLiPrazan(H))
	{
		printf("\nGomila je prazna i ne moze se skidati element!");
		return 0;
	}

	minEl = H->el[1];
	zadnjiEl = H->el[H->velicina--];

	for(i = 1; i*2 <= H->velicina; i = dijete)
	{
		// Nadji manje dijete
		dijete = i*2;
		if(dijete != H->velicina && H->el[dijete+1] < H->el[dijete])
			dijete++;

		if(zadnjiEl > H->el[dijete]) // zadnji element se pomièe prema gore dok se ne pronaðe odgovarajuæe mjesto
			H->el[i] = H->el[dijete];
		else
			break;
	}

	H->el[i] = zadnjiEl;//zadnji element se premješta na pronaðeno mjesto
	return minEl;
}

void Isprazni (red H)
{
	if(JeLiPrazan(H))
	{
		printf("\nGomila je vec prazna!");
		return;
	}

	int r;
	for(int i=H->velicina; i>0; i--)//poziva se brisanje minimuma onoliko puta koliko gomila sadrži elemenata
		r=Izbrisi_min(H);
	printf("\nGomila je ispraznjena.");
}

void Umanji_kljuc (int x, int d, red H)
{
	if (H->el[x] < d || x>H->velicina)//ukoliko je kolièina veæa od kljuèa ili element ne postoji
	{
		printf("\nUmanjivanje bi dalo negativnu vrijednost!");
		return;
	}

	H->el[x] -= d; // umanjuje vrijednost cvora x za d

	int temp;
	while (x>0)
	{
		int y = x/2; // y odgovara roditelju od x

		if(H->el[x]>H->el[y]) // ako je umanjeni èvor još uvijek veæi od roditelja, prekini izvoðenje
			return;

		//zamjena roditelja s umanjenim èvorom
		temp = H->el[x];
		H->el[x] = H->el[y];
		H->el[y]= temp;

		x = y; //umanjeni èvor postaje roditelj
	}
}

void Izbrisi (int x, red H)
{
	int kljuc=H->el[x];
	Umanji_kljuc(x, H->el[x], H);// umanjuje vrijednost èvora kako bi postao minimum
	int r=Izbrisi_min(H);//element postaje minimum te se briše
	printf("\nCvor %d s kljucem %d je obrisan iz gomile.", x, kljuc);
}

void Heapsort (red H)
{
	int i, r;
	int vel=H->velicina;//pamti inicijalnu velièinu gomile radi ispisa krajnjeg rezultata
	for(i=vel; i>0; i--)
	{
		r=Izbrisi_min(H);
		H->el[i]=r;//izbrisani minimum se ubacuje na upravo osloboðeno mjesto u redu
	}

	H->velicina=vel;
	printf("\nSortirani niz: ");
	Ispis(H);
}

