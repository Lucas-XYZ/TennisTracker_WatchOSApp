//
//  Tennis_Score_TrackerApp.swift
//  Tennis Score Tracker Watch App
//
//  Created by Lucas Consolati on 28/6/2023.
//

import SwiftUI

@main

struct Tennis_Score_Tracker_Watch_AppApp: App {
    
    @State var points1 = 0
    @State var games1 = 0
    @State var sets1 = 0
    @State var points2 = 0
    @State var games2 = 0
    @State var sets2 = 0
    @State var serve1 = "Right"
    @State var serve2 = " "
    
    var body: some Scene {
        
        WindowGroup {
            TabView {
                ContentView(points1: $points1,
                            points2: $points2,
                            games1: $games1,
                            games2: $games2,
                            sets1: $sets1,
                            sets2: $sets2,
                            serve1: $serve1,
                            serve2: $serve2)
                SettingsView(points1: $points1,
                             points2: $points2,
                             games1: $games1,
                             games2: $games2,
                             sets1: $sets1,
                             sets2: $sets2,
                             serve1: $serve1,
                             serve2: $serve2)
            }
            .tabViewStyle(PageTabViewStyle())
        }
    }
}
