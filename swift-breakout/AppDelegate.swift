//
//  AppDelegate.swift
//  swift-breakout
//
//  Created by Luke Godfrey on 8/11/14.
//  Copyright (c) 2014 Luke Godfrey. See LICENSE.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
	var window: UIWindow!
	
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool
	{
		let viewController = Breakout()
		
		window = UIWindow(frame: UIScreen.mainScreen().bounds)
		window.rootViewController = viewController
		window.makeKeyAndVisible()
		
		return true
	}
}
