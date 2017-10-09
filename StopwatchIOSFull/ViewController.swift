//
//  ViewController.swift
//  StopwatchIOSFull
//
//  Created by Jabes Pauya on 10/9/29 H.
//  Copyright © 29 Jabes Pauya. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var laps : [String] = []
    
    var timer = Timer()
    var minutes : Int = 0;
    var seconds : Int = 0;
    var fractions : Int = 0;
    
    var stopWatchString : String = ""
    var startStopWatch : Bool = true
    var addLap : Bool = false
    
    
    @IBOutlet weak var stopWatchlbl: UILabel!
    
    @IBOutlet weak var lapsTblView: UITableView!
    
    @IBOutlet weak var _startBtn: UIButton!
    
    @IBOutlet weak var _lapBtn: UIButton!
    
    @IBAction func _startStopBtn(_ sender: UIButton) {
        
        if startStopWatch == true{
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateStopwatch), userInfo: nil, repeats: true)
            startStopWatch = false
            _startBtn.setTitle(String("Stop"), for: UIControlState.normal)
            _lapBtn.setTitle(String("Lap"), for: UIControlState.normal)
            
            addLap = true
        }else{
            timer.invalidate()
            startStopWatch = true
            _startBtn.setTitle(String("Start"), for: UIControlState.normal)
            _lapBtn.setTitle(String("Reset"), for: UIControlState.normal)
            addLap = false
        }
    }
    
    @IBAction func _timeLapBtn(_ sender: UIButton) {
        
        if addLap == true{
            
            laps.insert(stopWatchString, at: 0)
            lapsTblView.reloadData()
        }else {
            addLap = false
            _lapBtn.setTitle(String("Lap"), for: UIControlState.normal)
             laps.removeAll(keepingCapacity: false)
            lapsTblView.reloadData()
            
            fractions = 0
            minutes = 0
            seconds = 0
            
            stopWatchString = "00.00.00"
            stopWatchlbl.text = String(stopWatchString)
            
           
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        stopWatchlbl.text = String("00:00:00")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    //table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell(style : UITableViewCellStyle.value1, reuseIdentifier : "Cell")
        cell.backgroundColor = self.view.backgroundColor
        cell.textLabel?.text = "Lap \(laps.count - indexPath.row)"
        cell.detailTextLabel?.text = laps[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
   
    
    @objc func updateStopwatch(){
        fractions += 1
        if fractions == 100{
            seconds += 1
            fractions = 0
        }
        
        if seconds == 60 {
            minutes += 1
            seconds = 0
        }
        
        let fractionsString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        stopWatchString = "\(minutesString):\(secondsString): \(fractionsString)"
        stopWatchlbl.text = String(stopWatchString)
    }


}

