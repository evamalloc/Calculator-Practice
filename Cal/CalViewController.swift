//
//  CalViewController.swift
//  Cal
//
//  Created by Yang Tian on 11/3/15.
//  Copyright © 2015 Jiao Chu. All rights reserved.
//

import UIKit

class CalViewController: UIViewController {
    
    @IBOutlet weak var screen: UILabel!
    var userTying: Bool = false
    var cal = CalModel()
    var space = ""
    // convert display string to value and convert value to string to dispaly
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(screen.text!)!.doubleValue
        }
        set {
            screen.text = "\(newValue)"
            userTying = false
        }
    }
    
    @IBAction func number(sender: UIButton) {
        let number = sender.currentTitle!
        if userTying {
            screen.text = screen.text! + number
        } else {
            screen.text = number
            userTying = true
        }
    }
    
    @IBAction func operation(sender: UIButton) {
        if userTying {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = cal.performCal(operation) {
                displayValue = result
                print(displayValue)
            } else {
                displayValue = 0
                print(displayValue)
            }
        }
    }


    @IBAction func enter() {
        userTying = false
        if let result = cal.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
   
    @IBAction func clear() {
        userTying = false
        displayValue = 0
        screen.text = space
        cal.emptyStack()
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        //screen.text = space
//    }
 


}
