//
//  Tennis_Score_TrackerApp.swift
//  Tennis Score Tracker Watch App
//
//  Created by Lucas Consolati on 28/6/2023.
//

import SwiftUI

// Access save data
let defaults = UserDefaults.standard
var savedMatches: [[[Any]]] = [[[]]]

var matchHistory: [[Any]] = [[]]

let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect() // Create 1s timer

@main

struct Tennis_Score_Tracker_Watch_AppApp: App {
    init() {
        // Import save data if avaliable
        if (defaults.object(forKey: "savedMatches") != nil) {
            savedMatches = defaults.object(forKey: "savedMatches") as! [[[Any]]]
        }
    }
    
    // Create match vars
    @State var points1: Int = 0
    @State var games1: Int = 0
    @State var sets1: Int = 0
    @State var points2: Int = 0
    @State var games2: Int = 0
    @State var sets2: Int = 0
    @State var serve1: String = "Right"
    @State var serve2: String = " "
    
    @State var timerCount: Int = 0
    
    var body: some Scene {
        
        // Page layout
        WindowGroup {
            TabView {
                ScrollView {
                    MainView(points1: $points1,
                              points2: $points2,
                              games1: $games1,
                              games2: $games2,
                              sets1: $sets1,
                              sets2: $sets2,
                              serve1: $serve1,
                              serve2: $serve2,
                              timerCount: $timerCount)
                }
                // ScrollView used to stop display error
                ScrollView {
                    ContentView(points1: $points1,
                                points2: $points2,
                                games1: $games1,
                                games2: $games2,
                                sets1: $sets1,
                                sets2: $sets2,
                                serve1: $serve1,
                                serve2: $serve2,
                                timerCount: $timerCount)
                    
                }
                    .scrollDisabled(true)
                SettingsView(points1: $points1,
                             points2: $points2,
                             games1: $games1,
                             games2: $games2,
                             sets1: $sets1,
                             sets2: $sets2,
                             serve1: $serve1,
                             serve2: $serve2,
                             timerCount: $timerCount)
            }
              .tabViewStyle(PageTabViewStyle())
        }
    }
}
