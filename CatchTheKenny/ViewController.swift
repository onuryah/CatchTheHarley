//
//  ViewController.swift
//  CatchTheKenny
//
//  Created by Ceren Çapar on 22.09.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scorLabel: UILabel!
    @IBOutlet weak var bestScorLabel: UILabel!
    @IBOutlet weak var har1: UIImageView!
    @IBOutlet weak var har2: UIImageView!
    @IBOutlet weak var har3: UIImageView!
    @IBOutlet weak var har4: UIImageView!
    @IBOutlet weak var har5: UIImageView!
    @IBOutlet weak var har6: UIImageView!
    @IBOutlet weak var har7: UIImageView!
    @IBOutlet weak var har8: UIImageView!
    @IBOutlet weak var har9: UIImageView!
    var scor = 0
    var timer = Timer()
    var counter = 10
    var harArray = [UIImageView]()
    var hideTimer = Timer()
    var highscore = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storedScore = UserDefaults.standard.object(forKey: "best")
        
        if storedScore == nil {
            highscore = 0
            bestScorLabel.text = "Higest Score: \(highscore)"
        }
        if let newScore = storedScore as? Int{
            highscore = newScore
            bestScorLabel.text = "Higest Score: \(newScore)"
        }
        
        har1.isUserInteractionEnabled = true
        let hareket1 = UITapGestureRecognizer(target: self, action: #selector(clicked))
        har1.addGestureRecognizer(hareket1)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeChange), userInfo: nil, repeats: true)
        
        har2.isUserInteractionEnabled = true
        let hareket2 = UITapGestureRecognizer(target: self, action: #selector(clicked))
        har2.addGestureRecognizer(hareket2)
        
        har3.isUserInteractionEnabled = true
        let hareket3 = UITapGestureRecognizer(target: self, action: #selector(clicked))
        har3.addGestureRecognizer(hareket3)
        
        har4.isUserInteractionEnabled = true
        let hareket4 = UITapGestureRecognizer(target: self, action: #selector(clicked))
        har4.addGestureRecognizer(hareket4)
        
        har5.isUserInteractionEnabled = true
        let hareket5 = UITapGestureRecognizer(target: self, action: #selector(clicked))
        har5.addGestureRecognizer(hareket5)
        
        har6.isUserInteractionEnabled = true
        let hareket6 = UITapGestureRecognizer(target: self, action: #selector(clicked))
        har6.addGestureRecognizer(hareket6)
        
        har7.isUserInteractionEnabled = true
        let hareket7 = UITapGestureRecognizer(target: self, action: #selector(clicked))
        har7.addGestureRecognizer(hareket7)
        
        har8.isUserInteractionEnabled = true
        let hareket8 = UITapGestureRecognizer(target: self, action: #selector(clicked))
        har8.addGestureRecognizer(hareket8)
        
        har9.isUserInteractionEnabled = true
        let hareket9 = UITapGestureRecognizer(target: self, action: #selector(clicked))
        har9 .addGestureRecognizer(hareket9)
        
        harArray = [har1,har2,har3,har4,har5,har6,har7,har8,har9]
        
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(HideHar), userInfo: nil, repeats: true)
        HideHar()
    }
   @objc func HideHar(){
        for i in harArray{
            i.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(harArray.count-1)))
        harArray[random].isHidden = false
    if counter == 0 {
        hideTimer.invalidate()
        for i in harArray{
            i.isHidden = true
        }
    }
    }
    
    
    
    @objc func clicked() {
        if counter > 0 {
        scor += 1
        scorLabel.text = "\(scor)"
        }
    }
    
    @objc func timeChange() {
        counter -= 1
        timeLabel.text = "Time left: \(counter)"
        
        if counter == 0 {
            timer.invalidate()
            timeLabel.text = "Time is Over!"
            let alert = UIAlertController(title: "Time is Over", message: "Go On or Go Out", preferredStyle: UIAlertController.Style.alert)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.cancel) { UIAlertAction in
//
                self.scor = 0
                self.scorLabel.text = "Scor: \(self.scor)"
                self.counter = 10
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timeChange), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.HideHar), userInfo: nil, repeats: true)
                self.timeLabel.text = "Time Left: \(self.counter)"
                
                
                
            }
            let okButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(replayButton)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
            
            if self.scor > self.highscore {
                self.highscore = self.scor 
                bestScorLabel.text = "Higest Score: \(scor)"
            
            UserDefaults.standard.setValue(self.highscore, forKey: "best")
            }
        }
}
}
