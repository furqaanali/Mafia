//
//  GameData.swift
//  Mafia3
//
//  Created by Furqaan Ali on 5/20/20.
//  Copyright © 2020 Furqaan Ali. All rights reserved.
//

import Foundation
import SwiftUI

final class GameData: ObservableObject {
    @Published var numPlayers: Int = 5
    @Published var numMafia: Int = 2
    
    @Published var password: String = ""
    
    @Published var includeBarman: Bool = false
    @Published var includeCupid: Bool = false
    @Published var includeDetective: Bool = false
    @Published var includeDoctor: Bool = false
    @Published var includeGrandma: Bool = false
    @Published var includeKiller: Bool = false
    @Published var includeLawyer: Bool = false
    
    @Published var additionalRoles: [String: Bool] = ["Barman": false, "Cupid": false, "Detective": false, "Doctor": false, "Grandma with a Shotgun": false, "Serial Killer": false, "Lawyer": false]
    
    @Published var playerNames: [String] = []
    @Published var roles: [String] = []
    @Published var isActive: [Bool] = []
    @Published var activePlayers: [String] = []
    
}
