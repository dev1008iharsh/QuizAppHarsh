//
//  Constant.swift
//  SwiftApiMVVM
//
//  Created by My Mac Mini HARSH DARJI on 08/01/24.
//  https://github.com/dev1008iharsh?tab=repositories

import Foundation
 
class Constant{
    static let shared = Constant()
    private init(){}
    
    var totalQuestionToBeAsked = 10
    
    var CELL_QUESTION_CVC = "QuestionCVC"
    var CELL_ANSWERS_TVC = "AnswersTVC"
    
    var IMG_CHECKED = "check"
    var IMG_UN_CHECKED = "uncheck"
    
    var VC_RESULT_VC = "ResultVC"
    var VC_QUESTIONS_VC = "QuestionsVC"
    
    
}
