//: [Previous](@previous)

//:![](BBM_Horizontal.png)
















/*:
# The way we work:
 ### - pair programming
 ### - TDD
 */















//: ## Task
//: ### Load messages when app launches















struct Message {
    let author: String
    let text: String
    let id: String
}















protocol MessageLoaderProtocol {
    func load(_ callback: @escaping([Message]) -> Void )
}















class MessageLoader: MessageLoaderProtocol {
    func load(_ callback: @escaping ([Message]) -> Void) {
        callback([ ])
    }
}















import UIKit

class MessengerAppDelegte: NSObject, UIApplicationDelegate {
    
    //TODO: Initialize a loader
    let loader = MessageLoader()
    
    
    
    
    
    
    
    
    
    
    
    

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        
        //TODO: Load messages when app launches
        loader.load { print($0) }
        
        
        return true
    }
}













//: # ⛔️ Not so fast!
















//: # ⛔️ TDD - tests come first!
/*:
1. Red ❌
1. Green ✅
1. Refactor 🔄
*/
import XCTest















/*:
 ## Terms
 
 - `sut` - system/subject under test
 - Arrange, Act, Assert
 
 */






















/*:
 ## Behaviour to test
`load` called in `application:willFinishLaunchingWithOptions:`
 */
class AppDelegate: NSObject, UIApplicationDelegate {
    var loader: MessageLoaderProtocol = MessageLoader()
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        loader.load {
            print($0)
        }
        
        return true
    }
}














/*:
 ```Swift
 protocol MessageLoaderProtocol {
 func load(_ callback:@escaping([Message]) -> Void)
 }
 ```
 */

//TODO: Create `MessageLoaderMock` class
class MessageLoaderMock: MessageLoaderProtocol {
    var called = false
    func load(_ callback: @escaping ([Message]) -> Void) {
        called = true
        callback([ ])
    }
}













//Arrange
let sut = AppDelegate()
let loader = MessageLoaderMock()
sut.loader = loader
XCTAssertFalse(loader.called)
let app = UIApplication.shared

//Act
sut.application(app, willFinishLaunchingWithOptions: [ : ])

//Assert
//TODO: Should call `load` on `MessageLoader`
XCTAssertTrue(loader.called)
















/*:
 ## Thanks to TDD
 ### behaviour described
 ### no //comments needed
 ### fail-safe for changes
*/

//: [Next](@next)
