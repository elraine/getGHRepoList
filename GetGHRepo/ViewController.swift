//
//  ViewController.swift
//  GetGHRepo
//
//  Created by Alexis Chan on 30/05/2016.
//  Copyright © 2016 achan. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var lookButton: UIButton!
    
    @IBAction func justDoIt(sender: UIButton) {
        
        if ((searchField.text) != nil) {
            if((searchField.text!.isEmpty)){
                print("lolno")
                return
            }
            
            let composeReq = "https://api.github.com/search/repositories?q=user:"+searchField.text!+"&sort=updated&order=desc"
            
            Alamofire.request(.GET, composeReq , parameters: ["foo": "bar"])
                .responseJSON { response in
                    print("URL req")
                    print(response.request)  // original URL request
                    print("URL resp")
                    print(response.response) // URL response
                    print("URL data")
                    print(response.data)     // server data
                    print("results")
                    print(response.result)   // result of response serialization
                    
                    switch response.result {
                    case .Success:
                        print("Validation Successful")
                    case .Failure(let error):
                        print(error)
                    }
                    
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
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

