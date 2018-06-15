# 프로세스 동기화


* [프로세스 동기화 문제](#프로세스-동기화-문제)
    * [프로그램적 해결법의 충족 조건](#프로그램적-해결법의-충족-조건)
    * [알고리즘 1](#알고리즘-1)
    * [알고리즘 2](#알고리즘-2)
    * [알고리즘 3](#알고리즘-3)
    * [동기화 하드웨어](#동기화-하드웨어)
* [세마포어(Semaphore)](#세마포어semaphore)
    * [Busy-Wait](#busywait)
    * [Block/Wakeup](#block/wakeup)
    * [세마포어의 두 타입](#세마포어의-두-타입)
    * [데드록 및 기아현상](#데드록-및-기아현상)
    * [Bounded-Buffer Problem](#boundedbuffer-problem)
    * [Readers-Writers Problem](#readerswriters-problem)
    * [Dining-Philosophers Problem](#diningphilosophers-problem)
* [모니터(Monitor)](#모니터monitor)
    * [Bounded-Buffer Problem](#boundedbuffer-problem)
    * [Dining-Philosophers Problem](#diningphilosophers-problem)


&nbsp;      
## 프로세스 동기화 문제
#### 문제 해결을 위한 초기 시도
두 개의 프로세스 P0, P1이 있다고 가정, 프로세스들의 일반적인 구조는:
```
do {
    entry section
    critical section
    exit section
    remainder section
} while(1)
```


프로세스들은 수행의 동기화(synchronize)를 위해 몇몇 변수를 공유할 수 있다 -> 동기화 변수(synchronization variable)


&nbsp;      
### 프로그램적 해결법의 충족 조건
#### 상호 배제(Mutual Exclusion)
프로세스 Pi가 임계 영역(critical section) 부분을 수행 중이면 다른 모든 프로세스들은 그들의 임계 영역에 들어가면 안된다.


#### 진행(Progress)
아무도 임계 영역(critical section)에 있지 않은 상태에서 임계 영역에 들어가고자 하는 프로세스가 있으면 임계 영역에 들어가게 해주어야 한다.


#### 유한 대기(Bounded Waiting)
프로세스가 임계 영역(critical section)에 들어가려고 요청한 후부터 그 요청이 허용될 때까지 다른 프로세스들이 임계 영역에 들어가는 횟수에 한계가 있어야 한다.


* 가정: 
    * 모든 프로세스들의 수행 속도는 0보다 크다.
    * 프로세스들 간의 상대적인 수행 속도는 가정하지 않는다.
    
   
&nbsp;   
### 알고리즘 1
```
Synchronization variable:
    int turn;
    initially turn = 0;  => Pi는 (turn == i)일 때, critical section에 들어갈 수 있다. 

Process P0:
do {
    while(trun != 0);  // My turn?
    critical section
    turn = 1;           // Now it's your turn
    remainder section
} while(1)
```


위 알고리즘은 충족 조건 중 상호 배제를 만족하지만 진행을 만족시키지 못한다.
* 즉, 과잉 양보: 반드시 한번씩 교대로 들어가야만 함(swap-turn). 상대방이 turn을 내 값으로 바꿔줘야만 내가 들어갈 수 있음. 특정 프로세스가 더 빈번히 임계 영역에 들어가야 한다면 요구를 충족시켜주지 못함.


&nbsp;
### 알고리즘 2
```
Synchronization variable:
    boolean flag[2];
    initially flag[모두] = false    // critical section에 아무도 없다
    Pi는 (flag[i] == true)일 때, critical section에 들어갈 준비가 된다.

Process Pi:
    do {
        flag[i] = true;     // Pretend I am in
        while(flag[j]);    // Is he also in? then wait
        critical section
        flag[i] = false;    // I am out now
        remainder section
    } while(1);
```


위 알고리즘은 충족 조건 중 상호 배제를 만족하지만 진행을 만족시키지 못한다.
* 둘 다 2행까지 수행 후 끊임 없이 양보하는 상황이 발생 가능하다.


&nbsp;
### 알고리즘 3
알고리즘1, 2의 동기화 변수들(Synchronization variables)을 결합한다. 결합한다.
```
Process Pi:
    do {
        flag[i] = true;     // My intention is to enter...
        turn = j;           // Set to his turn
        while(flag[j] && turn == j);    // Wait only if...
        critical section
        flag[i] = false;
        remainder section
    } while(1);
```


위 알고리즘은 세 가지 충족 조건을 모두 만족시키므로 두 프로세스에 대한 임계 영역 문제를 해결하였다. 
* 하지만 계속 CPU와 Memory를 사용하면서 wait하기 때문에 Busy waiting(= spin lock) 상황이 발생할 수 있다.


&nbsp;
### 동기화 하드웨어
하드웨어적으로 Test & modify를 atomic하게 수행할 수 있도록 지원하는 경우 앞의 문제는 간단히 해결된다.


![test&set]()


Test & Set으로 상호 배제:
```
Synchronization variable:
    boolean lock = false;
    
Process Pi:
    do {
        while(Test_and_Set(lock));
        critical section
        lock = false;
        remainder section
    }
```


&nbsp;
## 세마포어(Semaphore)
세마포어는 앞의 방식들을 추상화시킨 방법이다.
* Semaphore: 공유 자원을 획득, 반납 처리
* P연산: 세마포어 값(공유 데이터) 획득
* V연산: 반납
```
Semaphore S:
    integer variable
    아래의 두 가지 atomic 연산에 의해서만 접근 가능
    P(S):   while(S<=0) do no-op;
            S--;
            // S가 양수일 경우 감소시키고,
            // 음수라면 양수가 될 때까지 기다린다(busy-wait).
    V(S):   S++;
```


&nbsp;
### Busy-Wait
```
Synchronization variable:
    semaphore mutex;    // initially 1: 1개가 critical section에 들어갈 수 있다.

Process Pi:
    do {
        P(mutext);      // If positive, dec-&-enter, Otherwise, wait.
        critical section
        V(mutext);      // Increment semaphore
        remainder section
    } while(1);
```


Busy-Wait 방식은 효율적이지 못하다(= spin lock). 따라서 Block & Wakeup 방식으로 구현해야 한다(= sleep lock).


&nbsp;
### Block/Wakeup
세마포어를 다음과 같이 정의:
```
typedef stuct {
    int value;          // semaphore
    struct process *L;  // process wait queue
} semaphore;
```


block과 wakeup을 다음과 같이 가정한다:
* block: 커널은 block을 호출한 프로세스를 suspend시키고 이 프로세스의 PCB를 세마포어에 대한 wait queue에 넣는다.
* wakeup(P): block된 프로세스 P를 wakeup시키고 이 프로세스의 PCB를 ready queue로 옮긴다.


![bock&wakeup]()


세마포어 연산이 이제 다음과 같이 정의된다:
```
P(S):   S.value--;          // prepare to enter
        if(S.value < 0) {   // Oops, negative, I cannot enter
            add this process to S.L;
            block();
        }
```
```
V(S):   S.value++;
        if(S.value <= 0) {
            remove a process P from S.L;
            wakeup(P):
        }
```


#### Busy-Wait와 Block/Wakeup 비교
* 임계 영역의 길이가 긴 경우 Block/Wakeup이 적당
* 임계 영역의 길이가 매우 짧은 경우 Block/Wakeup 오버헤드가 Busy-Wait 오버헤드보다 더 커질 수 있다.
* 일반적으로는 Block/Wakeup 방식이 더 좋다.


&nbsp;
### 세마포어의 두 타입
Counting semaphore:
* 도메인이 0이상인 임의의 정수값
* 주로 resource counting에 사용


Binary semaphore(= mutex)
* 0또는 1값만 가질 수 있는 semaphore
* 주로 mutual exclusion(lock/unlock)에 사용


&nbsp;
### 데드록 및 기아현상
데드록(Deadlock)
* 둘 이상의 프로세스가 서로 상대방에 의해 충족될 수 있는 event를 무한히 기다리는 현상
* S와 Q가 1로 초기화된 세마포어라 할 때:


![deadlock]()


기아현상(Starvation)
* 무기한 차단(Indefinite blocking). 프로세스가 suspend된 이유에 해당하는 세마포어 큐에서 빠져나갈 수 없는 현상


&nbsp;
### Bounded-Buffer Problem
Producer(생산자):
1. Empty 버퍼 확인한다(없으면 기다림).
2. 공유 데이터에 lock을 건다.
3. Empty 버퍼에 데이터 입력 및 버퍼 조작.
4. Lock을 푼다.
5. Full 버퍼를 하나 증가시킨다.


Consumer(소비자):
1. Full 버퍼 확인한다(없으면 기다림).
2. 공유 데이터에 lock을 건다.
3. Full 버퍼에서 데이터를 꺼내고 버퍼 조작.
4. Lock을 푼다.
5. Empty 버퍼를 하나 증가시킨다.


![bounded-buffer problem]()


동기화 문제: 공유 버퍼에 생산자(소비자) 둘이 접근할 때 발생 -> lock을 걸어 해결한다. 
* 버퍼는 유한하고 가득찬 상황이 되면 생산자는 소비자가 올때 까지 기다린다. 반대로 버퍼가 빈 상황이 되면 소비자도 생산자가 올 때 까지 기다린다.
* 동기화 문제를 해결하기 위해 바이너리 세마포어(상호 배제)와 인테저 세마포어(자원 카운팅)가 필요하다.


Shared data: 
* 버퍼 자체 및 버퍼 조작 변수(empty/full 버퍼의 시작 위치)


Synchronization variables:
* 상호 배제(mutual exclusion) -> Need binary semaphore (shred data의 mutual exclusion을 위해)
* 자원 카운팅(resource count) -> Need integer semaphore (남은 full/empty buffer의 수 표시)

    
```
Synchronization variables:
semaphore full = 0, empty = n, mutex = 1;

Producer:                           
    do {                          
        ...                         
        produce an item in x
        ...
        P(empty);
        P(mutex);
        ...
        add x to buffer
        ...
        V(mutex);
        V(full);
    } while(1);
    
Consumer:
    do {
        P(full)
        P(mutex);
        ...
        remove an item from buffer to y
        ...
        V(mutex);
        V(empty);
        ...
        consume the item in y
        ...
    } while(1);
```


&nbsp;
### Readers-Writers Problem
한 프로세스가 DB(공유 자원)에 write 중일 때 다른 프로세스가 접근하면 안된다. 하지만 read는 동시에 여럿이 해도 된다.


해결 방안:
* Writer가 DB에 접근 허가를 아직 얻지 못한 상태에서는 모든 대기중인 Reader들을 다 DB에 접근하게 해준다.
* Writer는 대기 중인 Reader가 하나도 없을 때 DB 접근이 허용된다.
* 일단 Writer가 DB에 접근 중이면 Reader들은 접근이 금지된다.
* Writer가 DB에서 빠져나가야만 Reader의 접근이 허용된다.


Shared data:
* DB 자체
* readcount;    // 현재 DB에 접근 중인 Reader의 수


Synchronization variables:
* mutex   // 공유 변수 readcount를 접근하는 코드(임계 영역)의 상호 배제 보장을 위해 사용
* db        // Reader와 Writer가 공유 DB 자체를 올바르게 접근하게 하는 역할 


```
Shared date:
    int readcount = 0;
    DB 자체;
    
Synchronization variables:
    semaphore mutex = 1, db = 1;
    
Writer:
    P(db);
    ...
    writing DB is performed
    ...
    V(db);
    
    ! Starvation 발생 가능
    
Reader:
    P(mutex);
    readcount++;
    if(readcount == 1) { P(db); }   // block writer
    V(mutex);                       // readers follow
    ...
    reading DB is performed
    ...
    P(mutex);
    readcount--;
    if(readcount == 0) { V(db); }   // enable writer
    V(mutex);
```

&nbsp;
### Dining-Philosophers Problem


![dining-philosophers problem]()

```
Synchronization variables:
    semaphore chopstick[5]; // initially all values are 1

Philosopher i
    do {
        P(chopstick[i]);
        P(chopstick[(i + 1) % 5]);
        ...
        eat();
        ...
        V(chopstick[i]);
        V(chopstick[(i + 1) % 5]);
        ...
        think();
        ...
    } while(1);
```


앞의 해결 방안의 문제점:
* Deadlock 가능성이 있다.
* 모든 철학자가 동시에 배가 고파져 왼쪽 젓가락을 집어버린 경우


해결 방안:
* 4명의 철학자만이 테이블에 동시에 앉을 수 있도록 한다.
* 젓가락을 두 개 모두 집을 수 있을 때에만 젓가락을 집을 수 있게 한다.
* 비대칭: 짝수(홀수) 철학자는 왼쪽(오른쪽) 젓가락부터 집도록한다.


```
Synchronization variables:
    enum { thinking, hungry, eating } state[5];
    semaphore self[5] = 0;
    semaphore mutex = 1;

Philosopher i
    do {
        pickup(i);
        eat()
        putdown(i);
        think();
    } while(1);
    
    void putdown(int i) {
        P(mutex);
        state[i] = thinking;
        test((i + 4) % 5);
        test((i + 1) % 5);
        V(mutex);
    }
    
    void pickup(int i) {
        P(mutex);
        state[i] = hungry;
        test(i);
        V(mutex);
        P(self[i]);
    }
    
    void test(int i) {
        if(state[(i + 4) % 5] != eating && state[i] == hungry && state[(i + 1) % 5] != eating) {
            state[i] = eating;
            V(self[i]);
        }
    }
```


&nbsp;
## 모니터(Monitor)
세마포어는 다음과 같은 문제점이 있다:
* 코딩하기 힘들다.
* 정확성(correctness)의 입증이 어렵다.
* 자발적 협력(voluntary cooperation)이 필요하다.
* 한번의 실수가 모든 시스템에 치명적 영향을 끼친다.


![세마포어 문제점 예]()


모니터란 동시 수행중인 프로세스 사이에서 abstract data type의 안전한 공유를 보장하기 위한 high-level synchronization construct이다.
```
monitor monitor-name {
    shared variable declarations
    procedure body P1(...) {
        ...
    }
    procedure body P2(...) {
        ...
    }
    procedure body Pn(...) {
        ...
    }
    {
        initialization code
    }
}
```


![monitor]()


모니터의 특징:
* 모니터 내에서는 한번에 하나의 프로세스만이 활동 가능하다.
* 프로그래머가 동기화 제약 조건을 명시적으로 코딩할 필요가 없다.
* 프로세스가 모니터 안에서 기다릴 수 있도록 하기 위해 condition variable 사용 (예: condition x, y;)
* Condition variable은 wait와 signal 연산에 의해서만 접근 가능하다. 
    * x.wait()을 invoke한 프로세스는 다른 프로세스가 x.signal()을 invoke하기 전까지 suspend가 된다.
    * x.signal()은 정확하게 하나의 suspend된 프로세스를 resume한다. suspend된 프로세스가 없으면 아무 일도 일어나지 않는다.


&nbsp;
### Bounded-Buffer Problem
```
monitor bounded_buffer {
    int buffer[N];
    condition full, empty:
    // condition var는 값을 가지지 않고 자신의 큐에 프로세스를 매달아서 
    // sleep 시키거나 큐에서 프로세스를 깨우는 역할만 함

    void produce(int x) {
        if ther is no empty buffer {
            empty.wait();
        }
        add x to an empty buffer
        full.signal();
    }
    
    void consume(int *x) {
        if ther is no full buffer {
            full.wait();
        }
        remove an item from buffer and store it to *x
        empty.signal();
    }
}
```


&nbsp;
### Dining Philosophers Problem
```
monitor dining_philosopher {
    enum { thinking, hungry, eating } state[5];
    condition self[5];

    void pickup(int i) {
        state[i] = hungry;
        test(i);
        if(state[i] != eating) {
            self[i].wait(); // wait here
        }
    }
    
    void putdown(int i) {
        state[i] = thinking;
        // test left and right neighbors
        test((i + 4) % 5);  // if L is waiting
        test((i + 1) % 5);
    }
    
    void test(int i) {
        if((state[(i + 4) % 5] != eating) && (state[i] == hungry) && (state[(i + 1) % 5] != eating)) {
            state[i] = eating;
            self[i].signal();   // wake up Pi
        }
    }
    
    void init() {
        for(int i = 0; i < 5; i++) {
            state[i] = thinking;
        }
    }
}

Each Philosoper:
{
    pickup(i);  // Enter monitor
    eat();
    putdown(i); // Enter monitor
    think();
} while(1)
```


&nbsp;
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### 출처: [운영 체제와 정보 기술의 원리](http://book.naver.com/bookdb/book_detail.nhn?bid=4392911), [반효경 운영체제 강의](http://www.kocw.net/home/search/kemView.do?kemId=1046323)

