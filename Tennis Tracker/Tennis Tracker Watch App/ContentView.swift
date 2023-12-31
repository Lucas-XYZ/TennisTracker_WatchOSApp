//
//  ContentView.swift
//  Tennis Score Tracker Watch App
//
//  Created by Lucas Consolati on 28/6/2023.
//

import SwiftUI

struct ContentView: View {
    @Binding var tabSelection: Int
    
    // Constants
    let pointsList: [String] = ["0", "15", "30", "40", " ", "AD"] // Point types
    let blue: Color = Color(red: 0, green: 0, blue: 1)
    let orange: Color = Color(red: 1, green: 0.4, blue: 0)
    let animationSpeed: Double = 0.9
    
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
    
    // Animate vars
    @State var pointsAnimate1: Bool = false
    @State var pointsAnimate2: Bool = false
    @State var gamesAnimate1: Bool = false
    @State var gamesAnimate2: Bool = false
    @State var setsAnimate1: Bool = false
    @State var setsAnimate2: Bool = false
    
    // Update serve display
    func updateServe() {
        if (games1 == 6 && games2 == 6) { // Tiebreak
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
        else { // Non tiebreak
            if ((games1 + games2) % 2 == (((sets1 + sets2) % 2 == 0) ? 0 : 1)) {
                if ((points1 + points2) % 2 == 0) {
                    serve1 = "Right"
                    serve2 = " "
                }
                else {
                    serve1 = "Left"
                    serve2 = " "
                }
            }
            else {
                if ((points1 + points2) % 2 == 0) {
                    serve1 = " "
                    serve2 = "Right"
                }
                else {
                    serve1 = " "
                    serve2 = "Left"
                }
            }
        }
    }
    func updateSwap() -> Bool {
        // Start of game change
        if (((games1 + games2) % 2 == 1) && (points1 == 0 && points2 == 0) ) {
            return true
        }
        // Start of set change
        if (points1 == 0 && points2 == 0 && games1 == 0 && games2 == 0 && matchHistory.count > 1) {
            let prevGameState: [Int] = [matchHistory[matchHistory.count - 1][2], matchHistory[matchHistory.count - 1][3]] as! [Int]
            if (((prevGameState[0] + prevGameState[1]) % 4 == 0) || ((prevGameState[0] + prevGameState[1]) % 4 == 3)) {
                return true
            }
        }
        // Middle of tiebreak
        if (games1 == 6 && games2 == 6) {
            if (points1 + points2 == 6) {
                return true
            }
        }
        // Default return
        return false
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    HStack {
                        // Player 1 sets display
                        Text(String(sets1))
                            .frame(width: screenWidth * 1/5, height: screenHeight * 1/8)
                            .font(.body)
                            .background(setsAnimate1 ? .blue : Color.white.opacity(0))
                            .animation(.easeIn.speed(animationSpeed), value: setsAnimate1)
                            .background(setsAnimate1 ? Color.white.opacity(0) : .blue)
                            .animation(.easeInOut.speed(animationSpeed), value: setsAnimate1)
                            .containerShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
                        
                        // Player 1 games display
                        Text(String(games1))
                            .frame(width: screenWidth * 1/5, height: screenHeight * 1/8)
                            .font(.body)
                            .background(gamesAnimate1 ? .blue : Color.white.opacity(0))
                            .animation(.easeIn.speed(animationSpeed), value: gamesAnimate1)
                            .background(gamesAnimate1 ? Color.white.opacity(0) : .blue)
                            .animation(.easeInOut.speed(animationSpeed), value: gamesAnimate1)
                            .containerShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
                    }
                        .frame(width: screenWidth * 1/2, height: screenHeight * 1/7)
                        .background(.gray)
                        .containerShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
                    
                    // Name display
                    Text(name1)
                        .frame(width: screenWidth * 1/2, height: screenHeight * 1/12)
                        .font(.body)
                        .background(.black)
                        .cornerRadius(5)
                    
                    // Player 1 scoring button
                    Button() {
                        // Record match state
                        matchHistory.append([points1, points2, games1, games2, sets1, sets2, serve1, serve2, timerCount])
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
                                gamesAnimate1.toggle()
                                setsAnimate1.toggle()
                            }
                        }
                        // Not tie-break game
                        else {
                            // Player 1 wins game
                            if (points1 == 3 && points2 < 3 || points1 == 5 && points2 == 4) {
                                points1 = 0
                                points2 = 0
                                games1 += 1
                                gamesAnimate1.toggle()
                                // Player 1 wins set
                                if (games1 >= 6 && games1 - games2 >= 2) {
                                    games1 = 0
                                    games2 = 0
                                    sets1 += 1
                                    setsAnimate1.toggle()
                                }
                            }
                            // Player 1 gets advantage
                            else if (points1 == 3 && points2 == 3) {
                                points1 = 5
                                points2 = 4
                            }
                            // Player 1 removes opponent advantage
                            else if (points1 == 4 && points2 == 5) {
                                points1 = 3
                                points2 = 3
                            }
                            // Player 1 wins point
                            else {
                                points1 += 1
                            }
                        }
                        updateServe()
                        pointsAnimate1.toggle()
                    }
                label: {
                    // Player 1 points display
                    Text((games1 == 6 && games2 == 6) ? String(points1) : pointsList[points1])
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
                    .frame(width: screenWidth * 1/2, height: screenHeight * 2/5)
                    .buttonBorderShape(.roundedRectangle)
                    .background(pointsAnimate1 ? blue : Color.white.opacity(0))
                    .animation(.easeIn.speed(animationSpeed), value: pointsAnimate1)
                    .background(pointsAnimate1 ? Color.white.opacity(0) : blue)
                    .animation(.easeInOut.speed(animationSpeed), value: pointsAnimate1)
                    .cornerRadius(8)
                }
                VStack {
                    HStack {
                        // Player 2 games display
                        Text(String(games2))
                            .frame(width: screenWidth * 1/5, height: screenHeight * 1/8)
                            .font(.body)
                            .background(gamesAnimate2 ? .orange : Color.white.opacity(0))
                            .animation(.easeIn.speed(animationSpeed), value: gamesAnimate2)
                            .background(gamesAnimate2 ? Color.white.opacity(0) : .orange)
                            .animation(.easeInOut.speed(animationSpeed), value: gamesAnimate2)
                            .containerShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
                        // Player 2 sets display
                        Text(String(sets2))
                            .frame(width: screenWidth * 1/5, height: screenHeight * 1/8)
                            .font(.body)
                            .background(setsAnimate2 ? .orange : Color.white.opacity(0))
                            .animation(.easeIn.speed(animationSpeed), value: setsAnimate2)
                            .background(setsAnimate2 ? Color.white.opacity(0) : .orange)
                            .animation(.easeInOut.speed(animationSpeed), value: setsAnimate2)
                            .containerShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
                    }
                    .frame(width: screenWidth * 1/2, height: screenHeight * 1/7)
                    .background(.gray)
                    .containerShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
                    
                    // Name display
                    Text(name2)
                        .frame(width: screenWidth * 1/2, height: screenHeight * 1/12)
                        .font(.body)
                        .background(.black)
                        .cornerRadius(5)
                    
                    // Player 2 scoring button
                    Button() {
                        // Record match state
                        matchHistory.append([points1, points2, games1, games2, sets1, sets2, serve1, serve2, timerCount])
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
                                gamesAnimate2.toggle()
                                setsAnimate2.toggle()
                            }
                        }
                        // Not tie-break game
                        else {
                            // Player 2 wins game
                            if (points2 == 3 && points1 < 3 || points2 == 5 && points1 == 4) {
                                points2 = 0
                                points1 = 0
                                games2 += 1
                                gamesAnimate2.toggle()
                                // Player 2 wins set
                                if (games2 >= 6 && games2 - games1 >= 2) {
                                    games2 = 0
                                    games1 = 0
                                    sets2 += 1
                                    setsAnimate2.toggle()
                                }
                            }
                            // Player 2 gets advantage
                            else if (points2 == 3 && points1 == 3) {
                                points2 = 5
                                points1 = 4
                            }
                            // Player 2 removes opponent advantage
                            else if (points2 == 4 && points1 == 5) {
                                points2 = 3
                                points1 = 3
                            }
                            // Player 2 wins point
                            else {
                                points2 += 1
                            }
                        }
                        updateServe()
                        pointsAnimate2.toggle()
                    }
                label: {
                    // Player 2 points display
                    Text((games1 == 6 && games2 == 6) ? String(points2) : pointsList[points2])
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
                    .frame(width: screenWidth * 1/2, height: screenHeight * 2/5)
                    .buttonBorderShape(.roundedRectangle)
                    .background(pointsAnimate2 ? orange : Color.white.opacity(0))
                    .animation(.easeIn.speed(animationSpeed), value: pointsAnimate2)
                    .background(pointsAnimate2 ? Color.white.opacity(0) : orange)
                    .animation(.easeInOut.speed(animationSpeed), value: pointsAnimate2)
                    .cornerRadius(8)
                }
            }
        }
        
        HStack {
            // Player 1 serve message
            Text(serve1)
                .frame(width: screenWidth * 3/7, height: screenHeight * 1/10)
                .font(.body)
                .background(.gray)
                .opacity(serve1 == " " ? 0 : 1)
                .containerShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
            
            // Swap message
            Text(updateSwap() ? "🔄" : "")
                .frame(width: screenWidth * 1/7, height: screenHeight * 1/10)
                .font(.body)
                .background(.gray)
                .opacity(updateSwap() ? 1 : 0)
                .containerShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
            
            // Player 2 serve message
            Text(serve2)
                .frame(width: screenWidth * 3/7, height: screenHeight * 1/10)
                .font(.body)
                .background(.gray)
                .opacity(serve2 == " " ? 0 : 1)
                .containerShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(tabSelection: .constant(1),
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
