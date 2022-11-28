//
//  SwiftUI_google_cloud_video_intelligenceApp.swift
//  SwiftUI_google_cloud_video_intelligence
//
//  Created by Khuong Pham on 28/11/2022.
//

import SwiftUI
import Firebase

@main
struct SwiftUI_google_cloud_video_intelligenceApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
