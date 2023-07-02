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
    @State var pointsDisplay1: String = "0"
    @State var pointsDisplay2: String = "0"
    
    let blue: Color = Color(red: 0, green: 0, blue: 1)
    let orange: Color = Color(red: 1, green: 0.4, blue: 0)
    @State var pointsAnimate1: Bool = false
    @State var pointsAnimate2: Bool = false
        
    func updateServe(changeGame: Bool = false, changeSet: Bool = false, tieBreak: Bool = false) {
        if (tieBreak) {
            if ((sets1 + sets2) % 2 == 0) {
                if ((points1 + points2) % 4 == 0) {
                    serve1 = "Right"
                    serve2 = " "
                }
                else if ((points1 + points2) % 4 == 1) {
                    serve1 = " "
                    serve2 = "Left"
                }
                else if ((points1 + points2) % 4 == 2) {
                    serve1 = " "
                    serve2 = "Right"
                }
                else {
                    serve1 = "Left"
                    serve2 = " "
                }
            }
            else {
                if ((points1 + points2) % 4 == 0) {
                    serve1 = " "
                    serve2 = "Right"
                }
                else if ((points1 + points2) % 4 == 1) {
                    serve1 = "Left"
                    serve2 = " "
                }
                else if ((points1 + points2) % 4 == 2) {
                    serve1 = "Right"
                    serve2 = " "
                }
                else {
                    serve1 = " "
                    serve2 = "Left"
                }
            }
        }
        else {
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
                    if (changeGame) {
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
                    if (changeGame) {
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
                    .frame(width: 80, height: 25)
                    .padding(.horizontal, 7)
                    .padding(.vertical, 4)
                    .background(.gray)
                    .containerShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
                
                // Player 1 scoring button
                Button() {
                    // Record match state
                    matchHistory.append([points1, points2, games1, games2, sets1, sets2, serve1, serve2])
                    // Tie-break game
                    if (games1 == 6 && games2 == 6) {
                        points1 += 1
                        // Player 1 wins game/set
                        if (points1 >= 7 && points1 - points2 >= 2) {
                            points1 = 0
                            points2 = 0
                            games1 = 0
                            games2 = 0
                            sets1 += 1
                            updateServe(changeGame: true, changeSet: true)
                        }
                        pointsDisplay1 = String(points1)
                        pointsDisplay2 = String(points2)
                        updateServe(tieBreak: true)
                    }
                    // Not tie-break game
                    else {
                        // Player 1 wins game
                        if (points1 == 3 && points2 < 3 || points1 == 5 && points2 == 4) {
                            points1 = 0
                            points2 = 0
                            games1 += 1
                            // Player 1 wins set
                            if (games1 >= gamesPerSet && games1 - games2 >= 2) {
                                games1 = 0
                                games2 = 0
                                sets1 += 1
                                updateServe(changeGame: true, changeSet: true)
                            }
                            else {
                                updateServe(changeGame: true)
                            }
                        }
                        // Player 1 gets advantage
                        else if (points1 == 3 && points2 == 3) {
                            points1 = 5
                            points2 = 4
                            updateServe()
                        }
                        // Player 1 removes opponent advantage
                        else if (points1 == 4 && points2 == 5) {
                            points1 = 3
                            points2 = 3
                            updateServe()
                        }
                        // Player 1 wins point
                        else {
                            points1 += 1
                            updateServe()
                        }
                        pointsDisplay1 = pointsList[points1]
                        pointsDisplay2 = pointsList[points2]
                    }
                    pointsAnimate1.toggle()
                }
                label: {
                    // Player 1 points display
                    Text(pointsDisplay1)
                        .font(.system(size: 58))
                        .foregroundColor(.white)
                }
                    .buttonBorderShape(.roundedRectangle)
                    .background(pointsAnimate1 ? blue : Color.white.opacity(0))
                    .animation(.easeIn.speed(0.9), value: pointsAnimate1)
                    .background(pointsAnimate1 ? Color.white.opacity(0) : blue)
                    .animation(.easeInOut.speed(0.9), value: pointsAnimate1)
                    .cornerRadius(8)

                // Player 1 serve message
                Text(serve1)
                    .frame(width: 80, height: 12)
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
                .frame(width: 80, height: 25)
                    .padding(.horizontal, 7)
                    .padding(.vertical, 4)
                    .background(.gray)
                    .containerShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
                // Player 2 scoring button
                Button() {
                    // Record match state
                    matchHistory.append([points1, points2, games1, games2, sets1, sets2, serve1, serve2])
                    // Tie-break game
                    if (games1 == 6 && games2 == 6) {
                        points2 += 1
                        // Player 2 wins game/set
                        if (points2 >= 7 && points2 - points1 >= 2) {
                            points1 = 0
                            points2 = 0
                            games1 = 0
                            games2 = 0
                            sets2 += 1
                            updateServe(changeGame: true, changeSet: true)
                        }
                        pointsDisplay1 = String(points1)
                        pointsDisplay2 = String(points2)
                        updateServe(tieBreak: true)
                    }
                    // Not tie-break game
                    else {
                        // Player 2 wins game
                        if (points2 == 3 && points1 < 3 || points2 == 5 && points1 == 4) {
                            points2 = 0
                            points1 = 0
                            games2 += 1
                            // Player 2 wins set
                            if (games2 >= gamesPerSet && games2 - games1 >= 2) {
                                games2 = 0
                                games1 = 0
                                sets2 += 1
                                updateServe(changeGame: true, changeSet: true)
                            }
                            else {
                                updateServe(changeGame: true)
                            }
                        }
                        // Player 2 gets advantage
                        else if (points2 == 3 && points1 == 3) {
                            points2 = 5
                            points1 = 4
                            updateServe()
                            
                        }
                        // Player 2 removes opponent advantage
                        else if (points2 == 4 && points1 == 5) {
                            points2 = 3
                            points1 = 3
                            updateServe()
                        }
                        // Player 2 wins point
                        else {
                            points2 += 1
                            updateServe()
                        }
                        pointsDisplay1 = pointsList[points1]
                        pointsDisplay2 = pointsList[points2]
                    }
                    pointsAnimate2.toggle()
                }
                label: {
                    // Player 2 points display
                    Text(pointsDisplay2)
                        //.padding(.vertical, 15)
                        .font(.system(size: 58))
                        .foregroundColor(.white)
                }
                    .buttonBorderShape(.roundedRectangle)
                    .background(pointsAnimate2 ? orange : Color.white.opacity(0))
                    .animation(.easeIn.speed(0.9), value: pointsAnimate2)
                    .background(pointsAnimate2 ? Color.white.opacity(0) : orange)
                    .animation(.easeInOut.speed(0.9), value: pointsAnimate2)
                    .cornerRadius(8)
                // Player 2 serve message
                Text(serve2)
                    .frame(width: 80, height: 12)
                    .padding(.horizontal, 7)
                    .padding(.vertical, 4)
                    .background(.gray)
                    .containerShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
            }
        }
    }
}
