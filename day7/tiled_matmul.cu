#define  TILE_WIDTH 16
__global__
void tiled_matmul_kernel(float* M, float*N, float *P, int Width){
    __shared__ float Mds[TILE_WIDTH][TILE_WIDTH];
    __shared__ float Nds[TILE_WIDTH][TILE_WIDTH];

    int bx = blockIdx.x; 
    int by = blockIdx.y;

    int tx = threadIdx.x;
    int ty = threadIdx.y;

    int Row = by * TILE_WIDTH+ ty;
    int Col = bx * TILE_WIDTH +tx;

    float Pvalue {};
    for (int p_h = 0; p_h < Width/ TILE_WIDTH; ++p_h){
        Mds[ty][tx] = M[Row*Width +p_h*TILE_WIDTH+tx];
        Nds[ty][tx] = N[(p_h*TILE_WIDTH+ty)*Width +Col];
        __syncthreads();

        for (int k = 0;k <TILE_WIDTH; ++k ){
            Pvalue +=Mds[ty][k] * Nds[k][tx];
        }
        __syncthreads();

    }

    P[Row*Width+Col] = Pvalue;
}
