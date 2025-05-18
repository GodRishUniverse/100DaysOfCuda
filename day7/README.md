# Day 7

Tiled matrix Multiplication

    - Dividing the M and N matrices into smaller tiles - chosen to be able to fit into the shared memory

    - Calculation is done tile by tile in phases -The shared memory array for`M` is  `Mds `and `Nds `loaded for `N`

    - The basic idea to load into shared memory is to reduce the number of accesses to the gloabl memory which is slower. Reduction is by the width of the tile if the tile is`WIDTH x WIDTH`

    - The first`__syncthreads()` in tiles mat mul is called "red-after-write depenedence" - because threads must waut for the data to be read by all threads that need it before overwiting it. Other name is `true dependence`

    - The second`__syncthreads()` is called "write-after-read dependence" because a thread must wait for the data to be read by all threads that need it beofre overwriting it. Other name is `false dependence`

    - A read-after-write dependence is a true dependence because the reading thread truly needs the data supplied  by the writing thread, so it has no choice but to wait for it. A write-after-read dependence is a false dependence because the writing thread does not need any data from the reading thread. The dependence is caused by the fact that they are reusing the same memory location and would not exist if they used different locations.


- `strip-mining` takes a long-runing loop and breaks it into phases. Each phase involves an innerloop that exeutes a few consecutive iteratations of the original loop.The original loop becomes an outer loop whose role is to iteratively invoke the inner loop so that all the iterations of the original loop are executed in their
  original order. By adding barrier synchronizations before and after the inner loop,
  we force all threads in the same block to focus their work on the same section of
  input data during each phase. **Strip-mining is an important means to creating the
  phases that are needed by tiling in data parallel programs**

## Assumptions for tiled mat mul

* Width of the matrices is assumed to be a multiple of the width of the thread blocks
* MATRICES ARE SQUARE
