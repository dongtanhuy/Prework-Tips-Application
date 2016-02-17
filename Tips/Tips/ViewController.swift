//
//  ViewController.swift
//  Tips
//
//  Created by Julian Dong on 2/16/16.
//  Copyright © 2016 Julian Dong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var bgImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
    }
    
    override func viewWillAppear(animated: Bool) {
        let themeIndex = NSUserDefaults.standardUserDefaults().objectForKey(kThemeIndex) as! Int
        bgImage.image = UIImage(named: String(format: "bg%d", themeIndex))
        
        let navBackgroundImage:UIImage! = UIImage(named: String(format: "nb%d", themeIndex))
        self.navigationController!.navigationBar.setBackgroundImage(navBackgroundImage , forBarMetrics:.Default)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        let tipPercentages = [0.18,0.20,0.22]
        let tipPercent = tipPercentages[tipControl.selectedSegmentIndex]
        let billAmount = NSString(string: billField.text!).doubleValue
        let tip = billAmount * tipPercent
        let total = billAmount + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }

    @IBAction func onTap(sender: AnyObject) {
        self.view.endEditing(true)
    }
}

