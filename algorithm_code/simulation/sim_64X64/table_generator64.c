#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

#define SIZE 64
#define SAMPLE_SIZE 100000000

int output[SIZE];
int used[SIZE] = {0};
char sampled[SAMPLE_SIZE][SIZE + 1];

// 문자열 형태로 현재의 순열을 반환
void getCombinationString(char *buffer) {
    for (int i = 0; i < SIZE; i++) {
        buffer[i] = '0' + output[i];
    }
    buffer[SIZE] = '\0';
}

// 랜덤한 순열을 생성
void randomCombination() {
    memset(used, 0, sizeof(used));
    for (int i = 0; i < SIZE; i++) {
        int r;
        do {
            r = rand() % SIZE;
        } while (used[r]);
        output[i] = r;
        used[r] = 1;
    }
}

void printCombination() {
    printf("%d ",SIZE);
    for(int i = 0; i<SIZE; i++){
        printf("%d ",output[i]);
    }
    printf("\n");
}




int main() {
    srand(time(NULL));
    int uniqueCombinations = 0;

    while (uniqueCombinations < SAMPLE_SIZE) {
        randomCombination();

        char buffer[SIZE + 1];
        getCombinationString(buffer);

        int isUnique = 1;
        for (int i = 0; i < uniqueCombinations; i++) {
            if (strcmp(buffer, sampled[i]) == 0) {
                isUnique = 0;
                break;
            }
        }

        if (isUnique) {
            strcpy(sampled[uniqueCombinations], buffer);
            uniqueCombinations++;
            printCombination();
        }
    }

    return 0;
}