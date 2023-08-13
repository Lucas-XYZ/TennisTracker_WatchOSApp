//
//  SettingsView.swift
//  Tennis Score Tracker Watch App
//
//  Created by Lucas Consolati on 29/6/2023.
//

import SwiftUI

struct SettingsView: View {
    @Binding var tabSelection: Int
    
    // Import match vars
    @Binding var points1: Int
    @Binding var points2: Int
    @Binding var games1: Int
    @Binding var games2: Int
    @Binding var sets1: Int
    @Binding var sets2: Int
    @Binding var serve1: String
    @Binding var serve2: String
    @Binding var timerCount: Int
    @Binding var name1: String
    @Binding var name2: String
    
    @State var timerDisplay = "0:00" // Timer display in m:ss
    
    @State var undoPos: Int = 0 // Index latest match state
    
    var body: some View {
        VStack {
            HStack {
                TextField("Player 1", text: $name1)
                TextField("Player 2", text: $name2)
            }
            
            // Time played display
            Text("Time Played: \(timerDisplay)")
                .onReceive(timer) { _ in
                    timerCount += 1 // Increase time
                    // Convert timer display to m:ss
                    if (timerCount%60 < 10) {
                        timerDisplay = "\(timerCount/60):0\(timerCount%60)"
                    }
                    else {
                        timerDisplay = "\(timerCount/60):\(timerCount%60)"

                    }
                }
                .font(.body)
                .padding(.vertical, 3)

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
                    
                    tabSelection = 1
                }
            }
                .padding(.vertical, 1)
            
            // Save button
            Button("Save") {
                // Record match state
                matchHistory.append([points1, points2, games1, games2, sets1, sets2, serve1, serve2, timerCount])
                       
                // Save match
                savedMatches.append(matchHistory)
                defaults.set(savedMatches, forKey: "savedMatches")
                
                tabSelection = 0
            }
                .padding(.vertical, 1)
        }
            .padding(3)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(tabSelection: .constant(2),
                     points1: .constant(0),
                     points2: .constant(0),
                     games1: .constant(0),
                     games2: .constant(0),
                     sets1: .constant(0),
                     sets2: .constant(0),
                     serve1: .constant("Right"),
                     serve2: .constant(" "),
                     timerCount: .constant(0),
                     name1: .constant("Player 1"),
                     name2: .constant("Player 2"))
    }
}
