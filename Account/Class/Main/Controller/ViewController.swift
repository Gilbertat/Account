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
    
    var user : Results<User>!
    var userFeature: Results<UserFeature>!
    var result:User!
    var creditNum = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "积分记录"
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
    }
    
    func searchUser()  {
        self.user = realm.objects(User)
        self.userFeature = realm.objects(UserFeature)
        self.tableView.reloadData()
    }
    
   
    @IBAction func addRecord(sender: AnyObject) {
        let board = UIStoryboard(name: "Main", bundle: nil)
        let record = board.instantiateViewControllerWithIdentifier("detail") as! RecordTableViewController
        self.navigationController?.pushViewController(record, animated: true)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.searchUser()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    @IBAction func didSelectSortCriteria(sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            // 姓名
            self.user = self.user.sorted("name")
        } else {
            // 积分
            self.user = self.user.sorted("creditValue")
        }
        
        self.tableView.reloadData()
        
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
    @IBAction func addUser(sender: AnyObject) {
        let alertController = UIAlertController(title: "添加用户", message: nil, preferredStyle: .Alert)
        let createAction = UIAlertAction(title: "确定", style: .Default) { (action) in
            let userName = alertController.textFields?.first?.text
            let user = User()
            user.name = userName!
            try! realm.write({
                realm.add(user)
                self.searchUser()
            })
        }
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "添加新用户"
        }
        
        alertController.addAction(UIAlertAction(title: "取消", style: .Cancel, handler: nil))
        alertController.addAction(createAction)
        alertController.view.setNeedsLayout()
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("listCell", forIndexPath: indexPath) as! RecordListTableViewCell
        
        cell.recordUsers.text = self.user[indexPath.row].name
        
        cell.recordNums.text = "\(self.user[indexPath.row].creditValue)"
        
        
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
        self.performSegueWithIdentifier("record", sender: self.user[indexPath.row])
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationController = segue.destinationViewController as! RecordListViewController
//        if let indexPath = tableView.indexPathForSelectedRow {
            destinationController.user = sender as! User
        
    }

}

