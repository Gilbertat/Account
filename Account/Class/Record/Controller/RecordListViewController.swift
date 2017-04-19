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
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectData()
    }
    
    @IBAction func addDetail(_ sender: AnyObject) {
        let board = UIStoryboard(name: "Main", bundle: nil)
        let record = board.instantiateViewController(withIdentifier: "detail") as! RecordTableViewController
        record.user = self.user
        self.navigationController?.pushViewController(record, animated: true)

    }
    
    // 取出数据
    func collectData() {
        self.userFeatures = self.user.feature.filter("isNew = true")
        self.creditNum = self.userFeatures.sum(ofProperty: "credit")
        saveCredit(creditNum, updateValue: user)
        self.tableView.reloadData()
    }
    
       
    // 更新总分
    func saveCredit(_ value:Int, updateValue:User!) {
        try! realm.write({
            updateValue.creditValue = value
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationController = segue.destination as! RecordFeatureTableViewController
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let userFeature = self.userFeatures {
            return userFeature.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordListCell", for: indexPath) as! RecordListCell
        
        cell.timeLabel.text = userFeatures[indexPath.row].recordTime
        cell.pointLabel.text = "\(userFeatures[indexPath.row].credit)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
   
}
