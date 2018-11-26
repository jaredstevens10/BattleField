//
//  CreatePlayerViewController2.swift
//  BattleField
//
//  Created by Jared Stevens2 on 5/4/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

class CreatePlayerViewController2: UIViewController {
    
    @IBOutlet weak var availablePointsView: UIView!
    
    @IBOutlet weak var levelView: UIView!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var progress1: UIProgressView!
    @IBOutlet weak var stepper1: UIStepper!
    
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var progress2: UIProgressView!
    @IBOutlet weak var stepper2: UIStepper!
    
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var progress3: UIProgressView!
    @IBOutlet weak var stepper3: UIStepper!
    
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var progress4: UIProgressView!
    @IBOutlet weak var stepper4: UIStepper!
    
    var stepper1Progress = Double()
    var stepper2Progress = Double()
    var stepper3Progress = Double()
    var stepper4Progress = Double()
    
    var AvailablePoints = Double()
    
    var sender1Temp = Double()
     var sender2Temp = Double()
     var sender3Temp = Double()
     var sender4Temp = Double()
    
    let StartingPoints: Double = 20
    let MaxPoints: Double = 40
    
    @IBOutlet weak var availablePointsLBL: UILabel!
    @IBOutlet weak var AdjustRatingsView: UIView!
     @IBOutlet weak var NextBTN: UIButton!
     let prefs = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.availablePointsView.layer.cornerRadius = 5
        self.levelView.layer.cornerRadius = 5
        
        sender1Temp = 5
        sender2Temp = 5
            sender3Temp = 5
            sender4Temp = 5
        
         self.NextBTN.layer.cornerRadius = 40
         self.progress1.setProgress(0.05, animated: false)
         self.progress2.setProgress(0.05, animated: false)
         self.progress3.setProgress(0.05, animated: false)
         self.progress4.setProgress(0.05, animated: false)
        
        self.label1.text = "5"
        self.label2.text = "5"
        self.label3.text = "5"
        self.label4.text = "5"
        
