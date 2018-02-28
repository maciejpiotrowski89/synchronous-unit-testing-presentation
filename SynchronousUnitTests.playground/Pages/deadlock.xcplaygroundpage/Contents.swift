//: [Previous](@previous)

/*:
 # Beware of the 🐕 deadlock!
 */

import Foundation













//: ## Callback on the main thread
 func load(_ completion: @escaping ()->Void) {
    
    DispatchQueue.global().async {
        //fetch messages on a background thread
        
        DispatchQueue.main.async {
            completion() //on the main thread
        }
        
    }
 }















struct Message {
    let author: String
    let text: String
    let id: String
}

protocol MessageLoaderProtocol {
    func load(_ callback: @escaping([Message]) -> Void )
}

protocol MessageFetching {
    func fetchMessages() -> [Message]
}

class MessageStore: MessageFetching {
    func fetchMessages() -> [Message] {
        return [ ]
    }
}

extension Message {
    static let welcome =
        Message(author: "BBM",
                text:   "Welcome in BBM!",
                id:     "0")
}

protocol Dispatching {
    func dispatch(_ work: @escaping ()->Void)
}

import Foundation

class Dispatcher {
    let queue: DispatchQueue
    
    init(queue: DispatchQueue) {
        self.queue = queue
    }
}

class AsyncDispatcher: Dispatcher {}
extension AsyncDispatcher: Dispatching {
    func dispatch(_ work: @escaping ()->Void) {
        queue.async(execute: work)
    }
}

class SyncDispatcher: Dispatcher {}
extension SyncDispatcher: Dispatching {
    func dispatch(_ work: @escaping ()->Void) {
        queue.sync(execute: work)
    }
}

extension SyncDispatcher {
    static let main       = SyncDispatcher(queue: .main)
    static let global     = SyncDispatcher(queue: .global())
    static let background = SyncDispatcher(queue: .global(qos: .background))
}

extension AsyncDispatcher {
    static let main       = AsyncDispatcher(queue: .main)
    static let global     = AsyncDispatcher(queue: .global())
    static let background = AsyncDispatcher(queue: .global(qos: .background))
}
















class MessageLoader: MessageLoaderProtocol {

    var store: MessageFetching

    var main: Dispatching //NEW!
    var background: Dispatching //NEW!
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    init(main: Dispatching = AsyncDispatcher.main,
         background: Dispatching = AsyncDispatcher.background,
         store: MessageFetching = MessageStore()) {
        
        
        self.main = main //NEW!
        self.background = background //NEW!
        self.store = store
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func load(_ callback: @escaping([Message]) -> Void) {
        
        
        background.dispatch { //NEW!
            
            sleep(1)
            let messages = [ Message.welcome ] + self.store.fetchMessages()
            
            
            self.main.dispatch { //NEW!
                callback(messages)
            }
            
        }
    }
}















/*:
 ## What is a deadlock?
[Deadlock](https://en.wikipedia.org/wiki/Deadlock) in a multi-threaded application occurs when a thread enters a waiting state because a requested system resource is held by another waiting thread.
 */
















//: ## Deadlock in MessageLoader
let loader = MessageLoader(main:       SyncDispatcher.main,
                           background: SyncDispatcher.background)















//: ## Deadlock in MessageLoader
//:![](diagram2.png)















//: ## No deadlock

import XCTest

class MessageLoaderTests: XCTestCase {
    
    var sut: MessageLoader!

    override func setUp() {
        super.setUp()
        print(">>> Staring a test")
        sut = MessageLoader()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
        print(">>> Finished a test")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    func testAtLeastOneMessageOnLoad() {
        
        //Arrange
        print(#function, "Arrange - main thread")
        var messages: [Message]!

        //TODO: create main & background queues
        let background = SyncDispatcher.background
        let main = SyncDispatcher.global
        
        
        //TODO: switch queues on sut
        sut.main = main
        sut.background = background
        
    
        
        
        
        
        
        
        
        
        
        
        //Act
        print(#function, "Act - main thread")
        
        sut.load { fetched in
            print(#function, "callback on global thread")
            messages = fetched
            print(messages)
        }
        
        //Assert
        print(#function, "Assert - main thread")
        //NOTE: Messages should not be empty
        //TODO: Make an Assertion
        XCTAssertFalse(messages.isEmpty)
        
    }
}














//: ## Full control
let tests = MessageLoaderTests()
tests.setUp()
tests.testAtLeastOneMessageOnLoad()
tests.tearDown()













//: ## No deadlock
//: ![](diagram3.png)


//: [Next](@next)
