//
//  LogAction.swift
//  TicTacToeGame
//
//  Created by Станислав Лемешаев on 18.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

public enum LogAction {
    
    case playerInput(player: Player, position: GameboardPosition)
    
    case gameFinished(winner: Player?)
    
    case restartGame
    
}

public func Log(_ action: LogAction) {
    let command = LogCommand(action: action)
    LoggerInvoker.shared.addLogCommand(command)
}
