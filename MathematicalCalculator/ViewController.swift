//
//  ViewController.swift
//  Asmt_1_MathematicalCalculator
//
//  Created by  on 9/15/16.
//  Copyright © 2016 UHCL. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var aConstant: UITextField!
    
    
    @IBOutlet weak var bConstant: UITextField!
    
    
    @IBOutlet weak var cConstant: UITextField!
    

    @IBOutlet weak var dConstant: UITextField!
    
    
    @IBOutlet weak var accuracy: UITextField!
    
    
    @IBOutlet weak var pConstant: UITextField!
    
    
    @IBOutlet weak var qConstant: UITextField!
    
    
    @IBOutlet weak var showArea: UILabel!
    
    @IBOutlet weak var selectedFormula: UISegmentedControl!
    
    
    @IBOutlet weak var nSlider: UISlider!
    
    @IBAction func getFunction(sender: AnyObject) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("first segement clicked")
            cConstant.placeholder = ""
            dConstant.placeholder = ""
            cConstant.userInteractionEnabled = true
            dConstant.userInteractionEnabled = true
        case 1:
            print("second segment clicked")
            cConstant.text = ""
            dConstant.text = ""
            cConstant.placeholder = "No need"
            dConstant.placeholder = "No need"
            cConstant.userInteractionEnabled = false
            dConstant.userInteractionEnabled = false
        case 2:
            print("third segemnet clicked")
            cConstant.text = ""
            cConstant.placeholder = ""
            dConstant.placeholder = "No need"
            cConstant.userInteractionEnabled = true
            dConstant.userInteractionEnabled = false
        default:
            break;
        }  //Switch
        
    }
    
    
    @IBOutlet weak var significantDigit: UISegmentedControl!
    
    // put slider value in following text field
    @IBAction func getSliderVal(sender: AnyObject) {
        
        accuracy.text = String(Int(nSlider.value))
        
    }
    
    //Integrate button action
    @IBAction func calculateArea(sender: AnyObject) {
        
        // after clciking on button, remove cursor and keyboard
        aConstant.resignFirstResponder()
        
        //constants required for calculations, trimmed to remove before and after white spaces
        let startRangeVal = Double(pConstant.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()))
        let endRangeVal = Double(qConstant.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()))
        let accValue = Double(Int(nSlider.value))
        let aVal = Double(aConstant.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()))
        let bVal = Double(bConstant.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()))
        let cVal = Double(cConstant.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()))
        let dVal = Double(dConstant.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()))
        
        //Condition which does not allow nil values of constants
        if startRangeVal != nil && endRangeVal != nil {
            
            //Condition which checks that upper limit is greater than lower limit
            if startRangeVal < endRangeVal{
                
                //Calculate delta value
                let delta = (endRangeVal! - startRangeVal!) / accValue
                
                //Empty arrays
                var allArea = [Double]()
                var rangeVal = [Double]()
                var getAllXVal = [Double]()
                
                //Get all X values incremented by delta and add it to an empty array
                for k in startRangeVal!.stride(through: endRangeVal!, by: delta) {
                    getAllXVal.append(k)
                }
                
                //Group of all X values
                for i in getAllXVal {
                    
                    //Append first X
                    rangeVal.append(i)
                    
                    //Condition to check i an array rangeVal has more than 2 values
                    if rangeVal.count > 2 {
                        //Remove first index value to get only two values at a time
                        rangeVal.removeAtIndex(0)
                        
                    }
                    //Condition which checks that array has only one last most old value and one new value
                    if rangeVal.count == 2 {
                        
                        //Empty array which will collect each area
                        var funcVal = [Double]()
                        
                        //Latest two value array
                        for j in rangeVal {
                            
                            switch selectedFormula.selectedSegmentIndex {
                                
                            case 0:// when selected f(x) = ax^3 + bx^2 + cx + d
                                if aVal != nil && bVal != nil && cVal != nil && dVal != nil {
                                    // f(x) = ax^3 + bx^2 + cx + d
                                    let calCube = (aVal!*(j*j*j))
                                    let calSq = (bVal!*(j*j))
                                    let calRemaining = (cVal!*j) + dVal!
                                    let calFunc = calCube + calSq + calRemaining
                                    
                                    //Add calculated function value to an array
                                    funcVal.append(calFunc)
                                    
                                }else{
                                    showArea.text = ""
                                    let alert = UIAlertController(title: "Alert", message: "Please Enter Valid Numbers", preferredStyle: UIAlertControllerStyle.Alert)
                                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                                    self.presentViewController(alert, animated: true, completion: nil)
                                }
                                
                            case 1:// when selected f(x) = sqrt(ax-b)
                                if aVal != nil && bVal != nil {
                                    // f(x) = sqrt(ax-b)
                                    let cal = Double(((aVal!*j) - bVal!))
                                    let calFunc = sqrt(Double(cal))
                                    
                                    //Add calculated function value to an array
                                    funcVal.append(calFunc)
                                    
                                }else{
                                    showArea.text = ""
                                    let alert = UIAlertController(title: "Alert", message: "Please Enter Valid Numbers", preferredStyle: UIAlertControllerStyle.Alert)
                                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                                    self.presentViewController(alert, animated: true, completion: nil)
                                }
                                
                            case 2://when selected  f(x) = a^2x+bx+c
                                if aVal != nil && bVal != nil && cVal != nil {
                                    // f(x) = a^2x+bx+c
                                    let calFunc = (aVal!*aVal!*j) + (bVal!*j) + cVal!
                                    
                                    //Add calculated function value to an array
                                    funcVal.append(calFunc)
                                    
                                }else{
                                    showArea.text = ""
                                    let alert = UIAlertController(title: "Alert", message: "Please Enter Valid Numbers", preferredStyle: UIAlertControllerStyle.Alert)
                                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                                    self.presentViewController(alert, animated: true, completion: nil)
                                    
                                }
                            default:
                                break;
                            }
                        }
                        
                        //Sum of funcVal array values
                        let sumTwoFuncVal = funcVal.reduce(0, combine: +)
                        
                        //Add final area of each trapezoid
                        allArea.append((sumTwoFuncVal*delta)/2)
                        
                        //Empty the calculated function value array
                        funcVal = [Double]()
                        
                    }
                }
                //Sum of values in an allArea array to have total area
                let totalArea = allArea.reduce(0, combine: +)
                
                //Display final result with significant digits selected
                switch significantDigit.selectedSegmentIndex {
                case 0:
                    showArea.text = "The Value Of Integral Is: \(String(format: "%.1f", totalArea))"
                case 1:
                    showArea.text = "The Value Of Integral Is: \(String(format: "%.2f", totalArea))"
                case 2:
                    showArea.text = "The Value Of Integral Is: \(String(format: "%.3f", totalArea))"
                default:
                    showArea.text = ""
                    break;
                
                }
                
            }
            else{
                showArea.text = ""
                
                //Show alert box when upper limit is less than lower limit
                let alert = UIAlertController(title: "Alert", message: "q value must be greater than p", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
        }
        else{
            showArea.text = ""
            
            //Show alert when text fields are kept nil
            let alert = UIAlertController(title: "Alert", message: "Please Enter Valid Numbers", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }

        
    }
    
    // after hitting "Enter" in text field, keyboard should disappear
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //if textField == self.aConstant {
        //    textField.resignFirstResponder()
        //}
        self.view.endEditing(true)
        return true
    }
    
    // function of view controller which we have overrided
    // After clicking outside of text field, keyboard should disappear
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        aConstant.resignFirstResponder()
        //self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Default accuracy set to be 1
        accuracy.text = "1"
        //Make accuracy field disable
        accuracy.userInteractionEnabled = false
        aConstant.becomeFirstResponder()
        
        //Add delegate to every textfield to remove keyboard on return/enter is hit
        self.aConstant.delegate = self;
        self.bConstant.delegate = self;
        self.cConstant.delegate = self;
        self.dConstant.delegate = self;
        self.pConstant.delegate = self;
        self.qConstant.delegate = self;
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

