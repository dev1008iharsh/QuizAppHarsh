//
//  QueModel.swift
//  QuizAppHarsh
//
//  Created by My Mac Mini on 30/01/24.
//

import Foundation

struct QueModel : Decodable {
    
    let id : String
    let question : String
    let ans1 : String?
    let ans2 : String?
    let ans3 : String?
    let ans4 : String?
    let ans5 : String?
    let correct : String
    var userSelectedAnswer : String?
    //var userTappedAnswer : String?
     
}


