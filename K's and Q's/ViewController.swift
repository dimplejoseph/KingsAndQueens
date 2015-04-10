//
//  ViewController.swift
//  K's and Q's
//
//  Created by Dimple Joseph on 4/6/15.
//  Copyright (c) 2015 Dimple Joseph. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    
    var randomNumber = arc4random_uniform(6)
    
    var activePlayer = 1
    
    var gameActive = true
    
    var kingWins = 0
    
    var queenWins = 0
    
    @IBOutlet var playerOneName: UITextField!
    
    
    @IBOutlet var playerTwoName: UITextField!
    
    
    
    @IBOutlet var king: UILabel!
    
    @IBOutlet var queen: UILabel!
    
    //1 = circle, 2 = crosses
    
    var gameState = [0,0,0,0,0,0,0,0,0]
    
    var winningCombanitions = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    
    var counter = 0

    
    @IBOutlet var button: UIButton!
    
    @IBOutlet var gameOverLabel: UILabel!
    
    @IBOutlet var playAgainButton: UIButton!
    
        @IBAction func playAgainPressed(sender: AnyObject) {
        
        randomNumber = arc4random_uniform(6)
        
        activePlayer = 1
        
        counter = 0
        
        gameActive = true
        
        gameState = [0,0,0,0,0,0,0,0,0]
        
        var button: UIButton
        for var i = 0; i < 9; i++ {
            
            button = view.viewWithTag(i) as UIButton
            
            button.setImage(nil, forState: .Normal)
            
        }
        gameOverLabel.hidden = true
        
        playAgainButton.hidden = true
        
        gameOverLabel.center = CGPointMake(gameOverLabel.center.x-400, gameOverLabel.center.y)
        
        playAgainButton.center = CGPointMake(playAgainButton.center.x-400, playAgainButton.center.y)
    
    }
    
 
    

    
    
    @IBAction func buttonPressed(sender: AnyObject) {
        if gameState[sender.tag] == 0 && gameActive && counter < 9{
            
            var image = UIImage()
            
            
            
            
            counter = counter + 1
            
            if activePlayer == 1{
                
                image = UIImage(named: "circle.png")!
                
                activePlayer = 2
                
            }else if activePlayer == 4{
                
                image = UIImage(named: "cross.png")!
                
                activePlayer = 1
            
            }else if activePlayer == 3{
                
                image = UIImage(named: "circle.png")!
                
                activePlayer = 2

            }
            else{
                
                image = UIImage(named: "cross.png")!
                
                activePlayer = 1

            }
            
            if sender.tag == Int(randomNumber) && activePlayer == 1{
                
                image = UIImage(named: "black.jpeg")!
                
                activePlayer = 3
                
            }else if sender.tag == Int(randomNumber) && activePlayer == 2{
                
                image = UIImage(named: "black.jpeg")!
                
                activePlayer = 4
            }


            gameState[sender.tag] = activePlayer
            sender.setImage(image, forState: .Normal)
     
            
            for combination in winningCombanitions {
                
                if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]]{
                    
                    
                    if gameState[combination[0]] == 1{
                        
                        gameOverLabel.text = "Kings have Won!"
                        
                        kingWins++
                        if (queen.text?.isEmpty != nil && (playerTwoName.text as NSString).length > 0){

                            queen.text = (playerTwoName.text as NSString).substringToIndex(12) +  " Wins: \(kingWins)"

                        
                        }else{
                        
                            queen.text = "Kings Wins: \(kingWins)"
                        
                        }
                        
                    }else{
                        
                        gameOverLabel.text = "Queens have Won!"
                        
                        queenWins++
                        
                        if (king.text?.isEmpty != nil && (playerOneName.text as NSString).length > 0){
                            
                        
                            king.text = (playerOneName.text as NSString).substringToIndex(12) + " Wins: \(queenWins)"
                            
                        }else{
                        
                            king.text = "Queen Wins: \(queenWins)"
                        
                        }
                        
                    }
                    
                    gameOverLabel.hidden = false
                    
                    playAgainButton.hidden = false
                    
                    UIView.animateWithDuration(0.1, animations: { () -> Void in
                        
                        self.gameOverLabel.center = CGPointMake(self.gameOverLabel.center.x + 400, self.gameOverLabel.center.y)
                        
                        
                        self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x + 400, self.playAgainButton.center.y)
                        
                    })
                    
                    gameActive = false
                    
                }
            }
            
        }
        if counter == 9 && gameActive{
            
            gameOverLabel.text = "It's a draw"
            
            gameActive = false
            
            gameOverLabel.hidden = false
            
            playAgainButton.hidden = false
            
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                
                self.gameOverLabel.center = CGPointMake(self.gameOverLabel.center.x + 400, self.gameOverLabel.center.y)
                
                
                self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x + 400, self.playAgainButton.center.y)
            })
            
            
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        gameOverLabel.hidden = true
        
        playAgainButton.hidden = true
        
        gameOverLabel.center = CGPointMake(gameOverLabel.center.x-400, gameOverLabel.center.y)
        
        playAgainButton.center = CGPointMake(playAgainButton.center.x-400, playAgainButton.center.y)
        self.playerOneName.delegate = self
        self.playerTwoName.delegate = self

                
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(textField:UITextField!) -> Bool{
        
        playerOneName.resignFirstResponder()
        
        playerTwoName.resignFirstResponder()
        
        return true
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

