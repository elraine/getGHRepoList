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
    
    @IBOutlet weak var searchStatus: UILabel!
    
    
    var jsondata:JSON = []
    @IBAction func justDoIt(sender: UIButton) {
        
        
        let composeReq = "https://api.github.com/search/users?q="+searchField.text!
        var avatarURL:String = ""
        var login:String = ""
        
        searchStatus.hidden = true
        Alamofire.request(.GET, composeReq , parameters: ["foo": "bar"])
            .responseJSON { response in
                switch response.result {
                case .Success:
                    //                    print("Validation Successful")
                    if let value = response.result.value {
                        let json = JSON(value)
                        //                    print(json["items",0])
                        login = json["items",0,"login"].string!
                        avatarURL = json["items",0,"avatar_url"].string!
                        print(login)
                        print(avatarURL)
                        
                        //send for segue
                        
                    }
                    
                    //Set user info
                    self.avatarLogin.text = login
                    
                    //image
                    Alamofire.request(.GET, avatarURL).response { (request, response, data, error) in
                        self.avatarImage.image = UIImage(data: data!, scale:1)
                    }
                    
                case .Failure(let error):
                    self.searchStatus.hidden = false
                    self.searchStatus.text = "error"
                    print(error)
                }
                
                
        }
        
        
        
    }
    
    
    @IBAction func GetList(sender: AnyObject) {
        //    }
        //    func getUserRepoList(sender:UIButton){
        searchStatus.hidden = true
        
        if ((searchField.text) != nil) {
            if((searchField.text!.isEmpty)){
                print("Ca n'aura aucun effet")
                searchStatus.hidden = false
                searchStatus.text = "error"
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
                        //                        print("Validation Successful")
                        if let value = response.result.value {
                            let json = JSON(value)
                            print(json["items"])
                            self.jsondata = json["items"]
//                            self.performSegueWithIdentifier("getRepoList", sender:sender)
                        }
                    case .Failure(let error):
                        self.searchStatus.hidden = false
                        self.searchStatus.text = "error"
                        print(error)
                        
                    }
                    
                    
            }
            
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchStatus.hidden = true

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "getRepoList" {
            
            if let tableViewController = segue.destinationViewController as? TableViewController{
                tableViewController.json = jsondata
                tableViewController.login = self.avatarLogin.text!
            }
     
            
            
        }
    }
    
    
    
}



