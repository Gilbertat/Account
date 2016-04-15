//
//  Users.swift
//  Account
//
//  Created by shiyue on 16/4/13.
//  Copyright © 2016年 shiyue. All rights reserved.
//

import Foundation
import RealmSwift


// 总是在此线程更新realm
let realmQueue = dispatch_queue_create("com.YourApp.YourQueue", dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_UTILITY, 0))


class Users: Object {
    // 用户名
    dynamic var userNames = ""
    
    // 购买次数
    dynamic var buyNums = ""
    
    // 目前积分
    dynamic var nowIntegral = ""
    
    // 增长积分
    dynamic var increment = ""
    
    // 减少积分
    dynamic var decrement = ""
    
    // 历史积分
    dynamic var history = ""
    
    // 记录时间
    dynamic var recordTime = ""
    
    // 更新时间
    dynamic var updateTime = ""
    
}
