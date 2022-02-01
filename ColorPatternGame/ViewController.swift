//
//  ViewController.swift
//  ColorPatternGame
//
//  Created by Daniel Falkedal on 2022-02-01.
//

import UIKit

class ViewController: UIViewController {
    
    /* Output label */
    @IBOutlet weak var outputLabel: UILabel!
    
    /* ROW 0 */
    @IBOutlet weak var button00: MyUIButton!
    @IBOutlet weak var button01: MyUIButton!
    @IBOutlet weak var button02: MyUIButton!
    @IBOutlet weak var button03: MyUIButton!
    @IBOutlet weak var button04: MyUIButton!
    
    /* ROW 1 */
    @IBOutlet weak var button10: MyUIButton!
    @IBOutlet weak var button11: MyUIButton!
    @IBOutlet weak var button12: MyUIButton!
    @IBOutlet weak var button13: MyUIButton!
    @IBOutlet weak var button14: MyUIButton!
    
    /* ROW 2 */
    @IBOutlet weak var button20: MyUIButton!
    @IBOutlet weak var button21: MyUIButton!
    @IBOutlet weak var button22: MyUIButton!
    @IBOutlet weak var button23: MyUIButton!
    @IBOutlet weak var button24: MyUIButton!
    
    /* ROW 3 */
    @IBOutlet weak var button30: MyUIButton!
    @IBOutlet weak var button31: MyUIButton!
    @IBOutlet weak var button32: MyUIButton!
    @IBOutlet weak var button33: MyUIButton!
    @IBOutlet weak var button34: MyUIButton!
    
    /* ROW 4 */
    @IBOutlet weak var button40: MyUIButton!
    @IBOutlet weak var button41: MyUIButton!
    @IBOutlet weak var button42: MyUIButton!
    @IBOutlet weak var button43: MyUIButton!
    @IBOutlet weak var button44: MyUIButton!
    
    /* 2D ARRAY (BUTTONS) */
    var buttons = [[MyUIButton]]()
    
    let numberOfRows = 5
    let buttonsPerRow = 5
    
    /* Color array */
    var colors = [UIColor]()
    
    var isGameOver = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initColorsArray()
        initButtonsArray()
        
        randomizeSetup()
    }
    
    func initColorsArray() {
        colors = [UIColor]()
        
        colors.append(UIColor.green)
        colors.append(UIColor.red)
        colors.append(UIColor.blue)
        
        //print(colors[0])
    }

    func initButtonsArray() {
        //re-init the array
        buttons = [[MyUIButton]]()
        
        //add all buttons
        
        let row0 = [button00!, button01!, button02!, button03!, button04!]
        let row1 = [button10!, button11!, button12!, button13!, button14!]
        let row2 = [button20!, button21!, button22!, button23!, button24!]
        let row3 = [button30!, button31!, button32!, button33!, button34!]
        let row4 = [button40!, button41!, button42!, button43!, button44!]
        
        buttons.append(row0)
        buttons.append(row1)
        buttons.append(row2)
        buttons.append(row3)
        buttons.append(row4)
        
        if colors.count < 1 {
            return
        }
        
        for y in 0...numberOfRows-1 {
            for x in 0...buttonsPerRow-1 {
                buttons[y][x].y = y
                buttons[y][x].x = x
                buttons[y][x].tintColor = colors[0]
            }
        }
    }
    
    @IBAction func buttonClick(_ sender: MyUIButton) {
        
        if (isGameOver) {
            return
        }
        
        var currentButton = MyUIButton()
        var found = false
        
        for y in 0...numberOfRows-1 {
            for x in 0...buttonsPerRow-1 {
                if buttons[y][x] == sender {
                    currentButton = buttons[y][x]
                    found = true
                }
            }
        }
        
        if !found {
            return
        }
        
        updateButton(button: currentButton)
        
        checkVictory()
        
    }
    
    func updateButton(button currentButton: MyUIButton) {
        
        currentButton.tintColor = UIColor.yellow
        currentButton.incrementColorIndex(max: colors.count-1)
        currentButton.tintColor = colors[currentButton.getColorIndex()]
        
        updateAdjacentButtons(from: currentButton)
    }
    
    func updateAdjacentButtons(from centerButton: MyUIButton) {
        
        let centerY = centerButton.y
        let centerX = centerButton.x
        
        //TOP
        let topY = centerY-1
        let topX = centerX
        if (topY >= 0) {
            let currentButton = buttons[topY][topX]
            currentButton.incrementColorIndex(max: colors.count-1)
            currentButton.tintColor = colors[currentButton.getColorIndex()]
        }
        
        //BOTTOM
        let bottomY = centerY+1
        let bottomX = centerX
        if (bottomY <= numberOfRows-1) {
            let currentButton = buttons[bottomY][bottomX]
            currentButton.incrementColorIndex(max: colors.count-1)
            currentButton.tintColor = colors[currentButton.getColorIndex()]
        }
        
        //LEFT
        let leftY = centerY
        let leftX = centerX-1
        if (leftX >= 0) {
            let currentButton = buttons[leftY][leftX]
            currentButton.incrementColorIndex(max: colors.count-1)
            currentButton.tintColor = colors[currentButton.getColorIndex()]
        }
        
        //RIGHT
        let rightY = centerY
        let rightX = centerX+1
        if (rightX <= buttonsPerRow-1) {
            let currentButton = buttons[rightY][rightX]
            currentButton.incrementColorIndex(max: colors.count-1)
            currentButton.tintColor = colors[currentButton.getColorIndex()]
        }
        
    }
    
    func randomizeSetup() {
        
        let numberOfSimulatedClicks = 14
        
        for _ in 1...numberOfSimulatedClicks {
            let randomY = Int.random(in: 0...numberOfRows-1)
            let randomX = Int.random(in: 0...buttonsPerRow-1)
            
            let currentButton = buttons[randomY][randomX]
            
            let clickRepeats = Int.random(in: 1...2)
            for _ in 1...clickRepeats {
                updateButton(button: currentButton)
            }
            
            //print("y = \(randomY), x = \(randomX)")
        }
        
    }
    
    func checkVictory() {
        let firstButton = buttons[0][0]
        
        for y in 0...numberOfRows-1 {
            for x in 0...buttonsPerRow-1 {
                let otherButton = buttons[y][x]
                if firstButton.getColorIndex() != otherButton.getColorIndex() {
                    return
                }
            }
        }
        
        outputLabel.text = "VICTORY!"
        isGameOver = true
    }
    
}

