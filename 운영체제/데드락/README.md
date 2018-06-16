# 데드락


* [데드락 문제](#데드락-문제)
    * [데드락 발생의 4가지 조건](#데드락-발생의-4가지-조건)
    * [자원 할당 그래프(Resource-Allocation Graph)](#자원-할당-그래프resource-allocation-graph)
    * [데드락의 처리 방법](#데드락의-처리-방법)
* [데드락 예방(Deadlock Prevention)](#데드락-예방deadlock-prevention)
* [데드락 회피(Deadlock Avoidance)](#데드락-회피deadlock-avoidance)
    * [Resource Allocation Graph Algorithm](#resource-allocation-graph-algorithm)
    * [Banker's Algorithm](#banker's-algorithm)
* [데드락 발견 및 회복(Deadlock Detection and recovery)](#데드락-발견-및-회복deadlock-detection-and-recovery)
    * [데드락 발견](#데드락-발견)
    * [데드락 회복](#데드락-회복)
* [데드락 무시(Deadlock Ignorance)](#데드락-무시deadlock-ignorance)


&nbsp;      
## 데드락 문제
데드락(Deadlock 또는 교착상태)이란 일련의 프로세스들이 서로가 가진 자원을 기다리며 block된 상태를 말한다.


자원(Resource)이란 하드웨어, 소프트웨어 등을 포함하는 개념이다.
* 예) I/O device, CPU cycle, memory space, semaphore 등
* 프로세스가 자원을 사용하는 절차: Request, Allocate, Use, Release


데드락 예제:
* 시스템에 2개의 tape drive가 있을 때, 프로세스 P1과 P2 각각이 하나의 tape drive를 보유한 채 다른 하나를 기다리고 있는 상황.
* 바이너리 세마포어 A와 B가 있을 때, 아래와 같은 상황.
```
 P1      P2
P(A);   P(B);
P(B);   P(A);
```


&nbsp;      
### 데드락 발생의 4가지 조건
#### 상호 배제(Mutual exclusion)
매 순간 하나의 프로세스만이 자원을 사용할 수 있다.


#### 비선점(No preemption)
프로세스는 자원을 스스로 내어놓을 뿐 강제로 빼앗기지 않는다.


#### 보유 대기(Hold and wait)
자원을 가진 프로세스가 다른 자원을 기다릴 때 보유 자원을 놓지 않고 계속 가지고 있다.


#### 순환 대기(Circular wait)
자원을 기다리는 프로세스간에 사이클이 형성되어야 한다.
* 프로세스 P0, P1, ... Pn이 있을 때, 
    * P0는 P1이 가진 지원을 기다림
    * P1은 P2가 가진 지원을 기다림
    * Pn-1은 Pn이 가진 지원을 기다림
    * Pn은 P0가 가진 지원을 기다림
    
    
&nbsp;      
### 자원 할당 그래프(Resource-Allocation Graph)


![자원 할당 그래프1](https://github.com/0jun0815/YJStudy/blob/master/운영체제/데드락/images/자원%20할당%20그래프1.png)


* Vertex(정점):
    * Process P = {P1, P2, ..., Pn}
    * Resource R = {R1, R2, ..., Rm}
* Edge(모서리):
    * request edge Pi -> Rj (프로세스가 자원을 요청)
    * assignment edge Rj -> Pi (자원을 프로세스에 할당)
    
    
![자원 할당 그래프2](https://github.com/0jun0815/YJStudy/blob/master/운영체제/데드락/images/자원%20할당%20그래프2.png)


* 그래프에 cycle이 없으면 데드락이 아니다.
* 그래프에 cycle이 있으면:
    * 자원 유형당 인스턴스가 하나 뿐인 경우, 데드락이다.
    * 자원 유형당 인스턴스가 여러 개인 경우, 데드락이 발생할 수 있다.
    
    
nbsp;
### 데드락의 처리 방법
#### 데드락 예방(Deadlock Prevention)
자원 할당 시 데드락의 4가지 필요 조건(상호 배제, 비선점, 보유 대기, 순환 대기) 중 어느 하나가 만족되지 않도록 하는 것.


#### 데드락 회피(Deadlock Avoidance)
자원 요청에 대한 부가적인 정보를 이용해서 데드락의 가능성이 없는 경우에만 자원을 할당한다. 시스템 state가 원래 state로 돌아올 수 있는 경우에만 자원을 할당한다.


#### 데드락 발견 및 회복(Deadlock Detection and recovery)
데드락 발생은 허용하되 그에 대한 detection 루틴을 두어 데드락 발견시 recover 한다.


#### 데드락 무시(Deadlock Ignorance)
데드락을 시스템이 책임지지 않는다. UNIX를 포함한 대부분의 OS가 채택.


&nbsp;      
## 데드락 예방(Deadlock Prevention)
#### 상호 배제
공유해서는 안되는 자원의 경우 반드시 성립해야 한다.


#### 보유 대기
프로세스가 자원을 요청할 때 다른 어떤 자원도 가지고 있지 않아야 한다.
* 방법 1. 프로세스 시작 시 모든 필요한 자원을 할당받게 하는 방법
* 방법 2. 자원이 필요할 경우 보유 자원을 모두 놓고 다시 요청


#### 비선점
프로세스가 어떤 자원을 기다려야 하는 경우 이미 보유한 자원이 선점된다. 모든 필요한 자원을 얻을 수 있을 때 그 프로세스는 다시 시작된다.
* state를 쉽게 save하고 restore할 수 있는 자원에서 주로 사용 (CPU, memory)


#### 순환 대기
모든 자원 유형에 할당 순서를 정하여 정해진 순서대로만 자원을 할당한다.
* 예를 들어 순서가 3인 자원 Ri를 보유 중인 프로세스가 순서가 1인 자원 Rj를 할당받기 위해서는 우선 Ri를 release해야 한다.


데드락 예방 방법은 사용량 저하, 처리량 감소, 기아현상이 발생한다는 문제가 있다.


&nbsp;      
## 데드락 회피(Deadlock Avoidance)
데드락 회피 방법은 자원 요청에 대한 부가정보를 이용해서 자원 할당이 데드락으로부터 안전(safe)한지를 동적으로 조사해서 안전한 경우에만 할당한다.


가장 단순하고 일반적인 모델은 프로세스들이 필요로 하는 각 자원별 최대 사용량을 미리 선언하도록 하는 방법이다.


안전 상태(safe state)
* 시스템 내의 프로세스들에 대한 안전 시퀀스(safe sequence)가 존재하는 상태


안전 시퀀스(safe sequence)
* 프로세스의 sequence<P1, P2, ..., Pn>이 safe하려면 Pi(1 <= i <= n)의 자원 요청이 **가용 자원 + 모든 Pj (j < i)의 보유 자원**에 의해 충족되어야 함.
* 조건을 만족하면 다음 방법으로 모든 프로세스의 수행을 보장한다:
    * Pi의 자원 요청이 즉시 충족될 수 없으면 모든 Pj (j < i)가 종료될 때까지 기다린다.
    * Pj-1이 종료되면 Pi의 자원요청을 만족시켜 수행한다.
    
    
![데드락 회피](https://github.com/0jun0815/YJStudy/blob/master/운영체제/데드락/images/데드락%20회피.png)


* 시스템이 safe state에 있으면 => 데드락이 발생하지 않는다.
* 시스템이 unsafe state에 있으면 => 데드락이 발생할 수 있다.


데드락 회피 방법은 시스템이 unsafe state에 들어가지 않는 것을 보장해야 한다. 다음과 같은 2가지의 회피 알고리즘이 있다:
* 자원 유형당 하나의 인스턴스: Resource Allocation Graph Algorithm 사용
* 자원 유형당 여러 개의 인스턴스: Banker's Algorithm 사용


&nbsp;
### Resource Allocation Graph Algorithm
Claim edge Pi -> Rj
* 프로세스 Pi가 자원 Rj를 미래에 요청할 수 있음을 뜻한다(점선으로 표시).
* 프로세스가 해당 자원 요청시 request edge로 바뀐다(실선).
* Rj가 release되면 assignment edge는 다시 claim edge로 바뀐다.


Request edge의 assignment dege 변경시 (점선을 포함하여) cycle이 생기지 않는 경우에만 요청 자원을 할당한다.


Cycle 생성 여부 조사시 프로세스의 수가 n일 때 O(n²) 시간이 걸린다.


![Resource Allocation Graph Algorithm](https://github.com/0jun0815/YJStudy/blob/master/운영체제/데드락/images/Resource%20Allocation%20Graph%20Algorithm.png)


&nbsp;
### Banker's Algorithm
가정:
* 모든 프로세스는 자원의 최대 사용량을 미리 명시한다.
* 프로세스가 요청 자원을 모두 할당받은 경우 유한 시간 안에 이들 자원을 다시 반납한다.


방법:
* 기본 개념: 자원 요청시 safe 상태를 유지할 경우에만 할당한다.
* 총 요청 자원의 수가 가용 자원의 수보다 적은 프로세스를 선택한다(그런 프로세스가 없으면 unsafe 상태)
* 그런 프로세스가 있으면 그 프로세스에게 자원을 할당한다.
* 할당받은 프로세스가 종료되면 모든 자원을 반납한다.
* 모든 프로세스가 종료될 때까지 이러한 과정을 반복한다.


#### Banker's Algorithm 예제

![Banker's Algorithm1](https://github.com/0jun0815/YJStudy/blob/master/운영체제/데드락/images/Banker's%20Algorithm1.png)


* sequence <P1, P3, P4, P0, P2>가 존재하므로 시스템은 safe state이다.
* P1이 자원을 요청했을 경우, Need <= Available 인지 확인한다. (1, 2, 2) <= (3, 3, 2) 이므로 true


![Banker's Algorithm2](https://github.com/0jun0815/YJStudy/blob/master/운영체제/데드락/images/Banker's%20Algorithm2.png)


* sequence <P1, P3, P4, P0, P2>가 존재하므로 시스템은 safe state이다.


&nbsp;      
## 데드락 발견 및 회복(Deadlock Detection and recovery)
### 데드락 발견
* 자원 유형당 하나의 인스턴스인 경우 자원할당 그래프에서의 cycle이 곧 데드락을 의미한다.
* 자원 유형당 여러 개의 인스턴스인 경우 은행원 알고리즘과 유사한 방법을 활용한다.


#### Wait-for graph 알고리즘
자원 유형당 하나의 인스턴스인 경우 사용된다.


Wait-for graph는 자원할당 그래프의 변형으로 프로세스만으로 node를 구성한다.
* Pj가 가지고 있는 자원을 Pk가 기다리는 경우 Pk -> Pj


알고리즘은 Wait-for graph에 사이클이 존재하는지를 주기적으로 조사하며 O(n²) 시간이 소요된다.


![Wait-for graph](https://github.com/0jun0815/YJStudy/blob/master/운영체제/데드락/images/Wait-for%20graph.png)


* 자원의 최대 사용량을 미리 알릴 필요가 없다. => 그래프에 점선이 없음.


#### 자원 유형당 여러 개의 인스턴스인 경우
![데드락 발견 및 화복1](https://github.com/0jun0815/YJStudy/blob/master/운영체제/데드락/images/데드락%20발견%20및%20화복1.png)


* sequence <P0, P2, P3, P4, P1>이 형성되므로 데드락이 없다.
* Request는 추가 요청 가능량이 아니라 현재 실제로 요청한 자원량을 나타낸다.



다음과 같이 P2가 C유형의 자원에 추가적인 요청을 할 경우:


![데드락 발견 및 화복2](https://github.com/0jun0815/YJStudy/blob/master/운영체제/데드락/images/데드락%20발견%20및%20화복2.png)


* P0 완료 후 자원 반납이 가능하지만 충분하지는 않다. 따라서 데드락이 존재 한다(P1, P2, P3, P4).


&nbsp;
### 데드락 회복
#### Process Termination
두 가지 방법이 있다:
* 데드락된 모든 프로세스를 중단(abort)한다.
* 데드락 cycle이 제거될 때까지 한 번에 하나의 프로세스를 중단한다.


#### Resource Preemption
비용을 최소화할 victim(희생자)의 선정하고 safe state로 rollback하여 프로세스를 restart한다.


Starvation(기아 현상) 문제가 발생할 수 있다.
* 동일한 프로세스가 계속해서 victim으로 선정되는 경우
* 따라서 cost factor에 rollback 횟수도 같이 고려해야 한다.


&nbsp;      
## 데드락 무시(Deadlock Ignorance)
데드락 무시는 데드락이 일어나지 않는다고 생각하고 아무런 조치도 취하지 않는 방법이다.
* 데드락은 매우 드물게 발생하므로 데드락에 대한 조치 자체가 더 큰 오버헤드 일 수 있다.
* 만약, 시스템에 데드락이 발생한 경우 시스템이 비정상적으로 작동하는 것을 사람이 느낀 후 직접 프로세스를 죽이는 등의 방법으로 대처한다.
* UNIX, Windows 등 대부분의 범용 OS가 채택한 방법이다.


&nbsp;  
&nbsp;  
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### 출처: [운영 체제와 정보 기술의 원리](http://book.naver.com/bookdb/book_detail.nhn?bid=4392911), [반효경 운영체제 강의](http://www.kocw.net/home/search/kemView.do?kemId=1046323)

