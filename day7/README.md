# Day 7

Tiled matrix Multiplication

    - Dividing the M and N matrices into smaller tiles - chosen to be able to fit into the shared memory

    - Calculation is done tile by tile in phases -The shared memory array for`M` is  `Mds `and `Nds `loaded for `N`

    - The basic idea to load into shared memory is to reduce the number of accesses to the gloabl memory which is slower. Reduction is by the width of the tile if the tile is`WIDTH x WIDTH`

    - The first`__syncthreads()` in tiles mat mul is called "red-after-write depenedence" - because threads must waut for the data to be read by all threads that need it before overwiting it. Other name is `true dependence`

    - The second`__syncthreads()` is called "write-after-read dependence" because a thread must wait for the data to be read by all threads that need it beofre overwriting it. Other name is `false dependence`

    - A read-after-write dependence is a true dependence because the reading thread truly needs the data supplied  by the writing thread, so it has no choice but to wait for it. A write-after-read dependence is a false dependence because the writing thread does not need any data from the reading thread. The dependence is caused by the fact that they are reusing the same memory location and would not exist if they used different locations.
