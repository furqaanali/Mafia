//
//  PlayerRow.swift
//  Mafia3
//
//  Created by Furqaan Ali on 5/22/20.
//  Copyright © 2020 Furqaan Ali. All rights reserved.
//

import SwiftUI

struct PlayerRow: View {
    
    @EnvironmentObject var gameData: GameData
    
    var index: Int
    var isActive: Bool
    
    //
    // Body:
    //  content and behavior of PlayerRow
    //
    var body: some View {
        HStack {
            Image(gameData.roles[index])
            .resizable()
            .frame(width: 50, height: 50)
//            .clipShape(Circle())
//            .overlay(
//                Circle().stroke(Color.white, lineWidth: 4))
//            .shadow(radius: 10)
            Text(gameData.playerNames[index])
//            Text(gameData.roles[index])
            
            Spacer()
            
            if gameData.lovers.contains(gameData.playerNames[index]) {
                Image(systemName: "heart.fill")
                    .foregroundColor(Color.red)
//                    .resizable()
                    .frame(width: 50, height: 50)
            }
            
            if !isActive {
                Image("Dead")
                .resizable()
                .frame(width: 50, height: 50)
            }
        }
    }
}

struct PlayerRow_Previews: PreviewProvider {
    static var previews: some View {
        PlayerRow(index: 0, isActive: false)
    }
}
