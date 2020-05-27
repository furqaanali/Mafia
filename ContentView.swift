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
                       Image("homeViewBackground")
                           .resizable()
                           .edgesIgnoringSafeArea(.all)
                           .aspectRatio(contentMode: .fill)
                       NavigationLink(destination: GameSetupView()) {
                           Text("Start Game")
                               .fontWeight(.bold)
                               .foregroundColor(Color.white)
                               
                       }
                       .navigationBarTitle("")
                       .navigationBarHidden(true)
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
