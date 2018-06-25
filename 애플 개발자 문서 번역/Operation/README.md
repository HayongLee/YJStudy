# Operation
> 단일 작업과 관련된 코드와 데이터를 나타내는 추상 클래스이다. 


* [Overview](#overview)
* [Operation Dependencies](#operation-dependencies)
* [KVO-Compliant Properties](#kvo-compliant-properties)
* [Multicore Considerations](#multicore-considerations)
* [Asynchronous Versus Synchronous Operations](#asynchronous-versus-synchronous-operations)
* [Subclassing Notes](#subclassing-notes)
    * [Methods to Override](#methods-to-override)
    * [Maintaining Operation Object States](#maintaining-operation-object-states)
    * [Responding to the Cancel Command](#responding-to-the-cancel-command)
* [Topics](#topics)
    * [Executing the Operation](#executing-the-operation)
    * [Canceling Operations](#canceling-operations)
    * [Getting the Operation Status](#getting-the-operation-status)
    * [Managing Dependencies](#managing-dependencies)
    * [Configuring the Execution Priority](#configuring-the-execution-priority)
    * [Waiting on an Operation Object](#waiting-on-an-operation-object)
    * [Constants](#constants)
* [Relationships](#relationships)
* [See Also](#see-also)


&nbsp;    
## Overview
Operation 클래스는 추상 클래스이기 때문에 직접 사용하지 않고 대신 실제 작업을 수행하기 위해 시스템 정의 서브 클래스([NSInvocationOperation](https://developer.apple.com/documentation/foundation/nsinvocationoperation) 또는 [BlockOperation](https://developer.apple.com/documentation/foundation/blockoperation)) 중 하나를 서브 클래스로 사용한다. 추상임에도 불구하고 Operation의 기본 구현에는 작업의 안전한 실행을 조정하는 중요한 로직이 포함된다. 이 내장 로직을 사용하면 다른 시스템 객체와 올바르게 작동하는지 확인하는데 필요한 글루 코드 대신 실제 작업 구현에 집중할 수 있다. 


연산(Operation) 객체는 단일 샷 객체이다. 즉, 연산을 한 번 실행하고 다시 실행할 수는 없다. 일반적으로 연산을 연산 큐([OperationQueue](https://developer.apple.com/documentation/foundation/operationqueue) 클래스의 인스턴스)에 추가하여 연산을 실행한다. 연산 큐는 직접적으로 보조 스레드에서 실행하여 연산을 실행하거나 간접적으로 libdispatch 라이브러리(Grand Central Dispatch 라고도 함)을 사용하여 연산을 실행한다. 큐가 연산을 실행하는 방법에 대한 자세한 내용은 [OperationQueue](https://developer.apple.com/documentation/foundation/operationqueue)를 참조한다.


연산 큐를 사용하지 않으려면 코드에서 start() 메서드를 직접 호출하여 연산을 실행할 수 있다. 준비 상태가 아닌 연산을 시작하면 예외가 트리거되므로 수동으로 연산을 실행하면 코드에 더 많은 부담이 가중된다. isReady 프로퍼티는 연산의 준비 상태를 보고한다.


&nbsp;
## Operation Dependencies
종속성은 특정 순서로 연산을 실행하는 편리한 방법이다. addDependency(_:) 및 removeDependency(_:) 메서드를 사용하여 연산의 종속성을 추가 및 제거할 수 있다. 기본적으로 종속성이있는 연산 객체는 모든 종속 연산 객체의 실행이 완료될 때가지 준비 상태로 간주되지 않는다. 그러나 마지막 종속 연산이 완료되면 연산 객체가 준비되고 실행할 수 있게 된다.


NSOperation이 지원하는 종속성은 종속 연산이 성공적으로 완료되었는지 또는 성공적으로 완료되지 못했는지에 대해 구분하지 않는다. 즉, 연산을 취소하면 완료된 것으로 표시된다. 종속 연산이 취소되었거나 연산이 성공적으로 완료되지 않은 경우 종속 연산이 진행되어야하는지 여부를 결정해야 한다. 이로 인해 연산 객체에 몇 가지 추가 오류 추적 기능을 통합해야 할 수도 있다.


&nbsp;      
## KVO-Compliant Properties
NSOperation 클래스는 여러 프로퍼티에 대해 키-값 코딩(KVC) 및 키-값 관찰(KVO)을 준수한다. 필요에 따라 이러한 프로퍼티를 관찰하여 애플리케이션의 다른 부분을 제어할 수 있다. 프로퍼티를 관찰하려면 다음 키 경로를 사용한다:
* isCancelled - 읽기 전용
* isAsynchronous - 읽기 전용
* isExecuting - 읽기 전용
* isFinished - 읽기 전용
* isReady - 읽기 전용
* dependencies - 읽기 전용
* queuePriority - 읽기 쓰기 가능
* completionBlock - 읽기 쓰기 가능


옵저버를 이 프로퍼티에 연결할 수 있지만 Cocoa 바인딩을 사용하여 애플리케이션의 사용자 인터페이스 요소에 바인딩하지 않아야 한다. 사용자 인터페이스와 관련된 코드는 일반적으로 애플리케이션의 메인 스레드에서만 실행되어야 한다. 연산은 모든 스레드에서 실행될 수 있으므로 해당 연산과 관련된 KVO 알림은 모든 스레드에서 유사하게 발생할 수 있다.


이전 프로퍼티 중 하나에 대한 커스텀 구현을 제공하는 경우 구현은 KVC 및 KVO 준수를 유지해야 한다. NSOperation 객체에 대한 추가 프로퍼티를 정의하는 경우 해당 프로퍼티 KVC 및 KVO를 준수하는 것이 좋다. 키-값 코딩을 지원하는 방법에 대한 정보는 [Key-Value Coding Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueCoding/index.html#//apple_ref/doc/uid/10000107i) 참조. 키-값 관찰을 지원하는 방법에 대한 정보는 [Kev-Value Observing Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueObserving/KeyValueObserving.html#//apple_ref/doc/uid/10000177i) 참조.


&nbsp;      
## Multicore Considerations
NSOperation 클래스는 멀티 코어를 인식한다. 따라서 객체에 대한 접근을 동기화하기 위해 추가 락(locks)을 만들지 않고도 여러 스레드에서 NSOperation 객체의 메서드를 호출하는 것이 안전하다. 이 동작은 일반적으로 연산을 만들고 스레드를 모니터링하는 별도의 스레드에서 실행되기 때문에 필요하다.


NSOperation을 서브 클래스화할 때, 재정의 된 메서드가 다중 스레드로부터 안전하게 호출 할 수 있어야한다. 서브 클래스에서 커스텀 데이터 접근자 등의 커스텀 메서드를 구현하는 경우 해당 메서드가 스레드로부터 안전한지 확인해야 한다. 따라서 잠재적인 데이터 손상을 방지하려면 연산의 모든 데이터 변수에 대한 접근을 동기화해야 한다. 동기화에 대한 자세한 내용은 [Threading Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Multithreading/Introduction/Introduction.html#//apple_ref/doc/uid/10000057i) 참조. 


&nbsp;
## Asynchronous Versus Synchronous Operations
연산 객체를 수동으로 실행하려는 경우 큐에 추가하는 대신 연산을 동기식 또는 비동기식으로 실행하도록 설계할 수 있다. 연산 객체는 기본적으로 동기식이다. 동기 연산에서 연산 객체는 해당 작업을 실행할 개별 스레드를 작성하지 않는다. 코드에서 직접 동기 연산의 start() 메서드를 호출하면 연산이 현재 스레드에서 즉시 실행된다. 이러한 객체의 start() 메서드가 호출자에게 제어를 반환할 때까지 작업 자체가 완료된다.


비동기 연산의 start() 메서드를 호출하면 해당 작업이 완료되기 전에 해당 메서드가 반환될 수 있다. 비동기 연산 객체는 별도의 스레드에서 작업을 예약한다. 연산은 새로운 스레드를 직접 시작하거나, 비동기 메서드를 호출하거나, 실행을 위해 디스패치 큐에 블록을 제출하여 수행할 수 있다. 컨트롤이 호출자에게 반환 될 때 연산이 진행 중인지 여부는 실제로 중요하지 않으며 계속 진행될 수 있다.


연산을 실행하기 위해 항상 큐를 사용하려는 경우 이를 동기식으로 정의하는 것이 더 간단하다. 그러나 수동으로 연산을 실행하는 경우 연산 객체를 비동기로 정의할 수 있다. 비동기 연산을 정의하려면 KVO 알림을 사용하여 작업의 진행 상태를 모니터링하고 해당 상태의 변경 사항을 보고해야 하기 때문에 더 많은 작업이 필요하다. 그러나 비동기 연산을 정의하면 수동으로 실행된 연산이 호출 스레드를 차단하지 않도록 하려는 경우에 유용하다.


연산 큐에 연산을 추가하려면 큐는 [isAsynchronous](https://developer.apple.com/documentation/foundation/operation/1408275-isasynchronous) 프로퍼티 값을 무시하고 항상 별도의 스레드에서 start() 메서드를 호출한다. 따라서 연산 큐에 연산을 추가하여 항상 연산을 실행하면 비동기로 만들 필요가 없다.


동기 및 비동기 연산을 모두 정의하는 방법은 아래 subclassing notes를 참고한다.


&nbsp;      
## Subclassing Notes
NSOperation 클래스는 연산의 실행 상태를 추적하는 기본 논리를 제공하지만 실제 작업을 수행하려면 서브 클래스로 만들어야 한다. 서브 클래스를 만드는 방법은 연산이 동시성(concurrently) 또는 비 동시성(non-concurrently)으로 실행되도록 설계되었는지 여부에 따라 다르다.


&nbsp;      
### Methods to Override
비 동시 연산의 경우 일반적으로 한가지 메서드만 재정의한다.
* [main()](https://developer.apple.com/documentation/foundation/operation/1407732-main)


이 메서드에서는 주어진 작업을 수행하는 데 필요한 코드를 배치한다. 물론 커스텀 클래스의 인스턴스를 보다 쉽게 만들 수 있도록 커스텀 초기화 메서드를 정의해야 한다. getter 및 setter 메서드를 정의하여 연산의 데이터에 접근할 수도 있다. 그러나 커스텀 getter 및 setter 메서드를 정의하는 경우 이러한 메서드를 여러 스레드에서 안전하게 호출할 수 있어야 한다.


동시 연산을 만드는 경우 최소한 다음 메서드 및 프로퍼티를 재정의해야 한다:
* [start()](https://developer.apple.com/documentation/foundation/operation/1416837-start)
* [isAsynchronous](https://developer.apple.com/documentation/foundation/operation/1408275-isasynchronous)
* [isExecuting](https://developer.apple.com/documentation/foundation/operation/1415621-isexecuting)
* [isFinished](https://developer.apple.com/documentation/foundation/operation/1413540-isfinished)


동시 연산에서 start() 메서드는 비동기 방식으로 연산을 시작한다. 스레드를 생성하거나 비동기 함수를 호출하는 경우 이 메서드에서 수행한다. 연산을 시작할 때 start() 메서드는 isExecuting 프로퍼티에 의해 보고 된 연산의 실행 상태도 업데이트해야 한다. 이 연산은 isExecuting 키 경로에 대한 KVO 알림을 보내어 관심있는 클라이언트에게 연산이 현재 실행 중임을 알린다. isExcuting 프로퍼티는 스레드로부터 안전하게 상태를 제공해야 한다.


작업 완료 또는 취소시 동시 연산 객체는 연산의 최종 상태 변경을 표시하기 위해 isExecuting 및 isFinished 키 경로에 대한 KVO 알림을 생성해야 한다. (취소의 경우 연산이 작업을 완전히 완료하지 않은 경우에도 isFinished 키 경로를 업데이트하는 것이 중요하다. 대기중인 연산은 큐에서 작업을 마친 후에 큐에서 제거될 수 있음을 보고해야 한다.) KVO 알림을 생성할 때 isExecuting 및 isFinished 프로퍼티를 재정의해도 연산 상태를 기반으로 정확한 값을 계속해서 보고해야 한다.


동시 연산을 정의하는 방법에 대한 추가 정보는 [Concurrency Programming Guide](https://developer.apple.com/library/archive/documentation/General/Conceptual/ConcurrencyProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40008091) 참조.


> Important
>
> start() 메서드에서 즉시 super를 호출해야 한다. 동시 연산을 정의할 때 작업을 시작하고 적절한 KVO 알림을 생성하는 것과 같은 기본 start() 메서드가 제공하는 것과 동일한 동작을 제공하기 위해 직접 작업을 수행한다. start() 메서드는 작업을 실제로 시작하기 전에 연산 자체가 취소되었는지 확인해야 한다.  취소 의미에 대한 자세한 내용은 [Responding to the Cancel Command](https://developer.apple.com/documentation/foundation/operation#1661262) 참조.


동시 연산의 경우에도 위에 설명된 것 이외의 메서드를 재정의해야 할 필요는 거의 없다. 그러나 연산의 종속성 기능을 커스텀화하는 경우 추가 메서드를 재정의하고 추가 KVO 알림을 제공해야 할 수 있다. 종속성의 경우 isReady 키 경로에 대한 알림만 제공하면 된다. 종속성 프로퍼티에는 종속 연산 목록이 포함되어 있으므로 변경 내용은 기본 NSOperation 클래스에서 이미 처리된다.  


&nbsp;      
### Maintaining Operation Object States
연산 객체에는 내부적으로 상태 정보를 유지 관리하여 실행 안전 여부를 결정하고 외부 클라이언트에게 연산의 생명주기를 통해 진행 상황을 알린다. 커스텀 서브 클래스는 이 상태 정보를 유지 보수하여 코드에서 연산의 올바른 실행을 보장한다. 연산의 상태와 관련된 키 경로는 다음과 같다:
* isReady
    * isReady 키 경로를 통해 클라이언트는 연산이 언제 실행할 준비가 되었는지 알 수 있다. [isReady](https://developer.apple.com/documentation/foundation/operation/1412992-isready) 프로퍼티에는 연산을 지금 실행할 준비가 되었을 때 true 값이 포함되며, 종속이 아직 완료되지 않은 연산이 있으면 false 값을 포함한다.
    * 대부분의 경우 이 키 경로의 상태를 직접 관리할 필요가 없다. 그러나 연산의 준비 상태가 종속 연산 이외의 요인(예: 프로그램의 일부 외부 조건)에 의해 결정되는 경우 [isReady](https://developer.apple.com/documentation/foundation/operation/1412992-isready) 프로퍼티를 직접 구현하고 작업 상태를 직접 추적할 수 있다. 외부 상태가 허용하는 경우에만 연산 객체를 작성하는 것이 더 간단하다.
    * macOS 10.6 및 이후 버전에서 하나 이상의 종속 연산이 완료 될 때까지 대기하는 동안 연산을 취소하면 해당 종속성이 무시되고 이 프로퍼티 값이 업데이트되어 이제 실행할 준비가 되었음을 반영한다. 이 동작은 연산 큐에 취소 된 연산을 해당 큐에서 더 빨리 플러시 할 수 있는 기회를 제공한다.
* isExcuting
    * isExcuting 키 경로를 통해 클라이언트는 작업이 할당 된 연산에 대해 활발히 활발히 작동하는지 여부를 알 수 있다. [isExcuting](https://developer.apple.com/documentation/foundation/operation/1415621-isexecuting) 프로퍼티는 해당 연산에서 작업이 작동하는 경우 true를, 그렇지 않은 경우 false를 보고해야 한다. 
    * 연산 객체의 [start()](https://developer.apple.com/documentation/foundation/operation/1416837-start) 메서드를 바꿀 경우 [isExcuting](https://developer.apple.com/documentation/foundation/operation/1415621-isexecuting) 프로퍼티를 바꾸고 연산의 실행 상태가 변경될 때 KVO 알림을 생성해야 한다.
* isFinished
    * isFinished 키 경로를 통해 클라이언트는 연산이 작업을 성공적으로 완료했거나 취소되고 종료되었음을 알 수 있다. 연산 객체는 isFinished 키 경로의 값이 true로 변경될 때까지 종속성을 지우지 않는다. 마찬가지로 [isFinished](https://developer.apple.com/documentation/foundation/operation/1413540-isfinished) 프로퍼티에 true가 포함될 때까지 연산 큐는 연산을 큐에서 제외하지 않는다. 따라서 완료된 연산을 마킹하면 진행중인 연산이나 취소된 연산으로 인해 큐가 백업되지 않도록 유지하는 것이 중요하다.
    * [start()](https://developer.apple.com/documentation/foundation/operation/1416837-start) 메서드 또는 연산 객체를 바꿀 경우 [isFinished](https://developer.apple.com/documentation/foundation/operation/1413540-isfinished) 프로퍼티를 바꾸고 연산 실행이 완료되거나 취소 될 때 KVO 알림을 생성해야 한다.
* isCancelled
    * isCancelled 키 경로를 통해 클라이언트는 연산 취소가 요청되었음을 알 수 있다. 취소 지원은 자발적이지만 권장되며 사용자 코드가 이 키 경로에 대해 KVO 알림을 보내지 않아도 된다. 연산의 취소 알림 처리에 대한 자세한 내용은 [Responding to the Cancel Command](https://developer.apple.com/documentation/foundation/operation#1661262) 참조.


&nbsp;      
### Responding to the Cancel Command
큐에 연산을 추가하면 연산은 사용자의 손을 벗어난다. 큐가 작업을 인계 받아 해당 작업의 스케줄링을 처리한다. 그러나 나중에 연산을 수행하지 않으려는 경우 (예: 사용자가 진행 패널에서 취소 버튼을 누르거나 애플리케이션을 종료할 때 등) 연산을 취소하여 불필요하게 CPU 시간을 소비하지 않도록 할 수 있다. 이렇게하려면 연산 객체 자체의 cancle() 메서드를 호출하거나 OperationQueue 클래스의 [cancelAllOperations()](https://developer.apple.com/documentation/foundation/operationqueue/1417849-cancelalloperations) 메서드를 호출한다.


연산을 취소한다고 해서 즉시 중단되는 것은 아니다. isCancelled 프로퍼티의 값을 준수하는 것은 모든 연산에서 예상되지만 코드는 이 프로퍼티의 값을 명시적으로 확인하고 필요에 따라 중단해야 한다. NSOperation의 기본 구현에는 취소 확인이 포함된다. 예를 들어 start() 메서드가 호출되기 전에 연산을 취소하면 start() 메서드는 작업을 시작하지 않고 종료한다.


> Note
>
> macOS 10.6 이상에서는 연산 큐에 있고 종속 연산이 완료되지 않은 연산에 대해 cancel() 메서드를 호출하면 종속 연산이 무시된다. 연산이 이미 취소되었으므로 이 동작을 통해 큐는 연산의 start() 메서드를 호출하여 main() 메서드를 호출하지 않고 연산을 큐에서 제거할 수 있다. 큐에 없는 연산에서 cancel() 메서드를 호출하면 연산이 즉시 취소됨으로 마크된다. 각각의 경우에 연산을 준비 또는 완료로 마크하면 적절한 KVO 알림이 생성된다.


사용자가 작성한 모든 커스텀 코드에서 항상 취소 의미론을 지원해야 한다. 특히 메인 작업 코드는 isCancelled 프로퍼티의 값을 주기적으로 확인해야 한다. 프로퍼티에서 값이 true로 보고되면 연산 객체를 가능한 빨리 정리하고 종료해야 한다. 커스텀 start() 메서드를 구현하는 경우, 해당 메서드는 취소를 조기에 확인하고 적절하게 작동해야 한다. 이러한 타입의 조기 취소를 처리하려면 커스텀 start() 메서드를 준비해야 한다.


연산이 취소될 때 단순히 종료하는 것 외에도 취소된 연산을 적절한 최종 상태로 이동하는 것도 중요하다. 특히 isFinished 및 isExecuting 프로퍼티 값을 직접 관리하면 (아마도 동시 연산을 구현하기 때문에) 해당 프로퍼티를 적절히 업데이트해야 한다. 특히, isFinished에 의해 반환된 값을 true로 변경하고 isExcuting에 의해 반환 된 값을 false로 변경해야 한다. 실행을 시작하기 전에 연산이 취소된 경우에도 이러한 변경을 수행해야 한다.


&nbsp;      
## Topics
### Executing the Operation
> 연산 실행

* `func start()`
    * 연산의 실행을 시작한다.
* `func main()`
    * 리시버의 비 동시 작업을 수행한다.
* `var completionBlock: (() -> Void)?`
    * 연산의 메인 작업이 완료된 후 실행할 블록이다.
    

### Canceling Operations
> 연산 취소

* `func cancel()`
    * 연산 객체의 작업 실행을 중지해야 한다고 알린다.
    

### Getting the Operation Status
> 연산 상태 얻기

* `var isCancelled: Bool`
    * 연산이 취소되었는지 여부를 나타내는 부울 값.
* `var isExecuting: Bool`
    * 연산이 현재 실행 중인지 여부를 나타내는 부울 값.
* `var isFinished: Bool`
    * 연산의 작업이 실행이 완료되었는지 여부를 나타내는 부울 값.
* `var isConcurrent: Bool`
    * 연산이 비동기적으로 작업을 실행하는지 여부를 나타내는 부울 값. 
* `var isAsynchronous: Bool`
    * 연산이 비동기적으로 작업을 실행하는지 여부를 나타내는 부울 값. 
* `var isReady: Bool`
    * 연산을 지금 수행할 수 있는지 여부를 나타내는 부울 값.
* `var name: String?`
    * 연산의 이름.
    

### Managing Dependencies
> 종속성 관리

* `func addDependency(Operation)`
    * 지정된 연산 완료에 따라 리시버를 종속시킨다.
* `func removeDependency(Operation)`
    * 지정된 연산에 대한 리시버의 종속성을 제거한다.
* `var dependencies: [Operation]`
    * 현재 객체가 실행을 시작하기 전에 실행을 완료해야 하는 연산 객체의 배열이다.
    

### Configuring the Execution Priority
> 실행 우선 순위 구성

* `var qualityOfService: QualityOfService`
    * 연산에 시스템 자원을 부여할 때 상대적 중요성.
* `var queuePriority: Operation.QueuePriority`
    * 연산 큐에서 연산의 실행 우선 순위.

### Waiting on an Operation Object
> 연산 객체를 대기 중

* `func waitUntilFinished()`
    * 연산 객체가 작업을 완료할 때까지 현재 스레드의 실행을 차단한다.
    

### Constants
* `enum Operation.QueuePriority`
    * 이 상수를 사용하면 연산이 실행되는 순서의 우선 순위를 지정할 수 있다.
* `enum QualityOfService`
    * 시스템에 대한 연산의 성격과 중요성을 나타내는 데 사용된다. 높은 품질의 서비스 클래스로 작업하면 자원 경합이 있을 때마다 낮은 서비스 크래스로 작업하는 것보다 많은 자원이 수신된다.


&nbsp;      
## Relationships
### Inherits From
* NSObject


### Conforms To
* CVarArg, Equatable, Hashable


&nbsp;      
## See Also
### Operations
* class OperationQueue
* class BlockOperation


&nbsp;      
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gmail.com>
### [Apple Developer Documentation Operation](https://developer.apple.com/documentation/foundation/operation)
