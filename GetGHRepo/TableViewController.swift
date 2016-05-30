//
//  TableViewController.swift
//  GetGHRepo
//
//  Created by Alexis Chan on 30/05/2016.
//  Copyright © 2016 achan. All rights reserved.
//

import UIKit
import SwiftyJSON

class TableViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    var json:JSON = []
    var login:String = ""
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (key,subJson):(String, JSON) in json {
            //Do something you want
        }
        
    }


}
