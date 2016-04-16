//
//  RecordTableViewController.swift
//  Account
//
//  Created by shiyue on 16/4/12.
//  Copyright © 2016年 shiyue. All rights reserved.
//

import UIKit
import RealmSwift

class RecordTableViewController: UITableViewController, UITextFieldDelegate {
  
    
    // 用户名
    @IBOutlet weak var nameTextField: UITextField!
    // 商品名称
    @IBOutlet weak var numbersTextField: UITextField!
    // 单价
    @IBOutlet weak var internelTextField: UITextField!
    // 数量
    @IBOutlet weak var incrementTextField: UITextField!
    // 消费金额
    @IBOutlet weak var decrementTextField: UITextField!
    // 积分
    @IBOutlet weak var historyTextField: UITextField!
    // 记录时间
    @IBOutlet weak var recordTimeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "积分详情"

        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView(frame: CGRectZero)

   
        let systime:NSString = Common.systemDateToString()
        self.recordTimeTextField.text = Common.stringToDate(systime.doubleValue)
        self.decrementTextField.text = "0"
        self.historyTextField.text = "0"
        
    }
    
    func validateFields() -> Bool {
        let name = nameTextField.text!
        let numbers = numbersTextField.text!
        let internel = internelTextField.text!
        let increment = incrementTextField.text!
        let decrement = decrementTextField.text!
        let history = historyTextField.text!
        let record = recordTimeTextField.text!
        
        if name == "" || numbers == "" || internel == "" || increment == "" || decrement == "" || history == "" || record == "" {
            
            let alertController = UIAlertController(title: "出错啦！！", message: "除了记录时间以外都是必填项目，请检查后在试了噜！", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alertController .addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            
            return false
        } else {
            return true
        }
    }
    
    
    @IBAction func saveUsers(sender: AnyObject) {
        if validateFields() {
            addNewRecord()
            let alertController = UIAlertController(title: "注意啦", message: "保存后将无法更改,请慎重点击确定哦!", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "确定", style: .Cancel, handler: { (action) in
                self.navigationController?.popViewControllerAnimated(true)
            })
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func addNewRecord() {
        dispatch_async(realmQueue) { 
            
            let realm = try! Realm()

            let newRecord = UserFeature()
            newRecord.name = self.nameTextField.text!
            newRecord.proName = self.numbersTextField.text!
            newRecord.unitPrice = self.internelTextField.text!
            newRecord.count = self.incrementTextField.text!
            let all = (Int(self.internelTextField.text!)! * Int(self.incrementTextField.text!)!)
            newRecord.cost = "\(all)"
            newRecord.credit = "\(all)"
            newRecord.recordTime = self.recordTimeTextField.text!
            newRecord.allCredit = "\(all)"
            try! realm.write {
                realm.add(newRecord)
            }
        }
        
        // 添加用户名
        dispatch_async(realmQueue) {
            let realm = try! Realm()
            let newUser = User()
            newUser.name = self.nameTextField.text!
            try! realm.write{
                realm.add(newUser)
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // 进入界面,添加通知
    override func viewWillAppear(animated: Bool) {
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(RecordTableViewController.keyboardWillShowNotification(_:)), name: UIKeyboardWillShowNotification, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(RecordTableViewController.keyboardWillHideNotification(_:)), name: UIKeyboardWillHideNotification, object: nil)

    }
    
    // 离开界面，销毁通知
    override func viewWillDisappear(animated: Bool) {
       // NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // 键盘弹出或收起
//    func keyboardWillShowNotification(notification:NSNotification) {
//        let userInfo:NSDictionary = notification.userInfo!
//        let rect = userInfo[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue
//        let keyBoardHeight = CGRectGetHeight(rect!)
//        let keyboardDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey]?.doubleValue
//        
//        UIView .animateWithDuration(keyboardDuration!) { () -> Void in
//            self.tableView.frame = CGRectMake(0, -keyBoardHeight, self.tableView.frame.size.width, self.tableView.frame.size.height)
//        }
//        
//    }
//    
//    func keyboardWillHideNotification(notification:NSNotification) {
//        let userInfo:NSDictionary = notification.userInfo!
//        let keyboardDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey]?.doubleValue
//        
//        
//        UIView.animateWithDuration(keyboardDuration!) { () -> Void in
//            self.tableView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height)
//            
//        }
//    }
    
    // 键盘相关
    func textFieldDidEndEditing(textField: UITextField) {
        textField.layoutIfNeeded()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField == nameTextField {
            numbersTextField.becomeFirstResponder()
        } else if textField == numbersTextField {
            internelTextField.becomeFirstResponder()
        } else if textField == internelTextField{
            incrementTextField.becomeFirstResponder()
        } else if textField == incrementTextField{
            decrementTextField.becomeFirstResponder()
        } else if textField == decrementTextField {
            historyTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }


}
