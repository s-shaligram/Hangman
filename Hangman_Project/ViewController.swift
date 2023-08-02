//
//  ViewController.swift
//  Hangman_Project
//
//  Created by Sameer Shaligram on 2023-02-21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstLetter: UITextField!
    
    @IBOutlet weak var secondLetter: UITextField!
    
    @IBOutlet weak var thirdLetter: UITextField!
    
    @IBOutlet weak var forthLetter: UITextField!
    
    @IBOutlet weak var fifthLetter: UITextField!
    
    @IBOutlet weak var sixthLetter: UITextField!
    
    @IBOutlet weak var seventhLetter: UITextField!
    
    @IBOutlet weak var headImage: UIImageView!
    
    @IBOutlet weak var rightArm: UIImageView!
    
    @IBOutlet weak var leftArm: UIImageView!
    
    @IBOutlet weak var bodyImage: UIImageView!
    
    @IBOutlet weak var rightLeg: UIImageView!
    
    @IBOutlet weak var leftLeg: UIImageView!
    
    @IBOutlet var keyBoard: [UIButton]!
    
    @IBOutlet weak var winLabel: UILabel!
    
    @IBOutlet weak var loseLabel: UILabel!
    
    @IBOutlet var play: UIButton!
    
    @IBOutlet weak var hangLabel: UILabel!
    
    
    
    var chosenWord = ""
    
    var chosenWordArray: [String] = []
    
    var count = 1
    var hangCount = 1
    var wins = 0
    var lose = 0
    var i:Int? = nil
    
    var index: Int? = 0
    
    private let sevenWord: [Int:String] = [
        1:"ADDRESS",
        2:"ANCIENT",
        3:"TEQUILA",
        4:"GONDOLA",
        5:"PIRANHA",
        6:"BATTERY",
        7:"CAPTAIN"
    ]
    
    
    
    // var numArr: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGame()
    }
    private func setupGame() {
        chooseWord()
        // Reset win and lose labels
        wins = 0
        lose = 0
        winLabel.text = "0"
        loseLabel.text = "0"
        
        // Hide the body parts and reset hangCount
        hideAllBodyParts()
        hangCount = 1
        
        // Reset the text fields
        firstLetter.text = ""
        secondLetter.text = ""
        thirdLetter.text = ""
        forthLetter.text = ""
        fifthLetter.text = ""
        sixthLetter.text = ""
        seventhLetter.text = ""
        
        // Reset the keyboard buttons
        resetKeyboard()
        
        // Remove the play button if it exists
        play?.removeFromSuperview()
    }
    private func resetKeyboard() {
        for button in keyBoard {
            button.backgroundColor = UIColor.systemBackground
        }
    }
    
    private func hideAllBodyParts() {
        headImage.isHidden = true
        rightArm.isHidden = true
        leftArm.isHidden = true
        bodyImage.isHidden = true
        rightLeg.isHidden = true
        leftLeg.isHidden = true
    }
    private func randomInt(n: Int) -> Int{
        return Int.random(in: 1...n)
    }
    
    private func chooseWord(){
        chosenWord = sevenWord[randomInt(n: 7)] ?? ""
        print("\(chosenWord)")
    }
    
    private func inArray(word: String){
        chosenWordArray = chosenWord.map { $0.uppercased()}
    }
    @IBAction func pressButton(_ sender: UIButton) {
        let c = sender.titleLabel?.text ?? ""
        inArray(word: chosenWord)
        
        var indicesToRemove: [Int] = []
        for (index, letter) in chosenWordArray.enumerated() {
            if letter == c {
                indicesToRemove.append(index)
            }
        }
        
        if indicesToRemove.isEmpty {
            sender.backgroundColor = UIColor.red
            hangCount += 1
        } else {
            sender.backgroundColor = UIColor.green
            for indexToRemove in indicesToRemove {
                switch indexToRemove {
                case 0:
                    firstLetter.text = sender.titleLabel?.text
                case 1:
                    secondLetter.text = sender.titleLabel?.text
                case 2:
                    thirdLetter.text = sender.titleLabel?.text
                case 3:
                    forthLetter.text = sender.titleLabel?.text
                case 4:
                    fifthLetter.text = sender.titleLabel?.text
                case 5:
                    sixthLetter.text = sender.titleLabel?.text
                case 6:
                    seventhLetter.text = sender.titleLabel?.text
                default:
                    break
                }
                count += 1
            }
        }
        
        for indexToRemove in indicesToRemove.reversed() {
            chosenWordArray.remove(at: indexToRemove)
        }
        
        toShowAlert(c: count, hc: hangCount)
        hangPerson(hangCount: hangCount)
    }
    
    
    private func hangPerson(hangCount: Int){
        if hangCount == 2{
            headImage.isHidden = false
        } else if hangCount == 3{
            rightArm.isHidden = false
        } else if hangCount == 4{
            leftArm.isHidden = false
        } else if hangCount == 5{
            bodyImage.isHidden = false
        } else if hangCount == 6{
            rightLeg.isHidden = false
        } else if hangCount == 7{
            leftLeg.isHidden = false
            headImage.image = UIImage(named: "head")
        } else if hangCount == 8{
            headImage.image = UIImage(named: "head")
        }
        
    }
    
    private func toShowAlert(c: Int, hc: Int){
        
        if c == 8 {
            
            let alert = UIAlertController(title: "Phew!", message: "You saved me! Would you like to play again? \nWins: \(calculateWin(c: count)) Losses: \(calculateLose(hc: hangCount))", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "Default action"), style: .default, handler: { _ in
                for i in self.keyBoard{
                    i.backgroundColor = UIColor.systemBackground
                }
                
                self.headImage.isHidden = true
                self.rightArm.isHidden = true
                self.leftArm.isHidden = true
                self.bodyImage.isHidden = true
                self.rightLeg.isHidden = true
                self.leftLeg.isHidden = true
                
                self.firstLetter.text = ""
                self.secondLetter.text = ""
                self.thirdLetter.text = ""
                self.forthLetter.text = ""
                self.fifthLetter.text = ""
                self.sixthLetter.text = ""
                self.seventhLetter.text = ""
                
                self.chooseWord()
                
            }))
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: "Default action"), style: .cancel, handler: { _ in
                self.showPlayButton()
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }else if hc == 8 {
                let alert = UIAlertController(title: "Game Over", message: "Correct word was \(chosenWord). Would you like to play again? \nWins: \(calculateWin(c: count)) Losses: \(calculateLose(hc: hangCount))", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "Default action"), style: .default, handler: { _ in
                    self.setupGame()
                }))
                
                alert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: "Default action"), style: .cancel, handler: { _ in
                    self.showPlayButton()
                    NSLog("The \"No\" alert occurred.")
                }))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        private func showPlayButton() {
            play = UIButton(type: .system)
            play.setTitle("Play", for: .normal)
            play.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            play.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
            play.translatesAutoresizingMaskIntoConstraints = false
                    view.addSubview(play)

                    // Add Auto Layout constraints for the "Play" button
                    NSLayoutConstraint.activate([
                        play.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                        play.topAnchor.constraint(equalTo: hangLabel.bottomAnchor, constant: 10) // Adjust the constant value to change the vertical position
                    ])

        }
        
        @objc private func playButtonPressed() {
            setupGame()
        }
        
        private func calculateLose(hc: Int) -> Int{
            if hangCount == 8{
                lose += 1
                loseLabel.text = String(lose)
                hangCount = 1
                count = 1
                // i = nil
            }
            
            return lose
        }
        
        private func calculateWin(c: Int) -> Int{
            if count == 8{
                wins += 1
                winLabel.text = String(wins)
                count = 1
                hangCount = 1
                // i = nil
            }
            
            return wins
        }
        
    }

