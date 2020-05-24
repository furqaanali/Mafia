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
    @State private var lynched: Int = -1
    
    @State private var isNight: Bool = false
    @State private var showingResults: Bool = false
    @State private var isLynching: Bool = false
    @State private var lynchAvailable: Bool = false
    
    @State private var attackedPlayerName: String = ""
    @State private var rescuedPlayerName: String = ""
    
    
    //
    // PrepareForNewRound
    //  reset all roundly game values,
    //  update round number,
    //  and trigger NightView()
    //
    func prepareForNewRound() -> Void {
        self.attackedPlayerName = ""
        self.rescuedPlayerName = ""
        self.attacked = -1
        self.rescued = -1
        self.lynched = -1
        self.currentRound += 1
        self.lynchAvailable = false
        self.isNight.toggle()
    }
    
    
    //
    // EvaluateEvents
    //  evaluate which players were eliminated
    //  and store attacked/rescued players
    //
    func evaluateEvents() -> Void {
        if !lynchAvailable {
            if attacked >= 0 {
                attackedPlayerName = gameData.activePlayers[attacked]
            }
            if rescued >= 0 {
                rescuedPlayerName = gameData.activePlayers[rescued]
            }
            
            if attacked != rescued {    // player was killed
                if attacked != -1 {
                    eliminatePlayer(playerName: attackedPlayerName)
                }
            }
            lynchAvailable.toggle()
        }
        else {  // performing lynch
            if lynched != -1 {
                eliminatePlayer(playerName: gameData.activePlayers[lynched])
                lynchAvailable.toggle()
            }
        }
    }
    
    
    //
    // EliminatePlayer
    //  remove player from activePlayers list
    //  and update the isActive list to display
    //  an elimination symbol beside the player name
    //
    func eliminatePlayer(playerName: String) -> Void {
        var index = gameData.activePlayers.firstIndex(of: playerName)
        gameData.activePlayers.remove(at: index!)
        index = gameData.playerNames.firstIndex(of: playerName)
        gameData.isActive[index!] = false
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
    // UpdateView
    //  after returning to Day View, call functions to:
    //  process the previous Night's events,
    //  update the current game info and view,
    //  and trigger the presentResults() sheet
    //
    func updateView() -> Void {
        if self.currentRound > 1 {
            self.evaluateEvents()
            if self.lynchAvailable {
                self.showingResults.toggle()
            }
        }
    }
    
    
    //
    // CreateDayView
    //  generate view where director can
    //  see all player and round information
    //
    func createDayView() -> some View {
        return (
            VStack {
                Text("Directors View")
                    .font(.title)

                List(gameData.playerNames.indices, id: \.self) { index in
                    PlayerRow(index: index, isActive: self.gameData.isActive[index])
                }
                
                HStack {
                    Button(action: {self.prepareForNewRound()}) {
                        Text("Begin Night")
                    }
                    
                    if lynchAvailable {
                        Spacer()
                        Button(action: {self.isLynching.toggle()}) {
                            Text("Lynch")
                        }
                    }
                }
                .padding()
                .padding()
                
                Text("Round: \(currentRound)")
                    .onAppear(perform: {self.updateView()})
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
                            ForEach(0 ..< self.gameData.activePlayers.count) {
                                Text(self.gameData.activePlayers[$0])
                           }
                        }
                    }
                }
                
                NavigationView {
                    Form {
                        Text("Who does the Doctor Rescue?")
                        Picker(selection: self.$rescued, label: Text("")) {
                            ForEach(0 ..< self.gameData.activePlayers.count) {
                                Text(self.gameData.activePlayers[$0])
                           }
                        }
                    }
                }
                
                Form {
                    if attacked >= 0 {
                        Text("Attacked: \(self.gameData.activePlayers[attacked])")
                    }
                    if rescued >= 0 {
                        Text("Rescued: \(self.gameData.activePlayers[rescued])")
                    }
                }
                
                Button(action: {self.isNight.toggle()}) {
                    Text("Confirm")
                }
            }
        )
    }
    
    
    //
    // CreateLynchView
    //  generate view where director can
    //  select which player the community
    //  decided to lynch
    //
    func createLynchView() -> some View {
        return (
            VStack {
                NavigationView {
                    Form {
                        Text("Who does the Community lynch?")
                        Picker(selection: self.$lynched, label: Text("")) {
                            ForEach(0 ..< self.gameData.activePlayers.count) {
                                Text(self.gameData.activePlayers[$0])
                           }
                        }
                    }
                }
                
                Form {
                    if lynched >= 0 {
                        Text("Lynched: \(self.gameData.activePlayers[lynched])")
                    }
                }
                
                Button(action: {self.isLynching.toggle()}) {
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
            if !isNight && !isLynching {
                createDayView()
            }
            else if isNight {
                createNightView()
            }
            else {
                createLynchView()
            }
        }
    }
    
}

struct DirectorsView_Previews: PreviewProvider {
    static var previews: some View {
        DirectorsView()
    }
}

