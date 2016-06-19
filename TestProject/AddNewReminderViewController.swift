//
//  AddNewReminderViewController.swift
//  TestProject
//
//  Created by Pavan Gandhi on 19/06/16.
//  Copyright © 2016 Pavan Gandhi. All rights reserved.
//

import UIKit
import THCalendarDatePicker

class AddNewReminderViewController: BaseViewController {

    @IBOutlet var btnSave : UIButton!
    @IBOutlet var btnChooseDate : UIButton!
    @IBOutlet var txtTitle : UITextField!
    @IBOutlet var txvMessage : UITextView!
    @IBOutlet var datePicker : UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnSave.layer.cornerRadius = 5.0
            
        AppUtilities.drawClearBorderToTextView(self.txvMessage, cornerRadius: 5.0, borderRadius: 1.0)
        AppUtilities.drawClearBorderToTextfield(self.txtTitle, cornerRadius: 5.0, borderRadius: 1.0)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    var curDate : NSDate? = NSDate()
//    lazy var formatter: NSDateFormatter = {
//        var tmpFormatter = NSDateFormatter()
//        tmpFormatter.dateFormat = "dd/MM/yyyy --- HH:mm"
//        return tmpFormatter
//    }()
//    
//    lazy var datePicker : THDatePickerViewController = {
//        let picker = THDatePickerViewController.datePicker()
//        picker.delegate = self
//        picker.date = self.curDate
//        picker.setAllowClearDate(false)
//        picker.setClearAsToday(false)
//        picker.setAutoCloseOnSelectDate(true)
//        picker.setAllowSelectionOfSelectedDate(true)
//        picker.setDisableYearSwitch(true)
//        //picker.setDisableFutureSelection(false)
//        picker.setDaysInHistorySelection(1)
//        picker.setDaysInFutureSelection(0)
//        picker.setDateTimeZoneWithName("UTC")
//        picker.autoCloseCancelDelay = 5.0
//        picker.rounded = true
//        picker.dateTitle = "My DatePicker"
//        picker.selectedBackgroundColor = UIColor(red: 125.0/255.0, green: 208.0/255.0, blue: 0.0/255.0, alpha: 1.0)
//        picker.currentDateColor = UIColor(red: 242.0/255.0, green: 121.0/255.0, blue: 53.0/255.0, alpha: 1.0)
//        picker.currentDateColorSelected = UIColor.yellowColor()
//        return picker
//    }()
    
//    @IBAction func touchedButton(sender: AnyObject) {
//        datePicker.date = self.curDate
//        datePicker.setDateHasItemsCallback { (date: NSDate!) -> Bool in
//            let tmp = (arc4random() % 30)+1
//            return (tmp % 5 == 0)
//        }
//        presentSemiViewController(datePicker, withOptions: [
//            convertCfTypeToString(KNSemiModalOptionKeys.shadowOpacity) as String! : 0.3 as Float,
//            convertCfTypeToString(KNSemiModalOptionKeys.animationDuration) as String! : 1.0 as Float,
//            convertCfTypeToString(KNSemiModalOptionKeys.pushParentBack) as String! : false as Bool
//            ])
//    }
    
    @IBAction func btnSaveClicked(sender : AnyObject)
    {
        let dateformatter = NSDateFormatter()
        print(datePicker.date)
        dateformatter.dateFormat = "dd-MM-yyyy hh:mm:ss"
        let dateString = dateformatter.stringFromDate(datePicker.date)
        
        let objNoti : RemindersClass = RemindersClass()
        objNoti.reminderDate = dateString as String
        objNoti.reminerTitle = self.txtTitle.text! as String
        objNoti.reminderDescription = self.txvMessage.text as String
    
        print(objNoti.reminderDate)
        print(objNoti.reminerTitle)
        print(objNoti.reminderDescription)
        
        if objNoti.save().success
        {
            NSLog("%@", "Success with Storing obj Reminder Data.")
            let settings = UIApplication.sharedApplication().currentUserNotificationSettings()
            
            if settings!.types == .None {
                let ac = UIAlertController(title: "Can't schedule", message: "Either we don't have permission to schedule notifications, or we haven't asked yet.", preferredStyle: .Alert)
                ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                presentViewController(ac, animated: true, completion: nil)
                return
            }
            let datestr : NSDate = datePicker.date
            let notification = UILocalNotification()
            notification.fireDate = datestr
            notification.timeZone = NSTimeZone.defaultTimeZone()
            notification.alertBody = self.txtTitle.text
            notification.alertAction = "be awesome!"
            notification.soundName = UILocalNotificationDefaultSoundName
            notification.userInfo = ["CustomField1": self.txvMessage.text]
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
    }
    
//    /* https://vandadnp.wordpress.com/2014/07/07/swift-convert-unmanaged-to-string/ */
//    func convertCfTypeToString(cfValue: Unmanaged<NSString>!) -> String?{
//        /* Coded by Vandad Nahavandipoor */
//        let value = Unmanaged<CFStringRef>.fromOpaque(
//            cfValue.toOpaque()).takeUnretainedValue() as CFStringRef
//        if CFGetTypeID(value) == CFStringGetTypeID(){
//            return value as String
//        } else {
//            return nil
//        }
//    }
    
//    // MARK: THDatePickerDelegate
//    
//    func datePickerDonePressed(datePicker: THDatePickerViewController!) {
//        curDate = datePicker.date
//        self.btnChooseDate.setTitle((curDate != nil ? formatter.stringFromDate(curDate!) : "No date selected"), forState: UIControlState.Normal)
//        dismissSemiModalView()
//    }
//    
//    func datePickerCancelPressed(datePicker: THDatePickerViewController!) {
//        dismissSemiModalView()
//    }
//    
//    func datePicker(datePicker: THDatePickerViewController!, selectedDate: NSDate!) {
//        print("Date selected: ", formatter.stringFromDate(selectedDate))
//    }

}
