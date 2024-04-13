// C++ program to generate binary numbers from 1 to n
#include <bits/stdc++.h>
using namespace std;


void generatePrintBinary(int n)
{
for(int i=16;i<=n;i++){
	string str="";
	int temp=i;
	while(temp){
		if(temp&1){str=to_string(1)+str;}
		else{str=to_string(0)+str;}
			
		temp=temp>>1;
	}
	cout<<"|$0.0"<< str <<"$"<<"|$0."<< str <<"$|"<<"$"<< str.insert(1, ".") <<"$|"<<endl;
}
}

// Driver code
int main()
{
	int n = 31;

	// Function call
	generatePrintBinary(n);
	return 0;
}
