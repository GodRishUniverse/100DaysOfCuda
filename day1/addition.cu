#include <iostream>

__global__
void add(float *a, float *b, float *c) {
    int index = blockIdx.x * blockDim.x + threadIdx.x;
    c[index] = a[index] + b[index];
}

void printArray(float *array, int size) {
    for (int i = 0; i < size; i++) {
        std::cout << array[i] << " ";
    }
    std::cout << std::endl;
}

void vectorAdd(float *a, float *b, float *c, int n) {
    int size = n * sizeof(float);

    float *d_a, *d_b, *d_c;

    cudaMalloc(&d_a, size);
    cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice); // Host to Device
    cudaMalloc(&d_b, size);
    cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice); // Host to Device

    cudaMalloc(&d_c, size);

    // kernel code
    add<<<ceil(n / 256.0), 256>>>(d_a, d_b, d_c);

    cudaMemcpy(c, d_c, size, cudaMemcpyDeviceToHost); // Device to Host

    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

}


int main() {
    float a[] = {1.f, 2.f, 3.f, 4.f};
    float b[] = {5.f, 6.f, 7.f, 8.f};

    float c[4];

    vectorAdd(a, b, c, 4);

    printArray(c, 4);
    return 0;
}
