//: [Previous](@previous)
/*:
 # Asynchronous world
 - UI handled on `DispatchQueue.main`
 - heavy tasks on `DispatchQueue.global(qos: .background)`
 */















protocol MessageLoaderProtocol {
    func load(_ callback: @escaping([Message]) -> Void )
}
















protocol MessageFetching {
    func fetchMessages() -> [Message]
}

class MessageStore: MessageFetching {
    
    func fetchMessages() -> [Message] {
        return [  ]
    }
    
}

















struct Message {
    
    let author: String
    let text: String
    let id: String
    
    static let welcome =
        Message(author: "BBM", text: "Welcome in BBM!",id: "0")
    
}














class MessageLoader: MessageLoaderProtocol {
    
    var store: MessageFetching = MessageStore()

    
    
    
    
    
    
    
    
    
    
    
    
    

    func load(_ callback: @escaping([Message]) -> Void) {
        
        DispatchQueue.global().async {
            
            //NOTE: dispatching heavy operations in background
            sleep(1)
            
            
            
            let messages = [ Message.welcome ] + self.store.fetchMessages()
            callback(messages)

        }
    }
}















//: ## Standard unit test

import XCTest
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true












class MessageLoaderTests: XCTestCase {
    
    var sut: MessageLoader!
    
    override func setUp() {
        super.setUp()
        sut = MessageLoader()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    func testAtLeastOneMessageOnLoad() {
        //Arrange
        var messages: [Message] = [ ]
        
        //Act
        sut.load { fetched in
            //TODO: assign messages
            messages = fetched
            print(#function, "background thread")
            print("Messages: ", messages)
        }
        
        //Assert
        print(#function,"main thread")
        print("Messages: ", messages)
        //TODO: Callback should get at least 1 message
//        XCTAssertFalse(messages.isEmpty)
    }
}










//: ## What's wrong?

let test = MessageLoaderTests()
test.setUp()
test.testAtLeastOneMessageOnLoad()
test.tearDown()
//: [Next](@next)
