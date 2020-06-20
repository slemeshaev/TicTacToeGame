//
//  GameViewController.swift
//  TicTacToeGame
//
//  Created by Станислав Лемешаев on 16.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

protocol GameViewInput: UIViewController {
    func incorrectMoveLabel(hide: Bool)
    func firstPlayerTurnLabel(hide: Bool)
    func secondPlayerTurnLabel(hide: Bool)
    func winnerLabel(hide: Bool)
    func winnerLabel(text: String)
}

class GameViewController: UIViewController {
    
    @IBOutlet weak var gameboardView: GameboardView!
    @IBOutlet weak var firstPlayerTurnLabel: UILabel!
    @IBOutlet weak var secondPlayerTurnLabel: UILabel!
    @IBOutlet weak var incorrectMoveLabel: UILabel!
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    
    private let gameboard = Gameboard()
    private var gameSettings = GameSettings()
    
    private var currentPlayer: Player = .first
    lazy var referee = Referee(gameboard: self.gameboard)
    
    private let moveInvoker = MoveInvoker.shared
    
    private var currentState: GameState! {
        didSet {
            self.currentState.begin()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.switchToFirstState()
        configureViews()
        incorrectMoveLabel(hide: true)
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        self.gameboard.clear()
        self.gameboardView.clear()
        self.currentPlayer = .first
        self.switchToFirstState()
        self.moveInvoker.clear()
    }

}

// MARK: - State machine logic
extension GameViewController {
    
    private func switchToFirstState() {
        self.swithToPlayerInputState(with: .first)
    }
    
    private func switchToNextState() {
        if false == self.currentState.isCompleted { return }
        
        switch gameSettings.gameMode {
        case .oneMove:
            oneMoveStateChanger()
            
        case .fiveMoves:
            fiveMovesStateChanger()
        }
    }
}

//MARK: - FiveMoves State machine
extension GameViewController {

    private func fiveMovesStateChanger() {
        if moveInvoker.needExecute() {
            switchToFinishedState()
        } else {
            self.switchSettingsByGameSettings()
        }
    }
    
    private func switchToFinishedState() {
        restartButton(enable: false)
        self.moveInvoker.execute { [weak self] in
            self?.restartButton(enable: true)
            if let winner = self?.referee.determineWinner() {
                self?.switchToFinishedState(with: winner)
            } else {
                self?.switchToFinishedState(with: nil)
            }
        }
    }
    
    func restartButton(enable: Bool) {
        self.restartButton.isEnabled = enable
    }
}

//MARK: - OneMove State machine
extension GameViewController {
    
    private func oneMoveStateChanger() {
        if let winner = self.referee.determineWinner() {
            self.switchToFinishedState(with: winner)
            
        } else if self.gameboard.areAllPositionsFullfilled() {
            self.switchToFinishedState(with: nil)
            
        } else {
            self.switchSettingsByGameSettings()
        }
    }
    
    private func switchStateByGameType() {
        self.currentPlayer = self.currentPlayer.next
        if self.currentPlayer == .first {
            self.swithToPlayerInputState(with: self.currentPlayer)
        } else if self.gameSettings.gameType == GameType.pvp {
            self.swithToPlayerInputState(with: self.currentPlayer)
        } else {
            self.swithToComputerInputState(with: self.currentPlayer)
            self.switchToNextState()
        }
    }
    
    private func swithToPlayerInputState(with player: Player) {
        let prototype = player.markViewPrototype
        switch player {
        case .first:
            prototype.lineColor = .red
        case .second:
            prototype.lineColor = .green
        }
        prototype.layoutSubviews()
        
        if gameSettings.gameMode == GameMode.oneMove {
            self.currentState = PlayerInputState(player: player,
                                                 inputState: self,
                                                 gameboard: self.gameboard,
                                                 gameboardView: self.gameboardView)
        } else {
            self.currentState = PlayerFiveMovesInputState(player: player,
                                                          inputState: self,
                                                          gameboard: self.gameboard,
                                                          gameboardView: self.gameboardView)
        }
        
    }
    
    private func swithToComputerInputState(with player: Player) {
        let prototype = player.markViewPrototype
        prototype.lineColor = .green
        prototype.layoutSubviews()
        
        self.currentState = ComputerInputState(player: player,
                                          inputState: self,
                                          gameboard: self.gameboard,
                                          gameboardView: self.gameboardView)
    }
    
    private func switchToFinishedState(with winner: Player?) {
        self.currentState = GameEndedState(winner: winner, inputState: self)
    }
    
    private func switchSettingsByGameSettings() {
        switchStateByGameType()
    }
    
}

//MARK: - Actions
extension GameViewController {
    
    private func configureViews() {
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            self.currentState.addMark(at: position)
            self.switchToNextState()
        }
    }
    
}

//MARK: - Received GameType
extension GameViewController {
    
    public func set(gameSettings: GameSettings) {
        self.gameSettings = gameSettings
    }
    
}

extension GameViewController: GameViewInput {
    
    func incorrectMoveLabel(hide: Bool) {
        self.incorrectMoveLabel.isHidden = hide
    }
    
    func firstPlayerTurnLabel(hide: Bool) {
        self.firstPlayerTurnLabel.isHidden = hide
    }
    
    func secondPlayerTurnLabel(hide: Bool) {
        self.secondPlayerTurnLabel.isHidden = hide
    }
    
    func winnerLabel(hide: Bool)  {
        self.winnerLabel.isHidden = hide
    }
    
    func winnerLabel(text: String) {
        self.winnerLabel.text = text
    }
    
}
