//
//  GameState.swift
//  TicTacToeGame
//
//  Created by Станислав Лемешаев on 16.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import Foundation

protocol GameState {
    // выполнено ли состояние
    var isCompleted: Bool { get }
    //
    var inputState: GameViewInput { set get }
    // реализация состояния
    func begin()
    // добавляет либо крестик, либо нолик
    func addMark(at position: GameboardPosition)
}
