//
//  GameSettings.swift
//  TicTacToeGame
//
//  Created by Станислав Лемешаев on 19.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import Foundation

struct GameSettings {
    
    let gameMode: GameMode
    let gameType: GameType
    
    init() {
        self.gameMode = GameMode.oneMove
        self.gameType = GameType.pvp
    }
    
    init(mode: GameMode, type: GameType) {
        self.gameMode = mode
        self.gameType = type
    }
}
