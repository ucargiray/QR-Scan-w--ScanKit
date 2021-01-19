//
//  AppDelegate.swift
//  Okan University Coding Challenge
//
//  Created by Giray Uçar on 9.01.2021.
//

import UIKit
import AGConnectCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let config = AGCServicesConfig.init(defaultPlist: ())
        config.clientId = "541387866534588800";
        config.clientSecret = "59C4D27CF0DDEF447AE79C9B72ABA514401956CE5D34370E8B071CC4B9A21E33";
        config.apiKey = "CgB6e3x9ifsTg4TvoH1tDEbfEu/gEDZqBpIpCtR7LJ+7tgMXgxMgYfg2oqNLGnk2Oig0FrbRNm6CDWUD+MEBnpMr";
        AGCInstance.startUp(config)
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }


}

