//
//  AnswersTVC.swift
//  QuizAppHarsh
//
//  Created by My Mac Mini on 30/01/24.
//

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
