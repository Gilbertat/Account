//
//  RecordListTableViewCell.swift
//  Account
//
//  Created by shiyue on 16/4/12.
//  Copyright © 2016年 shiyue. All rights reserved.
//

import UIKit

class RecordListTableViewCell: UITableViewCell {

    @IBOutlet weak var recordUsers: UILabel!
    @IBOutlet weak var recordNums: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
