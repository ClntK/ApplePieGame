//
//  ViewController.swift
//  Apple Pie
//
//  Created by user193857 on 7/28/21.
//

import UIKit

class ViewController: UIViewController {

    var listOfWords = ["booplesnoot", "chicanery", "quartet", "paraphernalia", "deuteronomy", "interlocutor"]
    
    let incorrectMovesAllowed = 7
    
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    var currentGame: Game!
    
    
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet var LetterButtons: [UIButton]!
    
    
    @IBAction func hideResetButton(_ sender: UIButton) {
        totalWins = 0
        totalLosses = 0
        listOfWords = ["booplesnoot", "chicanery", "quartet", "paraphernalia", "deuteronomy"]
        updateUI()
        resetButton.isHidden = true
        
    }
    @IBAction func LetterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        }
        else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        }
        else {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newRound()
        resetButton.isHidden = true
    }
    
    
    
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
                enableLetterButtons(true)
            updateUI()
    
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in LetterButtons {
            button.isEnabled = enable
        }
    }
    
    func enableResetButton(_ enable: Bool) {
        resetButton.isHidden = false
    }
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
        if listOfWords.isEmpty && totalWins > totalLosses {
            treeImageView.image = UIImage(named:"winImage")
            enableResetButton(true)
            
        }
        if listOfWords.isEmpty && totalLosses > totalWins  {
            treeImageView.image = UIImage(named:"lossImage")
            enableResetButton(true)
        }
    }

    
}

