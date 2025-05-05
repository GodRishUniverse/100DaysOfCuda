

__global__
void imageBlur(unsigned char *in, unsigned char *out, int width, int height) {
    int col = threadIdx.x + blockIdx.x * blockDim.x;
    int row = threadIdx.y + blockIdx.y * blockDim.y;
    if (row < height && col < width) {
        int pixVal = 0;
        int pixels = 0;
        for (int i = -1; i <= 1; i++) { // 1 is the BLUR_SIZE
            for (int j = -1; j <= 1; j++) {
                int curRow = row + i;
                int curCol = col + j;
                if (curRow >= 0 && curRow < height && curCol >= 0 && curCol < width) {
                    pixels++;
                    pixVal += in[curRow * width + curCol];
                    
                }
            }
        }

        out[row * width + col] = (unsigned char)(pixVal / pixels);
    }
}
