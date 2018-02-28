//: [Previous](@previous)
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
    
    var loader: MessageLoaderProtocol?
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        
        //TODO: Load messages when app launches
        loader?.load { messages in
            print(messages)
        }
        
        
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
 
 - `sut` - system under test
 - Arrange, Act, Assert
 
 */















/*:
 ```Swift
 protocol MessageLoaderProtocol {
 func load(_ callback:@escaping([Message]) -> Void)
 }
 ```
 */
//TODO: create `MessageLoaderMock`
class MessageLoaderMock: MessageLoaderProtocol{
    func load(_ callback:@escaping([Message]) -> Void) {
        callback([ ])
    }
}





















/*:
 ## Assumption \#1
`load` called in `application: willFinishLaunchingWithOptions:`
 */
class AppDelegte: NSObject, UIApplicationDelegate {
    var loader: MessageLoaderProtocol?
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        return true
    }
}













//Arrange
var sut: AppDelegate = AppDelegte()

//Act


//Assert
//TODO: Should call `load` on `MessageLoader`
















/*:
## Assumption \#2
 `loader` is not nil after `AppDelegate:init`
*/















//Arrange & Act
//sut =

//Assert
//TODO: `loader` should not be nil after init













/*:
 ## Thanks to TDD
 ### app behaviour described
 ### no comments needed
 ### fail-safe for changes
*/


//: [Next](@next)
