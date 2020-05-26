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
    
    @State private var playerBeingLynched: String = ""
    @State private var playerProtectedFromLynch: String = ""
    
    @State private var isNight: Bool = false
    @State private var showingResultsSheet: Bool = false
    @State private var showingLynchSheet: Bool = false
    @State private var lynchAvailable: Bool = false
    
    @State private var nightlyRoles = ["Mafia", "Doctor", "Serial Killer", "Lawyer", "Barman", "Cupid"]
    @State private var nightlyChoices = ["", "", "", "", ""]
    
    @State private var currentEvents: [String] = []
    
    @State var currentRoleIndex = 0
    
    //
    // PrepareForNewRound
    //  reset all roundly game values,
    //  update round number,
    //  and trigger NightView()
    //
    func prepareForNewRound() -> Void {
        currentEvents.removeAll()
        for index in 0...nightlyChoices.count-1 {
            nightlyChoices[index] = ""
        }
        self.playerBeingLynched = ""
        self.playerProtectedFromLynch = ""
        self.currentRound += 1
        self.lynchAvailable = false
        self.currentRoleIndex = 0
        self.isNight.toggle()
    }
    
    //
    // EvaluateEvents
    //  evaluate which players were eliminated
    //  and display events to the user
    //
    func evaluateEvents() -> Void {
        if !lynchAvailable {
            processPlayerChoices()
            handleAttacks()
            lynchAvailable.toggle()
        }
        else {
            handleLynch()
        }
    }
    
    //
    // ProcessPlayerChoices
    //  collect and display all choices that were made
    //  by special-role players during the night
    //
    func processPlayerChoices() -> Void {
        if nightlyChoices[0] != "" { // mafia made an attack
            currentEvents.append("\(nightlyChoices[0]) was attacked by the Mafia")
        }
        if nightlyChoices[1] != "" { // doctor made a rescue
            currentEvents.append("\(nightlyChoices[1]) was treated by the Doctor")
        }
        if nightlyChoices[2] != "" {
            currentEvents.append("\(nightlyChoices[2]) was attacked by the Serial Killer")
        }
        if nightlyChoices[3] != "" {
            currentEvents.append("\(nightlyChoices[3]) is protected from lynching by the Lawyer")
        }
        if nightlyChoices[4] != "" {
            let inhibitedPlayer = nightlyChoices[4]
            let inhibitedRole = gameData.roles[gameData.playerNames.firstIndex(of: inhibitedPlayer)!]
            if inhibitedRole != "Civilian" {
                currentEvents.append("\(inhibitedRole) (\(inhibitedPlayer)) was inhibited by the Barman")
                switch inhibitedRole {
                case "Mafia": nightlyChoices[0] = ""
                case "Doctor": nightlyChoices[1] = ""
                case "Serial Killer": nightlyChoices[2] = ""
                case "Lawyer": nightlyChoices[3] = ""
                default: break
                }
            }
        }
    }
    
    //
    // HandleAttacks
    //  determine the outcomes for all possible
    //  situations of a player being attacked
    //
    func handleAttacks() -> Void {
        let attackedByMafia = nightlyChoices[0]
        let treatedByDoctor = nightlyChoices[1]
        let attackedByKiller = nightlyChoices[2]
        playerProtectedFromLynch = nightlyChoices[3]
        let inhibitedPlayer = nightlyChoices[4]
        var inhibitedRole = ""
        if inhibitedPlayer != "" {
            inhibitedRole = gameData.roles[gameData.playerNames.firstIndex(of: inhibitedPlayer)!]
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
    }
    
    //
    // HandleLynch
    //  eliminate a player if chosen by the community
    //  to be lynched while player is not protected
    //
    func handleLynch() -> Void {
        if playerBeingLynched != "" {
            if playerBeingLynched != playerProtectedFromLynch {
                eliminatePlayer(playerName: playerBeingLynched, treatedByDoctor: "")
            }
            else {
                currentEvents.append("\(playerBeingLynched) could not be playerBeingLynched")
            }
            lynchAvailable.toggle()
        }
    }
    
    //
    // EliminatePlayer
    //  remove player from activePlayers list
    //  and update the isActive list to display
    //  an elimination symbol beside the player name
    //
    //  also eliminate the player's lover if he/she has one
    //
    func eliminatePlayer(playerName: String, treatedByDoctor: String) -> Void {
        var index = gameData.activePlayers.firstIndex(of: playerName)
        gameData.activePlayers.remove(at: index!)
        index = gameData.playerNames.firstIndex(of: playerName)
        gameData.isActive[index!] = false
        currentEvents.append("\(playerName) has died")
        
        checkForLover(playerName: playerName, treatedByDoctor: treatedByDoctor)
    }
    
    //
    // CheckForLover
    //  check if given player has a lover.
    //  if the lover is not treated by the doctor,
    //  then eliminate the lover
    //
    func checkForLover(playerName: String, treatedByDoctor: String) -> Void {
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
//            if self.lynchAvailable {
                self.showingResultsSheet.toggle()
//            }
        }
    }
    
    
    //
    // IsSelected
    //  provide a bool for the selection list
    //  to determine whether a player is selected or not
    //
    func isSelected(player: String) -> Bool {
        if nightlyRoles[self.currentRoleIndex] == "Cupid" {
            return (self.gameData.lovers.contains(player))
        }
        else {
            return (self.nightlyChoices[self.currentRoleIndex] == player)
        }
    }
    
    //
    // SelectionAction
    //  provide the action() function for the selection list
    //  to determine which elements to update
    //  if an item is selected/deselected
    //
    func selectionAction(player: String) -> Void {
        if nightlyRoles[self.currentRoleIndex] == "Cupid" {
            if self.gameData.lovers.contains(player) {
                self.gameData.lovers.removeAll(where: { $0 == player })
            }
            else {
                self.gameData.lovers.append(player)
            }
        }
        else {
            if self.nightlyChoices[self.currentRoleIndex] == player {
                self.nightlyChoices[self.currentRoleIndex] = ""
            }
            else {
                self.nightlyChoices[self.currentRoleIndex] = player
            }
        }
    }
    
    //
    // UpdateSelectionView
    //  update the selection view for the next players/role
    //  to make their choice
    //  if all players have chosen, exit the selection view
    //
    func updateSelectionView() -> Void {
        repeat {
            self.currentRoleIndex += 1
            if self.currentRound == 2 {
                if self.currentRoleIndex >= 6 {
                    self.isNight.toggle()
                    break
                }
            }
            else {
                if self.currentRoleIndex >= 5 {
                    self.isNight.toggle()
                    break
                }
            }
        }
        while ( !(self.gameData.roles.contains(self.nightlyRoles[self.currentRoleIndex]) && self.gameData.isActive[self.gameData.roles.firstIndex(of: self.nightlyRoles[self.currentRoleIndex])!]))
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
                        Button(action: {self.showingLynchSheet.toggle()}) {
                            Text("Lynch")
                        }
                    }
                }
                .padding()
                .padding()
                
                Text("Round: \(currentRound)")
                    .onAppear(perform: {self.updateView()})
                    .sheet(isPresented: self.$showingResultsSheet) {
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
                Group {
                    Text("Who does \(self.nightlyRoles[currentRoleIndex]) choose?")
                    List {
                        ForEach(self.gameData.activePlayers, id: \.self) { player in
                            SelectionRow(title: player, isSelected: self.isSelected(player: player)) {
                                self.selectionAction(player: player)
                            }
                        }
                    }
                }

                Form {
                    ForEach(nightlyChoices.indices, id: \.self) {index in
                        Group {
                            if self.nightlyChoices[index] != "" {
                                Text("\(self.nightlyRoles[index]) chose \(self.nightlyChoices[index])")
                            }
                        }
                    }
                }

                Button(action: {self.updateSelectionView()}) {
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
                Text("Who does the community lynch?")
                List {
                    ForEach(self.gameData.activePlayers, id: \.self) { player in
                        SelectionRow(title: player, isSelected: self.playerBeingLynched == player) {
                            if self.playerBeingLynched == player {
                                self.playerBeingLynched = ""
                            }
                            else {
                                self.playerBeingLynched = player
                            }
                        }
                    }
                }
                
                Form {
                    if playerBeingLynched != "" {
                        Text("Community chose: \(self.playerBeingLynched)")
                    }
                }
                
                Button(action: {self.showingLynchSheet.toggle()}) {
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
            if !isNight && !showingLynchSheet {
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

struct SelectionRow: View {
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
