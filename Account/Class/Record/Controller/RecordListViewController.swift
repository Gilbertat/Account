//
//  RecordListViewController.swift
//  Account
//
//  Created by shiyue on 16/4/15.
//  Copyright © 2016年 shiyue. All rights reserved.
//

import UIKit
import RealmSwift

class RecordListViewController: UIViewController {

    var userFeatures:Results<UserFeature>!
    var creditNum = 0
    
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    override func viewWillAppear(animated: Bool) {
        reciveNum()
    }
    
    func reciveNum() {
        for num in 0 ..< userFeatures.count {
            creditNum += Int(userFeatures[num].allCredit)!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension RecordListViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let userFeature = self.userFeatures {
            return userFeature.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("recordListCell", forIndexPath: indexPath) as! RecordListCell
        
        cell.timeLabel.text = userFeatures[indexPath.row].recordTime
        cell.pointLabel.text = "\(creditNum)"
        
        return cell
    }
    
}
