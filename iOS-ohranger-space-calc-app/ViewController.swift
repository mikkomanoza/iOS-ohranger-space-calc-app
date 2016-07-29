 //
//  ViewController.swift
//  iOS-ohranger-space-calc-app
//
//  Created by Joseph Mikko Manoza on 28/07/2016.
//  Copyright © 2016 TeamOhrange. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String { //custom type //the Str type it can be every type i know double bool float etc
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case empty = "empty"
    }
    
    
    
    @IBOutlet weak var outputLabel: UILabel!
    
    //create audio player
    var  btnSound = AVAudioPlayer()
    
    var runningNumbers = "" //it runs empty str
    var leftValString = ""
    var rightValString = ""
    
    var result = ""
    
    
    
    var currentOperation: Operation = Operation.empty //it first run its empty //Operation is custom type enum
    
    
    
    
    //is call whenever the viewLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup player
        //grab things
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        
        
        do{ //do this block of code then if there is a problem go to catch
            try
         
        btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
        
        } catch let err as NSError{ //catch the problem or error
        
            print(err.debugDescription)
        
        }
  
    
        
    }
    
    //number pressed with sounds
    @IBAction func numberPressed(btn: UIButton){
        
        //call playSOund func
        playSounds()
        
        runningNumbers += "\(btn.tag)" //grab the tag of the button and rename it to btn
        outputLabel.text = runningNumbers
        
    }
    
    
    //operation b utton func
    
    @IBAction func onDividePressed(sender: UIButton){
        
        processOperation(Operation.Divide)
    
    }

    @IBAction func onMultiplyPressed(sender: UIButton){
    
        processOperation(Operation.Multiply)
    
    }
    
    @IBAction func onSubtractPressed(sender: UIButton){
    
        processOperation(Operation.Subtract)
    
    }
    
    @IBAction func onAddPressed(sender: UIButton){
    
        processOperation(Operation.Add)
        
    }
    
    
    
    @IBAction func onEqualPressed(sender: UIButton){
    
    
        processOperation(currentOperation)
        
        
    }
    
    
    func processOperation(op: Operation){
        //dont repeat yourself in term of logic create one func to it not to rewrite logic over & over again
        
        //its okay to call function repeatedly
        
        if currentOperation != Operation.empty {
            
            //do some math
            
            //A user selected an operator but then selected another operator without
            //first entering number 
            
            
            if runningNumbers !=  "" {
            
                rightValString = runningNumbers
                runningNumbers = ""
                
                if currentOperation == Operation.Multiply{
                    
                    result = "\(Double(leftValString)! * Double (rightValString)!)" //grabbing String and Converting it to Double
                } else if currentOperation == Operation.Divide{
                    
                    result = "\(Double(leftValString)! / Double (rightValString)!)"
                } else if currentOperation == Operation.Subtract{
                    
                    result = "\(Double(leftValString)! - Double (rightValString)!)"
                } else if currentOperation == Operation.Add{
                    
                    result = "\(Double(leftValString)! + Double (rightValString)!)"
                }
            
            
            
            
            }
            
            
            
            //store number another next operations
            
            leftValString = result
             outputLabel.text = result
            
            currentOperation = op
            
            
            
        } else {
        
            leftValString = runningNumbers
            runningNumbers = ""
            currentOperation = op
            
        
        }
        
    
    }
    
    //func for playSounds
    
    func playSounds(){
        
        if btnSound.playing {
        
            btnSound.stop()
        
        }
        
        btnSound.play()
    
    }
    


}

