#include <stdio.h>
#include <omp.h>
int main()
{
	int maxThreads=omp_get_max_threads();
	omp_set_num_threads(4);
	printf("Maximum number of threads in the shared memory environment is %d\n",maxThreads);
	#pragma omp parallel
	{
		printf("Welcome to HPC and AI Summer School, Hosted by IIT Palakkad %d\n",omp_get_thread_num());
	}
	return 0;
}
