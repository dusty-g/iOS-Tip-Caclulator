//
//  ViewController.swift
//  tipster
//
//  Created by Dustin Galindo on 5/11/17.
//  Copyright © 2017 Dustin Galindo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var groupSizeLabel: UILabel!
    
    @IBOutlet weak var lowTipLabel: UILabel!
    @IBOutlet weak var mediumTipLabel: UILabel!
    @IBOutlet weak var highTipLabel: UILabel!
    
    @IBOutlet weak var individualTipLow: UILabel!
    @IBOutlet weak var individualTipMedium: UILabel!
    @IBOutlet weak var individualTipHigh: UILabel!
    
    
    @IBOutlet weak var individualTotalLow: UILabel!
    @IBOutlet weak var individualTotalMedium: UILabel!
    @IBOutlet weak var individualTotalHigh: UILabel!
    
    
    var groupSize: Int = 1
    var isDecimal = false
    var dollars: String = ""
    var cents = ""
    var centsFloat: Float = 0.0
    var tipSize: Float = 0.10
    var total: Float = 0.0
    //sender.tag will give the value of they key pressed
    
    @IBAction func keyIsPressed(_ sender: UIButton) {
        if isDecimal {
            if cents.characters.count > 1 {
                
                return
            }
            cents = cents + String(sender.tag)
            if cents.characters.count == 1 {
                centsFloat = Float(cents)! / 10
            }else{
                centsFloat = Float(cents)! / 100
            }
            
            total = total + centsFloat
            totalLabel.text = dollars + "." + cents
            
        }
        else{
            if dollars.characters.count == 0 && sender.tag == 0{
                
                return
            }
            dollars = dollars + String(sender.tag)
            total = Float(dollars)!
            totalLabel.text = dollars
        }
        
        updateValues()
    }
    
    func reset() -> (){
        dollars = ""
        cents = ""
        total = 0.0
        centsFloat = 0.0
        isDecimal = false
        totalLabel.text = ""
        
        updateValues()
        
        individualTipLow.text = "0.00"
        individualTipMedium.text = "0.00"
        individualTipHigh.text = "0.00"
        
        individualTotalLow.text = "0.00"
        individualTotalMedium.text = "0.00"
        individualTotalHigh.text = "0.00"
        
        
    }
    @IBAction func clearIsPressed(_ sender: UIButton) {
        reset()
    }
    
    @IBAction func decimalIspressed(_ sender: UIButton) {
        if isDecimal{
            return
        }
        isDecimal = true
        totalLabel.text = dollars + "."
    }
    @IBAction func groupSizeSlider(_ sender: UISlider) {
        groupSize = Int(ceil(sender.value))
        groupSizeLabel.text = "Group Size: " + String(groupSize)
        updateValues()
    }
    @IBAction func tipSlider(_ sender: UISlider) {
        tipSize = ceil(sender.value * 100)/100
        
        updateValues()
    }
    
    func updateValues(){
        lowTipLabel.text = String(Int(tipSize*100)) + "%"
        mediumTipLabel.text = String(Int(tipSize*100+5)) + "%"
        highTipLabel.text = String(Int(tipSize*100+10)) + "%"
        
        if total != 0 {
            individualTipLow.text = String(format: "%.2f", ceil((total * tipSize)*100)/100)
            individualTipMedium.text = String(format: "%.2f", ceil((total * (tipSize + 0.05))*100)/100)
            individualTipHigh.text = String(format: "%.2f", ceil((total * (tipSize + 0.1))*100)/100)
            
            individualTotalLow.text = String(format: "%.2f", ceil(((total + total * (tipSize)) / Float(groupSize))*100)/100)
            individualTotalMedium.text = String(format: "%.2f", ceil(((total + total * (tipSize + 0.05)) / Float(groupSize))*100)/100)
            individualTotalHigh.text = String(format: "%.2f", ceil(((total + total * (tipSize + 0.1)) / Float(groupSize))*100)/100)
        }
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reset()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

