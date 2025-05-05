#include <iostream>

__global__
void kernel_matmul(float *in_a, float *in_b, float *out, int m, int n, int k) {
    // in_a is m by n
    // in_b is n by k
    // out is m by k

    int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;

    if (row < m && col < k) {
        int sum {0};
        for (int i = 0; i < n; i++) {
            sum += in_a[row * n + i] * in_b[i * k + col];
        }   
        out[row * k + col] = sum;
    }
}


void matmul(float *a, float *b, float *c, int m , int n, int k) {
    int size_a = m*n * sizeof(float);
    int size_b = n*k * sizeof(float);
    int size_c = m*k * sizeof(float);

    float *d_a, *d_b, *d_c;

    cudaError_t err = cudaMalloc((void **)&d_a, size_a);
    if (err != cudaSuccess) {
        printf("Error: %s\n", cudaGetErrorString(err), __FILE__,__LINE__);
        exit(EXIT_FAILURE);
    }
    cudaMemcpy(d_a, a, size_a, cudaMemcpyHostToDevice); // Host to Device
    err = cudaMalloc((void**)&d_b, size_b);
    if (err != cudaSuccess) {
        printf("Error: %s\n", cudaGetErrorString(err), __FILE__,__LINE__);
        exit(EXIT_FAILURE);
    }
    cudaMemcpy(d_b, b, size_b, cudaMemcpyHostToDevice); // Host to Device

    err = cudaMalloc((void **)&d_c, size_c);
    if (err != cudaSuccess) {
        printf("Error: %s\n", cudaGetErrorString(err), __FILE__,__LINE__);
        exit(EXIT_FAILURE);
    }

    // kernel code
    dim3 dimGrid(32, 1,1);
    dim3 dimBlock(32, 1,1);
    kernel_matmul<<<dimGrid, dimBlock>>>(d_a, d_b, d_c, m, n, k);

    cudaMemcpy(c, d_c, size_c, cudaMemcpyDeviceToHost); // Device to Host

    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);
}



int main(){
    // we will test here

    float a[] = {1.f, 2.f, 3.f, 4.f};
    float b[] = {5.f, 6.f, 7.f, 8.f};

    float c[1];

    matmul(a, b, c, 1, 4, 1);
    std::cout << c[0] << std::endl;

    return 0;

    
}
