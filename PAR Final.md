# PAR Final Exam

## Unit 1

### 1.1 Types of execution

- **Serial execution**:

> The programs are executed at 1 instruction at a given time.
> 
> (Legacy format, not very present nowadays)

- **Concurrent execution**:

> The programs are executed at 1 instruction but multiplexed between all of them to give the feel of a parallel execution

- **Parallel**:

> Dividing the program in different tasks that can be executed at the same time

### 1.2 Concurrency Problems

- **Race Condition**:

> Multiple tasks read and write some data and the final result depends on the relative riming of their execution

- **Deadlock**:

> Two or more tasjs are unable to proceed because each one is waiting for one of the others to do something

- **Starvation**:

> A task is unable to gain access to a shared resource and is unable to make progress

- **Livelock**:

> Two or more tasks continuously change their state in response to changes in the other tasks without doing any useful work.

### 1.3 Tasks vs Processes / Threads vs Processors

| Tasks                       | Processes                                  | Threads                                    | Processors                                         |
| --------------------------- | ------------------------------------------ | ------------------------------------------ | -------------------------------------------------- |
| Created by parallel runtime | Logical computing agents offered by the OS | Logical computing agents offered by the OS | Hardware units that execute the logical components |

![Figura 1](https://user-images.githubusercontent.com/59342135/213032921-c964f4f0-b789-46bf-acd9-d4ca36515f95.png)

## Unit 2

### 2.1 Task Dependency Graph (TDG)

- What is a TDG?

> Graphical representation of the decomposition. Were each node represents a task and its weight represents the amount of work to be done. An edge represents a dependency between nodes

- **Critical path?**:

> Is the path of the TDG taht from begining to and end has a highest accumulated work

![Figura 4](https://user-images.githubusercontent.com/59342135/213033040-69c33122-5433-4245-b003-e7c730a36372.png)

### 2.1 Computing the Parallelism

- **$T_1$**:

> Sum of all the "work" of each node in the task dependency graph (TDG)

![Figura 2](https://user-images.githubusercontent.com/59342135/213033002-41737cab-e15d-42ff-9ebd-e1eeb0183f95.png)

- $T_ \infty$:

> Sum of all the "work" of each node in the critical path of the TDG

![Figura 3](https://user-images.githubusercontent.com/59342135/213033025-783bf021-c638-426a-b900-0d4e115b2428.png)

- **$Parallelism\ ={T_1\over T_\infty} $**:

> Sequential / Max parallelism

- **$P_{min}$**:

> Minimum number of processors necessary to achieve Parellalism

- **$T_p$**:

> Parallel execution in P processors without overhead

$$
T_p = {T_1 \over P}
$$

> Parallel execution in P processors with overhead

$$
T_p={T_1 \over P+T_{overhead}(P)}
$$

- **$S_p={T_1 \over T_p}$**

> How many times faster the application will be with P processors

- $E_p={S_p \over P}$

> How efficient is the application with P processors

- $T_1=T_{seq}+T_{par}$

- $\phi= {T_{par} \over T_1}$

> Phi ($\phi$) is the parallel fraction region

- $S_p={1 \over (1- \phi)}$

> Amdahl law, negative effect of the serial parts in your parallel application

> In other words... Which is the best possible speedup that you can get

## Unit 3

In order to get coherence there are two ways in the reader side and two ways in the writer side.

**Writer Side**:

- **Write update**:

> Writing processor broadcaasts **the line** with the new value and forces all others to update their copies

- **Write-invadilate**:

> Writing processor forces all others to invalidate their copies; **the line** with the new value is provided to others **when requested** or **when flushed** from cache

**Reader Side**:

- **Snooping**:

> Bus serves as broadcast mechanism to mantain coherency among copies of the same memory line in caches

- **Directory**:

> The sharing status of each line in memory is kept centralized in just one location ( in the directory)

### 3.1 Particurar coherence implementations

- **Write-update snooping coherence**

> Each cache line has a:
> 
> 1. Valid bit (V)
> 
> 2. Tag (T)
> 
> 3. Data
> 
> The caches access the main memory through a bus (as in the example)

![Figura 5](https://user-images.githubusercontent.com/59342135/213033065-66133e03-27e2-468e-9b89-bc5ee4999951.png)

- **Write-invalidate snooping coherence**

> Each cache line has a:
> 
> 1. Valid bit (V)
> 
> 2. Tag (T)
> 
> 3. Share bit (S)
> 
> 4. Dirty bit (D)
> 
> 5. Data
> 
> The caches access the main memory through a bus (as in the example)

![Figura 6](https://user-images.githubusercontent.com/59342135/213033089-6d17e7dd-d8c9-4bf7-b671-38ebf662d3cf.png)

### 3.2 Particular memeory implementations (IMPORTANT!)

- **(Centralized) Shared-memory srchitecture** (**SMP or UMA**)

> **Address space**: Single shared address space, uniform access time
> 
> **Model for data sharing**: Load/store instructions from processors

![Figura 7](https://user-images.githubusercontent.com/59342135/213033103-3e1254ef-d9cc-4891-8c29-64e98510a60c.png)

> - **Simple write-invalidate snooping protocol (MSI)**:
> 
> > A line in a cache memory can be in three different states:
> > 
> > - Modified (M): Dirty copy of the line
> > 
> > - Shared (S): Clean copy of the line
> > 
> > - Invalid (I): Invalid copy of the line (not valid) or it does not exist in the cache
> > 
> > CPU events:
> > 
> > - PrRd: Processor read
> > 
> > - PrWr: Processor write
> > 
> > Bus events (caused by cache controllers):
> > 
> > - BusRd: Asks for copy with no intent to modify
> > 
> > - BusRdX: Asks for a copy with intent to modify
> > 
> > - BusUpgr: Asks for permission to modify existing line, causes invalidation of other copies
> > 
> > - Flush: Puts line on bus, either because requested or voluntarily when dirty line in cache is replaced
> > 
> > ![Figura 10](https://user-images.githubusercontent.com/59342135/213033215-27620fa0-22a0-4958-9213-285df4c2556d.png)
> > 
> > IF line in S or I in other caches then main memory provides it
> > 
> > IF line in M in another cache then this cache provides it (Flush)
> 
> - **MESI**:
> 
> > Is the same as MSI but adds the Exclusive clean state:
> > 
> > - Cache line in E only one clean copy of the line
> > 
> > - If write access by the same processor, the upgrade from E to M **does not require** a bus transaction (BusUpgr)
> > 
> > - If line in E and another cache request it then cache line state changes from E to S

- **Distributed-memory architecture** with **ssas** (**DSM or NUMA**)

> **Address space**: Single shared address space (**ssas**), non-uniform access time
> 
> **Model for data sharing**: Load/store instructions from processors
> 
> **MSU directory-based cache coherency**:
> 
> One slice of the directory is associated to each node memory, one entry per line of memory
> 
> - Status bits: They track the state of cache lines in its memory
> 
> - Sharers list: Tracks the list of remote nodes having a copy of a line.
> 
> Directory slice is the "centralised" structure that "orders" the accesses to the lines in the associated node
> 
> ![Figura 11](https://user-images.githubusercontent.com/59342135/213033252-f8957411-44b7-4f7c-8f6a-06a99e58f396.png)
> 
> **Node types**:
> 
> - **Home** node: node where the line is allocated. It has the directory slice with the information to maintain its coherence. The OS does, with first touch:
>   
>   - The node that first "touches" a page will be the home node for all the lines in that page
>   
>   - Normally 1 page is 1 line
> 
> - **Local** node: node with the processor accessing the line.
> 
> - **Remote** nodes: **Owner** node containing **dirty** copy of **Reader** nodes containg **clean** copies of the line
> 
> **Simplified coherency protocol**:
> 
> - Possible commands arriving to home node **from** local node
>   
>   - **RdReq**: asks for copy of the line with no intent to modify
>     
>     - Home node sends as a result a clean copy of the line (**Dreply**)
>   
>   - **WrReq**: asks for copy of the line with intent to modify
>     
>     - Home node sends as a result a clean copy of the line (**Dreply**)
>   
>   - **UpgrReq**: asks for permission to modify an existing line, invalidating all other copies
>     
>     - Home node sends as a result an acknowledgment (**Ack**)
> 
> - Possible commands arriving to remote **from** home node
>   
>   - **Fetch**: asks remote (owner) node for a copy of the line with **Dreply**
>   
>   - **Invalidate**: asks remote (reader) node to invalidate its copy, remote sends confirmation to home with **Ack**
> 
> ![Figura 12](https://user-images.githubusercontent.com/59342135/213033267-60f78617-59da-4b6d-9c30-5df9c9e8f6a4.png)
> 
> **Snooping and directory-based protocol**:
> 
> If nodes have snoopy-based coherence, then the hub becomes an additional agent that interacts with the home direcorty nodes for the cache lines copied in the node
> 
> ![Figura 13](https://user-images.githubusercontent.com/59342135/213033292-e7688e6a-c403-4936-a451-c1f983d871ea.png)
> 
> **Number of bits necessary to maneint the coherence AMONG numa node**:
> 
> $(\#nodes)·[({size\ MP \over size\ line\ MP})·(2+2+presence\ {bits \over line})]$

![Figura 8](https://user-images.githubusercontent.com/59342135/213033166-883714f7-22ef-4fd6-a2a6-cf84cb2b30bf.png)

- **Distributed-memory architecture** with **msas**

> **Address space**: Multiple separate address spaces (**msas**)
> 
> **Model for data sharing**: Explicit messages through network interface card
> 
> **Other names**: Message-passing multiprocessor, cluster architecture, multicomputer

![Figura 9](https://user-images.githubusercontent.com/59342135/213033191-c6bcf1b5-167f-484e-a90c-675f13c7f458.png)

## Unit 4

### 4.1 Identifying tasks in your sequential program

- **Linear** task decomposition:
  
  - A task is a "code block" or a procedure invocation

- **Iterative** task decomposition:
  
  - Tasks found in iterative constructs, such as loops

- **Recursive** task decomposition:
  
  - Tasks found in divide-and-conquer problems and other recursive problems
  
  > **Leaf strategy**: a task corresponds with each final leaf of the tree
  > 
  > ![Figura 14](https://user-images.githubusercontent.com/59342135/213033317-1b941f7e-5559-4be4-b889-f4470414c046.png)
  > 
  > ```c
  > ...
  > if (n>MIN_SIZE) {
  >     ...
  > }
  > else {
  >     tareador_start_task("leaftask");
  >     ...
  >     tareador_end_task("leaftask");
  > }
  > ...
  > ```
  > 
  > **Tree strategy**: a task corresponds with each sub-tree
  > 
  > ![Figura 15](https://user-images.githubusercontent.com/59342135/213033333-0d2deb7e-cbc4-49a4-899b-2712f23c47a1.png)
  > 
  > ```c
  > ...
  > if (n>MIN_SIZE) {
  >     int n2 = n/2;
  >     tareador_start_task("treetask1");
  >     func1(n2);
  >     tareador_end_task("treetask1");
  >     tareador_start_task("treetask2");
  >     func2(n-n2);
  >     tareador_end_task("treetask2");
  > }
  > ...
  > ```

### 4.2 Lab summary

- `#pragma omp parallel`: One **implicit** task is created for each thread in the team

- `int omp_get_num_threads()`: Returns the number of threads in the current team

- `int omp_get_thread_num()`: Returns the identifier of the thread

- `#pragma omp task`: One **explicit** task is created

- `#pragma omp taskloop`: **Explicit** tasks created for chunks of loop iterations

- `#pragma omp barrier`: Wait for all threads to finish previous work

- `#pragma omp taskwait`: Suspends the execution of the current task, waiting for completion of **its child tasks**

- `#pragma omp taskgroup`: Suspends the execution of the current task at the end of the structured block **waiting for its child tasks and their descendent tasks**.

### 4.3 Task generation control

- Leaf strategy with **depth recursion control**:

> ```c
> ...
> if (n>MIN_SIZE) {
>     int n2 = n / 2;
>     if (depth == CUTOFF)
>         #pragma omp task
>         {
>             recursiveFunction(n2, depth+1);
>             recursiveFunction(n-n2, depth+1);            
>         }
>     else {
>         recursiveFunction(n2, depth+1);
>         recursiveFunction(n-n2, depth+1);
>     }
> }
> else {
>     if (depth <= CUTOFF)
>         #pragma omp task
>         tmp = baseCaseFunction(n);
>     else
>         tmp = baseCaseFunction(n);
> }
> ...
> ```
> 
> 

- Tree strategy with **depth recursion control**:

> ```c
> ...
> if (n>MIN_SZIE) {
>     int n2 = n / 2;
>     if (!omp_in_final()) {
>         #pragma omp task shared(tmp1) final(depth >= CUTOFF)
>         tmp1 = recursiveFunction(n2, depth+1);
>         #pragma omp task shared(tmp2) final(depth >= CUTOFF)
>         tmp2 = recursiveFunction(n-n2, depth+1);
>         #pragma omp taskwait
>     }
>     else {
>         tmp1 = recursiveFunction(n2, depth+1);
>         tmp2 = recursiveFunction(n-n2, depth+1)
>     }
> }
> else tmp = baseCaseFunction(n);
> return tmp1+tmp2;
> ...
> ```

### 4.4 Task dependences

- **in specifier**: The generated task will be a dependent task of all previously generated task with out or inout that references the in variable.

- **out and inout specifier**: The generated task will be dependent task of all previously generated tasks with in, out or inout that references the variable

Types of dependences:

- **read-after-write**: Caused by matched out-in

- **write-after-read**: Caused by matched in-out

- **write-after-write**: Caused by matched out-out

### 4.5 Protecting task interactions in OpenMP

- `#pragma omp atomic`: Guarantee atomicity in 1 line/operation

- `#pragma omp critical`: Mutual exclusion region (not recommended)

- Reduction (the best option):
  
  - `#pragma omp taskgroup task_reduction(+:sum)`
  
  - `#pragma omp taskloop reductionj(+:sum)`

**Locks**

Locks an specific register from it's use

- `omp_set_lock(&hash_lock[index]);`

- `omp_unset_lock(&hash_lock[index]);`

## Unit 5

- **(Input) Block data decomposition**

> ![Figura 22](https://user-images.githubusercontent.com/59342135/213033502-4a094f7e-488b-45ca-b7c3-dcaf37b392ad.png)

- **(Input) Cyclic data decomposition, by ROWS**

> ![Figura 16](https://user-images.githubusercontent.com/59342135/213033375-6fd335e8-ac56-41d2-9623-e3068715fc37.png)

- **(Input) Block-Cyclic data decomposition, by COLUMNS**

> ![Figura 17](https://user-images.githubusercontent.com/59342135/213033421-761300c4-cebc-4bc8-a71a-9ea9f48efdd3.png)

- **2D Block / Block data decomposition**

> ![Figura 18](https://user-images.githubusercontent.com/59342135/213033445-a405d50d-ffb6-4b98-bc70-158db74b9be6.png)

- **(Output) Block data decomposition**:

> ![Figura 19](https://user-images.githubusercontent.com/59342135/213033457-c6449969-da60-4f6d-a791-831da8222143.png)

- **(Output) Cyclic decomposition**

> ![Figura 20](https://user-images.githubusercontent.com/59342135/213033470-9a6f0351-b360-4914-ab1d-a81ee2247584.png)

- **(Output) Block-Cyclic decomposition**

> ![Figura 21](https://user-images.githubusercontent.com/59342135/213033480-03601dec-0c30-4c0d-8353-c322399e753c.png)


