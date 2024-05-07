//
//  AppDelegate.swift
//  Spotify
//
//  Created by Terry Jason on 2023/12/2.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .spotifyBlack
        window?.makeKeyAndVisible()
        
        let navigatorController = UINavigationController(rootViewController: TitleBarController())
        window?.rootViewController = navigatorController
        
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = .spotifyBlack
        
        return true
    }
    
}

