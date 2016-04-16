//
//  ViewController.swift
//  Account
//
//  Created by shiyue on 16/4/9.
//  Copyright © 2016年 shiyue. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    var user : Results<UserFeature>!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "积分记录"
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        
    }
    
    func searchUser()  {
        self.user = realm.objects(UserFeature)
        self.tableView.reloadData()
    }
    
    

    @IBAction func addRecord(sender: AnyObject) {
        let board = UIStoryboard(name: "Main", bundle: nil)
        let record = board.instantiateViewControllerWithIdentifier("detail") as! RecordTableViewController
    
        self.navigationController?.pushViewController(record, animated: true)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "record" {
                let model = self.user
                let destinationController = segue.destinationViewController as! RecordListViewController
                destinationController.userFeatures = model
        }
    }

    
    override func viewWillAppear(animated: Bool) {
        self.searchUser()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let record = self.user {
            return record.count
        }
        return 0
        

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("listCell", forIndexPath: indexPath) as! RecordListTableViewCell
        
        cell.recordNums.text = self.user[indexPath.row].name
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Destructive, title: "Delete") { (deleteAction, indexPath) -> Void in
            
            //Deletion will go here
            
            let listToBeDeleted = self.user[indexPath.row]
            try! realm.write({ () -> Void in
                realm.delete(listToBeDeleted)
                self.searchUser()
            })
            
        }
        return [deleteAction]

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

