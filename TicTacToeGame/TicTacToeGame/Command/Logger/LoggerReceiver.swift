//
//  LoggerReceiver.swift
//  TicTacToeGame
//
//  Created by Станислав Лемешаев on 19.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import Foundation

class LoggerReceiver {
    
    static let shared: LoggerReceiver = LoggerReceiver()
    
    func log(mesage: String) {
        debugPrint(mesage)
    }
    
}
