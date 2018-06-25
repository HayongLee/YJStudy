# Concurrency Programming Guide


* [Concurrency and Application Design](#concurrency-and-application-design)
    * [The Move Away from Threads](#the-move-away-from-threads)


&nbsp;    
## Concurrency and Application Design
### The Move Away from Threads
스레드는 수년 동안 계속 사용되어 왔지만 확장 가능한 방식으로 여러 작업을 실행하는 일반적인 문제를 해결하지 못한다. 스레드를 사용하면 확장 가능한 솔루션을 만드는 부담이 개발자의 어깨에 달려 있다. 시스템 상태가 변함에 따라 동적으로 생성하고 조정할 스레드 수를 결정해야 한다. 또 다른 문제점은 애플리케이션이 사용하는 스레드를 만들고 유지 관리하는 것과 관련된 대부분의 비용을 가정한다는 것이다.


스레드에 의존하는 대신 OS X 및 iOS는 동시성 문제를 해결하기 위해 비동기식 설계 방식을 사용한다. 비동기 함수는 오랫동안 운영체제에 있었으며 종종 디스크에서 데이터를 읽는 것과 같이 오랜 시간이 걸릴 수 있는 작업을 시작하는 데 사용된다. 호출 될 때 비동기 함수는 작업의 실행을 시작하기 위해 배후에서 작동하지만 실제로 작업이 완료되기 전에 반환된다. 일반적으로 이 작동은 백그라운드 스레드를 획득하고 해당 스레드에서 원하는 작업을 시작한 다음 작업이 완료되면 호출자에게 (일반적으로 콜백 함수를 통해) 알림을 보낸다. 과거에는, 당신이 하고 싶은 것을 위해 비동기 함수가 존재하지 않는다면, 당신은 자신의 비동기 함수를 작성하고 자신만의 스레드를 만들어야 했다. 그러나 이제 OS X 및 iOS는 스레드를 직접 관리하지 않고도 모든 작업을 비동기적으로 수행할 수 있는 기술을 제공한다.


비동기식으로 작업을 시작하는 기술 중 하나는 Grand Central Dispatch(GCD)이다. 이 기술은 일반적으로 자신의 애플리케이션에서 쓰는 스레드 관리 코드를 사용하여 해당 코드를 시스템 레벨로 이동시킨다. 실행할 작업을 정의하고 이를 적절한 디스패치 큐에 추가하기만 하면 된다. GCD는 필요한 스레드를 생성하고 해당 스레드에서 실행되도록 작업을 스케줄링한다. 스레드 관리가 이제 시스템의 일부이므로 GCD는 작업 관리 및 실행에 대한 전체론적 접근 방식을 제공하여 전통적인 스레드보다 더 나은 효율성을 제공한다.


연산 큐는 디스패치 큐와 매우 유사한 Objective-C 객체이다. 실행할 작업을 정의한 다음 연산 큐에 추가하여 해당 작업의 스케줄링 및 실행을 처리한다. GCD와 마찬가지로 연산 큐는 모든 스레드 관리를 처리하여 시스템에서 가능한한 신속하고 효율적으로 작업을 실행하도록 한다.


다음 절에서는 애플리케이션에서 사용할 수 있는 디스패치 큐, 연산 큐 및 기타 관련 비동기 기술에 대해 자세히 설명한다.


#### Dispatch Queues
디스패치 큐는 커스텀 작업을 실행하기 위한 C 기반 메커니즘이다. 디스패치 큐는 작업을 순차적으로 또는 동시해 수행하지만 항상 선입선출로 수행한다. 즉, 디스패치 큐는 항상 큐에 추가된 것과 동일한 순서로 큐에서 제거(디큐) 작업을 시작한다. 직렬(serial) 디스패치 큐는 한 번에 하나의 작업만 실행하고 해당 작업이 큐에서 나가기 전에 완료될 때까지 대기하고 새 큐를 시작한다. 반대로 동시(concurrency) 디스패치 큐는 이미 시작된 작업이 완료될 때까지 기다리지 않고 가능한 많은 작업을 시작한다.


디스패치 큐의 장점:
* 간단하고 단순한 프로그래밍 인터페이스를 제공한다.
* 자동 및 전체 스레드 풀 관리 기능을 제공한다.
* 튜닝 된 어셈블리 속도를 제공한다.
* 스레드 스택이 애플리케이션 메모리에 남아있지 않기 때문에 훨씬 더 효율적이다.
* 로드 중에 커널에 트랩되지 않는다.
* 디스패치 큐에 작업을 비동기적으로 전달하면 큐를 교착 상태(데드락)으로 만들 수 없다.
* 논쟁하에 우아하게 확장된다.
* 직렬 디스패치 큐는 락 및 기타 동기화 프리미티브보다 효율적인 대안을 제공한다.


디스패치 큐에 제출하는 작업은 함수 또는 블록 객체 내에 캡슐화되어야 한다. 블록 객체는 함수 포인터와 비슷한 OS X v10.6 및 iOS 4.0에 도입 된 C언어 기능이지만 몇 가지 추가 이점이 있다. 자신의 어휘 범위에서 블록을 정의하는 대신 일반적으로 블록을 다른 함수 또는 메서드 내에 정의하여 해당 함수 또는 메서드의 다른 변수에 접근할 수 있다. 블록을 원본 범위 밖으로 이동하고 힙에 복사할 수도 있다. 디스패치 큐에 블록을 제출하면 블록이 복사된다. 이러한 모든 의미는 상대적으로 적은 코드로 매우 동적인 작업을 구현할 수 있게 한다.


디스패치 큐는 Grand Central Dispatch 기술의 일부이며 C 런타임의 일부인다. 애플리케이션에서 디스패치 큐 사용에 대한 자세한 내용은 [Dispatch Queues](https://developer.apple.com/library/archive/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/OperationQueues.html#//apple_ref/doc/uid/TP40008091-CH102-SW1)를 참조. 블록 및 이점에 대한 자세한 내용은 [Blocks Programming Topics](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Blocks/Articles/00_Introduction.html#//apple_ref/doc/uid/TP40007502) 참조.


#### Dispatch Sources
디스패치 소스는 특정 타입의 시스템 이벤트를 비동기적으로 처리하기 위한 C 기반 메커니즘이다. 디스패치 소스는 특정 타입의 시스템 이벤트에 대한 정보를 캡슐화하고 해당 이벤트가 발생할 때마다 특정 블록 객체 또는 함수를 디스패치 큐로 전송한다. 디스패치 소스를 사용하여 다음 타입의 시스템 이벤트를 모니터링 할 수 있다:
* Timer
* Signal handlers
* Descriptor-related events
* Process-related events
* Mach port events
* Custom events that you trigger


디스패치 소느는 Grand Central Dispatch 기술의 일부이다. 디스패치 소스를 사용하여 애플리케이션에서 이벤트를 수신하는 방법에 대한 자세한 내용은 [Dispatch Sources](https://developer.apple.com/library/archive/documentation/General/Conceptual/ConcurrencyProgrammingGuide/GCDWorkQueues/GCDWorkQueues.html#//apple_ref/doc/uid/TP40008091-CH103-SW1)를 참조.


#### Operation Queues
연산 큐는 동시 디스패치 큐와 동일한 Cocoa이며 [NSOperationQueue](https://developer.apple.com/documentation/foundation/operationqueue) 클래스에 의해 구현된다. 디스패치 큐는 항상 선입선출 순서로 작업을 실행하지만 연산 큐는 작업의 실행 순서를 결정할 때 다른 요인을 고려한다. 이러한 요소 중 가장 중요한 것은 주어진 작업이 다른 작업의 완료 여부에 의존하는지 여부이다. 작업을 정의할 때 종속성을 구성하고 이를 사용하여 작업에 대한 복잡한 실행 순서 그래프를 만들 수 있다.


연산 큐에 제출하는 작업은 [NSOperation](https://developer.apple.com/documentation/foundation/nsoperation) 클래스의 인스턴스여야 한다. 연산 객체는 수행할 작업과 해당 작업을 수행하는 데 필요한 데이터를 캡슐화하는 Objective-C 객체이다. 기본적으로 NSOperation 클래스는 추상 기본 클래스이기 때문에 일반적으로 커스텀 서브 클래스를 정의하여 작업을 수행한다. 그러나 Foundation 프레임 워크에는 작업을 수행하기 위해 만들고 사용할 수 있는 몇 가지 구체적인 서브 클래스가 포함되어 있다. 


연산 객체는 키-값 관찰(KVO) 알림을 생성하므로 작업 진행 상황을 모니터링하는 유용한 방법이 될 수 있다. 연산 큐는 항상 작업을 동시에 실행하지만 종속성을 사용하여 필요할 때 순차적으로 실행되도록 할 수 있다.


연산 큐를 사용하는 방법과 커스텀 연산 객체를 정의하는 방법에 대한 자세한 내용은 [Operation Queues](https://developer.apple.com/library/archive/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationObjects/OperationObjects.html#//apple_ref/doc/uid/TP40008091-CH101-SW1)를 참조


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation Concurrency Programming Guide](https://developer.apple.com/library/archive/documentation/General/Conceptual/ConcurrencyProgrammingGuide/Introduction/Introduction.html)
