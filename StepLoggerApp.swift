//
//  StepLoggerApp.swift
//  StepLogger
//
//  Created by rei asahina on 2023/02/11.
//

import SwiftUI

@main
struct StepLoggerApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AppEnvironment())
        }
    }
}

