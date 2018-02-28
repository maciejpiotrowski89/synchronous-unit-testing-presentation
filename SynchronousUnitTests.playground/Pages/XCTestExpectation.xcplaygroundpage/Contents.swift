//: [Previous](@previous)
//: # Code ran asynchronously
//: `XCTestExpectation` comes in handy
















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

class MessageLoader: MessageLoaderProtocol {
    
    let store: MessageFetching = MessageStore()
    
    func load(_ callback: @escaping([Message]) -> Void) {
        
        DispatchQueue.global().async {
            sleep(1)
            let messages = [ Message.welcome ] + self.store.fetchMessages()
            callback(messages)
        }
    }
}

import XCTest
let sut = MessageLoader()
func wait(for expectations: [XCTestExpectation], timeout seconds: TimeInterval) -> XCTWaiter.Result {
    return .completed
}

import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true




























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
        //TODO: Should invoke callback with at least 1 message
        let expectation = XCTestExpectation(description: "Should invoke callback with at least 1 message")
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        //Act
        sut.load { messages in
            print(#function, "callback on a background thread")
            print(#function, "messages on a background thread\n", messages)
            //TODO: assert
            XCTAssertFalse(messages.isEmpty)
            //TODO: fulfill
            expectation.fulfill()
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        //Assert
        print(#function, "main thread before wait")
        //TODO: wait for 2 seconds
        wait(for: [expectation], timeout: 2)
        print(#function, "main thread after wait")

    }
    
}













//: # Drawbacks
//: ### - AAA not clearly visible
//: ### - asynchronous
//: ### - longer execution














//: ## Unreadable
func testIsUnreadable() {
    //Arrange
    let expectation = XCTestExpectation(description: "Should invoke callback with at least 1 message")
    //Act
    sut.load { messages in
        //Assert
        XCTAssertFalse(messages.isEmpty)
        expectation.fulfill()
    }
    //???
    wait(for: [expectation], timeout: 2)
}












//: ## No control
func testIsNotControled() {

    sut.load { messages in
        
        //When will this callback get invoked?
        
        //What's the timeout?
        
    }

}














//:## Overhead
let tests = MessageLoaderTests()
tests.setUp()
tests.testAtLeastOneMessageOnLoad()
tests.tearDown()











//:# Test failed - it's flaky.
//:### Just increase the timeout...
/*:
 ```Swift
 wait(for: [expectation], timeout: 20)
 ```
 */












//: # ⛔️ Don't increase!
//: ## Typical timeout = 100ms
/*:
 ```Swift
 wait(for: [expectation], timeout: 0.1)
 ```
*/
 
 
 
 
 
 
 
 
 
 
 

//: # A new hope
//: ### we can run code synchronously!


//: [Next](@next)
