//
//  Task.swift
//  SQLiteDB-iOS
//
//  Created by Fahim Farook on 6/11/15.
//  Copyright © 2015 RookSoft Pte. Ltd. All rights reserved.
//

import UIKit

class RemindersClass:SQLTable
{
	var id = -1
	var reminderDate = ""
	var reminerTitle = ""
	var reminderDescription = ""
	
	init() {
		super.init(tableName:"tblReminders")
	}

	required convenience init(tableName:String) {
		self.init()
	}
}
