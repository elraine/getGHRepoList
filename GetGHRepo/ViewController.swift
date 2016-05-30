//
//  ViewController.swift
//  GetGHRepo
//
//  Created by Alexis Chan on 30/05/2016.
//  Copyright © 2016 achan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var lookButton: UIButton!
    
    @IBOutlet weak var avatarLogin: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    
    @IBAction func justDoIt(sender: UIButton) {
        
        
        let composeReq = "https://api.github.com/search/users?q="+searchField.text!
        var avatarURL:String = ""
        var login:String = ""
        
        
        Alamofire.request(.GET, composeReq , parameters: ["foo": "bar"])
            .responseJSON { response in
                //                    print("URL req")
                //                    print(response.request)  // original URL request
                //                    print("URL resp")
                //                    print(response.response) // URL response
                //                    print("URL data")
                //                    print(response.data)     // server data
                //                    print("results")
                //                    print(response.result)   // result of response serialization
                
                switch response.result {
                case .Success:
                    print("Validation Successful")
                case .Failure(let error):
                    print(error)
                }
                
                if let value = response.result.value {
                    let json = JSON(value)
//                    print(json["items",0])
                    login = json["items",0,"login"].string!
                    avatarURL = json["items",0,"avatar_url"].string!
                    print(login)
                    print(avatarURL)
                }
                
             //Set user info
                self.avatarLogin.text = login
                
                Alamofire.request(.GET, avatarURL).response { (request, response, data, error) in
                    self.avatarImage.image = UIImage(data: data!, scale:1)
                }
        }
        
        
        
    }
    
    
    @IBAction func GetList(sender: AnyObject) {
//    }
//    func getUserRepoList(sender:UIButton){
        
        if ((searchField.text) != nil) {
            if((searchField.text!.isEmpty)){
                print("lolno")
                return
            }
            
            let composeReq = "https://api.github.com/search/repositories?q=user:"+searchField.text!+"&sort=updated&order=desc"
            
            
            Alamofire.request(.GET, composeReq , parameters: ["foo": "bar"])
                .responseJSON { response in
                    //                    print("URL req")
                    //                    print(response.request)  // original URL request
                    //                    print("URL resp")
                    //                    print(response.response) // URL response
                    //                    print("URL data")
                    //                    print(response.data)     // server data
                    //                    print("results")
                    //                    print(response.result)   // result of response serialization
                    
                    switch response.result {
                    case .Success:
                        print("Validation Successful")
                        if let value = response.result.value {
                            let json = JSON(value)
                            print(json["items",1,"owner","login"])
                        }
                    case .Failure(let error):
                        print(error)
                    }
                    
                    
            }
            
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}



