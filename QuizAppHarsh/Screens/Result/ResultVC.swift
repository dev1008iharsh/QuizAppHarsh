//
//  ResultVC.swift
//  QuizAppHarsh
//
//  Created by My Mac Mini on 30/01/24.
//

import UIKit

class ResultVC: UIViewController {
    //MARK: -  @IBOutlet
    @IBOutlet weak var totalAnswer: UILabel!
    @IBOutlet weak var wrongANs: UILabel!
    @IBOutlet weak var rightAns: UILabel!
    
    //MARK: -  Properties
    var counterCorrectAnswer = 0
    var totalQuestions = 0
    var skipedQuestions = 0
    
    //MARK: -  ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print("counterCorrectAnswer",counterCorrectAnswer)
        //print("totalQuestions",totalQuestions)
        
        totalAnswer.text = "TOTAL QUESTIONS : \(totalQuestions)"
        wrongANs.text = "WRONG ANSWER : \(totalQuestions - (counterCorrectAnswer+skipedQuestions)) \n\nSKIPPED QUESTIONS : \(skipedQuestions) "
        rightAns.text = "RIGHT ANSWER : \(counterCorrectAnswer)"
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
 
}
