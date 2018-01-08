//
//  TodayViewController.swift
//  Royal Widget
//
//  Created by Philip Bell on 1/7/18.
//  Copyright © 2018 BetterEveryDay. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var cardioActivityLabel: UILabel!
    
    @IBOutlet weak var pushupDisplay: UILabel!
    @IBOutlet weak var situpDisplay: UILabel!
    @IBOutlet weak var dipDisplay: UILabel!
    @IBOutlet weak var burpeeDisplay: UILabel!
    @IBOutlet weak var cardioDisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateWorkoutCounts()
    }
    
    func updateWorkoutCounts()
    {
        let sharedDefaults = UserDefaults.init(suiteName: "group.com.better.royal")
        if( sharedDefaults?.value(forKey: "pushups") != nil )
        {
            pushupDisplay.text = sharedDefaults?.value(forKey: "pushups") as! String
            situpDisplay.text = sharedDefaults?.value(forKey: "situps") as! String
            dipDisplay.text = sharedDefaults?.value(forKey: "dips") as! String
            burpeeDisplay.text = sharedDefaults?.value(forKey: "burpees") as! String
            cardioDisplay.text = sharedDefaults?.value(forKey: "cardioTime") as! String
            cardioActivityLabel.text = sharedDefaults?.value(forKey: "cardioAction") as! String
        }
        else
        {
            pushupDisplay.text = " "
            situpDisplay.text = " "
            dipDisplay.text = " "
            burpeeDisplay.text = " "
            cardioActivityLabel.text = "Set your"
            cardioDisplay.text = "start date"
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //updatePriceHistoryLineChart()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
