#include <stdio.h>

int AA[100];  		// linearized version of A[10][10]
int BB[100];  		// linearized version of B[10][10]
int CC[100];  		// linearized version of C[10][10]
int m;       		// actual size of the above matrices is mxm, where m is at most 10

int main() {
	// code here
    int m;
    scanf("%d", &m);
    // if (m > 10){
        //throw error
    // }
    for (int i = 0; i < m; i++) {
		for ( int j = 0; j < m; j++) {
			// scanf("%d", &A[[j][i]]);
			scanf("%d", &AA[i + j*m]);
		}
	}

	for (int i = 0; i < m; i++) {
		for (int j = 0; j < m; j++) {
			// scanf("%d", &B[j][i]);
            scanf("%d", &BB[i + j*m]);
		}
	}

	for (int i = 0; i < m; i++) {
		for (int j = 0; j < m; j++) {
			int sum = 0;
			for (int k = 0; k < m; k++) {
				// sum += A[k][i] * B[j][k];
                sum += AA[i + k*m] * BB[k + j*m];
			}

			CC[i + j*m] = sum;
		}
	}

	for (int i = 0; i < m; i++) {
		for (int j = 0; j < m; j++) {
			printf("%d ", CC[i + j*m]);
		}
		printf("\n");
	}
}