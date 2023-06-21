#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>
#include <sys/time.h>
void MA(int A[N][N],int B[N][N],int C[N][N],int start_row,int end_row){
	for(int i=start_row;i<end_row;i++){
		for(int j=0;j<N;j++){
			C[i][j]=A[i][j]+B[i][j];
		}
	}
}

int main(int argc,char* argv[]){
	int rank,size,flag;
	int A[N][N],B[N][N],C[N][N];
	int subMatrixSize,start_row,end_row;
	double elapsed;
	struct timeval tv1,tv2;
	struct timezone tz;
	double startTime,endTime;
	MPI_Init(&argc,&argv);
	MPI_Initialized(&flag);
	if(flag==0){MPI_Init(&argc,&argv);}
	MPI_Comm_rank(MPI_COMM_WORLD,&rank);
	MPI_Comm_size(MPI_COMM_WORLD,&size);
	subMatrixSize=N/size;
	for(int i=0;i<N;i++){
		for(int j=0;j<N;j++){
			A[i][j]=1;
			B[i][j]=2;
		}
	}
	gettimeofday(&tv1,&tz);
	for(int i=0;i<size;i++){
		MA(A,B,C,i*subMatrixSize,(i+1)*subMatrixSize);
	}
	gettimeofday(&tv2,&tz);
	elapsed=(double)(tv2.tv_sec-tv1.tv_sec)+(double)(tv2.tv_usec-tv1.tv_usec)*1.e-6;
	printf("Time elapsed=%4.2lf\n",elapsed);
	for(int i=0;i<N;i++){
		for(int j=0;j<N;j++)
			printf("%d\t",C[i][j]);
		printf("\n");
	}
}	
