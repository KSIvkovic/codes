#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

typedef struct cvor *poz;

struct cvor
{
	int el;//vrijednost elementa
	poz lijevi;//lijevo dijete
	poz desni;//desno dijete
	unsigned int npl;//podatak o duljini nultog puta
};

typedef poz red;

red Ispitaj_spoj(red H1, red H2);
red Spoji(red H1, red H2);
red Ubaci(int x, red H);
red Izbrisi_min(red H);
void Zamijeni_djecu(red H);
void Ispis(red H);

void main()
{
	red H1 = NULL;
	red H2 = NULL;
	red H3 = NULL;
	int x;
	char c = 0;
	while(c!='k')
	{
		printf("\nIzbornik:\n");
		printf("\n1-Unos u prvu gomilu");
		printf("\n2-Unos u drugu gomilu");
		printf("\n3-Brisanje minimuma prve gomile");
		printf("\n4-Brisanje minimuma druge gomile");
		printf("\n5-Ispis prve gomile");
		printf("\n6-Ispis druge gomile");
		printf("\n7-Spajanje gomila");
		printf("\n8-Ispis spojene gomile");
		printf("\nk-kraj\n");
		printf("\nIzbor: ");
		scanf(" %c", &c);
		switch(c)
		{
		case '1':
			printf("\nUnesite element: ");
			scanf_s("%d", &x);
			H1=Ubaci(x, H1);
			break;
		case '2':
			printf("\nUnesite element: ");
			scanf_s("%d", &x);
			H2=Ubaci(x, H2);
			break;
		case '3':
			H1=Izbrisi_min(H1);
			break;
		case '4':
			H2=Izbrisi_min(H2);
			break;
		case '5':
			printf("\n");
			Ispis(H1);
			printf("\n");
			break;
		case '6':
			printf("\n");
			Ispis(H2);
			printf("\n");
			break;
		case '7':
			H3=Ispitaj_spoj(H1, H2);
			break;
		case '8':
			printf("\n");
			Ispis(H3);
			printf("\n");
			break;
		default:
			printf("\nKrivi unos! Unesite ponovno.");
			break;
		}
	}
}

red Ispitaj_spoj(red H1, red H2)
{
	if(H1 == NULL)
		return H2;
	if(H2 == NULL)
		return H1;
		
	if(H1->el < H2->el)
		return Spoji(H1, H2);
	else
		return Spoji(H2, H1);
}

red Spoji(red H1, red H2)
{
	if(H1->lijevi == NULL)  // ukoliko lijevo nema djece
		H1->lijevi = H2;     // H1->desni je veæ NULL, H1->npl je veæ 0
	else
	{
		H1->desni = Ispitaj_spoj(H1->desni, H2);// H2 postaje desna podgomila od H1
		
		if(H1->lijevi->npl < H1->desni->npl)//ukoliko na korijenu nije zadovoljeno svojstvo lijeve orijentacije, zamijeni nj djecu
			Zamijeni_djecu(H1);

		H1->npl = H1->desni->npl + 1;
	}

	return H1;
}

red Ubaci(int x, red H)
{
	poz sami_cvor;
	sami_cvor = (poz) malloc(sizeof (struct cvor));//stvara se novi èvor koji se samo poveže u odgovarajuæu gomilu

	if(sami_cvor == NULL)
		printf("\nNema dovoljno prostora!");
	else
	{
		sami_cvor->el = x; sami_cvor->npl = 0;
		sami_cvor->lijevi = sami_cvor->desni = NULL;
		H = Ispitaj_spoj(sami_cvor, H);//spajanje samostalnog èvora s veæom gomilom
	}

	return H;
}

red Izbrisi_min(red H)
{
	int x = H->el;// pamti kljuè minimuma radi ispisa
	red lijeva_gom, desna_gom;
	lijeva_gom = H->lijevi;// poèetna gomila se razbija na lijevu i desnu
	desna_gom = H->desni;
	free(H);//minimum se briše
	printf("\nMinimum s kljucem %d je obrisan", x);
	return Ispitaj_spoj(lijeva_gom, desna_gom);//lijeva i desna gomila se spajaju u novu gomilu
}

void Zamijeni_djecu(red H)
{
	poz temp;
	temp = (poz) malloc(sizeof (struct cvor));

	temp->el=H->desni->el; temp->lijevi=H->desni->lijevi; temp->desni=H->desni->desni; temp->npl=H->desni->npl;
	H->desni->el=H->lijevi->el; H->desni->lijevi=H->lijevi->lijevi; H->desni->desni=H->lijevi->desni; H->desni->npl=H->lijevi->npl;
	H->lijevi->el=temp->el; H->lijevi->lijevi=temp->lijevi; H->lijevi->desni=temp->desni; H->lijevi->npl=temp->npl;
	free(temp);
}

void Ispis(red H)//ispis se vrši rekurzivno, lijevo dijete, pa element, pa desno dijete
{
	if(H!=NULL)
	{
	Ispis(H->lijevi);
	printf("\t%d", H->el);
	Ispis(H->desni);
	}
}