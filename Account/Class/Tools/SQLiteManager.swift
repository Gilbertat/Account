//
//  SQLiteManager.swift
//  Account
//
//  Created by shiyue on 16/4/9.
//  Copyright © 2016年 shiyue. All rights reserved.
//

import Foundation

class SQLiteManager {
    // 单例
    static let sharedManager = SQLiteManager()
    
    // 数据库句柄：COpaquePointer(含糊的指针)通常是一个结构体指针
    private var db:COpaquePointer = nil
    
    /**
     打开数据库
     
     - parameter dbName: 数据库名称
     */
    func openDB(dbName:String) {
        // 获取沙盒路径
        let documentPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last! as NSString
        
        // 获取数据库完整路径
        let path = documentPath.stringByAppendingPathComponent(dbName)
        
        /*
         参数:
            1.fileName: 数据库完整路径
            2.数据库句柄
         返回值:
            Int,SQLITE_OK表示打开数据库成功
         注意:
            1:如果数据库不存在，会创建数据库在打开。
            2:如果存在，直接打开
         
         */
        if sqlite3_open(path, &db) != SQLITE_OK {
            print("打开数据库失败，请重试")
            
            return
        }
        print("打开数据库成功")
    }
    
    /**
     执行sql语句
     
     - parameter sql: sql语句
     
     - returns: sql语句是否执行成功
     */
    internal func execSql(sql: String) -> Bool {
        
        /**
         sqlite执行语句
         
         参数:
         *  1.COpaquePointer: 数据库句柄
         *  2.sql: 要执行的sql语句
         *  3.callback: sql执行完后的回调，通常为nil
         *  4.UnsafeMutablePointer<Void>: 回调函数第一个参数地址，通常为nil
         *  5.错误信息的指针，通常为nil
         返回值:
            Int: SQLite_OK表示执行成功
         */
        return (sqlite3_exec(db, sql, nil, nil, nil) == SQLITE_OK)
    }
    
    internal func createTable() -> Bool {
        let sql = "CREATE TABLE IF NOT EXISTS AC_USERS( \n" +
        "id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, \n" +
        "userNames TEXT, \n" +
        "buyNums INTEGER, \n" +
        "n_integral INTEGER, \n" +
        "in_integral INTEGER, \n" +
        "de_integral INTEGER, \n" +
        "history INTEGER, \n" +
        "r_time INTEGER, \n" +
        "u_time INTEGER \n" +
        ")"
        
        print("sql:\(sql)")
        
        // 执行sql
        
        return execSql(sql)
    }
    
    
}