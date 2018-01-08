//
//  DataViewController.swift
//  Royal Workout
//
//  Created by Philip Bell on 1/7/18.
//  Copyright © 2018 BetterEveryDay. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var pushupDisplay: UILabel!
    @IBOutlet weak var situpsDisplay: UILabel!
    @IBOutlet weak var dipsDisplay: UILabel!
    @IBOutlet weak var burpeesDisplay: UILabel!
    @IBOutlet weak var cardioDisplay: UILabel!
    @IBOutlet weak var cardioActivityDisplay: UILabel!
    
    let sharedDefaults = UserDefaults(suiteName: "group.com.better.royal")
    
    var dataObject: String = ""
    let pushups = 10
    let situps = 15
    let dips = 10
    let burpees = 10
    let pullups = 3
    let runswim = 15
    let bike = 25
    let addReps = 5
    let addMins = 5
    
    let runDays = [2,5,7]
    let swimDays = [3,6]
    
    var currentPushups = 0
    var currentSitups = 0
    var currentDips = 0
    var currentBurpees = 0
    var currentRunTime = 0
    var currentBikeTime = 0
    
    var startDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        updateCurrentWorkoutCounts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dataLabel!.text = dataObject
        updateCurrentWorkoutCounts()
    }

    func updateCurrentWorkoutCounts()
    {   
        let userCalendar = Calendar.current
        let currentDate = Date()
        let weekday = Calendar.current.component(.weekday, from: currentDate)
        let weeksSince = userCalendar.dateComponents([.weekOfYear], from: startDate, to: currentDate)
        let weekCount = weeksSince.weekOfYear!
        
        if( weekCount > 2 )
        {
            let multiplier = weekCount - 2
            let buffer = addReps*multiplier
            currentPushups = pushups + buffer
            currentSitups = situps + buffer
            currentDips = dips + buffer
            currentBurpees = burpees + buffer
            
            self.pushupDisplay.text = "\(currentPushups)"
            self.situpsDisplay.text = "\(currentSitups)"
            self.dipsDisplay.text = "\(currentDips)"
            self.burpeesDisplay.text = "\(currentBurpees)"
            
            sharedDefaults?.setValue("\(currentPushups)", forKey: "pushups")
            sharedDefaults?.setValue("\(currentSitups)", forKey: "situps")
            sharedDefaults?.setValue("\(currentDips)", forKey: "dips")
            sharedDefaults?.setValue("\(currentBurpees)", forKey: "burpees")
            
            currentRunTime = runswim + addMins*multiplier
            currentBikeTime = bike + addMins*multiplier
            
            
            
            if( runDays.contains(weekday) )
            {
                self.cardioActivityDisplay.text = "Run"
                self.cardioDisplay.text = "\(currentRunTime)"
                
                sharedDefaults?.setValue("Run", forKey: "cardioAction")
                sharedDefaults?.setValue("\(currentRunTime)", forKey: "cardioTime")
            }
            else if( swimDays.contains(weekday) )
            {
                self.cardioActivityDisplay.text = "Bike or Swim"
                self.cardioDisplay.text = "\(currentBikeTime) \\ \(currentRunTime)"
                
                sharedDefaults?.setValue("Bike or Swim", forKey: "cardioAction")
                sharedDefaults?.setValue("\(currentBikeTime) \\ \(currentRunTime)", forKey: "cardioTime")
            }
            else
            {
                self.cardioActivityDisplay.text = "Skip Cardio"
                self.cardioDisplay.text = " "
                
                sharedDefaults?.setValue("Skip Cardio", forKey: "cardioAction")
                sharedDefaults?.setValue(" ", forKey: "cardioTime")
            }
        }
        else
        {
            self.pushupDisplay.text = "\(pushups)"
            self.situpsDisplay.text = "\(situps)"
            self.dipsDisplay.text = "\(dips)"
            self.burpeesDisplay.text = "\(burpees)"
            
            sharedDefaults?.setValue("\(pushups)", forKey: "pushups")
            sharedDefaults?.setValue("\(situps)", forKey: "situps")
            sharedDefaults?.setValue("\(dips)", forKey: "dips")
            sharedDefaults?.setValue("\(burpees)", forKey: "burpees")
            
            if( runDays.contains(weekday) )
            {
                self.cardioActivityDisplay.text = "Run"
                self.cardioDisplay.text = "\(runswim)"
                
                sharedDefaults?.setValue("Run", forKey: "cardioAction")
                sharedDefaults?.setValue("\(runswim)", forKey: "cardioTime")
            }
            else if( swimDays.contains(weekday) )
            {
                self.cardioActivityDisplay.text = "Bike or Swim"
                self.cardioDisplay.text = "\(bike) or \(runswim)"
                
                sharedDefaults?.setValue("Bike or Swim", forKey: "cardioAction")
                sharedDefaults?.setValue("\(bike) or \(runswim)", forKey: "cardioTime")
            }
            else
            {
                self.cardioActivityDisplay.text = "Skip Cardio"
                self.cardioDisplay.text = " "
                
                sharedDefaults?.setValue("Skip Cardio", forKey: "cardioAction")
                sharedDefaults?.setValue(" ", forKey: "cardioTime")
            }
        }
        
    }
    @IBAction func startDateChange(_ sender: Any)
    {
        startDate = startDatePicker.date
        updateCurrentWorkoutCounts()
    }
    
}

