import Foundation
import Alamofire

let semaphore = DispatchSemaphore(value: 0)

print("\n\n")
print("type user name to get his repos:")

if let username = readLine() {
    let url = "https://api.github.com/users/\(username)/repos"
    print("\n")
    
    print("sending request to github...")
    print()
    let task = Alamofire.request(url).responseJSON(queue: DispatchQueue.global()) { response in
        if let error = response.result.error as? AFError {
            print(error)
            semaphore.signal()
            return
        }
        
        if let statusCode = response.response?.statusCode {
            if statusCode != 200 {
                print("result code is \(statusCode)")
                if let result = response.result.value as? NSDictionary {
                    if let message = result["message"] {
                        print("result message is \"\(message)\"")
                    }
                }
                semaphore.signal()
                return
            }
        }
        
        
        if let repos = response.result.value as? Array<NSDictionary> {
            print("received \(repos.count) repos:")
            print()
            for var repo in repos {
                print(repo["name"]!)
            }
            
        }
        print()
        semaphore.signal()
        
    }
    
    task.resume()
    semaphore.wait()
}
