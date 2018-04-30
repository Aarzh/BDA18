#include <iostream>
using namespace std;
class Nodo{
	private:
		int *llave;
		int t, n;
		bool hoja;
		Nodo **C;
 
	public:
		Nodo(int _t, bool _hoja);   // Constructor
		void imprimeArbol();
		int getBef(int idx);
		int getAft(int idx);
		void insertaNonFull(int k);
		void splithijo(int i, Nodo *y);
		void merge(int idx);
		void llenaArbol(int idx);
		void PrestaDelAnterior(int idx);
		void borrowFromNext(int idx);
		friend class BTree;
		
};
 
class BTree{
	private:
		Nodo *raiz; // Pointer to raiz node
		int t;  // Minimum degree
	public:
		BTree(int _t){
			raiz = NULL;
			t = _t;
		}
 
		void imprimeArbol(){
			if (raiz != NULL) raiz->imprimeArbol();
		}	
		void inserta(int k);
 
};

void Nodo::merge(int idx){
	Nodo *hijo = C[idx];
	Nodo *compa = C[idx+1];
	hijo->llave[t-1] = llave[idx];
 
	for (int i=0; i<compa->n; ++i)
		hijo->llave[i+t] = compa->llave[i];
		if (!hijo->hoja){
			for(int i=0; i<=compa->n; ++i)
				hijo->C[i+t] = compa->C[i];
		}
 
	for (int i=idx+1; i<n; ++i)
		llave[i-1] = llave[i];
	for (int i=idx+2; i<=n; ++i)
		C[i-1] = C[i];
		hijo->n += compa->n+1;
		n--;
		delete(compa);
		return;
}
 
Nodo::Nodo(int t1, bool hoja1){		
		t = t1;
		hoja = hoja1;
		llave = new int[2*t-1];
		C = new Nodo *[2*t];
		n = 0;
}

int Nodo::getBef(int idx){
	Nodo *cur=C[idx];
	while (!cur->hoja)
		cur = cur->C[cur->n];
	return cur->llave[cur->n-1];
}
 
int Nodo::getAft(int idx){
	Nodo *cur = C[idx+1];
	while (!cur->hoja)
		cur = cur->C[0];
	return cur->llave[0];
}
 
void Nodo::PrestaDelAnterior(int idx){
	Nodo *hijo=C[idx];
	Nodo *compa=C[idx-1];
	for (int i=hijo->n-1; i>=0; --i)
		hijo->llave[i+1] = hijo->llave[i];
		if (!hijo->hoja){
			for(int i=hijo->n; i>=0; --i){
				hijo->C[i+1] = hijo->C[i];
			}
		}
		hijo->llave[0] = llave[idx-1];
		if (!hoja){
			hijo->C[0] = compa->C[compa->n];
		}
		llave[idx-1] = compa->llave[compa->n-1];
		hijo->n += 1;
		compa->n -= 1;
		return;
}
 
void Nodo::llenaArbol(int idx){
	if (idx!=0 && C[idx-1]->n>=t)
		PrestaDelAnterior(idx);
	else if (idx!=n && C[idx+1]->n>=t){
		borrowFromNext(idx);
	}else{
		if (idx != n){
			merge(idx);
		}else{	
			merge(idx-1);
		}
	}
		return;
}

void Nodo::borrowFromNext(int idx){
		Nodo *hijo=C[idx];
		Nodo *compa=C[idx+1];
		hijo->llave[(hijo->n)] = llave[idx];
		if (!(hijo->hoja))
			hijo->C[(hijo->n)+1] = compa->C[0];
		llave[idx] = compa->llave[0];
 
		for (int i=1; i<compa->n; ++i)
			compa->llave[i-1] = compa->llave[i];
 
		if (!compa->hoja){
			for(int i=1; i<=compa->n; ++i)
				compa->C[i-1] = compa->C[i];
		}
 
		hijo->n += 1;
		compa->n -= 1;
 
		return;
}
void BTree::inserta(int k){
		
	if (raiz == NULL){
		raiz = new Nodo(t, true);
		raiz->llave[0] = k;  
		raiz->n = 1;  
		}else{
			if (raiz->n == 2*t-1){
			Nodo *s = new Nodo(t, false);
			s->C[0] = raiz;
			s->splithijo(0, raiz);
			int i = 0;
			if (s->llave[0] < k)
				i++;
				s->C[i]->insertaNonFull(k);		
				raiz = s;
			}else
				raiz->insertaNonFull(k);
		}
}
 

void Nodo::insertaNonFull(int k){
	int i = n-1;
	if (hoja == true){
		while (i >= 0 && llave[i] > k){
			llave[i+1] = llave[i];
			i--;
		}
	llave[i+1] = k;
	n = n+1;
	}else{
		while (i >= 0 && llave[i] > k)
			i--;
			if (C[i+1]->n == 2*t-1){
				splithijo(i+1, C[i+1]);
				if (llave[i+1] < k)
					i++;
			}
			C[i+1]->insertaNonFull(k);
	}
}

void Nodo::splithijo(int i, Nodo *y){
	Nodo *z = new Nodo(y->t, y->hoja);
	z->n = t - 1;
	for (int j = 0; j < t-1; j++)
		z->llave[j] = y->llave[j+t];
		if (y->hoja == false){
			for (int j = 0; j < t; j++)
				z->C[j] = y->C[j+t];
		}
		y->n = t - 1;
 
	
	for (int j = n; j >= i+1; j--)
		C[j+1] = C[j];
		C[i+1] = z;
		for (int j = n-1; j >= i; j--)
			llave[j+1] = llave[j];
		llave[i] = y->llave[t-1];
		n = n + 1;
}
 
void Nodo::imprimeArbol(){
	int i;
	for (i = 0; i < n; i++){
		if (hoja == false)
			C[i]->imprimeArbol();
			cout << " " << llave[i];
		}
		if (hoja == false)
				C[i]->imprimeArbol();
}
 

int main()
{
		BTree test(3); 
		test.inserta(1);
		test.inserta(3);
		test.inserta(2);
		test.inserta(17);
		test.inserta(12);
		test.inserta(6);
		test.imprimeArbol();
 
		return 0;
}