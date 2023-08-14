//
//  MainView.swift
//  Tennis Tracker Watch App
//
//  Created by Lucas Consolati on 13/7/2023.
//

import SwiftUI

struct MainView: View {
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
    
    // Create match list
    @State var matchList: [MatchItem] = [] // Create match list
    @State var matchPos: Int = 0 // Index latest game state
    struct MatchItem: Identifiable {
        let id = UUID() // Generate unique id
        let index: Int
        let data: [[Any]] // Match history data
        let timerDisplay: String // Time display
    }
    // Update matchList for display
    func setMatchList() {
        matchList = [] // Reset matchList
        if (defaults.object(forKey: "savedMatches") != nil && savedMatches.count > 1) { // Check for avaliable data
            for i in 1...(savedMatches.count - 1) { // Loop through saved matches
                
                var timerDisplay: String // Stores timerCount in form m:ss
                let timerIndex: Int = savedMatches[i][savedMatches[i].count-1][8] as! Int // stores timerCount
                if (timerIndex%60 < 10) {
                    timerDisplay = "\(timerIndex/60):0\(timerIndex%60)"
                }
                else {
                    timerDisplay = "\(timerIndex/60):\(timerIndex%60)"

                }
                
                matchList.append(MatchItem(index: i, data: savedMatches[i], timerDisplay: timerDisplay)) // Create list item
            }
        }
    }
    
    var body: some View {
        VStack {
            // New match button
            Button("New Match") {
                // Reset match vars
                points1 = 0
                points2 = 0
                games1 = 0
                games2 = 0
                sets1 = 0
                sets2 = 0
                serve1 = "Right"
                serve2 = " "
                timerCount = 0
                matchHistory = [[]]
                
                tabSelection = 1
            }
                .padding(3)
                .onAppear() { // Reload match list
                    setMatchList()
                }
            
            // Loop though match list
            ForEach(matchList, id: \.id) {match in
                HStack {
                    // Display "sets1 : sets2 | m:ss"
                    Button("\(match.data[match.data.count-1][4] as! Int) : \(match.data[match.data.count-1][5] as! Int) | \(match.timerDisplay)") {
                        // Set match vars to latest match state
                        matchPos = match.data.count - 1
                        points1 = match.data[matchPos][0] as! Int
                        points2 = match.data[matchPos][1] as! Int
                        games1 = match.data[matchPos][2] as! Int
                        games2 = match.data[matchPos][3] as! Int
                        sets1 = match.data[matchPos][4] as! Int
                        sets2 = match.data[matchPos][5] as! Int
                        serve1 = match.data[matchPos][6] as! String
                        serve2 = match.data[matchPos][7] as! String
                        timerCount = match.data[matchPos][8] as! Int
                        matchHistory = match.data
                        
                        tabSelection = 1
                    }
                    // Clear match data
                    Button("X") {
                        savedMatches.remove(at: match.index)
                        defaults.set(savedMatches, forKey: "savedMatches")
                        setMatchList() // Reload match list
                        
                    }
                        .frame(width: screenWidth * 0.25)
                }
            }
                .padding(3)
            
            // Clear data button
            Button("Clear Data") {
                UserDefaults.standard.removeObject(forKey: "savedNames") // Clear saved names
                name1 = "Player 1"
                name2 = "Player 2"
                
                UserDefaults.standard.removeObject(forKey: "savedMatches") // Clear saved data
                savedMatches = [[[]]] // Reset saved data var
                setMatchList() // Reload match list
            }
                .padding(3)
        }
        .padding(3)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(tabSelection: .constant(0),
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
