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
    var user : Results<Users>!
    var record:Users!
    var types:Int!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numbersTextField: UITextField!
    @IBOutlet weak var internelTextField: UITextField!
    @IBOutlet weak var incrementTextField: UITextField!
    @IBOutlet weak var decrementTextField: UITextField!
    
    @IBOutlet weak var historyTextField: UITextField!
    @IBOutlet weak var recordTimeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "积分详情"

        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView(frame: CGRectZero)

   
        let systime:NSString = Common.systemDateToString()
        self.recordTimeTextField.text = Common.stringToDate(systime.doubleValue)
        
        
    }
    
    func loadData() {
        self.nameTextField.text = record.userNames
        self.numbersTextField.text = record.buyNums
        self.internelTextField.text = record.nowIntegral
        self.incrementTextField.text = record.increment
        self.decrementTextField.text = record.decrement
        self.historyTextField.text = record.history
        self.recordTimeTextField.text = record.recordTime
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
            if record == nil {
                self.addNewRecord()
            } else {
                self.updateRecord()
            }
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func addNewRecord() {
        
        let newRecord = Users()
        
        newRecord.userNames = self.nameTextField.text!
        newRecord.buyNums = self.numbersTextField.text!
        newRecord.nowIntegral = self.internelTextField.text!
        newRecord.increment = self.incrementTextField.text!
        newRecord.decrement = self.decrementTextField.text!
        newRecord.history = self.historyTextField.text!
        newRecord.recordTime = self.recordTimeTextField.text!
        newRecord.updateTime = self.recordTimeTextField.text!
        
        try! realm.write {
            realm.add(newRecord)
        }
    }
    
    func updateRecord() {
        try! realm.write {
            self.record.userNames = self.nameTextField.text!
            self.record.buyNums = self.numbersTextField.text!
            self.record.nowIntegral = self.internelTextField.text!
            self.record.increment = self.incrementTextField.text!
            self.record.decrement = self.decrementTextField.text!
            self.record.history = self.historyTextField.text!
            self.record.recordTime = self.recordTimeTextField.text!
            self.record.updateTime = self.recordTimeTextField.text!
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
