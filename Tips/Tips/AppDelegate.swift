//
//  AppDelegate.swift
//  Tips
//
//  Created by Julian Dong on 2/16/16.
//  Copyright © 2016 Julian Dong. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var billAmount: String?
    var currencySimple: String?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let appearance = UINavigationBar.appearance()
        appearance.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]

        if NSUserDefaults.standardUserDefaults().objectForKey(kThemeIndex) == nil {
            billAmount = ""
            NSUserDefaults.standardUserDefaults().setObject(0, forKey: kThemeIndex)
            NSUserDefaults.standardUserDefaults().setObject(billAmount, forKey: kBillAmount)
            NSUserDefaults.standardUserDefaults().setObject(0, forKey: kPercentage)
        }
        else {
            billAmount = NSUserDefaults.standardUserDefaults().objectForKey(kBillAmount) as? String
        }
        
        let language = NSLocale.currentLocale().objectForKey(NSLocaleLanguageCode)! as! String
        switch language {
        case "vi":
            currencySimple = "đ"
        default:
            currencySimple = "$"
        }
        
        let themeIndex = NSUserDefaults.standardUserDefaults().objectForKey(kThemeIndex) as! Int
        let navBackgroundImage:UIImage! = UIImage(named: String(format: "nb%d", themeIndex))
        appearance.setBackgroundImage(navBackgroundImage, forBarMetrics: .Default)
        appearance.tintColor = UIColor.whiteColor()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        NSUserDefaults.standardUserDefaults().setObject(billAmount, forKey: kBillAmount)
        NSUserDefaults.standardUserDefaults().synchronize()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

