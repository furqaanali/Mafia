//
//  PlayingView.swift
//  Mafia3
//
//  Created by Furqaan Ali on 5/20/20.
//  Copyright © 2020 Furqaan Ali. All rights reserved.
//

import SwiftUI

struct PlayingView: View {
    
    @EnvironmentObject var gameData: GameData
    
    var body: some View {
        VStack {
            Text("Players: \(gameData.numPlayers)")
            Text("Mafia: \(gameData.numMafia)")        }
    }
}

struct PlayingView_Previews: PreviewProvider {
    static var previews: some View {
        PlayingView()
    }
}

