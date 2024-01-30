//
//  QuestionCVC.swift
//  QuizAppHarsh
//
//  Created by My Mac Mini on 30/01/24.
//

import UIKit

class QuestionCVC: UICollectionViewCell {
    
    @IBOutlet weak var tblAnswers: UITableView!
    
    @IBOutlet weak var lblQues: UILabel!
    
    var arrAnswers = [String]()
    
    //var strUserTapped : String?
    
    var currentIndex : String?
    
    var strCorrectAns : String?
    
    //var selectedCheckedIndex : Int?
    //var arrSelectedCheckedIndex = [Int]()
    
    var queModel : QueModel?
    var userSelectedAns : ((String) -> Void)?
    
   
    func configureArray(){
        tblAnswers.delegate = self
        tblAnswers.dataSource = self
        
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

extension QuestionCVC : UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAnswers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AnswersTVC", for: indexPath) as? AnswersTVC else {
            return UITableViewCell()
        }
        cell.lblAnswer.text = ""
        cell.lblAnswer.text = arrAnswers[indexPath.row]
        
        cell.imgSelected.image = UIImage(named: "uncheck")
        //print("**",Constant.shared.dictSelected)
        if indexPath.row == Constant.shared.dictSelected[currentIndex ?? "-1"]{
            cell.imgSelected.image = UIImage(named: "check")
        }else{
            cell.imgSelected.image = UIImage(named: "uncheck")
        }
        
        /*
        if indexPath.row == self.selectedCheckedIndex{
            cell.imgSelected.image = UIImage(named: "check")
        }else{
            cell.imgSelected.image = UIImage(named: "uncheck")
        }
       
        if let tapAns = strUserTapped{
            if tapAns == arrAnswers[indexPath.row]{
                cell.imgSelected.image = UIImage(named: "check")
            }else{
                cell.imgSelected.image = UIImage(named: "uncheck")
            }
        }else{
            cell.imgSelected.image = UIImage(named: "uncheck")
        }*/
         
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("*arrAnswers[indexPath.row]",arrAnswers[indexPath.row])
        //arrSelectedCheckedIndex.append(<#T##newElement: Int##Int#>)
        //self.selectedCheckedIndex = indexPath.row
        
        Constant.shared.dictSelected[currentIndex ?? "-1"] = indexPath.row
        let answer = "ans\(indexPath.row+1)"
        self.userSelectedAns?(answer)
        
        self.tblAnswers.reloadData()
       
    }
    /*
     if self.selectedCheckedIndex == indexPath.row{
         self.selectedCheckedIndex = -1
     }else{
        
     }*/
    
}

