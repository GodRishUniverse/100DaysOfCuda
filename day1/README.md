# Day 1

Read Chapter 1 of PMPP

Implemented addition in kernel

## Notes

- CPUs are latency-based devices
  - Large ALUs
  - Large Caches
  - CU does a lot of branch management
- GPUs are throughput-based devices (Throughput is a measure of the **ACTUAL** amount of data or work that can be processed by a system, network, or application within a given time period)
  - Small Cache - boosting mechanism for memory throughput
  - Small control logic - no branch prediction
  - Large Number of Small - ALUs - many high-throughput but long latency
  - Very large number of arithmetic operations parallelly done
  - Massive number of threads to tolerate latencies - thread logic and thread state
- Hetergenous parallel  systems may use both
  - Use CPUs where latency matters
  - Use GPUs where throughput matters - many computations
