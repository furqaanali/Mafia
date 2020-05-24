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
            NavigationLink(destination: GameSetupView()) {
                Text("Start Game")
            }
            .navigationBarTitle("Mafia")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
