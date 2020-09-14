//
//  ViewController.swift
//  Concentration
//
//  Created by 이지원 on 2020/09/02.
//  Copyright © 2020 JiWon Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        get {
            return (cardButtons.count + 1 ) / 2
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var newGameButton: UIButton!
    @IBOutlet private weak var nowThemeLabel: UILabel!
    @IBOutlet private weak var gameScoreLabel: UILabel!
    
    private func updateGameLabel() {
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        
        // set flipCountLabel
        let attributedString = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
        self.flipCountLabel.attributedText = attributedString
        
        // set gameScoreLabel
        let gameScoreAttributedString = NSAttributedString(string: "Score: \(game.gameScore)", attributes: attributes)
        self.gameScoreLabel.attributedText = gameScoreAttributedString
        
        // set nowThemeLabel
        let nowThemeAttributedString = NSAttributedString(string: "Theme: \(nowTheme)", attributes: attributes)
        self.nowThemeLabel.attributedText = nowThemeAttributedString

    }
        
    private(set) var nowTheme: String = "" {
        didSet {
            nowThemeLabel.text = "Theme: \(nowTheme)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateGameLabel()
        self.view.backgroundColor = UIColor(named: theme.1[0])
    }
    
    @IBAction func touchUpNewGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        theme = Theme.chooseTheme()
        for index in cardButtons.indices {
            let button = cardButtons[index]
            button.setTitle("", for: .normal)
//            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
//            self.view.backgroundColor = UIColor(named: "systemBlue")
            self.view.backgroundColor = UIColor(named: theme.1[0])
            button.backgroundColor = UIColor(named: theme.1[1])
        }
        newGameButton.isHidden = true
    }
    
    @IBAction func touchUpCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
        
        updateGameLabel()
        
        let check = game.cards.map { $0.isMatched }
        if check.allSatisfy({$0}) {
            newGameButton.isHidden = false
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : UIColor(named: theme.1[1])
            }
        }
    }
    
    
    private var theme = Theme.chooseTheme() {
        didSet {
            nowTheme = theme.0.key
        }
    }
    
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, theme.0.value.count > 0 {
            emoji[card] = theme.0.value.remove(at: theme.0.value.count.arc4random)
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
