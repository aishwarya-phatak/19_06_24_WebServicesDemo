//
//  ViewController.swift
//  19_06_24_WebServicesDemo
//
//  Created by Vishal Jagtap on 29/07/24.
//

import UIKit

class ViewController: UIViewController {

    var url : URL?
    var urlRequest : URLRequest?
    var urlSession : URLSession?
    var apiResponse : [[String:Any]]?
    var posts : [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonSerialization()
    }
    
    private func jsonSerialization(){
        
        //convert string into url format
        url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        
        //create urlRequest with specified method
        urlRequest = URLRequest(url: url!)
        urlRequest?.httpMethod = "GET"
        
        //urlSession
        urlSession = URLSession(configuration: .default)
        
        
        let urlSessionDataTask = urlSession?.dataTask(with: urlRequest!){
            data, response, error in
            
            print(data)
            print(response)
            print(error)
            
            do{
                self.apiResponse = try JSONSerialization.jsonObject(with: data!) as! [[String:Any]]
                for eachPostObject in self.apiResponse!{
                    let eachPostUserId = eachPostObject["userId"] as! Int
                    let eachPostId = eachPostObject["id"] as! Int
                    let eachPostTitle = eachPostObject["title"] as! String
                    let eachPostBody = eachPostObject["body"] as! String
                    
                    let newPostObject = Post(userId: eachPostUserId, id: eachPostId, title: eachPostTitle, body: eachPostBody)
                    
                    self.posts.append(newPostObject)
                    print(self.posts)
                }
            }catch{
                print(error)
            }
        }
        urlSessionDataTask?.resume()
    }
}
