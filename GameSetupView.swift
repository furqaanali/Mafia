//
//  GameSetupView.swift
//  Mafia3
//
//  Created by Furqaan Ali on 5/20/20.
//  Copyright © 2020 Furqaan Ali. All rights reserved.
//

import SwiftUI

struct GameSetupView: View {
    
    @EnvironmentObject var gameData: GameData
    
    @State private var numPlayers = 5
    @State private var numMafia = 2
    
    @State private var includeBarman: Bool = false
    @State private var includeCupid: Bool = false
    @State private var includeDetective: Bool = false
    @State private var includeDoctor: Bool = false
    @State private var includeGrandma: Bool = false
    @State private var includeKiller: Bool = false
    @State private var includeLawyer: Bool = false
    
    @State private var dataCollected: Bool = false
    @State private var showInvalidAlert: Bool = false
    
    @State private var password: String = ""
    @State private var passwordAccepted: Bool = false
    
    
    //
    // SaveGameData
    //  copy all of the acquired information into
    //  the @EnvironmentObject so this data can
    //  be accessed later in the game
    //
    //  display an error message if settings are invalid
    //  else, continue to next screen
    //
    func saveGameData() -> Void {
        gameData.numPlayers = self.numPlayers
        gameData.numMafia = self.numMafia
        gameData.additionalRoles["Barman"] = self.includeBarman
        gameData.additionalRoles["Cupid"] = self.includeCupid
        gameData.additionalRoles["Detective"] = self.includeDetective
        gameData.additionalRoles["Doctor"] = self.includeDoctor
        gameData.additionalRoles["Grandma with a Shotgun"] = self.includeGrandma
        gameData.additionalRoles["Serial Killer"] = self.includeKiller
        gameData.additionalRoles["Lawyer"] = self.includeLawyer
        
        if isGameDataValid() {
            dataCollected.toggle()
        }
        else {
            showInvalidAlert.toggle()
        }
    }
    
    
    //
    // IsGameDataValid
    //  check if the game settings are valid
    //  numPlayers must be >= numMafia + otherRoles
    //
    func isGameDataValid() -> Bool {
        var numAdvancedRoles = 0
        for (_,value) in gameData.additionalRoles {
            if value == true {
                numAdvancedRoles += 1
            }
        }
        if gameData.numPlayers >= gameData.numMafia + numAdvancedRoles {
            return true
        }
        else {
            return false
        }
    }
    
    //
    // SavePassword
    //  save the acquired password to protect
    //  player roles from being viewed by
    //  persons other than the moderator
    //
    func savePassword() -> Void {
        if password != "" {
            gameData.password = password
            passwordAccepted = true
        }
    }
    
    //
    // CreateDataCollectionView
    //  generate view that allows the user
    //  to configure the game settings
    //
    func createDataCollectionView() -> some View {
        return (
            VStack {
                Stepper(value: self.$numPlayers, in: 4...25) {
                    Text("Players: \(self.numPlayers)")
                }
                Stepper(value: self.$numMafia, in: 1...4) {
                    Text("Mafia: \(self.numMafia)")
                }
                Toggle(isOn: self.$includeBarman) {
                    Text("Barman")
                }
                Toggle(isOn: self.$includeCupid) {
                    Text("Cupid")
                }
                Toggle(isOn: self.$includeDetective) {
                    Text("Detective")
                }
                Toggle(isOn: self.$includeDoctor) {
                    Text("Doctor")
                }
                Toggle(isOn: self.$includeGrandma) {
                    Text("Grandma with a Shotgun")
                }
                Toggle(isOn: self.$includeKiller) {
                    Text("Serial Killer")
                }
                Toggle(isOn: self.$includeLawyer) {
                    Text("Lawyer")
                }
                Button(action: {
                    self.saveGameData()
                }) {
                    Text("Continue")
                }
                .alert(isPresented: $showInvalidAlert) {
                Alert(title: Text("Invalid Settings"), message: Text("There are more roles than the given player count"), dismissButton: .default(Text("Close")))
                }
            }
            .padding()
            .padding()
            .navigationBarTitle("Players")
        )
    }
    
    //
    // CreatePasswordCreationView
    //  generate view that prompts the
    //  user to create a password
    //
    func createPasswordCreationView() -> some View {
        return (
            VStack {
                if !passwordAccepted {
                    TextField("Create A Password", text: $password)
                    
                    Button(action: {self.savePassword()}) {
                        Text("Save Password")
                    }
                }
                    
                else {
                    NavigationLink(destination: DistributionView()) {
                        Text("Play")
                    }
                }
            }
        )
    }
    
    //
    // Body:
    //  content and behavior of GameSetupView
    //
    var body: some View {
        Group {
            if !self.dataCollected {
                self.createDataCollectionView()
            }
            else {
                self.createPasswordCreationView()
            }
        }
    }
    
}


struct GameSetupView_Previews: PreviewProvider {
    static var previews: some View {
        GameSetupView()
    }
}
