//
//  Tennis_Score_TrackerApp.swift
//  Tennis Score Tracker Watch App
//
//  Created by Lucas Consolati on 28/6/2023.
//

import SwiftUI

// Screen size vars
let screenWidth: CGFloat = WKInterfaceDevice.current().screenBounds.width
let screenHeight: CGFloat = WKInterfaceDevice.current().screenBounds.height

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
        // Import saved names if avaliable
        if (defaults.object(forKey: "savedNames") != nil) {
            //var savedNames: [String] = defaults.object(forKey: "savedNames") as! [String]
            name1 = (defaults.object(forKey: "savedNames") as! [String])[0]
            name2 = (defaults.object(forKey: "savedNames") as! [String])[1]
        }
        else {
            name1 = "Player 1"
            name2 = "Player 2"
        }
    }
    @State var tabSelection = 0
    
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
    
    @State var name1: String
    @State var name2: String
    
    var body: some Scene {
        
        // Page layout
        WindowGroup {
            TabView(selection: $tabSelection) {
                ScrollView {
                    MainView(tabSelection: $tabSelection,
                             points1: $points1,
                             points2: $points2,
                             games1: $games1,
                             games2: $games2,
                             sets1: $sets1,
                             sets2: $sets2,
                             serve1: $serve1,
                             serve2: $serve2,
                             timerCount: $timerCount,
                             name1: $name1,
                             name2: $name2)
                }
                    .tag(0)
                // ScrollView used to stop display error
                ScrollView {
                    ContentView(tabSelection: $tabSelection,
                                points1: $points1,
                                points2: $points2,
                                games1: $games1,
                                games2: $games2,
                                sets1: $sets1,
                                sets2: $sets2,
                                serve1: $serve1,
                                serve2: $serve2,
                                timerCount: $timerCount,
                                name1: $name1,
                                name2: $name2)
                }
                    .tag(1)
                    .scrollDisabled(true)
                SettingsView(tabSelection: $tabSelection,
                             points1: $points1,
                             points2: $points2,
                             games1: $games1,
                             games2: $games2,
                             sets1: $sets1,
                             sets2: $sets2,
                             serve1: $serve1,
                             serve2: $serve2,
                             timerCount: $timerCount,
                             name1: $name1,
                             name2: $name2)
                    .tag(2)
            }
            
              .tabViewStyle(PageTabViewStyle())
        }
    }
}
