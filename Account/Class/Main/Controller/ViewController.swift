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
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        
    }
    
    func searchUser()  {
        self.user = realm.objects(User.self)
        self.userFeature = realm.objects(UserFeature.self)
        self.tableView.reloadData()
    }
    
   
    @IBAction func addRecord(_ sender: AnyObject) {
        let board = UIStoryboard(name: "Main", bundle: nil)
        let record = board.instantiateViewController(withIdentifier: "detail") as! RecordTableViewController
        self.navigationController?.pushViewController(record, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.searchUser()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    @IBAction func didSelectSortCriteria(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            // 姓名
            self.user = self.user.sorted(byKeyPath: "name")
        } else {
            // 积分
            self.user = self.user.sorted(byKeyPath: "creditValue")
        }
        
        self.tableView.reloadData()
        
    }
    
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let record = self.user {
            return record.count
        }
        return 0
        

    }
    @IBAction func addUser(_ sender: AnyObject) {
        let alertController = UIAlertController(title: "添加用户", message: nil, preferredStyle: .alert)
        let createAction = UIAlertAction(title: "确定", style: .default) { (action) in
            let userName = alertController.textFields?.first?.text
            let user = User()
            user.name = userName!
            try! realm.write({
                realm.add(user)
                self.searchUser()
            })
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "添加新用户"
        }
        
        alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        alertController.addAction(createAction)
        alertController.view.setNeedsLayout()
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! RecordListTableViewCell
        
        cell.recordUsers.text = self.user[indexPath.row].name
        
        cell.recordNums.text = "\(self.user[indexPath.row].creditValue)"
        
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive , title: "Delete") { (deleteAction, indexPath) -> Void in
            
            //Deletion will go here
            
            let listToBeDeleted = self.user[indexPath.row]
            
            try! realm.write({ () -> Void in
                realm.delete(listToBeDeleted)
                self.searchUser()
                
            })
            
        }
        return [deleteAction]

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "record", sender: self.user[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationController = segue.destination as! RecordListViewController
//        if let indexPath = tableView.indexPathForSelectedRow {
            destinationController.user = sender as! User
        
    }

}

