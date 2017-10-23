//
//  AppDelegate.swift
//  MMH
//
//  Created by Alex Aslett on 8/28/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
      
        UINavigationBar.appearance().barTintColor = UIColor(red: 0/255, green: 173/255, blue: 225/255, alpha: 1)
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.black]
        
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor(red: 0/255, green: 173/255, blue: 225/255, alpha: 1)
        UITabBar.appearance().tintColor = UIColor.black
        
        return true
    }
 
    
    
}

