//
//  ComputerInputState.swift
//  TicTacToeGame
//
//  Created by Станислав Лемешаев on 19.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import Foundation

class ComputerInputState: GameState {
    
    var isCompleted: Bool = false
    private let player: Player
    var inputState: GameViewInput
    private weak var gameboard: Gameboard?
    private weak var gameboardView: GameboardView?
    
    init(player: Player, inputState: GameViewInput, gameboard: Gameboard, gameboardView: GameboardView) {
        self.player = player
        self.inputState = inputState
        self.gameboard = gameboard
        self.gameboardView = gameboardView
    }
    
    func begin() {
        self.inputState.winnerLabel(hide: true)
        self.inputState.firstPlayerTurnLabel(hide: true)
        self.inputState.secondPlayerTurnLabel(hide: false)
        let position: GameboardPosition = generateMovePosition()
        addMark(at: position)
    }
    
    func addMark(at position: GameboardPosition) {
        if self.isCompleted { return }
        self.gameboard?.setPlayer(self.player, at: position)
        let markView = self.player.markViewPrototype.makeCopy()
        self.gameboardView?.placeMarkView(markView, at: position)
        self.isCompleted = true
    }
}

extension ComputerInputState {
    
    private func generateMovePosition() -> GameboardPosition {
        if let freePositions = gameboard?.getFreePositions() {
            let randomMoveId = Int.random(in: 0 ..< freePositions.count)
            return freePositions[randomMoveId]
        }
        else {
            let position = getBruteForcePosition()
            return position
        }
    }
    
    private func getBruteForcePosition() -> GameboardPosition {
        for column in 0 ..< GameboardSize.columns {
            for row in 0 ..< GameboardSize.rows {
                let newPosition = GameboardPosition(column: column, row: row)
                let isFreePosition = !(gameboard?.containsAnyPlayer(at: newPosition) ?? true)
                if isFreePosition {
                    return newPosition
                }
            }
        }
        return GameboardPosition(column: 0, row: 0)
    }
    
}
