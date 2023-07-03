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
    
    @State var undoPos: Int = 0
    
    var body: some View {
        VStack {
            // Undo button
            Button("Undo") {
                if (matchHistory.count > 1) {
                    // Get index for latest match state
                    undoPos = matchHistory.count - 1
                    // Set match data to previous state
                    points1 = matchHistory[undoPos][0] as! Int
                    points2 = matchHistory[undoPos][1] as! Int
                    games1 = matchHistory[undoPos][2] as! Int
                    games2 = matchHistory[undoPos][3] as! Int
                    sets1 = matchHistory[undoPos][4] as! Int
                    sets2 = matchHistory[undoPos][5] as! Int
                    serve1 = matchHistory[undoPos][6] as! String
                    serve2 = matchHistory[undoPos][7] as! String
                    // Remove current match state from history
                    matchHistory.removeLast()
                }
            }
                .padding(.vertical, 10)
            // Reset button
            Button("Reset") {
                // Record match state
                matchHistory.append([points1, points2, games1, games2, sets1, sets2, serve1, serve2])
                // Reset score vars
                points1 = 0
                points2 = 0
                games1 = 0
                games2 = 0
                sets1 = 0
                sets2 = 0
                serve1 = "Right"
                serve2 = " "
                //matchHistory = [[]] // Optional clear match history on reset
            }
                .padding(.vertical, 10)
        }
            .padding(5)
    }
}
