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
    
    @Published var playerNames: [String] = []
    @Published var roles: [String] = []
    
}
