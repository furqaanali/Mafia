/*
//
//  Testing.swift
//  Mafia3
//
//  Created by Furqaan Ali on 5/22/20.
//  Copyright © 2020 Furqaan Ali. All rights reserved.
//

import SwiftUI

struct Testing: View {
    
    @State private var isNight: Bool = false
    @State private var attacked: Int = 0
    @State private var rescued: Int = 0
    
    private var playerNames = ["Furqaan", "Ayesha", "Farhan", "Aamina"]
    
    var body: some View {
        VStack {
//        Button(action: {self.isNight.toggle()}) {
//            Text("Begin Night")
//        }
//        .sheet(isPresented: self.$isNight) {
            
            NavigationView {
                Form {
                    Section {
                    Text("Who does the Mafia attack?")
                    Picker(selection: self.$attacked, label: Text("")) {
                        ForEach(0 ..< self.playerNames.count) {
                            Text(self.playerNames[$0])
                       }
                    }
                    }
                }
            }
            NavigationView {
                Form {
                    Section {
                    Text("Who does the Doctor Rescue?")
                    Picker(selection: self.$rescued, label: Text("")) {
                        ForEach(0 ..< self.playerNames.count) {
                            Text(self.playerNames[$0])
                       }
                    }
                    }
                }
            }
            
            Form {
            Text("Attacked: \(self.attacked)")
            Text("Rescued: \(self.rescued)")
            }
//        }
        }
    }
}

struct Testing_Previews: PreviewProvider {
    static var previews: some View {
        Testing()
    }
}
*/


//
//  PlayerRow.swift
//  Mafia3
//
//  Created by Furqaan Ali on 5/22/20.
//  Copyright © 2020 Furqaan Ali. All rights reserved.
//

/*
import SwiftUI

struct PlayerRow: View {
    
    var playerNames = ["Ayesha", "Farhan", "Furqaan", "Aamina"]
    var roles = ["Civilian", "Mafia", "Civilian", "Doctor"]
    
    var index: Int
    
    var body: some View {
        HStack {
            Image(roles[index])
            .resizable()
            .frame(width: 50, height: 50)
//            .clipShape(Circle())
//            .overlay(
//                Circle().stroke(Color.white, lineWidth: 4))
//            .shadow(radius: 10)
            Text(playerNames[index])
            Text(roles[index])
            Spacer()
        }
    }
}

struct PlayerRow_Previews: PreviewProvider {
    static var previews: some View {
        PlayerRow(index: 0)
    }
}
*/

import SwiftUI

struct Testing: View {

    var body: some View {
        VStack {
            HStack {
                Text("Hello")
                Text("Civilian")
                    .font(.caption)
                    .fontWeight(.light)
                    .foregroundColor(Color.pink)
                    
                Spacer()
            }
        }
    }
}

struct Testing_Previews: PreviewProvider {
    static var previews: some View {
        Testing()
    }
}
