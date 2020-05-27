//
//  ContentView.swift
//  Mafia3
//
//  Created by Furqaan Ali on 5/20/20.
//  Copyright © 2020 Furqaan Ali. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var gameData: GameData
    
    //
    // Body:
    //  content and behavior of ContentView
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
                    
//                    Spacer()
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
//               .background(Color.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
