//
//  CharactersViewController.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/27/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit

class CharactersViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    var theJobTitle = String()
    var theJobDescription = String()
    var theJobImage = UIImage()
    
    var TotalJobsArray = [CharacterJobInfo]()
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let PoliceImage = UIImage(named: "CharacterPoliceIcon.png")!
        let SurgeonImage = UIImage(named: "CharacterSurgeonIcon.png")!
        let EngImage = UIImage(named: "CharacterEngineerIcon.png")!
        let ConstructionImage = UIImage(named: "CharacterConstructionIcon.png")!
        
        TotalJobsArray.append(CharacterJobInfo(jobtitle: "Police Officer", jobImage: PoliceImage, jobDescription: "Coming Soon"))
        
        TotalJobsArray.append(CharacterJobInfo(jobtitle: "Doctor", jobImage: SurgeonImage, jobDescription: "Coming Soon"))
        
        TotalJobsArray.append(CharacterJobInfo(jobtitle: "Engineer", jobImage: EngImage, jobDescription: "Coming Soon"))
        
        TotalJobsArray.append(CharacterJobInfo(jobtitle: "Construction Worker", jobImage: ConstructionImage, jobDescription: "Coming Soon"))
        
        
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        self.collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return 12
        
        
        return TotalJobsArray.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BasicItemCollectionCell", for: indexPath) as! BasicItemCollectionViewCell
        
        var JobSelected: CharacterJobInfo
        
        JobSelected = TotalJobsArray[indexPath.row]
        
        cell.imageView.image = JobSelected.jobImage
        cell.titleLBL.text = JobSelected.jobtitle
        cell.theButton.tag = indexPath.row
        cell.theButton.addTarget(self, action: #selector(CharactersViewController.JobSelected(_:)), for: UIControl.Event.touchUpInside)
        
        return cell
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Job Selected"
        alertView.message = "Item \(indexPath.row) Selected"
        alertView.delegate = self
        alertView.addButton(withTitle: "OK")
        alertView.show()
        
        
       
       // self.removeFromSuperview()
        
        
        
    }
    
    @objc func JobSelected(_ sender: AnyObject) {
        
        let row = sender.tag
        var JobSelected: CharacterJobInfo
        
        JobSelected = TotalJobsArray[row!]
        
        self.theJobTitle = JobSelected.jobtitle
        self.theJobImage = JobSelected.jobImage
        self.theJobDescription = JobSelected.jobDescription
        
         self.performSegue(withIdentifier: "CharacterInfo", sender: self)
        
        
    }
    
    @IBAction func CloseBTN(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CharacterInfo" {
             if let CharacterStatsViewController = segue.destination as? CharacterStatsViewController {
                
                CharacterStatsViewController.theJobTitle = self.theJobTitle
                CharacterStatsViewController.theJobImage = self.theJobImage
                CharacterStatsViewController.theJobDescription = self.theJobDescription
                
            }
            
        }
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

struct CharacterJobInfo {
    
    var jobtitle: String
    var jobImage: UIImage
    var jobDescription: String
    
}
