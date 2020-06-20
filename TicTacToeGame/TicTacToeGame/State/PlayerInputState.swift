//
//  PlayerInputState.swift
//  TicTacToeGame
//
//  Created by Станислав Лемешаев on 16.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import Foundation

class PlayerInputState: GameState {
    
    var isCompleted: Bool = false
    let player: Player
    var inputState: GameViewInput
    weak var gameboard: Gameboard?
    weak var gameboardView: GameboardView?
    
    init(player: Player, inputState: GameViewInput, gameboard: Gameboard, gameboardView: GameboardView) {
        self.player = player
        self.inputState = inputState
        self.gameboard = gameboard
        self.gameboardView = gameboardView
    }
    
    func begin() {
        switch self.player {
        case .first:
            self.inputState.firstPlayerTurnLabel(hide: false)
            self.inputState.secondPlayerTurnLabel(hide: true)
        case .second:
            self.inputState.firstPlayerTurnLabel(hide: true)
            self.inputState.secondPlayerTurnLabel(hide: false)
        }
        self.inputState.winnerLabel(hide: true)
    }
    
    func addMark(at position: GameboardPosition) {
        if self.isCompleted { return }
        if true == self.gameboard?.containsAnyPlayer(at: position) {
            self.inputState.incorrectMoveLabel(hide: false)
            return }
        self.inputState.incorrectMoveLabel(hide: true)
        self.gameboard?.setPlayer(self.player, at: position)
        let markView = self.player.markViewPrototype.makeCopy()
        self.gameboardView?.placeMarkView(markView, at: position)
        self.isCompleted = true
    }
}
