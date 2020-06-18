//
//  PlayerInputState.swift
//  TicTacToeGame
//
//  Created by Станислав Лемешаев on 16.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import Foundation

public class PlayerInputState: GameState {
    
    public private(set) var isCompleted: Bool = false
    
    public let player: Player
    private(set) weak var gameViewController: GameViewController?
    private(set) weak var gameboard: Gameboard?
    private(set) weak var gameboardView: GameboardView?
    
    public var markViewPrototype: MarkView
    
    init(player: Player, markViewPrototype: MarkView, gameViewController: GameViewController, gameboard: Gameboard, gameboardView: GameboardView) {
        self.player = player
        self.markViewPrototype = markViewPrototype
        self.gameViewController = gameViewController
        self.gameboard = gameboard
        self.gameboardView = gameboardView
    }
    
    // метод реализации состояния
    public func begin() {
        switch self.player {
        case .first:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = false
            self.gameViewController?.secondPlayerTurnLabel.isHidden = true
        case .second:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = true
            self.gameViewController?.secondPlayerTurnLabel.isHidden = false
        }
        self.gameViewController?.winnerLabel.isHidden = true
    }
    
    // метод добавления крестика или нолика
    public func addMark(at position: GameboardPosition) {
        guard let gameboardView = self.gameboardView, gameboardView.canPlaceMarkView(at: position) else { return }
        
        self.gameboard?.setPlayer(self.player, at: position)
        self.gameboardView?.placeMarkView(self.markViewPrototype.copy(), at: position)
        self.isCompleted = true
    }
}
