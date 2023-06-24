#include <bits/stdc++.h>
using namespace std;
int fib(int n,vector<int> &arr){
	if(arr[n]!=-1)return arr[n];
	if(n<=1)return arr[n]=0;
	else if(n==2)return 1;
	return arr[n]=fib(n-1,arr)+fib(n-2,arr);
}
int main(){
	int n=30;
	vector<int> arr(n+1,-1);
	
	//for(int i=0;i<=100;i++)printf("%d ",arr[i]);
	cout<<fib(n,arr);
}	