        if let font = UIFont(name: "Verdana", size: 25.0) {
            self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.white]
        }
        
        // navigationController!.navigationBar.barTintColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0)
        
        navigationController!.navigationBar.barTintColor = UIColor(red: 145/255, green: 38/255, blue: 27/255, alpha: 1.0)
        
        self.AdjustRatingsView.layer.cornerRadius = 5
        self.AdjustRatingsView.layer.borderWidth = 1
        self.AdjustRatingsView.layer.borderColor = UIColor.white.cgColor
        
        
        stepper1.wraps = false
        stepper1.maximumValue = 100
        
        
        AvailablePoints = StartingPoints
        
        
        availablePointsLBL.text = Int(AvailablePoints).description
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func UpdateAvailablePoints(_ Points: Double, stepperName: String, stepperValue: Double) -> Double{
        var TempPoints = Double()
        
        if Points >= MaxPoints {
            AvailablePoints = MaxPoints
            availablePointsLBL.text = Int(AvailablePoints).description
            
            
            print("Final Points Max: \(Points)")
            print("Stepper name: \(stepperValue)")
            print("Stepper Value: \(stepperValue)")
            print("Stepper1 current value: \(stepper1.value)")
            print("Stepper2 current value: \(stepper2.value)")
            print("Stepper3 current value: \(stepper3.value)")
            print("Stepper4 current value: \(stepper4.value)")
            if Points > MaxPoints {
                
                switch stepperName {
                case "stepper1":
                    
                    self.stepper1.value = sender1Temp
                case "stepper2":
                    self.stepper2.value = sender2Temp
                case "stepper3":
                    self.stepper3.value = sender3Temp
                case "stepper4":
                    self.stepper4.value = sender4Temp
                    
                default:
                    break
                    
                }
                
                
            } else {
                
                switch stepperName {
                case "stepper1":
                    self.stepper1.value = stepperValue
                    self.sender1Temp = stepperValue
                case "stepper2":
                    self.stepper2.value = stepperValue
                    self.sender2Temp = stepperValue
                case "stepper3":
                    self.stepper3.value = stepperValue
                    self.sender3Temp = stepperValue
                case "stepper4":
                    self.stepper4.value = stepperValue
                    self.sender4Temp = stepperValue
                    
                default:
                    break
                    
                }
                
            }
            
            
        } else {
            
            if Points <= 0 {
                AvailablePoints = 0
                availablePointsLBL.text = Int(AvailablePoints).description
                
                print("Final Points: \(Points)")
                print("Stepper name: \(stepperValue)")
                print("Stepper Value: \(stepperValue)")
                print("Stepper1 current value: \(stepper1.value)")
                print("Stepper2 current value: \(stepper2.value)")
                print("Stepper3 current value: \(stepper3.value)")
                print("Stepper4 current value: \(stepper4.value)")
                if Points < 0 {
                    
                    switch stepperName {
                    case "stepper1":
                       
                        self.stepper1.value = sender1Temp
                    case "stepper2":
                        self.stepper2.value = sender2Temp
                    case "stepper3":
                        self.stepper3.value = sender3Temp
                    case "stepper4":
                        self.stepper4.value = sender4Temp
                        
                    default:
                        break
                        
                    }
                    
                    
                } else {
                    
                    switch stepperName {
                    case "stepper1":
                        self.stepper1.value = stepperValue
                        self.sender1Temp = stepperValue
                    case "stepper2":
                        self.stepper2.value = stepperValue
                        self.sender2Temp = stepperValue
                    case "stepper3":
                        self.stepper3.value = stepperValue
                        self.sender3Temp = stepperValue
                    case "stepper4":
                        self.stepper4.value = stepperValue
                        self.sender4Temp = stepperValue
                        
                    default:
                        break
                        
                    }
                    
                    
                    
                }
            } else {
                
                AvailablePoints = Points
                availablePointsLBL.text = Int(AvailablePoints).description
                
                switch stepperName {
                case "stepper1":
                    self.stepper1.value = stepperValue
                    self.sender1Temp = stepperValue
                case "stepper2":
                    self.stepper2.value = stepperValue
                    self.sender2Temp = stepperValue
                case "stepper3":
                    self.stepper3.value = stepperValue
                    self.sender3Temp = stepperValue
                case "stepper4":
                    self.stepper4.value = stepperValue
                    self.sender4Temp = stepperValue
                    
                default:
                    break
                    
                }
                
                
            }
            
        }
        
        TempPoints = AvailablePoints
        return TempPoints
        
    }
    
    //STEPPER 1
    @IBAction func stepper1ValueChanged(_ sender: UIStepper) {
        
        
        
        
        self.stepper1Progress = sender.value
        
        
      //  if AvailablePoints > 0 {
        
        print("Sender Value: \(sender.value)")
                print("Avail points: \(AvailablePoints)")
        
        var isHigher = Bool()
        if sender.value > sender1Temp {
            isHigher = true
        } else {
            isHigher = false
        }
       // sender1Temp = sender.value
        print("Step Value: \(sender.stepValue)")
        
       var TempPoints = Double()
        
        if isHigher {
           TempPoints = AvailablePoints - sender.stepValue
            
        } else {
          TempPoints = AvailablePoints + sender.stepValue
        }
        
        
        print("Temp Points: \(TempPoints)")
        let NewPoints = UpdateAvailablePoints(TempPoints, stepperName: "stepper1", stepperValue: sender.value)
        print("New Points: \(NewPoints)")

        if NewPoints >= 0 {
            if NewPoints <= MaxPoints {
            
        self.label1.text = "\(Int(stepper1.value).description)"
        UpdateProgress1(self.stepper1Progress)
                
            }
        }
            
    //  }
    }
    

    func UpdateProgress1(_ NewValue: Double) {
        let newProgress: Float = Float(NewValue / 100)
        self.progress1.setProgress(newProgress, animated: true)
    }
    
    
    //STEPPER 2
    @IBAction func stepper2ValueChanged(_ sender: UIStepper) {
        
        self.stepper2Progress = sender.value
        
        var isHigher = Bool()
        if sender.value > sender2Temp {
            isHigher = true
        } else {
            isHigher = false
        }
      // sender2Temp = sender.value
        
        print("Sender2Temp: \(sender2Temp)")
        print("Sende Value: \(sender.stepValue)")
        
        var TempPoints = Double()
        
        if isHigher {
            TempPoints = AvailablePoints - sender.stepValue
            
        } else {
            if sender2Temp > 0 {
            TempPoints = AvailablePoints + sender.stepValue
            }
            
        }
        
let NewPoints = UpdateAvailablePoints(TempPoints, stepperName: "stepper2", stepperValue: sender.value)
          if NewPoints >= 0 {
             if NewPoints <= MaxPoints {
            self.label2.text = "\(Int(stepper2.value).description)"
        UpdateProgress2(self.stepper2Progress)
            }
        }
    }
    
    
    func UpdateProgress2(_ NewValue: Double) {
        let newProgress: Float = Float(NewValue / 100)
        self.progress2.setProgress(newProgress, animated: true)
    }
    
    //STEPPER 3
    @IBAction func stepper3ValueChanged(_ sender: UIStepper) {
        
        self.stepper3Progress = sender.value
        
        
        var isHigher = Bool()
        if sender.value > sender3Temp {
            isHigher = true
        } else {
            isHigher = false
        }
      //  sender3Temp = sender.value
        print("Sende Value: \(sender.stepValue)")
        
        var TempPoints = Double()
        
        if isHigher {
            TempPoints = AvailablePoints - sender.stepValue
            
        } else {
            TempPoints = AvailablePoints + sender.stepValue
        }
        
let NewPoints = UpdateAvailablePoints(TempPoints, stepperName: "stepper3", stepperValue: sender.value)
        
          if NewPoints >= 0 {
             if NewPoints <= MaxPoints {
            self.label3.text = "\(Int(stepper3.value).description)"
        UpdateProgress3(self.stepper3Progress)
            }
        }
    }
    
    
    func UpdateProgress3(_ NewValue: Double) {
        let newProgress: Float = Float(NewValue / 100)
        self.progress3.setProgress(newProgress, animated: true)
    }
    
    //STEPPER 4
    @IBAction func stepper4ValueChanged(_ sender: UIStepper) {
                self.stepper4Progress = sender.value
        var isHigher = Bool()
        if sender.value > sender4Temp {
            isHigher = true
        } else {
            isHigher = false
        }
     //   sender4Temp = sender.value
        print("Sende Value: \(sender.stepValue)")
        
        var TempPoints = Double()
        
        if isHigher {
            TempPoints = AvailablePoints - sender.stepValue
            
        } else {
            TempPoints = AvailablePoints + sender.stepValue
        }
        
let NewPoints = UpdateAvailablePoints(TempPoints, stepperName: "stepper4", stepperValue: sender.value)
          if NewPoints >= 0 {
             if NewPoints <= MaxPoints {
        self.label4.text = "\(Int(stepper4.value).description)"
        UpdateProgress4(self.stepper4Progress)
            }
        }
    }
    
    
    func UpdateProgress4(_ NewValue: Double) {
        let newProgress: Float = Float(NewValue / 100)
        self.progress4.setProgress(newProgress, animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
