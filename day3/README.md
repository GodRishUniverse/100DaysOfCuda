# Chapter 3 PMPP

All CUDA threads in a grid execute the same kernel function 


A grid consists of one or more blocks whereas a block consists of one or more threads

```cuda
dim3 dimGrid(32, 1,1);
dim3 dimBlock(128,1,1); // dim3 is a C struct

vecAddKernel<<<dimGrid, dimBlock>>>(...);
```
