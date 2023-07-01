//
//  ContentView.swift
//  Tennis Score Tracker Watch App
//
//  Created by Lucas Consolati on 28/6/2023.
//

import SwiftUI

struct ContentView: View {
    
    let pointsList: [String] = ["0", "15", "30", "40", " ", "AD"]
    let gamesPerSet: Int = 6
    
    @Binding var points1: Int
    @Binding var points2: Int
    @Binding var games1: Int
    @Binding var games2: Int
    @Binding var sets1: Int
    @Binding var sets2: Int
    @Binding var serve1: String
    @Binding var serve2: String
    
    func updateServe(changeServe: Bool, changeSet: Bool) {
        if (changeSet) {
            if ((sets1 + sets2) % 2 == 0) {
                serve1 = "Right"
                serve2 = " "
            }
            else {
                serve1 = " "
                serve2 = "Right"
            }
        }
        else {
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
    }
    
    var body: some View {
        
        HStack {
            VStack {
                HStack {
                    // Player 1 sets display
                    Text(String(sets1))
                        .padding(.horizontal, 15)
                        .padding(.vertical, 5)
                        .frame(width: 40, height: 30)
                        .background(.blue)
                        .containerShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
                    // Player 1 games display
                    Text(String(games1))
                        .padding(.horizontal, 15)
                        .padding(.vertical, 5)
                        .frame(width: 40, height: 30)
                        .background(.blue)
                        .containerShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
                }
                    .frame(height: 25)
                    .frame(width: 80)
                    .padding(.horizontal, 7)
                    .padding(.vertical, 4)
                    .background(.gray)
                    .containerShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
                // Player 1 scoring button
                Button() {
                    // Record match state
                    matchHistory.append([points1, points2, games1, games2, sets1, sets2, serve1, serve2])
                    // Player 1 wins game
                    if (points1 == 3 && points2 < 3 || points1 == 5 && points2 == 4) {
                        points1 = 0
                        points2 = 0
                        games1 += 1
                        if (games1 == gamesPerSet) {
                            games1 = 0
                            games2 = 0
                            sets1 += 1
                            updateServe(changeServe: true, changeSet: true)
                        }
                        else {
                            updateServe(changeServe: true, changeSet: false)
                        }
                    }
                    // Player 1 gets advantage
                    else if (points1 == 3 && points2 == 3) {
                        points1 = 5
                        points2 = 4
                        updateServe(changeServe: false, changeSet: false)
                    }
                    // Player 1 removes opponent advantage
                    else if (points1 == 4 && points2 == 5) {
                        points1 = 3
                        points2 = 3
                        updateServe(changeServe: false, changeSet: false)
                    }
                    // Player 1 wins point
                    else {
                        points1 += 1
                        updateServe(changeServe: false, changeSet: false)
                    }
                }
                label: {
                    // Player 1 points display
                    Text(pointsList[points1])
                        //.padding(.vertical, 5)
                        .font(.system(size: 58))
                        .foregroundColor(.white)
                }
                    .buttonBorderShape(.roundedRectangle)
                    .background(.blue)
                    .cornerRadius(8)
                // Player 1 serve message
                Text(serve1)
                    .frame(height: 12)
                    .frame(width: 80)
                    .padding(.horizontal, 7)
                    .padding(.vertical, 4)
                    .background(.gray)
                    .containerShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
            }
            VStack {
                HStack {
                    // Player 2 games display
                    Text(String(games2))
                        .padding(.horizontal, 15)
                        .padding(.vertical, 5)
                        .frame(width: 40, height: 30)
                        .background(.orange)
                        .containerShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
                    // Player 2 sets display
                    Text(String(sets2))
                        .padding(.horizontal, 15)
                        .padding(.vertical, 5)
                        .frame(width: 40, height: 30)
                        .background(.orange)
                        .containerShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
                }
                    .frame(height: 25)
                    .frame(width: 80)
                    .padding(.horizontal, 7)
                    .padding(.vertical, 4)
                    .background(.gray)
                    .containerShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
                // Player 2 scoring button
                Button() {
                    // Record match state
                    matchHistory.append([points1, points2, games1, games2, sets1, sets2, serve1, serve2])
                    // Player 2 wins game
                    if (points2 == 3 && points1 < 3 || points2 == 5 && points1 == 4) {
                        points2 = 0
                        points1 = 0
                        games2 += 1
                        if (games2 == gamesPerSet) {
                            games2 = 0
                            games1 = 0
                            sets2 += 1
                            updateServe(changeServe: true, changeSet: true)
                        }
                        else {
                            updateServe(changeServe: true, changeSet: false)
                        }
                    }
                    // Player 2 gets advantage
                    else if (points2 == 3 && points1 == 3) {
                        points2 = 5
                        points1 = 4
                        updateServe(changeServe: false, changeSet: false)
                        
                    }
                    // Player 2 removes opponent advantage
                    else if (points2 == 4 && points1 == 5) {
                        points2 = 3
                        points1 = 3
                        updateServe(changeServe: false, changeSet: false)
                    }
                    // Player 2 wins point
                    else {
                        points2 += 1
                        updateServe(changeServe: false, changeSet: false)
                    }
                }
                label: {
                    // Player 2 points display
                    Text(pointsList[points2])
                        //.padding(.vertical, 15)
                        .font(.system(size: 58))
                        .foregroundColor(.white)
                }
                    .buttonBorderShape(.roundedRectangle)
                    .background(.orange)
                    .cornerRadius(8)
                // Player 2 serve message
                Text(serve2)
                    .frame(height: 12)
                    .frame(width: 80)
                    .padding(.horizontal, 7)
                    .padding(.vertical, 4)
                    .background(.gray)
                    .containerShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
            }
        }
    }
}
