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
            .frame(width: 40, height: 40)
            .clipShape(Circle())
            .overlay(
                Circle().stroke(Color.black, lineWidth: 2))
            .shadow(radius: 5)
            
            Divider()
            
            Text(gameData.playerNames[index])
            
            Spacer()
            
            if gameData.lovers.contains(gameData.playerNames[index]) {
                Image(systemName: "heart.fill")
                    .foregroundColor(Color.red)
            }
            
            if !isActive {
                Image("Dead")
                .resizable()
                .frame(width: 30, height: 30)
            }
        }
    }
}
