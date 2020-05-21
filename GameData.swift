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
    @Published var numPlayers: Int = 4
    @Published var numMafia: Int = 2
    @Published var text: String = "Helloooo"
    
}
