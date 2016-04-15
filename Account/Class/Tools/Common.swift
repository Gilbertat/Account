//
//  Common.swift
//  Account
//
//  Created by shiyue on 16/4/9.
//  Copyright © 2016年 shiyue. All rights reserved.
//

import Foundation
import UIKit

class Common {
    
    // 将系统当前时间转换为时间戳
    static func systemDateToString() -> String {
        
        let date = NSDate(timeIntervalSinceNow: 0)
        let dateString = String(format: "%.f", date.timeIntervalSince1970)
        return dateString
        
    }
    
    /**
     将时间转化为时间戳存储
     
     - parameter nowDate: 给定的时间字符串
     
     - returns: 返回转化后的时间戳
     */
    static func dateToString(nowDate:String) -> String {
        
        let formatter = NSDateFormatter()
        // 设置时间格式
        formatter.dateFormat = "YYYY-MM-dd"
        // 设置时区
        let timeZone = NSTimeZone(name: "Asia/Shanghai")
        
        formatter.timeZone = timeZone
        
        // 将字符串根据时间格式转换为date
        let date = formatter.dateFromString(nowDate)
        
        let dateString = String(format: "%.f", date!.timeIntervalSince1970)
        
        return dateString
        
    }
    
    // 将时间戳转换为时间
    
    static func stringToDate(timeValue:Double) -> String {
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let timeZone = NSTimeZone(name: "Asia/Shanghai")
        formatter.timeZone = timeZone
        
        let date = NSDate(timeIntervalSince1970: timeValue)
        let nowDate = formatter.stringFromDate(date)
        
        return nowDate
    }
    
    
}

extension UIColor {
    convenience init(red:Int, green:Int, blue:Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red:CGFloat(red) / 255.0, green:CGFloat(green) / 255.0, blue:CGFloat(blue) / 255.0, alpha:1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}
