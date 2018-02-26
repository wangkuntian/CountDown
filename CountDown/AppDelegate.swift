//
//  AppDelegate.swift
//  CountDown
//
//  Created by 王坤田 on 2017/10/27.
//  Copyright © 2017年 王坤田. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let userDefaults = UserDefaults.standard
        
        if !userDefaults.bool(forKey: "firstLaunch") {
            
            userDefaults.set(true, forKey: "firstLaunch")
            
            userDefaults.synchronize()
            
            let images : [String] = ["ic_book.png","ic_exam.png","ic_star.png","ic_music.png","ic_computer.png","ic_draw.png"]
            let names : [String] = ["看书","考试","重要","音乐","电脑","画画"]
            
            
            
            for (index,image) in images.enumerated() {
                
                let level = Double(CoreDataTool.getAllTypes().count) + 1.0
                
                let type = Type(id: Date.longCurrentDateString, name: names[index], image: image, level: level)
                
                _ = CoreDataTool.addNewType(type: type)
                
            }
  
        }
        
        
        //UINavigationBar.appearance().backIndicatorImage = UIImage()
        //UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage()
        
        UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        UINavigationBar.appearance().setBackgroundImage(UserConfig.share.backgroundImage, for: .default)
        
        
        let mainVC = MainVC()
        
        window?.rootViewController = UINavigationController(rootViewController: mainVC)
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
       
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
       
    }

    func applicationWillTerminate(_ application: UIApplication) {
       
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        
        
        let container = NSPersistentContainer(name: "CountDown")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

