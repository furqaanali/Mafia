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
    
    @State private var myDictKeys = ["Mafia", "Doctor", "Killer", "Joker"]
    @State private var myDictVals = [-1, -1, -1, -1]
    @State var mylist = [ "jack", "joe" , "ben"]
    @State var temp = [-1]
    
    @State var playerNames = ["Ayesha", "Farhan", "Furqaan", "Aamina"]
    @State var lover = ""
    
    @State var lynchAvailable: Bool = false

    var body: some View {
        VStack{
            Image(systemName: "person")
            Image(systemName: "heart")
        }
//        VStack {
//            Text("Directors View")
//                .font(.title)
//
//            Divider()
//
//            List(playerNames.indices, id: \.self) { index in
//                PlayerRow(index: index, isActive: true)
//            }
//
//            HStack {
//                Button(action: {self.lynchAvailable.toggle()}) {
//                    Text("Begin Night")
//                }
//
//                if lynchAvailable {
//                    Spacer()
//                    Button(action: {self.lynchAvailable.toggle()}) {
//                        Text("Lynch")
//                    }
//                }
//            }
//            .padding()
//            .padding()
//
//            Text("Round: 1")
//
//        }
//        .padding()
//        .padding()
//        Color.purple
//        .edgesIgnoringSafeArea(.all)
//        .overlay(
//        VStack() {
//
//            Text("Hi")
//        }
//        GeometryReader { geometry in
//            ZStack {
//                Image("homeViewBackground")
//                    .resizable()
//                    .aspectRatio(geometry.size, contentMode: .fill)
//                    .edgesIgnoringSafeArea(.all)
//                VStack {
//                    Text("BYE")
//                    Text("HELLO")
//                }
//            }
//        }
//        NavigationView {
//            ZStack {
//                Image("homeViewBackground")
//                    .edgesIgnoringSafeArea(.all)
////                Color.red.edgesIgnoringSafeArea(.all)
//                ScrollView {
//                    Text("Example")
//                }
//                NavigationLink (destination: GameSetupView()) {
//                    Text("Hi")
//                }
//                .navigationBarTitle("title")
//            }
//        }
        
//        NavigationView {
//            ZStack {
//                Image("homeViewBackground")
//                    .resizable()
//                    .edgesIgnoringSafeArea(.all)
//                    .aspectRatio(contentMode: .fill)
//                NavigationLink(destination: GameSetupView()) {
//                    Text("Start Game")
//                        .fontWeight(.bold)
//                        .foregroundColor(Color.white)
//
//                }
//                .navigationBarTitle("")
//                .navigationBarHidden(true)
//            }
//        }
//        .background(Color.black)

    }
}

struct Testing_Previews: PreviewProvider {
    static var previews: some View {
        Testing()
    }
}
