//
//  BaseViewController.swift
//  DoHomeCall
//
//  Created by Bigscal on 20/04/15.
//  Copyright (c) 2015 Bigscal. All rights reserved.
//

import UIKit

// constants
let useClosures = false

class BaseViewController: UIViewController, UIAlertViewDelegate
{
    // prepared local variables
    var actInd : UIActivityIndicatorView?
    var internetConnection:Bool = true;
	var userdefaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
	
    override func viewDidLoad()
    {
        super.viewDidLoad()
	}

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    /*========================================================
    * function Name: setNavigationBarWithBackOption
    * function Purpose: to set navigation bar for view
    * function Parameters: title: NSString
    * function ReturnType: nil
    *=======================================================*/
    
    func setNavigationBarWithBackOption(title: NSString)
    {
		self.navigationController?.navigationBar.translucent = false
	   UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        // Left Navigation Item
        let btnLeft:UIButton! = UIButton()
        btnLeft!.frame = CGRectMake(0, 0, 18, 25)
        let addImage:UIImage = UIImage(named: "Back")!
        btnLeft!.setBackgroundImage(addImage, forState: UIControlState.Normal)
        btnLeft!.addTarget(self, action: "handleBackOption:",forControlEvents: UIControlEvents.TouchUpInside)
        let leftItem:UIBarButtonItem = UIBarButtonItem(customView: btnLeft!)
        self.navigationItem.leftBarButtonItem = leftItem
        
        // Title of Navigation Item
        let navigationTitleLbl:UILabel = UILabel(frame:CGRectMake(0, 0, 320, 40.0))
        navigationTitleLbl.text = title as String
        navigationTitleLbl.font =  UIFont.boldSystemFontOfSize(18.0)
        navigationTitleLbl.font =  UIFont(name: FONT_NAME, size: 18.0)
        navigationTitleLbl.textColor=UIColor.whiteColor()
        navigationTitleLbl.textAlignment = NSTextAlignment.Center
        navigationTitleLbl.frame = CGRectMake(100, 0.0, 100, 100)
        self.navigationItem.titleView = navigationTitleLbl
		
		self.navigationController!.navigationBar.setBackgroundImage(UIImage(named: "Navbar"),
			forBarMetrics: .Default)
		

    }
	
	func setNavigationBarWithBackCartOption(title: NSString)
	{
		self.navigationController?.navigationBar.translucent = false
		UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
		// Left Navigation Item
		let btnLeft:UIButton! = UIButton()
		btnLeft!.frame = CGRectMake(0, 0, 18, 25)
		let addImage:UIImage = UIImage(named: "Back")!
		btnLeft!.setBackgroundImage(addImage, forState: UIControlState.Normal)
		btnLeft!.addTarget(self, action: "handleBackOption:",forControlEvents: UIControlEvents.TouchUpInside)
		let leftItem:UIBarButtonItem = UIBarButtonItem(customView: btnLeft!)
		self.navigationItem.leftBarButtonItem = leftItem
		
		// Title of Navigation Item
		let navigationTitleLbl:UILabel = UILabel(frame:CGRectMake(0, 0, 320, 40.0))
		navigationTitleLbl.text = title as String
		navigationTitleLbl.font =  UIFont.boldSystemFontOfSize(18.0)
		navigationTitleLbl.font =  UIFont(name: FONT_NAME, size: 18.0)
		navigationTitleLbl.textColor=UIColor.whiteColor()
		navigationTitleLbl.textAlignment = NSTextAlignment.Center
		navigationTitleLbl.frame = CGRectMake(100, 0.0, 100, 100)
		self.navigationItem.titleView = navigationTitleLbl
		
		self.navigationController!.navigationBar.setBackgroundImage(UIImage(named: "Navbar"),
			forBarMetrics: .Default)
		
		self.setRightbarbutton()
	}

	
	func setNavigationBarWithMENUOption(title: NSString)
	{
		self.navigationController?.navigationBar.translucent = false
		UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
		// Left Navigation Item
		let btnLeft:UIButton! = UIButton()
		btnLeft!.frame = CGRectMake(0, 0, 25, 20)
		let addImage:UIImage = UIImage(named: "Main Icon")!
		btnLeft!.setBackgroundImage(addImage, forState: UIControlState.Normal)
		btnLeft!.addTarget(self, action: "presentLeftMenuViewController:",forControlEvents: UIControlEvents.TouchUpInside)
		let leftItem:UIBarButtonItem = UIBarButtonItem(customView: btnLeft!)
		self.navigationItem.leftBarButtonItem = leftItem
		
		// Title of Navigation Item
		let navigationTitleLbl:UILabel = UILabel(frame:CGRectMake(0, 0, 320, 40.0))
		navigationTitleLbl.text = title as String
		navigationTitleLbl.font =  UIFont.boldSystemFontOfSize(18.0)
		navigationTitleLbl.font =  UIFont(name: FONT_NAME, size: 18.0)
		navigationTitleLbl.textColor=UIColor.whiteColor()
		navigationTitleLbl.textAlignment = NSTextAlignment.Center
		navigationTitleLbl.frame = CGRectMake(100, 0.0, 100, 100)
		self.navigationItem.titleView = navigationTitleLbl
		
		self.navigationController!.navigationBar.setBackgroundImage(UIImage(named: "Navbar"),
			forBarMetrics: .Default)
		
	}
	
