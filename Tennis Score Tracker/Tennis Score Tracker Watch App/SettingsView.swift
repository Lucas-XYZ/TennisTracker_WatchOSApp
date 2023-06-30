//
//  SettingsView.swift
//  Tennis Score Tracker Watch App
//
//  Created by Lucas Consolati on 29/6/2023.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var points1: Int
    @Binding var points2: Int
    @Binding var games1: Int
    @Binding var games2: Int
    @Binding var sets1: Int
    @Binding var sets2: Int
    @Binding var serve1: String
    @Binding var serve2: String
    
    var body: some View {
        
        Button("Reset") {
            points1 = 0
            points2 = 0
            games1 = 0
            games2 = 0
            sets1 = 0
            sets2 = 0
            serve1 = "Right"
            serve2 = " "
        }
    }
}
