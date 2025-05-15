# Day 7

Tiled matrix Multiplication

    - Dividing the M and N matrices into smaller tiles - chosen to be able to fit into the shared memory

    - Calculation is done tile by tile in phases -The shared memory array for`M` is  `Mds `and `Nds `loaded for `N`

    - The basic idea to load into shared memory is to reduce the number of accesses to the gloabl memory which is slower. Reduction is by the width of the tile if the tile is`WIDTH x WIDTH`

    -

    -
