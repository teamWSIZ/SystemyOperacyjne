// kompilacja: g++ -O3 testFilesMemory.cc -lrt
// uruchamianie: "./a.out"



#include <bits/stdc++.h>
#define REP(i,n)  for(int i=0;i<(int)(n);++i)
#define FOR(i,b,n)  for(int i=b;i<(n);++i)
#define ALL(c) (c).begin(),(c).end()
#define SZ(c) (int)((c).size())
#define SS size()
#define CLR(a,v) memset((a),(v), sizeof a)
#define PB push_back
#define MP make_pair
#define FOREACH(it,x) for(__typeof((x).begin()) it=(x.begin()); it!=(x).end(); ++it)
#define ST first
#define ND second
using namespace std;
#pragma GCC diagnostic ignored "-Wformat"   // "%I64d"
typedef long long ll;
typedef vector<int> vi;
typedef vector<vi> vvi;
typedef vector<ll> vl;
typedef vector<vl> vvl;
typedef vector<double> vd;
typedef vector<vd> vvd;
typedef pair<int,int> pii;

timespec startCLK, stopCLK;
#define START clock_gettime(CLOCK_MONOTONIC, &startCLK)
#define STOP(c)   clock_gettime(CLOCK_MONOTONIC, &stopCLK); \
    printf("dt = %6.3f [ms]%s\n", (stopCLK.tv_sec - startCLK.tv_sec) * 1000. +\
        1. * (stopCLK.tv_nsec - startCLK.tv_nsec) / 1e6, (c))


const int SZ = 1e8;   //number of integers in the file
const int RD_CNT=1e6; //number of integers to read from file
/**
* Create file containing 100 000 000 integers (400MB)
*/
void createFile() {
  START;
  FILE* ff;
  ff = fopen("test.dat","wb");
  int* dane = new int[SZ];
  REP(i,SZ) dane[i] = i;
  fwrite(dane, 4, SZ, ff);
  fclose(ff);
  ff = fopen("test.dat","rb");
  int odczytane[10];
  fseek(ff,120,SEEK_SET);
  fread(odczytane, 4, 10, ff);    //dest*, #bytes_each, #objects, file*)
  fclose(ff);
  STOP(" --> czas zapisu");
}

void randomReadFile() {
  srand(111);
  ll controlSum = 0;
  FILE* ff;
  ff = fopen("test.dat","rb");
  START;
  REP(i,RD_CNT) {
    int which = rand() % SZ;
    int dst = 0;
    fseek(ff, which*4, SEEK_SET);
    fread(&dst, 4, 1, ff);
    controlSum = (controlSum + dst) % 10007;
  }
  STOP(" --> czas odczytu(dysk)");
  cout << "(control sum:" << controlSum << ")\n";
}

int* memory;
void createMemory() {
  START;
  memory = new int[SZ];
  REP(i,SZ) memory[i] = i;
  STOP(" --> czas zapisu");
}

void randomReadMemory() {
  srand(111);
  ll controlSum = 0;
  START;
  REP(i,RD_CNT) {
    int which = rand() % SZ;
    controlSum = (controlSum + memory[which]) % 10007;
  }
  STOP(" --> czas odczytu(pamiec)");
  cout << "(control sum:" << controlSum << ")\n";
}



int main() {
  printf("Wielkosc proby:%iMB\n",SZ * 4 / 1000000);
  createFile();
  randomReadFile();
  createMemory();
  randomReadMemory();
}







