#include <iostream>

__global__ void add(int *a, int *b, int *c) {
    int index = threadIdx.x;
    c[index] = a[index] + b[index];
}

void printArray(int *array, int size) {
    for (int i = 0; i < size; i++) {
        std::cout << array[i] << " ";
    }
    std::cout << std::endl;
}

void testAddition() {
    int size = 10;
    int *a, *b, *c;
    cudaMallocManaged(&a, size * sizeof(int));
    cudaMallocManaged(&b, size * sizeof(int));
    cudaMallocManaged(&c, size * sizeof(int));

    // Initialize input arrays
    for (int i = 0; i < size; i++) {
        a[i] = i;
        b[i] = i * 2;
    }

    // Print input arrays
    std::cout << "Array A: ";
    printArray(a, size);
    std::cout << "Array B: ";
    printArray(b, size);

    // Launch kernel
    int blockSize = 256;
    int numBlocks = (size + blockSize - 1) / blockSize;
    add<<<numBlocks, blockSize>>>(a, b, c);

    // Wait for kernel to finish
    cudaDeviceSynchronize();

    // Print result array
    std::cout << "Array C (A + B): ";
    printArray(c, size);

    // Clean up
    cudaFree(a);
    cudaFree(b);
    cudaFree(c);
}

int main() {
    testAddition();
    return 0;
}
