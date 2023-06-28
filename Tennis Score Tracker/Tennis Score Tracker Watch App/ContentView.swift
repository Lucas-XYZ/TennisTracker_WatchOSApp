//
//  ContentView.swift
//  Tennis Score Tracker Watch App
//
//  Created by Lucas Consolati on 28/6/2023.
//

import SwiftUI
import UIKit



struct ContentView: View {
    
    let scoreList = ["0", "15", "30", "40", "", "AD"]
    @State var score1 = 0
    @State var score2 = 0
    @State var output = "No winner yet"
    
    func reset() {
        score1 = 0
        score2 = 0
        //output = "No winner yet"
    }
    
    var body: some View {
        VStack {
            
            HStack {
                Button(scoreList[score1]) {
                    if (score1 == 3 && score2 < 3) {
                        output = "Player 1 wins"
                        //reset()
                    }
                    else if (score1 == 5 && score2 == 4) {
                        output = "Player 1 wins"
                    }
                    else if (score1 == 3 && score2 == 3) {
                        score1 = 5
                        score2 = 4
                    }
                    else if (score1 == 4 && score2 == 5) {
                        score1 = 3
                        score2 = 3
                    }
                    else {
                        score1 += 1
                    }
                }
                Button(scoreList[score2]) {
                    if (score2 == 3 && score1 < 3) {
                        output = "Player 2 wins"
                        //reset()
                    }
                    else if (score2 == 5 && score1 == 4) {
                        output = "Player 2 wins"
                    }
                    else if (score2 == 3 && score1 == 3) {
                        score2 = 5
                        score1 = 4
                    }
                    else if (score2 == 4 && score1 == 5) {
                        score2 = 3
                        score1 = 3
                    }
                    else {
                        score2 += 1
                    }
                }
            }
            .padding()
            
            Text(output)
            
            Button("Reset") {
                score1 = 0
                score2 = 0
                output = "No winner yet"
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
