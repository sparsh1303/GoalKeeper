//
//  CreateGoalsVC.swift
//  Application
//
//  Created by Himanshu Joshi on 27/05/19.
//  Copyright © 2019 Himanshu Joshi. All rights reserved.
//

import UIKit
import CoreData

class CreateGoalsVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var createGoalBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var goalTextView: UITextView!
    
    var goalType: GoalType = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalBtn.bindToKeyboard()
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
        goalTextView.delegate = self
    }
    
    @IBAction func createBtnPressed(_ sender: UIButton) {
        if goalTextView.text != "" && goalTextView.text != "What is your Goal?" {
            self.save { (complete) in
                if complete {
                    dismiss(animated: true, completion: nil)
                }
            }
        } else {
            alertController()
        }
    }
    
    @IBAction func shortTermBtnPressed(_ sender: UIButton) {
        goalType = .shortTerm
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
    }
    
    @IBAction func longTermBtnPressed(_ sender: UIButton) {
        goalType = .longTerm
        longTermBtn.setSelectedColor()
        shortTermBtn.setDeselectedColor()
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismissDetail()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalTextView.text = ""
        goalTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    
    
    func save(completion: (_ finished: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let goal = Goal(context: managedContext)
        
        goal.goalDescription = goalTextView.text
        goal.goalType = goalType.rawValue
        
        do {
            try managedContext.save()
            completion(true)
            print("Successfully saved data")
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
            completion(false)
        }
    }

    func alertController() {
        let alert = UIAlertController(title: "Could not create Goal", message: "Please write something to create a goal.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true,completion: nil)
    }
    
}
