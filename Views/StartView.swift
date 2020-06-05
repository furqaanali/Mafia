//
//  StartView.swift
//  Mafia3
//
//  Created by Furqaan Ali on 5/20/20.
//  Copyright © 2020 Furqaan Ali. All rights reserved.
//

import SwiftUI

struct StartView: View {
    
    @EnvironmentObject var gameData: GameData
    
    //
    // Body:
    //  content and behavior of StartView
    //
    var body: some View {
        NavigationView {
            ZStack {
                Image("mafiaBackground")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .aspectRatio(contentMode: .fill)
                
                VStack {
                    Spacer()
                    NavigationLink(destination: GameSetupView()) {
                        Text("Start Game")
                            .padding()
                            .foregroundColor(Color.black)
                            .background(Color.gray)
                            .opacity(0.75)
                            .cornerRadius(1000)
                    }
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    
                    Divider()
                    Divider()
                    
                    Text("M A F I A")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(Color.gray)
                        .opacity(0.8)
                }
                .padding()
                .padding()
                .padding()
            }
        }
    }
    
}
