//
//  LoggerInvoker.swift
//  TicTacToeGame
//
//  Created by Станислав Лемешаев on 18.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

// MARK: - Invoker
class LoggerInvoker {
     
    static let shared: LoggerInvoker = LoggerInvoker()
    
    private var commands: [LoggerCommand] = []
    private let batchSize: Int = 5
    
    func addCommand(_ loggerCommand: LoggerCommand) {
        self.commands.append(loggerCommand)
        self.executeIfNeeded()
    }
    
    private func executeIfNeeded() {
        if self.commands.count < self.batchSize { return }
        
        for command in self.commands {
            command.execute()
        }
        
        self.commands.removeAll()
    }
    
}
