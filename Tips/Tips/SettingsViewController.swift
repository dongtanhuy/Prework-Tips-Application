//
//  SettingsViewController.swift
//  Tips
//
//  Created by Julian Dong on 2/16/16.
//  Copyright © 2016 Julian Dong. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var percentageControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.clipsToBounds = true
        self.tableView.layer.cornerRadius = 10
        percentageControl.selectedSegmentIndex = NSUserDefaults.standardUserDefaults().objectForKey(kPercentage) as! Int
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectPercentage(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setObject(percentageControl.selectedSegmentIndex, forKey: kPercentage)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SettingsTableViewCell", forIndexPath: indexPath) as! SettingsTableViewCell
        
        cell.imageBG.image = UIImage(named: String(format: "nb%d", indexPath.row))
        
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSUserDefaults.standardUserDefaults().setObject(indexPath.row, forKey: kThemeIndex)
        NSUserDefaults.standardUserDefaults().synchronize()
        self.navigationController?.popViewControllerAnimated(true)
    }
}
