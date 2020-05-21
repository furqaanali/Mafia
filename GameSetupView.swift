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
    
    var body: some View {
        VStack {
            Stepper(value: $numPlayers, in: 3...20) {
                Text("Players")
                Text("\(numPlayers)")
            }
            Stepper(value: $numMafia, in: 1...5) {
                Text("Mafia")
                Text("\(numMafia)")
            }
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
