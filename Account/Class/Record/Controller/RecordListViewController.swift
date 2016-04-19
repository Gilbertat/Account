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
    var user:User!
  
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = user.name
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    override func viewWillAppear(animated: Bool) {
        collectData()
    }
    
    @IBAction func addDetail(sender: AnyObject) {
        let board = UIStoryboard(name: "Main", bundle: nil)
        let record = board.instantiateViewControllerWithIdentifier("detail") as! RecordTableViewController
        record.user = self.user
        self.navigationController?.pushViewController(record, animated: true)

    }
    
    // 取出数据
    func collectData() {
        self.userFeatures = self.user.feature.filter("isNew = true")
        self.creditNum = self.userFeatures.sum("credit")
        saveCredit(creditNum, updateValue: user)
        self.tableView.reloadData()
    }
    
       
    // 更新总分
    func saveCredit(value:Int, updateValue:User!) {
        try! realm.write({
            updateValue.creditValue = value
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationController = segue.destinationViewController as! RecordFeatureTableViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationController.userRecord = userFeatures[indexPath.row]
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
        cell.pointLabel.text = "\(userFeatures[indexPath.row].credit)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
   
}
