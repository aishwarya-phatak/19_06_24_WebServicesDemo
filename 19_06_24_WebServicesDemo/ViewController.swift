//
//  ViewController.swift
//  19_06_24_WebServicesDemo
//
//  Created by Vishal Jagtap on 29/07/24.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var postTableView: UITableView!
    
    var url : URL?
    var urlRequest : URLRequest?
    var urlSession : URLSession?
    var apiResponse : [[String:Any]]?
    var posts : [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonSerialization()
        initializeViews()
        registerXIBWithPostTableViewCell()
        print(UserDefaults.standard.string(forKey: "username")!)
    }
    
    private func initializeViews(){
        postTableView.dataSource = self
        postTableView.delegate = self
    }
    
    private func registerXIBWithPostTableViewCell(){
        let uiNIb = UINib(nibName: Constants.reuseIdentifierForPostTableViewCell, bundle: nil)
        self.postTableView.register(uiNIb, forCellReuseIdentifier: Constants.reuseIdentifierForPostTableViewCell)
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
            
            DispatchQueue.main.async {
                self.postTableView.reloadData()
            }
        }
        urlSessionDataTask?.resume()
    }
}


extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postTableViewCell = self.postTableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifierForPostTableViewCell, for: indexPath) as! PostTableViewCell
        
        postTableViewCell.layer.borderColor = CGColor(srgbRed: 50.0, green: 0.0, blue: 100.0, alpha: 4.0)
        postTableViewCell.layer.borderWidth = 5.0
        postTableViewCell.layer.cornerRadius = 20.0
        
        //selecting custom colour added under assets folder
        postTableViewCell.postUserIdLabel.backgroundColor = UIColor(named: "ColourPurple")
        
        postTableViewCell.postUserIdLabel.text = String(posts[indexPath.row].userId)
        postTableViewCell.postTitleLabel.text = posts[indexPath.row].title
        postTableViewCell.postBodyLabel.text = posts[indexPath.row].body
        
        return postTableViewCell
    }
}


extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 325.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
