//
//  LoggerInvoker.swift
//  TicTacToeGame
//
//  Created by Станислав Лемешаев on 18.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

// MARK: - Invoker
internal final class LoggerInvoker {
    
    // MARK: Singleton
    
    internal static let shared = LoggerInvoker()
    
    // MARK: Private properties
    
    private let logger = Logger()
    
    private let batchSize = 10
    
    private var commands: [LogCommand] = []
    
    // MARK: Internal
    
    internal func addLogCommand(_ command: LogCommand) {
        self.commands.append(command)
        self.executeCommandsIfNeeded()
    }
    
    // MARK: Private
    
    private func executeCommandsIfNeeded() {
        guard self.commands.count >= batchSize else { return }
        self.commands.forEach { self.logger.writeMessageToLog($0.logMessage) }
        self.commands = []
    }
}
