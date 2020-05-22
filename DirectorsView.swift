//
//  DirectorsView.swift
//  Mafia3
//
//  Created by Furqaan Ali on 5/20/20.
//  Copyright © 2020 Furqaan Ali. All rights reserved.
//

import SwiftUI

struct DirectorsView: View {
    
    @EnvironmentObject var gameData: GameData
    
    @State private var currentRound: Int = 1
    
    @State private var attacked: Int = -1
    @State private var rescued: Int = -1
    
    @State private var isNight: Bool = false
    @State private var showingResults: Bool = false
    
    @State var attackedPlayerName: String = ""
    @State var rescuedPlayerName: String = ""
    
    
    //
    // PrepareForNewRound
    //  reset all roundly game values and update round number
    //
    func prepareForNewRound() -> Void {
        self.attackedPlayerName = ""
        self.rescuedPlayerName = ""
        self.currentRound += 1
        self.attacked = -1
        self.rescued = -1
    }
    
    //
    // EvaluateLastRound
    //  evaluate which players were eliminated
    //  and store attacked/rescued players
    //
    func evaluateLastRound() -> Void {
        if attacked >= 0 {
            attackedPlayerName = gameData.playerNames[attacked]
        }
        if rescued >= 0 {
            rescuedPlayerName = gameData.playerNames[rescued]
        }
        
        if attacked != rescued {
            self.gameData.playerNames[attacked].append(contentsOf: " (Dead)")
        }
        
    }
    
    //
    // PresentResults
    //  display all events that occurred in the previous round
    //
    func presentResults() -> some View {
        return (
            VStack {
                Text("Mafia attacked \(attackedPlayerName)")
                Text("Doctor rescued \(rescuedPlayerName)")
            }
        )
    }
    
    //
    // CreateDayView
    //  generate view where director can
    //  see all player and round information
    //
    func createDayView() -> some View {
        return (
            VStack {
                Text("Players: \(gameData.numPlayers)")
                Text("Mafia: \(gameData.numMafia)")

                List(gameData.roles.indices, id: \.self) { index in
                    HStack{
                        Text(self.gameData.playerNames[index])
                        Text(self.gameData.roles[index])
                        Spacer()
                    }
                }
                
                Button(action: {
                    self.prepareForNewRound()
                    self.isNight.toggle()
                    
                }) {
                    Text("Begin Night")
                }
                
                Text("Round: \(currentRound)")
                    .onAppear(perform: {
                        if self.currentRound > 1 {
                            self.evaluateLastRound()
                            self.showingResults.toggle()
                        }
                        
                    })
                    .sheet(isPresented: self.$showingResults) {
                        self.presentResults()
                }
            }
        )
    }
    
    
    //
    // CreateNightView
    //  generate view where director can
    //  select all events that occurred in the round
    //
    func createNightView() -> some View {
        return (
            VStack {
                NavigationView {
                    Form {
                        Text("Who does the Mafia attack?")
                        Picker(selection: self.$attacked, label: Text("")) {
                            ForEach(0 ..< self.gameData.playerNames.count) {
                                Text(self.gameData.playerNames[$0])
                           }
                        }
                    }
                }
                
                NavigationView {
                    Form {
                        Text("Who does the Doctor Rescue?")
                        Picker(selection: self.$rescued, label: Text("")) {
                            ForEach(0 ..< self.gameData.playerNames.count) {
                                Text(self.gameData.playerNames[$0])
                           }
                        }
                    }
                }
                
                Form {
                    if attacked >= 0 {
                        Text("Attacked: \(self.gameData.playerNames[attacked])")
                    }
                    if rescued >= 0 {
                        Text("Rescued: \(self.gameData.playerNames[rescued])")
                    }
                }
                
                Button(action: {self.isNight.toggle()}) {
                    Text("Confirm")
                }
                
            }
        )
    }
    
    
    //
    // Body:
    //  content and behavior of DirectorsView
    //
    var body: some View {
        Group {
            if !isNight {
                createDayView()
            }
            else {
                createNightView()
            }
        }
    }
    
}

struct DirectorsView_Previews: PreviewProvider {
    static var previews: some View {
        DirectorsView()
    }
}

