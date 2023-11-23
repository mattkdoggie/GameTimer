//
//  ViewController.swift
//  Game Timer
//
//  Created by Matthew Kennedy on 23/11/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Button: UIButton!
    @IBOutlet weak var Startup: UIButton!
    @IBOutlet weak var Stop: UIButton!
    @IBOutlet weak var Reset: UIButton!
    @IBOutlet weak var Time1: UILabel!
    @IBOutlet weak var Time2: UILabel!
    @IBOutlet weak var TimeC1: UILabel!
    @IBOutlet weak var TimeC2: UILabel!
    @IBOutlet weak var Turns1: UILabel!
    @IBOutlet weak var Turns2: UILabel!
    @IBOutlet weak var Start: UILabel!
    @IBOutlet weak var TimePerMove1: UILabel!
    @IBOutlet weak var TimePerMove2: UILabel!

    var timer1: Timer?
    var timer2: Timer?
    var seconds1: Int = 0
    var seconds2: Int = 0
    var secondsC1: Int = 0
    var secondsC2: Int = 0
    var player: Int = 1
    var turns: Int = 0
    var run: Bool = true
    var hasStarted: Bool = false
    var randomBool = Bool.random()


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startGame(_ sender: Any) {
        Start.isHidden = true
        if randomBool == true {
            Button.backgroundColor = UIColor.blue
        }
        else {
            Button.backgroundColor = UIColor.red
        }
        if hasStarted == true {
            turns += 1
            start1()
            Startup.isEnabled = false
        }
        hasStarted = true
    }
    
    @IBAction func stopGame(_ sender: Any) {
        if player == 0 {
            if run == true {
                stop2()
                run = false
                Stop.setTitle("Resume", for: .normal)
            }
            else {
                start2()
                run = true
                Stop.setTitle("Pause", for: .normal)
            }
        }
        else {
            if run == true {
                stop1()
                run = false
                Stop.setTitle("Resume", for: .normal)
            }
            else {
                start1()
                run = true
                Stop.setTitle("Pause", for: .normal)
            }
        }
    }
    
    @IBAction func resetGame(_ sender: Any) {
        stop2()
        stop1()
        seconds1 = 0
        seconds2 = 0
        secondsC1 = 0
        secondsC2 = 0
        player = 1
        turns = 0
        run = true
        hasStarted = false
        randomBool = Bool.random()
        Start.isHidden = false
        Startup.isEnabled = true
        update1()
        update2()
        Turns1.text = String((turns)/2)
        Turns2.text = String((turns-1)/2)
        TimePerMove1.text = "0"
        TimePerMove2.text = "0"
    }
    
    @IBAction func startButtonClicked(_ sender: Any) {
        if run == true {
            if player == 0 {
                player = 1
                start1()
                stop2()
                turns += 1
                Turns1.text = String((turns)/2)
                Turns2.text = String((turns-1)/2)
                if Button.backgroundColor == UIColor.blue {
                    Button.backgroundColor = UIColor.red
                }
                else {
                    Button.backgroundColor = UIColor.blue
                }
            } else {
                player = 0
                stop1()
                start2()
                turns += 1
                Turns1.text = String((turns)/2)
                Turns2.text = String((turns-1)/2)
                if Button.backgroundColor == UIColor.blue {
                    Button.backgroundColor = UIColor.red
                }
                else {
                    Button.backgroundColor = UIColor.blue
                }
            }
        }
    }

    func start1() {
        timer1 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update1), userInfo: nil, repeats: true)
    }

    func stop1() {
        timer1?.invalidate()
        timer1 = nil
        secondsC1 = 0
        TimePerMove1.text = String(round((1000*(Double(seconds1)/(Double(turns+1)/2))))/1000)
    }

    @objc func update1() {
        seconds1 += 1
        Time1.text = formattedTime(seconds: seconds1)
        secondsC1 += 1
        TimeC1.text = formattedTime(seconds: secondsC1)
        if turns > 1 {
            TimePerMove1.text = String((round(1000*(Double(seconds1)/(Double(turns+1)/2))))/1000)
        }
    }
    
    func start2() {
        timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update2), userInfo: nil, repeats: true)
    }

    func stop2() {
        timer2?.invalidate()
        timer2 = nil
        secondsC2 = 0
        TimePerMove2.text = String((round(1000*(Double(seconds2)/(Double(turns)/2))))/1000)
    }

    @objc func update2() {
        seconds2 += 1
        Time2.text = formattedTime(seconds: seconds2)
        secondsC2 += 1
        TimeC2.text = formattedTime(seconds: secondsC2)
        TimePerMove2.text = String((round(1000*(Double(seconds2)/(Double(turns)/2))))/1000)
    }

    func formattedTime(seconds: Int) -> String {
        let minutes = (seconds % 3600) / 60
        let seconds = (seconds % 3600) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

