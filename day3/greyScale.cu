// day3/greyScale.cu

// there are 3 channels in RGB

// __global__
// void colorToGrayScale(unsigned char *P_Out, unsigned char *P_In, int width, int height) {
//     int col = blockIdx.x * blockDim.x + threadIdx.x;
//     int row = blockIdx.y * blockDim.y + threadIdx.y;
//     if (row < height && col < width) {
//         int greyOffset = row*width + col;

//         int rgbOffset = greyOffset*CHANNELS;    
//         unsigned char r = P_In[rgbOffset];
//         unsigned char g = P_In[rgbOffset + 2];
//         unsigned char b = P_In[rgbOffset + 3];
//         P_Out[greyOffset] = 0.21f *r + 0.72f*g + 0.07f*b;
//     }
// }
