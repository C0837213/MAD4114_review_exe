//
//  ViewController.swift
//  MAD4114_review_exe
//
//  Created by Philip Chau on 16/1/2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lapTime.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = lapTable.dequeueReusableCell(withIdentifier: "lap") as! LapViewCell
        cell.time.text = lapTime[indexPath.row]
        cell.lap.text = "lap \(indexPath.row + 1)"
        return cell
    }
    
    
    var timer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lapTable.delegate = self
        lapTable.dataSource = self
    }
    
    var second:Int = 0
    var minute:Int = 0
    var minSec:Int = 0
    var lapTime = [String]()
    var counting:Bool = false
    
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var secLabel: UILabel!
    @IBOutlet weak var minSecLabel: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var lapBtn: UIButton!
    @IBOutlet weak var lapTable: UITableView!
    
    
    @IBAction @objc func start(_ sender: UIButton) {
        counting = !counting
        if counting {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
            startBtn.setTitle("Stop", for: .normal)
        }else{
            timer.invalidate()
            startBtn.setTitle("Start", for: .normal)
            lapBtn.setTitle("Reset", for: .normal)
        }
    }
    
    @objc func fire () {
        minSec += 1;
        minSecLabel.text = "\(minSec)"
        if minSec == 100 {
            minSec = 0
            second += 1
            minSecLabel.text = "\(minSec)"
            secLabel.text = "\(second)"
            if second == 60 {
                second = 0
                minute += 1
                secLabel.text = "\(second)"
                minLabel.text = "\(minute)"
            }
        }
    }
    
    @IBAction func lap(_ sender: Any) {
        if counting {
            lapTime.append("\(minute):\(second):\(minSec)")
        }else{
            second = 0
            minute = 0
            minSec = 0
            minSecLabel.text = "\(minSec)"
            secLabel.text = "\(second)"
            minLabel.text = "\(minute)"
            lapTime.removeAll()
        }
        lapTable.reloadData()
    }
    
    
}

