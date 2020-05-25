//
//  DirectorsView.swift
//  Mafia3
//
//  Created by Furqaan Ali on 5/20/20.
//  Copyright © 2020 Furqaan Ali. All rights reserved.
//

import SwiftUI

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

struct DirectorsView: View {
    
    @EnvironmentObject var gameData: GameData
    
    @State private var currentRound: Int = 1
    
//    @State private var attacked: Int = -1
//    @State private var rescued: Int = -1
    @State private var lynched: Int = -1
    @State private var protectedFromLynch: String = ""
    
    @State private var isNight: Bool = false
    @State private var showingResults: Bool = false
    @State private var isLynching: Bool = false
    @State private var lynchAvailable: Bool = false
    
//    @State private var attackedPlayerName: String = ""
//    @State private var rescuedPlayerName: String = ""
    
    @State private var nightlyRoles = ["Mafia", "Doctor", "Serial Killer", "Lawyer", "Barman"]
    @State private var nightlyChoices = [-1, -1, -1, -1, -1]
    
    @State private var currentEvents: [String] = []
    
//    @State var lovers: [String] = []
    
    
    //
    // PrepareForNewRound
    //  reset all roundly game values,
    //  update round number,
    //  and trigger NightView()
    //
    func prepareForNewRound() -> Void {
        currentEvents.removeAll()
        for index in 0...nightlyChoices.count-1 {
            nightlyChoices[index] = -1
        }
        self.lynched = -1
        self.protectedFromLynch = ""
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
            
            var inhibitedRole = ""
            var attackedByMafia = ""
            var treatedByDoctor = ""
            var attackedByKiller = ""
            
            if nightlyChoices[0] >= 0 { // mafia made an attack
                attackedByMafia = gameData.activePlayers[nightlyChoices[0]]
                currentEvents.append("\(attackedByMafia) was attacked by the Mafia")
            }
            if nightlyChoices[1] >= 0 { // doctor made a rescue
                treatedByDoctor = gameData.activePlayers[nightlyChoices[1]]
                currentEvents.append("\(treatedByDoctor) was treated by the Doctor")
            }
            if nightlyChoices[2] >= 0 {
                attackedByKiller = gameData.activePlayers[nightlyChoices[2]]
                currentEvents.append("\(attackedByKiller) was attacked by the Serial Killer")
            }
            if nightlyChoices[3] >= 0 {
                protectedFromLynch = gameData.activePlayers[nightlyChoices[3]]
                currentEvents.append("\(protectedFromLynch) is protected from lynching by the Lawyer")
            }
            if nightlyChoices[4] >= 0 {
                let inhibitedPlayer = gameData.activePlayers[nightlyChoices[4]]
                inhibitedRole = gameData.roles[gameData.playerNames.firstIndex(of: inhibitedPlayer)!]
                if inhibitedRole != "Civilian" {
                    currentEvents.append("\(inhibitedRole) (\(inhibitedPlayer)) was inhibited by the Barman")
                    switch inhibitedRole {
                    case "Mafia": attackedByMafia = ""
                    case "Doctor": treatedByDoctor = ""
                    case "Serial Killer": attackedByKiller = ""
                    case "Lawyer": protectedFromLynch = ""
                    default: break
                    }
                }
            }
            
            if attackedByMafia != "" { // mafia attacked a player
                let attackedPlayerRole = gameData.roles[gameData.playerNames.firstIndex(of: attackedByMafia)!]
                if attackedPlayerRole == "Grandma with a Shotgun" && inhibitedRole != "Grandma with a Shotgun" { // random mafia member is killed
                    var aliveMafiaMembers: [String] = []
                    for index in 0...gameData.playerNames.count-1 {
                        if gameData.roles[index] == "Mafia" && gameData.isActive[index]{
                            aliveMafiaMembers.append(gameData.playerNames[index])
                        }
                    }
                    let killedMafiaMember = aliveMafiaMembers.randomElement()
                    eliminatePlayer(playerName: killedMafiaMember!, treatedByDoctor: treatedByDoctor)
                }
                else if attackedByMafia != treatedByDoctor {  // player is killed by mafia
                    eliminatePlayer(playerName: attackedByMafia, treatedByDoctor: treatedByDoctor)
                }
            }
            
            if attackedByKiller != "" && attackedByKiller != treatedByDoctor { // serial killer attacked player not treated by doctor
                eliminatePlayer(playerName: attackedByKiller, treatedByDoctor: treatedByDoctor)
            }
            
            if attackedByMafia != "" && attackedByMafia == attackedByKiller && attackedByKiller == treatedByDoctor {   // if both serial killer and mafia attacked player treated by doctor, eliminate the player
                eliminatePlayer(playerName: attackedByMafia, treatedByDoctor: treatedByDoctor)
            }
            lynchAvailable.toggle()
        }
        else {  // performing lynch
            if lynched != -1 {
                let playerBeingLynched = gameData.activePlayers[lynched]
                if protectedFromLynch != playerBeingLynched {
                    eliminatePlayer(playerName: playerBeingLynched, treatedByDoctor: "")
                }
                else {
                    currentEvents.append("\(playerBeingLynched) could not be lynched")
                }
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
    func eliminatePlayer(playerName: String, treatedByDoctor: String) -> Void {
        var index = gameData.activePlayers.firstIndex(of: playerName)
        gameData.activePlayers.remove(at: index!)
        index = gameData.playerNames.firstIndex(of: playerName)
        gameData.isActive[index!] = false
        currentEvents.append("\(playerName) has died")
        
        if gameData.lovers.contains(playerName) {
            var lover: String
            if gameData.lovers[0] == playerName {
                lover = gameData.lovers[1]
            }
            else {
                lover = gameData.lovers[0]
            }
            gameData.lovers.removeAll()
            
            if lover != treatedByDoctor {
                eliminatePlayer(playerName: lover, treatedByDoctor: "")
            }
        }
    }
    
    
    //
    // PresentResults
    //  display all events that occurred in the previous round
    //
    func presentResults() -> some View {
        return (
            List(currentEvents, id: \.self) { event in
                Text(event)
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
                
                ForEach(nightlyRoles.indices, id: \.self) { index in
                    Group {
                        if self.gameData.roles.contains(self.nightlyRoles[index]) && self.gameData.isActive[self.gameData.roles.firstIndex(of: self.nightlyRoles[index])!] || self.nightlyRoles[index] == "Mafia" {
                            NavigationView {
                                Form {
                                    Picker(selection: self.$nightlyChoices[index], label: Text("Who does \(self.nightlyRoles[index]) choose?")) {
                                        ForEach(0 ..< self.gameData.activePlayers.count) {
                                            Text(self.gameData.activePlayers[$0])
                                       }
                                    }
                                }
//                                .frame(height: 200.0)
                            }
                        }
                    }
                }
                
                Group {
                    if self.currentRound == 2 {
                        List {
                            ForEach(self.gameData.playerNames, id: \.self) { player in
                                MultipleSelectionRow(title: player, isSelected: self.gameData.lovers.contains(player)) {
                                    if self.gameData.lovers.contains(player) {
                                        self.gameData.lovers.removeAll(where: { $0 == player })
                                    }
                                    else {
                                        self.gameData.lovers.append(player)
                                    }
                                }
                            }
                        }
                    }
                }
                

                Form {
                    ForEach(nightlyRoles.indices, id: \.self) {index in
                        Group {
                            if self.nightlyChoices[index] >= 0 {
                                Text("\(self.nightlyRoles[index]) chose \(self.gameData.activePlayers[self.nightlyChoices[index]])")
                            }
                        }
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

