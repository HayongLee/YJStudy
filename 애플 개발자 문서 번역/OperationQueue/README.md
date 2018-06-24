# OperationQueue
> 연산의 실행을 규제하는 큐.


* [Overview](#overview)
* [Determining Execution Order](#determining-execution-order)
* [Canceling Operations](#canceling-operations)
* [KVO-Compliant Properties](#kvo-compliant-properties)
* [Thread Safety](#thread-safety)
* [Topics](#topics)
    * [Accessing Specific Operation Queues](#accessing-specific-operation-queues)
    * [Managing Operations in the Queue](#managing-operations-in-the-queue)
    * [Managing the Execution of Operations](#managing-the-execution-of-operations)
    * [Suspending Execution](#suspending-execution)
    * [Configuring the Queue](#configuring-the-queue)


&nbsp;    
## Overview
연산 큐는 큐에 있는 [Operation](https://developer.apple.com/documentation/foundation/operation) 객체를 우선 순위 및 준비 상태에 따라 실행한다. 연산 큐에 추가된 연산은 작업이 끝났음을 보고 할 때까지 큐에 남아있는다. 큐에 추가된 연산은 직접 큐에서 제거할 수 없다.


> Note
>
> 연산 큐는 연산이 끝날 때까지 연산을 유지하며 큐 자체는 모든 연산이 완료될 때까지 유지된다. 완료되지 않은 연산으로 연산 큐를 일시 중단하면 메모리 누수가 발생할 수 있다.


연산 큐 사용에 대한 자세한 정보는 [Concurrency Programming Guide](https://developer.apple.com/library/archive/documentation/General/Conceptual/ConcurrencyProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40008091)를 참조한다.


&nbsp;
## Determining Execution Order
큐 내의 연산은 준비 상태, 우선 순위 레벨 및 상호 연산 종속성에 구성되며 그에 따라 실행된다. 큐에있는 모든 연산에 동일한 [queuePriority](https://developer.apple.com/documentation/foundation/operation/1411204-queuepriority)가 있고 큐에 넣을 때 실행할 준비가 된 경우(즉, 해당 [isReady](https://developer.apple.com/documentation/foundation/operation/1412992-isready) 프로퍼티가 true를 반활 할 때) 큐로 전송된 순서대로 실행된다. 그렇지 않으면 연산 큐는 항상 다른 준비 작업과 관련하여 가장 높은 우선 순위를 갖는 연산 큐를 실행한다.


그러나 연산의 준비 순서를 변경하면 결과 실행 순서가 변경될 수 있으므로 연산의 특정 실행 순서를 보장하기 위해 큐 의미에 의존해서는 안된다. 상호 연산 의존성은 연산이 다른 연산 큐에 있더라도 연산의 절대 실행 순서를 제공한다. 연산 객체는 모든 종속 연산이 실행을 완료 할 때까지 실행 준비가 되어 있지 않는다. 


우선 순위 레벨 및 종속성을 설정하는 방법에 대한 자세한 내용은 [Operation](https://developer.apple.com/documentation/foundation/operation)의 [Managing Dependencies](https://developer.apple.com/documentation/foundation/operation#1661485)를 참조.


&nbsp;
## Canceling Operations
연산을 완료했다고 해서 반드시 연산이 수행되어 해당 작업이 완료되었다는 의미는 아니다. 연산을 취소할 수도 있다. 연산 객체를 취소하면 객체가 큐에 남아있지만 가능한 빨리 작업을 중지해야 한다는 것을 객체에 알린다. 현재 실행중인 연산의 경우 이는 연산 객체의 작동 코드가 취소 상태를 확인하고 수행중인 연산을 중지하고 완료된 것으로 표시해야 함을 의미한다. 큐에 있지만 아직 실행되지 않은 연산의 경우 큐에서 연산 객체의 [start()](https://developer.apple.com/documentation/foundation/operation/1416837-start) 메서드를 호출하여 취소 이벤트를 처리하고 완료됨으로 표시할 수 있어야 한다.


> Note
>
> 연산을 취소하면 연산에서 발생할 수 있는 종속성을 무시하게 된다. 이 동작을 통해 큐는 가능한 빨리 연산의 start() 메서드를 실행할 수 있다. start() 메서드는 연산을 완료 상태로 이동하여 큐에서 제거할 수 있도록 한다.


연산 취소에 대한 자세한 내용은 [Operation](https://developer.apple.com/documentation/foundation/operation)의 [Cancel Command in Operation](https://developer.apple.com/documentation/foundation/operation#1661262) 참조.


&nbsp;      
## KVO-Compliant Properties
OperationQueue 클래스는 키-값 코딩(KVC) 및 키-값 관찰(KVO)를 준수한다. 이러한 프로퍼티를 원하는대로 관찰하여 애플리케이션의 다른 부분을 제어할 수 있다. 프로퍼티를 관찰 확인하려면 다음 키 경로를 사용한다:
* [operations](https://developer.apple.com/documentation/foundation/operationqueue/1415168-operations) - 읽기 전용
* [operationCount](https://developer.apple.com/documentation/foundation/operationqueue/1415115-operationcount) - 읽기 전용
* [maxConcurrentOperationCount](https://developer.apple.com/documentation/foundation/operationqueue/1414982-maxconcurrentoperationcount) - 읽기 쓰기 가능
* [isSuspended](https://developer.apple.com/documentation/foundation/operationqueue/1415909-issuspended) - 읽기 쓰기 가능
* [name](https://developer.apple.com/documentation/foundation/operationqueue/1418063-name) - 읽기 쓰기 가능


옵저버를 이 프로퍼티에 연결할 수 있지만 Cocoa 바인딩을 사용하여 애플리케이션의 사용자 인터페이스 요소에 바인딩하지 않아야한다. 사용자 인터페이스와 관련된 코드는 일반적으로 앱의 메인 스레드에서만 실행되어야 한다. 그러나 연산 큐와 관련된 KVO 알림은 모든 스레드에서 발생할 수 있다.


키-값 관찰 및 옵저버를 객체에 연결하는 방법에 대한 자세한 내용은 [Key-Value Observing Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueObserving/KeyValueObserving.html#//apple_ref/doc/uid/10000177i) 참조.


&nbsp;
## Thread Safety
객체에 대한 접근을 동기화하기 위해 추가 락(locks)을 만들지 않고도 여러 스레드에서 하나의 OperationQueue 객체를 사용하는 것이 안전하다.


연산 큐는 [Dispatch](https://developer.apple.com/documentation/dispatch) 프레임 워크를 사용하여 해당 연산의 실행을 시작한다. 결과적으로 연산 동기 또는 비동기로 지정되어있는지 여부에 관계없이 항상 별도의 스레드에서 실행된다.


&nbsp;      
## Topics
### Accessing Specific Operation Queues
> 특정 연산 큐에 접근

* `class var main: OperationQueue`
    * 메인 스레드에 관련된 연산 큐를 반환한다.
* `class var current: OperationQueue?`
    * 현재 연산을 시작한 연산 큐를 반환한다.


### Managing Operations in the Queue
> 큐에서 연산 관리

* `func addOperation(Operation)`
    * 지정된 연산을 리시버에 추가한다.
* `func addOperations([Operation], waitUntilFinished: Bool)`
    * 지정된 연산을 큐에 추가한다.
* `func addOperation(() -> Void)`
    * 지정된 블록을 연산으로 감싸서 리시버에 추가한다.
* `var operations: [Operation]`
    * 현재 큐에있는 연산이다.
* `var operationCount: Int`
    * 현재 큐에있는 연산 수이다.
* `func cancelAllOperations()`
    * 대기 및 실행중인 모든 연산을 취소한다.
* `func waitUntilAllOperationsAreFinished()`
    * 리시버의 대기 및 실행중인 연산이 모두 완료될 때까지 현재 스레드를 차단한다.


### Managing the Execution of Operations
> 연산 실행 관리

* `var qualityOfService: QualityOfService`
    * 큐를 사용하여 실행된 연산에 적용할 기본 서비스 레벨이다.
* `var maxConcurrentOperationCount: Int`
    * 동시에 실행할 수 있는 대기중인 연산의 최대 수이다.
* `class let defaultMaxConcurrentOperationCount: Int`
    * 큐에서 동시에 실행될 기본 최대 연산 수이다.


### Suspending Execution
> 실행 중지

* `var isSuspended: Bool`
    * 큐가 실행을 위해 연산을 적극적으로 지 여부를 지타내는 부울 값.


### Configuring the Queue
> 큐 구성

* `var name: String?`
    * 연산 큐의 이름.
* `var underlyingQueue: DispatchQueue?`
    * 연산을 실행하는데 사용되는 디스패치 큐.


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation OperationQueue](https://developer.apple.com/documentation/foundation/operationqueue)
