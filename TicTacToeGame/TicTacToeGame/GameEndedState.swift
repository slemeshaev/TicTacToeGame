//
//  GameEndedState.swift
//  TicTacToeGame
//
//  Created by Станислав Лемешаев on 16.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import Foundation

public class GameEndedState: GameState {
    
    public let isCompleted = false
    
    public let winner: Player?
    private(set) weak var gameViewController: GameViewController?
    
    init(winner: Player?, gameViewController: GameViewController) {
        self.winner = winner
        self.gameViewController = gameViewController
    }
    
    public func begin() {
        Log(.gameFinished(winner: self.winner))
        self.gameViewController?.winnerLabel.isHidden = false
        if let winner = winner {
            self.gameViewController?.winnerLabel.text = "Победил " + self.winnerName(from: winner)
        } else {
            self.gameViewController?.winnerLabel.text = "Ничья!"
        }
        self.gameViewController?.firstPlayerTurnLabel.isHidden = true
        self.gameViewController?.secondPlayerTurnLabel.isHidden = true
    }
    
    public func addMark(at position: GameboardPosition) { }
    
    private func winnerName(from winner: Player) -> String {
        switch winner {
        case .first:
            return "1-й игрок"
        case .second:
            return "2-й игрок"
        }
    }
    
}
