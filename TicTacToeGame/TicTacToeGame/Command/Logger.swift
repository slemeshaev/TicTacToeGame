//
//  Logger.swift
//  TicTacToeGame
//
//  Created by Станислав Лемешаев on 18.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

// MARK: - Receiver

final class Logger {
    
    func writeMessageToLog(_ message: String) {
        // здесь должна быть реализация записи сообщения в лог
        // для простоты примера паттерна не в даемся в реализацию
        // а просто печатаем текст в консоль
        print(message)
    }
    
}
