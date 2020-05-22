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
    @State private var curPlayer = ""
    let strings = ["ab", "cd"]
    
    func changeValue() -> Void {
        curPlayer = "JOE"
    }
    
    var body: some View {
        VStack {
            Text("Players: \(gameData.numPlayers)")
            Text("Mafia: \(gameData.numMafia)")
            TextField("Enter your name", text: $curPlayer)
            Button(action: {
                self.changeValue()
                self.gameData.playerNames.append(self.curPlayer)
            }) {
                Text(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/)
            }
            List(self.gameData.playerNames, id: \.self) { name in
                Text(name)
            }
            
        }
    }
}

struct PlayingView_Previews: PreviewProvider {
    static var previews: some View {
        PlayingView()
    }
}

