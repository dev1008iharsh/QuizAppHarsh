//
//  AnswersTVC.swift
//  QuizAppHarsh
//
//  Created by My Mac Mini HARSH DARJI on 30/01/24.
//  https://github.com/dev1008iharsh?tab=repositories

import UIKit

class AnswersTVC: UITableViewCell {

    @IBOutlet weak var lblAnswer: UILabel!
    
    @IBOutlet weak var imgSelected: UIImageView!
     
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lblAnswer.text = ""
        imgSelected.image = nil
    }
}
