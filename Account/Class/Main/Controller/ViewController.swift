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
    
    var user : Results<Users>!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "积分记录"
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        
    }
    
    func searchUser()  {
        self.user = realm.objects(Users)
        self.tableView.reloadData()
    }
    
    

    @IBAction func addRecord(sender: AnyObject) {
        let board = UIStoryboard(name: "Main", bundle: nil)
        let record = board.instantiateViewControllerWithIdentifier("detail") as! RecordTableViewController
        record.types = 1
    
        self.navigationController?.pushViewController(record, animated: true)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "record" {
            
            if let indexPath = tableView.indexPathForSelectedRow {
                let model = self.user[indexPath.row]
                let destinationController = segue.destinationViewController as! RecordTableViewController
                destinationController.record = model
                destinationController.types = 0
            }
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
        
        cell.recordUsers.text = self.user[indexPath.row].userNames
        cell.recordNums.text = self.user[indexPath.row].history
        
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

