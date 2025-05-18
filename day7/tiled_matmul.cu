#define  TILE_WIDTH 16
__global__
void tiled_matmul_kernel(float* M, float*N, float *P, int Width){
    __shared__ float Mds[TILE_WIDTH][TILE_WIDTH]; // scope of shared memory is a block
    __shared__ float Nds[TILE_WIDTH][TILE_WIDTH]; // scope of shared memory is a block

    // one version for Mds and Nds for each block 

    // shorter name auto variables - placed in registers
    int bx = blockIdx.x; 
    int by = blockIdx.y;

    int tx = threadIdx.x;
    int ty = threadIdx.y;

    // each thread is responsible for calculating one value of P element

    int Row = by * TILE_WIDTH+ ty; // vertical position - same analogy is below for the vertical position 
    int Col = bx * TILE_WIDTH +tx; // horizontal position - bx blocks of threads (bx * TILE_WIDTH) before tx (thread)

    float Pvalue {}; // automatic variable - so generated per 

    for (int p_h = 0; p_h < Width/ TILE_WIDTH; ++p_h){ // p_h is going tile by tile
        Mds[ty][tx] = M[Row*Width +p_h*TILE_WIDTH+tx];
        Nds[ty][tx] = N[(p_h*TILE_WIDTH+ty)*Width +Col];
        __syncthreads(); // used to sync the threads to do this in parallel - IN A BLOCK
    

        // This is the dot product of the row in M with the column in N
        for (int k = 0;k <TILE_WIDTH; ++k ){
            Pvalue +=Mds[ty][k] * Nds[k][tx];
        }
        __syncthreads(); // acts as a barrier to ensure the threads are all synchorinized at this point

    }

    P[Row*Width+Col] = Pvalue;
}
