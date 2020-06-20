//
//  LoggerCommand.swift
//  TicTacToeGame
//
//  Created by Станислав Лемешаев on 19.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import Foundation

class LoggerCommand {
    
    let message: String
    
    init(message: String) {
        self.message = message
    }
    
    func execute() {
        LoggerReceiver.shared.log(mesage: self.message)
    }
    
}

