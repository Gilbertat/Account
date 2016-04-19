//
//  RecordFeatureTableViewController.swift
//  Account
//
//  Created by shiyue on 16/4/15.
//  Copyright © 2016年 shiyue. All rights reserved.
//

import UIKit
import RealmSwift
class RecordFeatureTableViewController: UITableViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var proNameLabel: UILabel!
    @IBOutlet weak var unitPriceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var updateTimeLabel: UILabel!
    
    var userRecord:UserFeature!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView(frame: CGRectZero)
        showData()
        
    }
    
    func showData() {
        self.nameLabel.text = userRecord.name
        self.proNameLabel.text = userRecord.proName
        self.unitPriceLabel.text = userRecord.unitPrice
        self.countLabel.text = userRecord.count
        self.costLabel.text = userRecord.cost
        self.creditLabel.text = "\(userRecord.credit)"
        self.updateTimeLabel.text = userRecord.recordTime
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
