//
//  DistributionView.swift
//  Mafia3
//
//  Created by Furqaan Ali on 5/22/20.
//  Copyright © 2020 Furqaan Ali. All rights reserved.
//

import SwiftUI

struct DistributionView: View {
    
    @EnvironmentObject var gameData: GameData
    
    @State private var currentPlayer: String = ""
    @State private var currentIndex: Int = -1
    
    @State private var showingRole: Bool = false
    @State private var finishedDistribution: Bool = false
    
    func generateRoles() -> Void {
        for _ in 1...self.gameData.numPlayers {
            self.gameData.roles.append("Civilian")
        }
        for index in 0...self.gameData.numMafia - 1 {
            self.gameData.roles[index] = "Mafia"
        }
        self.gameData.roles.shuffle()
    }
    
    func clearRoles() -> Void {
        self.gameData.roles.removeAll()
        self.gameData.playerNames.removeAll()
    }
    
    func displayRole() -> some View {
        return (
            VStack {
                Text("Role: \(self.gameData.roles[currentIndex])")
            }
        )
    }
    
    func updateForNextPlayer() -> Void {
        if self.currentPlayer != "" {
            self.gameData.playerNames.append(self.currentPlayer)
            self.currentPlayer.removeAll()
            self.showingRole.toggle()
            self.currentIndex += 1
        }
    }
    
    func createDistributionView() -> some View {
        return (
            VStack {
                        
                Text("Distribution Screen")
                    .onAppear(perform: self.generateRoles)
                    .onDisappear(perform: self.clearRoles)
                
                Text("Player #\(self.currentIndex + 2)")
                
                TextField("Enter your name", text: $currentPlayer)
                
                Button(action: {self.updateForNextPlayer()}) {
                    Text("View Role")
                }
                    
                // DESIGN OPTIONS: ACTION SHEET, SHEET, ALERT
                    
    //            .actionSheet(isPresented: $isDisabled) {
    //                ActionSheet(title: Text("What do you want to do?"), message: Text("There's only one choice..."), buttons: [.default(Text("Dismiss Action Sheet"))])
    //            }
                .alert(isPresented: $showingRole) {
                    Alert(title: Text("\(self.gameData.playerNames[currentIndex]), you are"), message: Text("\(self.gameData.roles[currentIndex])"), dismissButton: .default(Text("Close")) {
                        if self.currentIndex >= self.gameData.numPlayers - 1 {
                            self.finishedDistribution.toggle()
                        }
                        })
                }
    //            .sheet(isPresented: $isDisabled) {
    //                Text("Return to Director")
    //            }
    //            .sheet(isPresented: $isDisabled) {
    //                self.displayRole()
    //            }
                
                List(self.gameData.roles, id: \.self) { role in
                    Text(role)
                }
                
                List(self.gameData.playerNames, id: \.self) { name in
                    Text(name)
                }
            }
        )
    }
    
    func createReturnView() -> some View {
        return (
            VStack {
                Text("Return to Director")
                
                NavigationLink(destination: PlayingView()) {
                    Text("Continue to Directors Screen")
                }
            }
        )
    }
    
    var body: some View {
        Group {
            if !finishedDistribution {
                createDistributionView()
            }
            else {
                createReturnView()
            }
        }
    }
}

struct DistributionView_Previews: PreviewProvider {
    static var previews: some View {
        DistributionView()
    }
}
