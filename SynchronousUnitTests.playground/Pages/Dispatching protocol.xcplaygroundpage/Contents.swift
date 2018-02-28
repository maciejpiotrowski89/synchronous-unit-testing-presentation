//: [Previous](@previous)
//: # Let's run code synchronously!














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














protocol Dispatching { //NEW!
    func dispatch(_ work: @escaping ()->Void)
}















//: ## Superclass

class Dispatcher {
    let queue: DispatchQueue
    
    init(queue: DispatchQueue) {
        self.queue = queue
    }
}
















class AsyncDispatcher: Dispatcher {} //IMPORTANT!

extension AsyncDispatcher: Dispatching {
    func dispatch(_ work: @escaping ()->Void) {
        
        
        queue.async(execute: work) //IMPORTANT!
        
        
    }
}
















class SyncDispatcher: Dispatcher {} //IMPORTANT!

extension SyncDispatcher: Dispatching {
    func dispatch(_ work: @escaping ()->Void) {
        
        
        queue.sync(execute: work) //IMPORTANT!
        
        
    }
}

















class MessageLoader: MessageLoaderProtocol {
    
    var queue: Dispatching
    var store: MessageFetching
    
    init(queue: Dispatching = AsyncDispatcher.background,
         store: MessageFetching = MessageStore()) {
        
        
        self.queue = queue //NEW!
        self.store = store
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    func load(_ callback: @escaping([Message]) -> Void) {
        
        
        queue.dispatch { //NEW!
            
            
            
            sleep(1)
            let messages = [ Message.welcome ] + self.store.fetchMessages()
            callback(messages)
        }
    }
}















extension AsyncDispatcher {
    
    static let main       = AsyncDispatcher(queue: .main)
    
    static let global     = AsyncDispatcher(queue: .global())
    
    static let background = AsyncDispatcher(queue: .global(qos: .background))
    
}











extension SyncDispatcher {
    
    static let main       = SyncDispatcher(queue: .main)
    
    static let global     = SyncDispatcher(queue: .global())
    
    static let background = SyncDispatcher(queue: .global(qos: .background))
    
}

















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
        var messages: [Message] = [ ]
        //TODO: Set a sync background queue
        let background = SyncDispatcher.background
        sut.queue = background
        
        
        
        
        
        
        
        
        
        
        
        //Act
        print(#function, "Act - main thread")

        sut.load { fetched in
            print(#function, "callback on background thread")
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















//: ## What happended?
//:![](diagram1.png)


//: [Next](@next)
