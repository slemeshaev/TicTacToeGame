//
//  MainViewController.swift
//  TicTacToeGame
//
//  Created by Станислав Лемешаев on 19.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private var gameMode = GameMode.oneMove
    private var gameType = GameType.pvi

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            self.gameType = GameType.pvp
            self.gameMode = GameMode.oneMove
            startGame()
        case 2:
            self.gameType = GameType.pvi
            self.gameMode = GameMode.oneMove
            startGame()
        case 3:
            self.gameType = GameType.pvp
            self.gameMode = GameMode.fiveMoves
            startGame()
        default:
            return
        }
    }
    
}

//MARK: - Segue example
extension MainViewController {
    
    private func startGame() {
        performSegue(withIdentifier: "toGame", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGame" {
            guard let upcoming = segue.destination as? GameViewController else { return }
            let gameSettings = GameSettings(mode: self.gameMode, type: self.gameType)
            upcoming.set(gameSettings: gameSettings)
        }
    }
    
}
