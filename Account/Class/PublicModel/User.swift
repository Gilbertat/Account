//
//  User.swift
//  Account
//
//  Created by shiyue on 16/4/14.
//  Copyright © 2016年 shiyue. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    
    dynamic var name = ""
    
    dynamic var creditValue = 0
    
    // 与用户表建立关联
    let feature = List<UserFeature>()

}
