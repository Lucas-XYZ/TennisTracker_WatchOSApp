//
//  ContentView.swift
//  Tennis Score Tracker Watch App
//
//  Created by Lucas Consolati on 28/6/2023.
//

import SwiftUI

struct ContentView: View {
    
    let pointsList = ["0", "15", "30", "40", "", "AD"]
    let gamesPerSet = 6
    
    @Binding var points1: Int
    @Binding var points2: Int
    @Binding var games1: Int
    @Binding var games2: Int
    @Binding var sets1: Int
    @Binding var sets2: Int
    @Binding var serve1: String
    @Binding var serve2: String
    
    func updateServe(changeServe: Bool) {
        if (serve1 != " ") {
            if (changeServe) {
                serve1 = " "
                serve2 = "Right"
            }
            else {
                if (serve1 == "Right") {
                    serve1 = "Left"
                }
                else {
                    serve1 = "Right"
                }
            }
        }
        else {
            if (changeServe) {
                serve2 = " "
                serve1 = "Right"
            }
            else {
                if (serve2 == "Right") {
                    serve2 = "Left"
                }
                else {
                    serve2 = "Right"
                }
            }
        }
    }
    
    var body: some View {
        
        VStack {
            HStack {
                VStack {
                    HStack {
                        Text(String(sets1))
                        Text(String(games1))
                    }
                    Button(pointsList[points1]) {
                        if (points1 == 3 && points2 < 3 || points1 == 5 && points2 == 4) {
                            points1 = 0
                            points2 = 0
                            games1 += 1
                            if (games1 == gamesPerSet) {
                                games1 = 0
                                games2 = 0
                                sets1 += 1
                            }
                            updateServe(changeServe: true)
                        }
                        else if (points1 == 3 && points2 == 3) {
                            points1 = 5
                            points2 = 4
                            updateServe(changeServe: false)
                        }
                        else if (points1 == 4 && points2 == 5) {
                            points1 = 3
                            points2 = 3
                            updateServe(changeServe: false)
                        }
                        else {
                            points1 += 1
                            updateServe(changeServe: false)
                        }
                    }
                    Text(serve1)
                }
                
                VStack {
                    HStack {
                        Text(String(games2))
                        Text(String(sets2))
                    }
                    Button(pointsList[points2]) {
                        
                        if (points2 == 3 && points1 < 3 || points2 == 5 && points1 == 4) {
                            points2 = 0
                            points1 = 0
                            games2 += 1
                            if (games2 == gamesPerSet) {
                                games2 = 0
                                games1 = 0
                                sets2 += 1
                            }
                            updateServe(changeServe: true)
                        }
                        else if (points2 == 3 && points1 == 3) {
                            points2 = 5
                            points1 = 4
                            updateServe(changeServe: false)
                            
                        }
                        else if (points2 == 4 && points1 == 5) {
                            points2 = 3
                            points1 = 3
                            updateServe(changeServe: false)
                        }
                        else {
                            points2 += 1
                            updateServe(changeServe: false)
                        }
                    }
                    Text(serve2)
                }
            }
        }
    }
}
/*
 struct ContentView_Previews: PreviewProvider {
 static var previews: some View {
 ContentView()
 }
 }
 */
