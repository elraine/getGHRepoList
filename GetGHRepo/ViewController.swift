//
//  ViewController.swift
//  GetGHRepo
//
//  Created by Alexis Chan on 30/05/2016.
//  Copyright © 2016 achan. All rights reserved.
//

import UIKit

//HTTP request
import Alamofire

//JSON handling
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var lookButton: UIButton!
    
    @IBOutlet weak var avatarLogin: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBOutlet weak var searchStatus: UILabel!
    
    
    //global for segue
    var jsondata:JSON = []
    
    
    @IBAction func justDoIt(sender: UIButton) {
        
        //i dont want every user of github, so i stop it there
        if((searchField.text!.isEmpty)){
            print("Ca n'aura aucun effet")
            searchStatus.hidden = false
            searchStatus.text = "error"
            return
        }
        
        //compose the URL string
        let composeReq = "https://api.github.com/search/users?q="+searchField.text!
        
        //declare here to show after
        var avatarURL:String = ""
        var login:String = ""
        
        //if status is valid, dont show it
        //hide for the new request
        searchStatus.hidden = true
        
        //ask Github API for information
        Alamofire.request(.GET, composeReq , parameters: ["foo": "bar"])
            .responseJSON { response in
                switch response.result {
                case .Success:
                    //print("Validation Successful")
                    if let value = response.result.value {
                        let json = JSON(value)
                        //print(json["items",0])
                        
                        //get these data
                        login = json["items",0,"login"].string!
                        avatarURL = json["items",0,"avatar_url"].string!
                        
                        //show me
                        print(login)
                        print(avatarURL)
                        
                        //send for segue
                        
                    }
                    
                    //Set user info
                    self.avatarLogin.text = login
                    
                    //image set
                    Alamofire.request(.GET, avatarURL).response { (request, response, data, error) in
                        self.avatarImage.image = UIImage(data: data!, scale:1)
                    }
                    
                case .Failure(let error):
                    //show status now
                    self.searchStatus.hidden = false
                    self.searchStatus.text = "error"
                    print(error)
                }
                
                
        }
        
        
        
    }
    
    
    @IBAction func GetList(sender: AnyObject) {
        //hide for the new request
        searchStatus.hidden = true
        
        //reduce the load
        //if searchField.text is empty, the search returns lots of repo, i dont want that.
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
                    switch response.result {
                    case .Success:
                        //                        print("Validation Successful")
                        if let value = response.result.value {
                            let json = JSON(value)
                            print(json["items"])
                            self.jsondata = json["items"]
// self.performSegueWithIdentifier("getRepoList", sender:sender)
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
        
        //not used, but it is there.
        if segue.identifier == "getRepoList" {
            
            if let tableViewController = segue.destinationViewController as? TableViewController{
                tableViewController.json = jsondata
                tableViewController.login = self.avatarLogin.text!
            }
     
            
            
        }
    }
    
    
    
}



