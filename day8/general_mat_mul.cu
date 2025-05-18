#include <iostream>

#define  TILE_WIDTH 16

#define ll long long

// Matrices be j*c and c*l
__global__
void gen_tiled_matmul_kernel(float* M, float*N, float *P, int j , int c , int l){
    __shared__ float Mds[TILE_WIDTH][TILE_WIDTH]; 
    __shared__ float Nds[TILE_WIDTH][TILE_WIDTH]; 

  
    int bx = blockIdx.x; 
    int by = blockIdx.y;

    int tx = threadIdx.x;
    int ty = threadIdx.y;


    int Row = by * TILE_WIDTH+ ty;  
    int Col = bx * TILE_WIDTH +tx; 
    float Pvalue {};

    // ceil ensures that the upper end of the tile is chosen
    for (int p_h = 0; p_h < static_cast<int>(ceil(c / TILE_WIDTH)); ++p_h){
        if (Row < j && (p_h*TILE_WIDTH+tx)< c){
            Mds[ty][tx] = M[Row*c +p_h*TILE_WIDTH+tx];
        }else{
            Mds[ty][tx] = 0.0f; // safest value if used in calculation
        }

        if ((p_h*TILE_WIDTH+ty)<c && Col<l){
            Nds[ty][tx] = N[(p_h*TILE_WIDTH+ty)*l +Col];
        } else{
            Nds[ty][tx] = 0.0f; // will not cause harm to the data
        }
        
        __syncthreads();
    
        for (int k = 0;k <TILE_WIDTH; ++k ){
            Pvalue +=Mds[ty][k] * Nds[k][tx];
        }
        __syncthreads();

    }
    if ((Row <j) && (Col <l )){
        P[Row*l+Col] = Pvalue;
    }
    
}


void execute_mul(float * M, float *N, float *P, int j, int c, int l ){
    ll size_m, size_n, size_p;
    size_m = j*c*sizeof(float);
    size_n = c*l*sizeof(float);
    size_p = j*l*sizeof(float);


    float* d_M;
    float* d_N;
    float* d_P;

    cudaError_t error = cudaMalloc((void**) &d_M, size_m);
    if (error !=cudaSuccess){
        printf("Error: %s\n", cudaGetErrorString(error), __FILE__,__LINE__);
        exit(EXIT_FAILURE);
    }

    cudaMemcpy(d_M, M, size_m, cudaMemcpyHostToDevice);


    error = cudaMalloc((void**) &d_N, size_n);
    if (error !=cudaSuccess){
        printf("Error: %s\n", cudaGetErrorString(error), __FILE__,__LINE__);
        exit(EXIT_FAILURE);
    }

    cudaMemcpy(d_N, N, size_n, cudaMemcpyHostToDevice);


    error = cudaMalloc((void**) &d_P, size_p);
    if (error !=cudaSuccess){
        printf("Error: %s\n", cudaGetErrorString(error), __FILE__,__LINE__);
        exit(EXIT_FAILURE);
    }

    // TODO: need to see if this is correct or not
    gen_tiled_matmul_kernel<<<4, 256>>> (d_M, d_N, d_P, j,c ,l);

    cudaMemcpy(P, d_P, size_p, cudaMemcpyDeviceToHost);

    cudaFree(d_M);
    cudaFree(d_N);
    cudaFree(d_P);

}

int main(){
    
}
