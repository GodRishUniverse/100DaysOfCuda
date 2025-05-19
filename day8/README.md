# Day 8

**Completed reading chapter 5 in PMPP**

We will add boundary checks to our tiled mat mul - accomodates for arbitrary width matrices

- It is often desirable for a kernel to be able to use different amounts of shared memory according to the amount available in the hardware. That is, we may want a host code to dynamically determine the size of the
  shared memory and adjust the amount of shared memory that is used by a kernel.
  This can be done by calling the `cudaGetDeviceProperties` function.

    - However, kernels do not support dynamically adjusting shared memory usage by the host code - they are hardwired using the compile time constant`TILE_WIDTH` - so we can use the `extern` keyword in `C`