	func setNavigationBarWithMENUCARTOption(title: NSString)
	{
		self.navigationController?.navigationBar.translucent = false
		UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
		// Left Navigation Item
		let btnLeft:UIButton! = UIButton()
		btnLeft!.frame = CGRectMake(0, 0, 25, 20)
		let addImage:UIImage = UIImage(named: "Main Icon")!
		btnLeft!.setBackgroundImage(addImage, forState: UIControlState.Normal)
		btnLeft!.addTarget(self, action: "presentLeftMenuViewController:",forControlEvents: UIControlEvents.TouchUpInside)
		let leftItem:UIBarButtonItem = UIBarButtonItem(customView: btnLeft!)
		self.navigationItem.leftBarButtonItem = leftItem
		
		// Title of Navigation Item
		let navigationTitleLbl:UILabel = UILabel(frame:CGRectMake(0, 0, 320, 40.0))
		navigationTitleLbl.text = title as String
		navigationTitleLbl.font =  UIFont.boldSystemFontOfSize(18.0)
		navigationTitleLbl.font =  UIFont(name: FONT_NAME, size: 18.0)
		navigationTitleLbl.textColor=UIColor.whiteColor()
		navigationTitleLbl.textAlignment = NSTextAlignment.Center
		navigationTitleLbl.frame = CGRectMake(100, 0.0, 100, 100)
		self.navigationItem.titleView = navigationTitleLbl
		
		self.navigationController!.navigationBar.setBackgroundImage(UIImage(named: "Navbar"),
			forBarMetrics: .Default)
		
		UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
		
		self.setRightbarbutton()
	}

	func setNavigationBarWithMENUTRACKOption(title: NSString)
	{
		self.navigationController?.navigationBar.translucent = false
		UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
		// Left Navigation Item
		let btnLeft:UIButton! = UIButton()
		btnLeft!.frame = CGRectMake(0, 0, 25, 20)
		let addImage:UIImage = UIImage(named: "Main Icon")!
		btnLeft!.setBackgroundImage(addImage, forState: UIControlState.Normal)
		btnLeft!.addTarget(self, action: "presentLeftMenuViewController:",forControlEvents: UIControlEvents.TouchUpInside)
		let leftItem:UIBarButtonItem = UIBarButtonItem(customView: btnLeft!)
		self.navigationItem.leftBarButtonItem = leftItem
		
		// Title of Navigation Item
		let navigationTitleLbl:UILabel = UILabel(frame:CGRectMake(0, 0, 320, 40.0))
		navigationTitleLbl.text = title as String
		navigationTitleLbl.font =  UIFont.boldSystemFontOfSize(18.0)
		navigationTitleLbl.font =  UIFont(name: FONT_NAME, size: 18.0)
		navigationTitleLbl.textColor=UIColor.whiteColor()
		navigationTitleLbl.textAlignment = NSTextAlignment.Center
		navigationTitleLbl.frame = CGRectMake(100, 0.0, 100, 100)
		self.navigationItem.titleView = navigationTitleLbl
		
		self.navigationController!.navigationBar.setBackgroundImage(UIImage(named: "Navbar"),
			forBarMetrics: .Default)
		
		UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
		
		self.setRightbarTrackbutton()
	}
	
	func setRightbarTrackbutton()
	{
		// Left Navigation Item
		let btnRight:UIButton! = UIButton()
		btnRight!.frame = CGRectMake(0, 0, 35, 35)
		let imgRight:UIImage = UIImage(named: "Delivery")!
		btnRight!.setBackgroundImage(imgRight, forState: UIControlState.Normal)
		btnRight!.addTarget(self, action: "DelieveyOption:",forControlEvents: UIControlEvents.TouchUpInside)
		let rightItem:UIBarButtonItem = UIBarButtonItem(customView: btnRight!)
		self.navigationItem.rightBarButtonItem = rightItem
	}

	func setNavigationBarWithSyncOption(title: NSString)
	{
		self.navigationController?.navigationBar.translucent = false
		UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
		// Left Navigation Item
		// Left Navigation Item
		let btnLeft:UIButton! = UIButton()
		btnLeft!.frame = CGRectMake(0, 0, 18, 25)
		let addImage:UIImage = UIImage(named: "Back")!
		btnLeft!.setBackgroundImage(addImage, forState: UIControlState.Normal)
		btnLeft!.addTarget(self, action: "handleBackOption:",forControlEvents: UIControlEvents.TouchUpInside)
		let leftItem:UIBarButtonItem = UIBarButtonItem(customView: btnLeft!)
		self.navigationItem.leftBarButtonItem = leftItem
		
		// Title of Navigation Item
		let navigationTitleLbl:UILabel = UILabel(frame:CGRectMake(0, 0, 320, 40.0))
		navigationTitleLbl.text = title as String
		navigationTitleLbl.font =  UIFont.boldSystemFontOfSize(18.0)
		navigationTitleLbl.font =  UIFont(name: FONT_NAME, size: 18.0)
		navigationTitleLbl.textColor=UIColor.whiteColor()
		navigationTitleLbl.textAlignment = NSTextAlignment.Center
		navigationTitleLbl.frame = CGRectMake(100, 0.0, 100, 100)
		self.navigationItem.titleView = navigationTitleLbl
		
		self.navigationController!.navigationBar.setBackgroundImage(UIImage(named: "Navbar"),
			forBarMetrics: .Default)
		
		UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
		
		//self.setRightbarSyncbutton()
		
	}

