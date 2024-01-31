//
//  QuestionCVC.swift
//  QuizAppHarsh
//
//  Created by My Mac Mini  HARSH DARJI on 30/01/24.
//  https://github.com/dev1008iharsh?tab=repositories

import UIKit

class QuestionCVC: UICollectionViewCell {
    //MARK: -  @IBOutlet
    @IBOutlet weak var tblAnswers: UITableView!
    
    @IBOutlet weak var lblQues: UILabel!
    
    
    //MARK: -  Properties
    var arrAnswers = [String]()
  
    var currentIndex : String?
    
    var strCorrectAns : String?
     
    var queModel : QueModel?
    
    var userSelectedAns : ((String) -> Void)?
    
    var dictSelected = [String : Int]()
   
    
    
    func configureArray(){
        tblAnswers.delegate = self
        tblAnswers.dataSource = self
        
        //This is wrong functionality from API because they should give an array of answers.
        
        var arrLocal = [String]()
        
        if let val1 = queModel?.ans1, !(val1.isEmpty){
            arrLocal.append(val1)
        }
        if let val2 = queModel?.ans2, !(val2.isEmpty){
            arrLocal.append(val2)
        }
        if let val3 = queModel?.ans3, !(val3.isEmpty){
            arrLocal.append(val3)
        }
        if let val4 = queModel?.ans4, !(val4.isEmpty){
            arrLocal.append(val4)
        }
        if let val5 = queModel?.ans5, !(val5.isEmpty){
            arrLocal.append(val5)
        }
        
        self.arrAnswers.removeAll()
        self.arrAnswers = arrLocal
        self.tblAnswers.reloadData()
        
    }
    
}


//MARK: -  UITableViewDelegate, UITableViewDataSource
extension QuestionCVC : UITableViewDelegate, UITableViewDataSource {
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAnswers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.shared.CELL_ANSWERS_TVC, for: indexPath) as? AnswersTVC else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.lblAnswer.text = arrAnswers[indexPath.row]
        if indexPath.row == self.dictSelected[currentIndex ?? "-1"]{
            cell.imgSelected.image = UIImage(named: Constant.shared.IMG_CHECKED)
        }else{
            cell.imgSelected.image = UIImage(named: Constant.shared.IMG_UN_CHECKED)
        }
         
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        self.dictSelected[currentIndex ?? "-1"] = indexPath.row
        
        let answer = "ans\(indexPath.row+1)"
        
        self.userSelectedAns?(answer)
        
        self.tblAnswers.reloadData()
       
    }

}

