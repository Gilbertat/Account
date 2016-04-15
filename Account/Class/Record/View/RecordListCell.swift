//
//  RecordListCell.swift
//  Account
//
//  Created by shiyue on 16/4/15.
//  Copyright © 2016年 shiyue. All rights reserved.
//

import UIKit

class RecordListCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
