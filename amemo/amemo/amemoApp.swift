//
//  amemoApp.swift
//  amemo
//
//  Created by qazx.mac on 07/09/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseRemoteConfig

@main
struct amemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().preferredColorScheme(.dark)
            //TestCode()
        }
    }
    
    init() {
        FirebaseApp.configure()
        
        let remoteConfig = RemoteConfig.remoteConfig()
        let remoteConfigSettings = RemoteConfigSettings()
        remoteConfigSettings.minimumFetchInterval = 0
        remoteConfig.configSettings = remoteConfigSettings
        remoteConfig.setDefaults(fromPlist: "RemoteConfigKeys")
    }
}
