//
//  ViewController.swift
//  Tips
//
//  Created by Julian Dong on 2/16/16.
//  Copyright © 2016 Julian Dong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var appDelegate: AppDelegate!
    private var tipPercentages = [0.18,0.20,0.22]
    private var tipPercentageIndex: Int!

    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: LTMorphingLabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var bgImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        billField.text = "\(appDelegate.billAmount!)"
        if billField.text == "0.0" {
            billField.text = ""
        }
        billField.delegate = self
        
        delay(0.5, closure: {
            self.billField.becomeFirstResponder()
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        let themeIndex = NSUserDefaults.standardUserDefaults().objectForKey(kThemeIndex) as! Int
        bgImage.image = UIImage(named: String(format: "bg%d", themeIndex))
        
        let navBackgroundImage:UIImage! = UIImage(named: String(format: "nb%d", themeIndex))
        self.navigationController!.navigationBar.setBackgroundImage(navBackgroundImage , forBarMetrics:.Default)
        tipPercentageIndex = NSUserDefaults.standardUserDefaults().objectForKey(kPercentage) as! Int
        tipPercentageLabel.text = String(format: "%.0f%% tip", tipPercentages[tipPercentageIndex] * 100)
        calculateBillAmount()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        calculateBillAmount()
    }
    
    func calculateBillAmount() {
        
        let tipPercent = tipPercentages[tipPercentageIndex]
        let billAmount = NSString(string: billField.text!).doubleValue
        appDelegate.billAmount = billField.text!
        let tip = billAmount * tipPercent
        let total = billAmount + tip

        if appDelegate.currencySimple! == "đ" {
            tipLabel.text = numberFormat(tip, simple: appDelegate.currencySimple!)
            totalLabel.text = numberFormat(total, simple: appDelegate.currencySimple!)
        }
        else {
            tipLabel.text = String(format: "$%.2f", tip)
            totalLabel.text = String(format: "$%.2f", total)
        }
    }

    @IBAction func onTap(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    func numberFormat(value: Double, simple: String) -> String {
        let numberFormatter:NSNumberFormatter = NSNumberFormatter()
        numberFormatter.currencySymbol = simple
        numberFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        return numberFormatter.stringFromNumber(value)!
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string) as NSString
        if newString.length > 0 {
            let scanner: NSScanner = NSScanner(string:newString as String)
            let isNumeric = scanner.scanDecimal(nil) && scanner.atEnd
            return isNumeric
            
        } else {
            return true
        }
    }
    
}
