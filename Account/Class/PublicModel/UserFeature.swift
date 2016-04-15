//
//  UserFeature.swift
//  Account
//
//  Created by shiyue on 16/4/14.
//  Copyright © 2016年 shiyue. All rights reserved.
//

import Foundation
import RealmSwift

class UserFeature: Object {
    
    // 用户名
    dynamic var name = ""
    
    // 商品名
    dynamic var proName = ""
    
    // 单价
    dynamic var unitPrice = ""
    
    // 数量
    dynamic var count = ""
    
    // 消费金额
    dynamic var cost = ""
    
    // 积分
    dynamic var credit = ""
    
    // 总积分
    dynamic var allCredit = ""
    
    // 记录时间
    dynamic var recordTime = ""
    
    // 与用户表建立关联
    dynamic var userName = User()
    
}
