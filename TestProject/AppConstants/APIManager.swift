//
//  APIManager.swift
//  IMSApp
//
//  Created by SATISH on 12/12/15.
//  Copyright © 2015 PayMyReview. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration
/*
class APIManager: NSObject
{
	// Getting menu Item and store into DB
	
	class func getMenuData(urlStr1 : NSString)
	{
		let urlStr : NSString = NSString(format: "%@%@", BASE_URL, GET_MENUS_DATA)
		let dict : NSMutableDictionary = NSMutableDictionary(objects: ["menu", urlStr1], forKeys: ["type", "website"])
		
		let manager :AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
		let requestObj : AFHTTPRequestSerializer = AFHTTPRequestSerializer()
		let responseObj : AFHTTPResponseSerializer = AFHTTPResponseSerializer()
		manager.requestSerializer = requestObj
		manager.responseSerializer = responseObj
		manager.responseSerializer.acceptableContentTypes = nil
		
		manager.POST(urlStr as String, parameters: dict, success: { (opration : AFHTTPRequestOperation!, responseObject : AnyObject!) -> Void in
			
			var dictMenuResult : NSMutableArray = NSMutableArray()
			let resDict : NSMutableArray = try! NSJSONSerialization.JSONObjectWithData((responseObject as? NSData)!, options: NSJSONReadingOptions.MutableContainers) as! NSMutableArray
			dictMenuResult = resDict
			
			if(dictMenuResult.count > 0)
			{
				let db = SQLiteDB.sharedInstance()
				let result = db.execute("DELETE FROM tblMenuMaster")
				if(result == 0)
				{
					
				}
				else
				{
					for(var i : Int = 0 ; i < dictMenuResult.count ; i++)
					{
						
						let obj : MenuMaster = MenuMaster()
						obj.ID = ((dictMenuResult.objectAtIndex(i).valueForKey("ID") as? NSString)?.integerValue)!
						obj.Name = (dictMenuResult.objectAtIndex(i).valueForKey("Name") as? String)!
						
						if obj.save().success
						{
							print("Success with Storing MenuData.")
						}
					}
				}
				
			}
			}) { (operaiton : AFHTTPRequestOperation!, error : NSError!) -> Void in
				print(error.description)
		}
	}
	
	// Get SMS Settings From API and Store into DB
	
	class func getSMSSettingsData(urlStr1 : NSString, successpart : (Bool) -> Void)
	{
		let urlStr : NSString = NSString(format: "%@%@", BASE_URL, GET_SMS_SETTINGS)
		let dict : NSMutableDictionary = NSMutableDictionary(objects: ["sms", urlStr1], forKeys: ["type","website"])
		
		let manager :AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
		let requestObj : AFHTTPRequestSerializer = AFHTTPRequestSerializer()
		let responseObj : AFHTTPResponseSerializer = AFHTTPResponseSerializer()
		manager.requestSerializer = requestObj
		manager.responseSerializer = responseObj
		manager.responseSerializer.acceptableContentTypes = nil
		
		manager.POST(urlStr as String, parameters: dict, success: { (opration : AFHTTPRequestOperation!, responseObject : AnyObject!) -> Void in
			
			var dictSMSMenuResult : NSMutableArray = NSMutableArray()
			let resDict : NSMutableArray = try! NSJSONSerialization.JSONObjectWithData((responseObject as? NSData)!, options: NSJSONReadingOptions.MutableContainers) as! NSMutableArray
			
			dictSMSMenuResult = resDict
			
			if(dictSMSMenuResult.count > 0)
			{
				for(var i : Int = 0 ; i < dictSMSMenuResult.count ; i++)
				{
//					var dic  :NSMutableDictionary = NSMutableDictionary()
//					dic = (dictSMSMenuResult.objectAtIndex(i) as? NSMutableDictionary)!
//					NSUserDefaults.standardUserDefaults().setValue(dic, forKey: "SMSSettings")
//					NSUserDefaults.standardUserDefaults().synchronize()
					let db = SQLiteDB.sharedInstance()
					let result = db.execute("DELETE FROM tblSmsSettings")
					if(result == 0)
					{
						
					}
					else
					{
						let objSMSSettings : SMSSettings = SMSSettings()
						objSMSSettings.SenderId = ((dictSMSMenuResult.objectAtIndex(i).valueForKey("SenderId") as? NSString))! as String
						objSMSSettings.UserId = (dictSMSMenuResult.objectAtIndex(i).valueForKey("UserId") as? String)!
						objSMSSettings.pswd = (dictSMSMenuResult.objectAtIndex(i).valueForKey("pswd") as? String)!
						objSMSSettings.Reason = ((dictSMSMenuResult.objectAtIndex(i).valueForKey("Reason") as? NSString))! as String
						objSMSSettings.ApplicationName = (dictSMSMenuResult.objectAtIndex(i).valueForKey("ApplicationName") as? String)!
						objSMSSettings.URLName = ((dictSMSMenuResult.objectAtIndex(i).valueForKey("URLName") as? NSString))! as String
						objSMSSettings.SMSGateway = (dictSMSMenuResult.objectAtIndex(i).valueForKey("SMSGateway") as? String)!
						objSMSSettings.SMSGatewayAPI = ((dictSMSMenuResult.objectAtIndex(i).valueForKey("SMSGatewayAPI") as? NSString))! as String
						objSMSSettings.MobileNos = ((dictSMSMenuResult.objectAtIndex(i).valueForKey("MobileNos") as? NSString))! as String
						objSMSSettings.SMS = ((dictSMSMenuResult.objectAtIndex(i).valueForKey("SMS") as? NSString))! as String
						objSMSSettings.BalanceURL = ((dictSMSMenuResult.objectAtIndex(i).valueForKey("BalanceURL") as? NSString))! as String
                        
						if objSMSSettings.save().success
						{
							print("Success with Storing SMS Settings Data.")
						}
						
                        self.loadSMSBalance(objSMSSettings.BalanceURL, userName: objSMSSettings.UserId, password:  objSMSSettings.pswd, successpart: { (status : Bool) -> Void in
                            //
                        })
					}
				}
			}
			successpart(true)
			}) { (operaiton : AFHTTPRequestOperation!, error : NSError!) -> Void in
				print(error.description)
				successpart(false)
		}
	}
	
    class func loadSMSBalance(urlstr : NSString, userName : NSString , password : NSString, successpart : (Bool) -> Void)

	{
		var urlStr : NSString = NSString(format: "%@%@&%@", urlstr, userName, password)
		urlStr = urlStr.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
		print(urlStr)
		
		let manager :AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
		let requestObj : AFHTTPRequestSerializer = AFHTTPRequestSerializer()
		let responseObj : AFHTTPResponseSerializer = AFHTTPResponseSerializer()
		manager.requestSerializer = requestObj
		manager.responseSerializer = responseObj
		
		manager.POST(urlStr as String, parameters: nil, success: { (opration : AFHTTPRequestOperation!, responseObject : AnyObject!) -> Void in
			
			let di : NSDictionary = NSDictionary(XMLData: (responseObject as? NSData)!)
			print(di)
			if let credit = di.valueForKey("credit") as? NSString
			{
				NSUserDefaults.standardUserDefaults().setValue(credit, forKey: "Balance")
				NSUserDefaults.standardUserDefaults().synchronize()
			}
			else
			{
				NSUserDefaults.standardUserDefaults().setValue("0.0", forKey: "Balance")
				NSUserDefaults.standardUserDefaults().synchronize()
			}
    
			NSNotificationCenter.defaultCenter().postNotificationName("updateBalanceData", object: self)
			successpart(true)
            
			}) { (operaiton : AFHTTPRequestOperation!, error : NSError!) -> Void in
				print(error.description)
                successpart(false)
		}
	}

	// GET STAFF DATA and store into DB
	
	class func getStaffData(urlStr : NSString, successpart : (Bool) -> Void)
	{
		let urlStr : NSString = NSString(format: "http://%@/services.asmx/%@", urlStr, GET_FACULTY_DATA)
		let dict : NSMutableDictionary = NSMutableDictionary(objects: ["faculty"], forKeys: ["type"])
		let manager :AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
		let requestObj : AFHTTPRequestSerializer = AFHTTPRequestSerializer()
		let responseObj : AFHTTPResponseSerializer = AFHTTPResponseSerializer()
		manager.requestSerializer = requestObj
		manager.responseSerializer = responseObj
		manager.responseSerializer.acceptableContentTypes = nil
		
		
		manager.POST(urlStr as String, parameters: dict, success: { (opration : AFHTTPRequestOperation!, responseObject : AnyObject!) -> Void in
			
			var dictDeviceResult : NSMutableArray = NSMutableArray()
			let resDict : NSMutableArray = try! NSJSONSerialization.JSONObjectWithData((responseObject as? NSData)!, options: NSJSONReadingOptions.MutableContainers) as! NSMutableArray
			dictDeviceResult = resDict
			
			if(dictDeviceResult.count > 0)
			{
				let db = SQLiteDB.sharedInstance()
				let result = db.execute("DELETE FROM tblFacultyMaster")
				if(result == 0)
				{
					
				}
				else
				{
					for(var i : Int = 0 ; i < dictDeviceResult.count ; i++)
					{
						let objStaff : Faculty = Faculty()
						objStaff.facultyID = (dictDeviceResult.objectAtIndex(i).valueForKey("Id") as? NSString)!.integerValue
						objStaff.facultyName = (dictDeviceResult.objectAtIndex(i).valueForKey("Faculty") as? NSString)! as String
						objStaff.userName = (dictDeviceResult.objectAtIndex(i).valueForKey("Username") as? NSString)! as String
						objStaff.password = (dictDeviceResult.objectAtIndex(i).valueForKey("Password") as? NSString)! as String
						objStaff.ClassID = (dictDeviceResult.objectAtIndex(i).valueForKey("ClassId") as? NSString)!.integerValue
						
						if objStaff.save().success
						{
							print("Success with Storing Faculty Data.")
						}
					}
				}
			}
			
				successpart(true)
			}) { (operaiton : AFHTTPRequestOperation!, error : NSError!) -> Void in
				print(error.description)
				successpart(false)
		}
	}
	
	// get Faculty Details Data and stote into Db
	
	class func getFacultyDetailsData(urlStr : NSString, successpart : (Bool) -> Void)
	{
		let urlStr : NSString = NSString(format: "http://%@/services.asmx/%@", urlStr, GET_FACULTY_DETAILS_DATA)
		let dict : NSMutableDictionary = NSMutableDictionary(objects: ["facultydet"], forKeys: ["type"])
		
		let manager :AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
		let requestObj : AFHTTPRequestSerializer = AFHTTPRequestSerializer()
		let responseObj : AFHTTPResponseSerializer = AFHTTPResponseSerializer()
		manager.requestSerializer = requestObj
		manager.responseSerializer = responseObj
		manager.responseSerializer.acceptableContentTypes = nil
		
		manager.POST(urlStr as String, parameters: dict, success: { (opration : AFHTTPRequestOperation!, responseObject : AnyObject!) -> Void in
			
			var facultyDetailsData : NSMutableArray = NSMutableArray()
			let resDict : NSMutableArray = try! NSJSONSerialization.JSONObjectWithData((responseObject as? NSData)!, options: NSJSONReadingOptions.MutableContainers) as! NSMutableArray
			facultyDetailsData = resDict
			
			if(facultyDetailsData.count > 0)
			{
				
				let db = SQLiteDB.sharedInstance()
				let result = db.execute("DELETE FROM tblFacultyDetailsMaster")
				if(result == 0)
				{
					
				}
				else
				{
					for(var i : Int = 0 ; i < facultyDetailsData.count ; i++)
					{
						
						let objFactDetails : FacultyDetailsMaster = FacultyDetailsMaster()
						objFactDetails.facultyID = (facultyDetailsData.objectAtIndex(i).valueForKey("facultyid") as? NSString)!.integerValue
						objFactDetails.subID = (facultyDetailsData.objectAtIndex(i).valueForKey("subid") as? NSString)!.integerValue
						objFactDetails.classID = (facultyDetailsData.objectAtIndex(i).valueForKey("classid") as? NSString)!.integerValue
			
						if objFactDetails.save().success
						{
							print("Success with Storing Faculty Details Data.")
						}
					}
				}
			}
			successpart(true)
			}) { (operaiton : AFHTTPRequestOperation!, error : NSError!) -> Void in
				print(error.description)
				successpart(false)
				//self.stopIndicatorforjob()
		}
	}

	// GEt Class Data and store into DB
	
	class func getClassData(urlStr : NSString, successPart : (Bool) -> Void)
	{
		let urlStr : NSString = NSString(format: "http://%@/services.asmx/%@", urlStr, GET_STANDARDS_DATA)
		let dict : NSMutableDictionary = NSMutableDictionary(objects: ["standard"], forKeys: ["type"])
		
		let manager :AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
		let requestObj : AFHTTPRequestSerializer = AFHTTPRequestSerializer()
		let responseObj : AFHTTPResponseSerializer = AFHTTPResponseSerializer()
		manager.requestSerializer = requestObj
		manager.responseSerializer = responseObj
		manager.responseSerializer.acceptableContentTypes = nil
		
		manager.POST(urlStr as String, parameters: dict, success: { (opration : AFHTTPRequestOperation!, responseObject : AnyObject!) -> Void in
			
			var arrClassData : NSMutableArray = NSMutableArray()
			let resDict : NSMutableArray = try! NSJSONSerialization.JSONObjectWithData((responseObject as? NSData)!, options: NSJSONReadingOptions.MutableContainers) as! NSMutableArray
			arrClassData = resDict
			
			if(arrClassData.count > 0)
			{
				
				let db = SQLiteDB.sharedInstance()
				let result = db.execute("DELETE FROM tblStandards")
				if(result == 0)
				{
					
				}
				else
				{
					for(var i : Int = 0 ; i < arrClassData.count ; i++)
					{
						let objClass : Standards = Standards()
						objClass.DeptId = (arrClassData.objectAtIndex(i).valueForKey("DeptId") as? NSString)!.integerValue
						objClass.DeptName = (arrClassData.objectAtIndex(i).valueForKey("DeptName") as? NSString)! as String
						objClass.startRN = (arrClassData.objectAtIndex(i).valueForKey("MinVal") as? NSString)!.integerValue
						objClass.endRN = (arrClassData.objectAtIndex(i).valueForKey("MaxVal") as? NSString)!.integerValue
					
						if objClass.save().success
						{
							print("Success with Storing Class Data.")
						}
					}
				}
			}
			successPart(true)
			}) { (operaiton : AFHTTPRequestOperation!, error : NSError!) -> Void in
				print(error.description)
				successPart(false)
		}
	}
	
	// Get Subjects Dat and store into DB
	
	
	class func getSubjectData(urlStr : NSString , successPart : (Bool) -> Void)
	{
		let urlStr : NSString = NSString(format: "http://%@/services.asmx/%@", urlStr, GET_SUBJECTS_DATA)
		
		let dict : NSMutableDictionary = NSMutableDictionary(objects: ["subject"], forKeys: ["type"])
	
		let manager :AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
		let requestObj : AFHTTPRequestSerializer = AFHTTPRequestSerializer()
		let responseObj : AFHTTPResponseSerializer = AFHTTPResponseSerializer()
		manager.requestSerializer = requestObj
		manager.responseSerializer = responseObj
		manager.responseSerializer.acceptableContentTypes = nil
		
		manager.POST(urlStr as String, parameters: dict, success: { (opration : AFHTTPRequestOperation!, responseObject : AnyObject!) -> Void in
			
			var arrSubjectData  :NSMutableArray = NSMutableArray()
			let resDict : NSMutableArray = try! NSJSONSerialization.JSONObjectWithData((responseObject as? NSData)!, options: NSJSONReadingOptions.MutableContainers) as! NSMutableArray
			arrSubjectData = resDict
			
			if(arrSubjectData.count > 0)
			{
				//self.stopIndicatorforjob()
				let db = SQLiteDB.sharedInstance()
				let result = db.execute("DELETE FROM tblSubjects")
				if(result == 0)
				{
					
				}
				else
				{
					for(var i : Int = 0 ; i < arrSubjectData.count ; i++)
					{
						let objSub : Subjects = Subjects()
						objSub.subCode = (arrSubjectData.objectAtIndex(i).valueForKey("code") as? NSString)!.integerValue
						objSub.subName = (arrSubjectData.objectAtIndex(i).valueForKey("Name") as? NSString)! as String
						
						if objSub.save().success
						{
							print("Success with Storing Subject Data.")
						}
					}
				}
			}
			successPart(true)
			}) { (operaiton : AFHTTPRequestOperation!, error : NSError!) -> Void in
				print(error.description)
				successPart(false)
				//self.stopIndicatorforjob()
		}
	}
	
	// Load Student Details and Store into DB
	class func getStudentData(urlStr : NSString, successPart : (Bool) -> Void)
	{
		//self.startIndicatorforjob(self.view)
		let urlStr : NSString = NSString(format: "http://%@/services.asmx/%@", urlStr, GET_STUDENTS_DATA)
		
		let dict : NSMutableDictionary = NSMutableDictionary(objects: ["student"], forKeys: ["type"])
		
		let manager :AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
		let requestObj : AFHTTPRequestSerializer = AFHTTPRequestSerializer()
		let responseObj : AFHTTPResponseSerializer = AFHTTPResponseSerializer()
		manager.requestSerializer = requestObj
		manager.responseSerializer = responseObj
		manager.responseSerializer.acceptableContentTypes = nil
		
		manager.POST(urlStr as String, parameters: dict, success: { (opration : AFHTTPRequestOperation!, responseObject : AnyObject!) -> Void in
			
			var arrStudentData : NSMutableArray = NSMutableArray()
			
			let resDict : NSMutableArray = try! NSJSONSerialization.JSONObjectWithData((responseObject as? NSData)!, options: NSJSONReadingOptions.MutableContainers) as! NSMutableArray
			arrStudentData = resDict
			
			
			if(arrStudentData.count > 0)
			{
				//self.stopIndicatorforjob()
				let db = SQLiteDB.sharedInstance()
				let result = db.execute("DELETE FROM tblStudents")
				if(result == 0)
				{
					
				}
				else
				{
					for(var i : Int = 0 ; i < arrStudentData.count ; i++)
					{
						let objStud : Students = Students()
						objStud.empId = (arrStudentData.objectAtIndex(i).valueForKey("EmpId") as? NSString)!.integerValue
						objStud.rollNo = (arrStudentData.objectAtIndex(i).valueForKey("RollNo") as? NSString)!.integerValue
						objStud.Name = (arrStudentData.objectAtIndex(i).valueForKey("Name") as? NSString)! as String
						objStud.studentMobile = (arrStudentData.objectAtIndex(i).valueForKey("StudentMobile") as? NSString)! as String
						objStud.fathersMobile = (arrStudentData.objectAtIndex(i).valueForKey("FathersMobile") as? NSString)! as String
						objStud.mothersMobile = (arrStudentData.objectAtIndex(i).valueForKey("MothersMobile") as? NSString)! as String
						let dateStr = (arrStudentData.objectAtIndex(i).valueForKey("DOB") as? NSString)! as String
						let dateFormatter=NSDateFormatter()
						dateFormatter.dateFormat="dd-MM-yyyy"
						let bdate : NSDate = dateFormatter.dateFromString(dateStr)!
						dateFormatter.dateFormat="yyyy-MM-dd"
						let finalbDate : NSString = dateFormatter.stringFromDate(bdate)
						objStud.DOB = finalbDate as String
						objStud.deptId = (arrStudentData.objectAtIndex(i).valueForKey("DeptId") as? NSString)!.integerValue
						objStud.busNo = (arrStudentData.objectAtIndex(i).valueForKey("BusNo") as? NSString)! as String
						objStud.grpCode = (arrStudentData.objectAtIndex(i).valueForKey("GrpCode") as? NSString)! as String
						objStud.areaId = (arrStudentData.objectAtIndex(i).valueForKey("AreaId") as? NSString)! as String
						objStud.schCode = (arrStudentData.objectAtIndex(i).valueForKey("SchCode") as? NSString)! as String
						
						if objStud.save().success
						{
							print("Success with Storing Student Details Data.")
						}
					}
				}
			}
			successPart(true)
			}) { (operaiton : AFHTTPRequestOperation!, error : NSError!) -> Void in
				print(error.description)
				successPart(false)
				//				/self.stopIndicatorforjob()
		}
	}
	
	// send Attendance Data to API 

	class func sendStudentAttendanceData(urlStr : NSString, successPart : (Bool) -> Void)
	{
		//self.startIndicatorforjob(self.view)
		var attendanceData : NSString = "["
		let db = SQLiteDB.sharedInstance()
		let data = db.query("SELECT * FROM studentAttendance")
		if(data.count > 0)
		{
			for(var p = 0; p < data.count; p++)
			{
				let row = data[p]
				let dict : NSMutableDictionary = NSMutableDictionary()
				dict.setValue(row["facultyId"], forKey: "fid")
				dict.setValue(row["rollNo"], forKey: "rollno")
				if(row["studStatus"]!.isEqualToString("Absent"))
				{
					dict.setValue("A", forKey: "status")
				}
				else
				{
					dict.setValue("P", forKey: "status")
				}
				dict.setValue(row["studName"], forKey: "name")
				dict.setValue(row["attendenceDate"], forKey: "date")
				dict.setValue(row["empId"], forKey: "studentid")
				dict.setValue(row["classID"], forKey: "classid")
				dict.setValue(row["subID"], forKey: "subid")
				let theJSONData = try! NSJSONSerialization.dataWithJSONObject( dict , options: NSJSONWritingOptions(rawValue: 0))
				let theJSONText = NSString(data: theJSONData,
					encoding: NSASCIIStringEncoding)
				print("JSON string = \(theJSONText!)")
				attendanceData = attendanceData.stringByAppendingString(theJSONText as! String)
				attendanceData = attendanceData.stringByAppendingString(",")
			}
		}
		attendanceData = attendanceData.substringWithRange(NSMakeRange(0, attendanceData.length - 1))
		attendanceData = attendanceData.stringByAppendingString("]")
		print(attendanceData)

		let urlStr : NSString = NSString(format: "http://%@/services.asmx/%@", urlStr, INSERT_ATTENDANCE_DATA)
		
		let dict : NSMutableDictionary = NSMutableDictionary(objects: ["atdata", attendanceData], forKeys: ["type", "data"])
		
		let manager :AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
		let requestObj : AFHTTPRequestSerializer = AFHTTPRequestSerializer()
		let responseObj : AFHTTPResponseSerializer = AFHTTPResponseSerializer()
		manager.requestSerializer = requestObj
		manager.responseSerializer = responseObj

		manager.POST(urlStr as String, parameters: dict, success: { (opration : AFHTTPRequestOperation!, responseObject : AnyObject!) -> Void in
		
			
			let resDict : NSMutableDictionary = try! NSJSONSerialization.JSONObjectWithData((responseObject as? NSData)!, options: NSJSONReadingOptions.MutableContainers) as! NSMutableDictionary
			print(resDict)
		
			if((resDict.valueForKey("Message") as? NSString)!.isEqualToString("Data Insert."))
			{
				AppUtilities.showAlertWithMessage(APP_TITLE, message: "Attendance Submitted Successfully.")
			}
			
			successPart(true)
			}) { (operaiton : AFHTTPRequestOperation!, error : NSError!) -> Void in
				print(error.description)
				successPart(false)
				//				/self.stopIndicatorforjob()
		}
	}
	
	class func sendStudentAttendanceRangeData(urlStr : NSString, startDate : NSString, endDate : NSString, successPart : (Bool) -> Void)
	{
		//self.startIndicatorforjob(self.view)
		var attendanceData : NSString = "["
		let db = SQLiteDB.sharedInstance()
		let data = db.query("SELECT * FROM studentAttendance where attendenceDate >= ? AND attendenceDate <= ?", parameters: [startDate, endDate])
		print(data.count)
		if(data.count > 0)
		{
			for(var p = 0; p < data.count; p++)
			{
				let row = data[p]
				let dict : NSMutableDictionary = NSMutableDictionary()
				dict.setValue(row["facultyId"], forKey: "fid")
				dict.setValue(row["rollNo"], forKey: "rollno")
				if(row["studStatus"]!.isEqualToString("Absent"))
				{
					dict.setValue("A", forKey: "status")
				}
				else
				{
					dict.setValue("P", forKey: "status")
				}
				dict.setValue(row["studName"], forKey: "name")
				dict.setValue(row["attendenceDate"], forKey: "date")
				dict.setValue(row["empId"], forKey: "studentid")
				dict.setValue(row["classID"], forKey: "classid")
				dict.setValue(row["subID"], forKey: "subid")
				let theJSONData = try! NSJSONSerialization.dataWithJSONObject( dict , options: NSJSONWritingOptions(rawValue: 0))
				let theJSONText = NSString(data: theJSONData,
					encoding: NSASCIIStringEncoding)
				print("JSON string = \(theJSONText!)")
				attendanceData = attendanceData.stringByAppendingString(theJSONText as! String)
				attendanceData = attendanceData.stringByAppendingString(",")
			}
		}
		attendanceData = attendanceData.substringWithRange(NSMakeRange(0, attendanceData.length - 1))
		attendanceData = attendanceData.stringByAppendingString("]")
		print(attendanceData)
		
		let urlStr : NSString = NSString(format: "http://%@/services.asmx/%@", urlStr, INSERT_ATTENDANCE_DATA)
		
		let dict : NSMutableDictionary = NSMutableDictionary(objects: ["atdata", attendanceData], forKeys: ["type", "data"])
		
		let manager :AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
		let requestObj : AFHTTPRequestSerializer = AFHTTPRequestSerializer()
		let responseObj : AFHTTPResponseSerializer = AFHTTPResponseSerializer()
		manager.requestSerializer = requestObj
		manager.responseSerializer = responseObj
		
		manager.POST(urlStr as String, parameters: dict, success: { (opration : AFHTTPRequestOperation!, responseObject : AnyObject!) -> Void in
			
			
			let resDict : NSMutableDictionary = try! NSJSONSerialization.JSONObjectWithData((responseObject as? NSData)!, options: NSJSONReadingOptions.MutableContainers) as! NSMutableDictionary
			print(resDict)
			
			if((resDict.valueForKey("Message") as? NSString)!.isEqualToString("Data Insert."))
			{
				AppUtilities.showAlertWithMessage(APP_TITLE, message: "Attendance Submitted Successfully.")
			}
			
			successPart(true)
			}) { (operaiton : AFHTTPRequestOperation!, error : NSError!) -> Void in
				print(error.description)
				successPart(false)
				//				/self.stopIndicatorforjob()
		}
	}
	
	// Load TimeTable Details and Store into DB
	class func getTimeTableData(urlStr : NSString, successPart : (Bool) -> Void)
	{
		//self.startIndicatorforjob(self.view)
		let urlStr : NSString = NSString(format: "http://%@/services.asmx/%@", urlStr, GET_TIME_TABLE)
		
		let dict : NSMutableDictionary = NSMutableDictionary(objects: ["timetable"], forKeys: ["type"])
		
		let manager :AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
		let requestObj : AFHTTPRequestSerializer = AFHTTPRequestSerializer()
		let responseObj : AFHTTPResponseSerializer = AFHTTPResponseSerializer()
		manager.requestSerializer = requestObj
		manager.responseSerializer = responseObj
		manager.responseSerializer.acceptableContentTypes = nil
		
		manager.POST(urlStr as String, parameters: dict, success: { (opration : AFHTTPRequestOperation!, responseObject : AnyObject!) -> Void in
			
			var arrTimeTableData : NSMutableArray = NSMutableArray()
			
			let resDict : NSMutableArray = try! NSJSONSerialization.JSONObjectWithData((responseObject as? NSData)!, options: NSJSONReadingOptions.MutableContainers) as! NSMutableArray
			arrTimeTableData = resDict
		
			if(arrTimeTableData.count > 0)
			{
				//self.stopIndicatorforjob()
				let db = SQLiteDB.sharedInstance()
				let result = db.execute("DELETE FROM tblTimeTable")
				if(result == 0)
				{
					
				}
				else
				{
					for(var i : Int = 0 ; i < arrTimeTableData.count ; i++)
					{
						let objTimeTable : TimeTable = TimeTable()
						objTimeTable.deptId = (arrTimeTableData.objectAtIndex(i).valueForKey("ClassID") as? NSString)!.integerValue
						objTimeTable.dayName = (arrTimeTableData.objectAtIndex(i).valueForKey("Day") as? NSString)! as String
						objTimeTable.dayTime = (arrTimeTableData.objectAtIndex(i).valueForKey("Time") as? NSString)! as String
						objTimeTable.facultyId = (arrTimeTableData.objectAtIndex(i).valueForKey("TechID") as? NSString)!.integerValue
						objTimeTable.facultyName = (arrTimeTableData.objectAtIndex(i).valueForKey("Faculty") as? NSString)! as String
						objTimeTable.subjectName = (arrTimeTableData.objectAtIndex(i).valueForKey("SubjectName") as? NSString)! as String
				
						if objTimeTable.save().success
						{
							print("Success with Storing Time Table Details Data.")
						}
					}
				}
			}
			
			successPart(true)
			}) { (operaiton : AFHTTPRequestOperation!, error : NSError!) -> Void in
				print(error.description)
				successPart(false)
				//				/self.stopIndicatorforjob()
		}
	}
	
	// Store Message templates
	
	class func getTemplates(urlStr1 : NSString)
	{
		let urlStr : NSString = NSString(format: "http://%@/services.asmx/%@", urlStr1, GET_TEMPLATES)
		let dict : NSMutableDictionary = NSMutableDictionary(objects: ["template"], forKeys: ["type"])
		
		let manager :AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
		let requestObj : AFHTTPRequestSerializer = AFHTTPRequestSerializer()
		let responseObj : AFHTTPResponseSerializer = AFHTTPResponseSerializer()
		manager.requestSerializer = requestObj
		manager.responseSerializer = responseObj
		manager.responseSerializer.acceptableContentTypes = nil
		
		manager.POST(urlStr as String, parameters: dict, success: { (opration : AFHTTPRequestOperation!, responseObject : AnyObject!) -> Void in
			
			var dictTempResult : NSMutableArray = NSMutableArray()
			let resDict : NSMutableArray = try! NSJSONSerialization.JSONObjectWithData((responseObject as? NSData)!, options: NSJSONReadingOptions.MutableContainers) as! NSMutableArray
			dictTempResult = resDict
			
			if(dictTempResult.count > 0)
			{
				let db = SQLiteDB.sharedInstance()
				let result = db.execute("DELETE FROM tblTemplates")
				if(result == 0)
				{
					
				}
				else
				{
					for(var i : Int = 0 ; i < dictTempResult.count ; i++)
					{
						
						let obj : Templates = Templates()
						obj.tempId = i
						obj.tempmsg = (dictTempResult.objectAtIndex(i).valueForKey("Message") as? String)!
						obj.temptitle = (dictTempResult.objectAtIndex(i).valueForKey("Name") as? String)!
						
						if obj.save().success
						{
							print("Success with Storing templatesData.")
						}
					}
				}
				
			}
			}) { (operaiton : AFHTTPRequestOperation!, error : NSError!) -> Void in
				print(error.description)
		}
	}
}*/
