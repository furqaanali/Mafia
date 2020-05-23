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
    @State var numPlayers = 5
    @State var numMafia = 2
    
    @State var includeBarman: Bool = false
    @State var includeCupid: Bool = false
    @State var includeDetective: Bool = false
    @State var includeDoctor: Bool = false
    @State var includeGrandma: Bool = false
    @State var includeKiller: Bool = false
    @State var includeLawyer: Bool = false
    
    @State var dataCollected: Bool = false
    
    @State var password: String = ""
    @State var passwordAccepted: Bool = false
    
    
    //
    // SaveGameData
    //  copy all of the acquired information into
    //  the @EnvironmentObject so this data can
    //  be accessed later in the game
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
        dataCollected.toggle()
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
                TextField("Create A Password", text: $password)
                
                if !passwordAccepted {
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