	func setRightbarbutton()
	{
		// Left Navigation Item
		let btnRight:UIButton! = UIButton()
		btnRight!.frame = CGRectMake(0, 0, 25, 20)
		let imgRight:UIImage = UIImage(named: "shopcart")!
		btnRight!.setBackgroundImage(imgRight, forState: UIControlState.Normal)
		btnRight!.addTarget(self, action: "shopCartOption:",forControlEvents: UIControlEvents.TouchUpInside)
		let rightItem:UIBarButtonItem = UIBarButtonItem(customView: btnRight!)
		self.navigationItem.rightBarButtonItem = rightItem
	}
	
	override func viewWillAppear(animated: Bool) {
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateOrder:", name: "orderUpdation", object: nil)
	}
	
	deinit
	{
		NSNotificationCenter.defaultCenter().removeObserver(self)
	}
	
	func updateOrder(notification:NSNotification)
	{
		self.setRightbarbutton()
	}

	@IBAction func DelieveyOption(sender: AnyObject)
	{
		// Delivery option
		
		let alert : UIAlertView = UIAlertView(title: "Track Info" as String, message: "Do you want to show tracking status?", delegate: self, cancelButtonTitle: "YES", otherButtonTitles: "NO")
		alert.tag = 111
		alert.show()

	}

	func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
		if(alertView.tag == 111)
		{
			if(buttonIndex == 0)
			{
//				let trackOrderObj = self.storyboard?.instantiateViewControllerWithIdentifier(trackProductListVCIdentifier) as? trackProductListViewController
//				self.navigationController?.pushViewController(trackOrderObj!, animated: true)
			}
		}
	}
	
	
    /*========================================================
    * function Name: handleBack
    * function Purpose: Go back to the previous view
    * function Parameters: sender: AnyObject
    * function ReturnType: nil
    *=======================================================*/
    
    @IBAction func handleBackOption(sender: AnyObject)
	{
		self.navigationController?.popViewControllerAnimated(true)
    }
	
    /*========================================================
    * function Name: showAlertWithMessage
    * function Purpose: showAlertWithMessage
    * function Parameters: var title: NSString ,var message:NSString
    * function ReturnType: nil
    * function Description: showAlertWithMessage
    *=====================================================*/
    
    func showAlertWithMessage(title: NSString , message:NSString)
    {
        let alert : UIAlertView = UIAlertView(title: title as String, message: message as String, delegate: self, cancelButtonTitle: "OK")
        alert.show()
    }
	
    //for Uploading
    /*========================================================
    * Function Name:startIndicator
    * Function Parameter:uiView:UIView
    * Function Return Type: none
    *Function Purpose:To display process are running indicator
    =========================================================*/
    
    func startIndicatorforjob(uiView:UIView)
    {
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        // create transparent View
        let container: UIView = UIView()
        container.frame = CGRectMake(0, 0, uiView.bounds.size.width, uiView.bounds.size.height + 75)
        container.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2)
        
        // create custom loading view
        let loadingView: UIView = UIView()
        loadingView.frame = CGRectMake(self.view.bounds.size.width / 2 - 75, self.view.bounds.size.height / 2 - 80, 150, 60)
        loadingView.backgroundColor = UIColor.blackColor()
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        // prepare activity indicator
        self.actInd = UIActivityIndicatorView()
        self.actInd?.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        self.actInd?.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        self.actInd?.bounds = CGRectMake(-5,-10, loadingView.frame.size.width / 2, loadingView.frame.size.height / 2)
        loadingView.addSubview(actInd!)
        
        // prepare label for display progress
        let label = UILabel(frame: CGRectMake(48, 21,120,20))
        label.text = "Please Wait..."
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name: "Arial", size: 15.0)
        loadingView.addSubview(label)
        
        // add custom view into transparent view
        container.addSubview(loadingView)
        uiView.addSubview(container)
        self.actInd!.startAnimating()
    }
    
    /*========================================================
    * Function Name:stopIndicator
    * Function Parameter: none
    * Function Return Type: none
    * Function Purpose:To remove display process are running indicator
    =========================================================*/
    
    func stopIndicatorforjob()
    {
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        self.actInd!.stopAnimating()
        ((self.actInd!.superview as UIView!).superview as UIView!).removeFromSuperview()
    }

}
