//
//  GameEndedState.swift
//  TicTacToeGame
//
//  Created by Станислав Лемешаев on 16.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import Foundation

public class GameEndedState: GameState {
    
    var isCompleted: Bool = false
    let winner: Player?
    var inputState: GameViewInput
    
    init(winner: Player?, inputState: GameViewInput) {
        self.winner = winner
        self.inputState = inputState
    }
    
    func begin() {
        self.inputState.firstPlayerTurnLabel(hide: true)
        self.inputState.secondPlayerTurnLabel(hide: true)
        self.inputState.incorrectMoveLabel(hide: true)
        self.inputState.winnerLabel(hide: false)
        
        var text = "Ничья!"
        if let winner = self.winner {
            text = winner.winnerText()
        }
        self.inputState.winnerLabel(text: text)
    }
    
    func addMark(at position: GameboardPosition) {}
    
}
