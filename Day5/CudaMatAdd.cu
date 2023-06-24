#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <unistd.h>

#define N 11

__global__ void MatAdd(int A[][N], int B[][N], int C[][N]){
           int i = threadIdx.x;
           int j = threadIdx.y;

           C[i][j] = A[i][j]+B[i][j];
       }


int main(){

    int A[N][N];
    int B[N][N];
    int C[N][N];

    for(int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
                A[i][j] = 1;
                B[i][j] = 1;
                C[i][j] = 99;
        }
    }

    int (*pA)[N], (*pB)[N], (*pC)[N];

    cudaMalloc((void**)&pA, (N*N)*sizeof(int));
    cudaMalloc((void**)&pB, (N*N)*sizeof(int));
    cudaMalloc((void**)&pC, (N*N)*sizeof(int));

    cudaMemcpy(pA, A, (N*N)*sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(pB, B, (N*N)*sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(pC, C, (N*N)*sizeof(int), cudaMemcpyHostToDevice);

    struct timeval tv1,tv2;
    struct timezone tz;
    double elapsed;

    int numBlocks = 1;
    dim3 threadsPerBlock(N,N);

    gettimeofday(&tv1,&tz);

    MatAdd<<<numBlocks,threadsPerBlock>>>(pA,pB,pC);

    gettimeofday(&tv2,&tz);
    elapsed = (double) (tv2.tv_sec - tv1.tv_sec) + (double) (tv2.tv_usec - tv1.tv_usec)*1.e-6;
    printf("Elapsed time=%4.2lf seconds.\n",elapsed);

    cudaMemcpy(C, pC, (N*N)*sizeof(int), cudaMemcpyDeviceToHost);

    int i, j; printf("C = \n");
    for(i=0;i<N;i++){
        for(j=0;j<N;j++){
            printf("%d ", C[i][j]);
        }
        printf("\n");
    }

    cudaFree(pA);
    cudaFree(pB);
    cudaFree(pC);

    printf("\n");

    return 0;
}
                                           

