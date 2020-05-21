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
    
    var body: some View {
        VStack {
            Stepper(value: self.$numPlayers, in: 4...25, step: 1, onEditingChanged: {_ in self.gameData.numPlayers = self.numPlayers}, label: {Text("Players \(self.numPlayers)")})
            
            Stepper(value: self.$numMafia, in: 4...25, step: 1, onEditingChanged: {_ in self.gameData.numMafia = self.numMafia}, label: {Text("Mafia \(self.numMafia)")})
            
            NavigationLink(destination: PlayingView()) {
                Text("Play")
            }
        }
        .padding()
        .padding()
        .navigationBarTitle("Players")
    }
}

struct GameSetupView_Previews: PreviewProvider {
    static var previews: some View {
        GameSetupView()
    }
}
