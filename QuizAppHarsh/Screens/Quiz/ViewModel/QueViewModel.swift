//
//  QueViewModel.swift
//  QuizAppHarsh
//
//  Created by My Mac Mini  HARSH DARJI  on 30/01/24.
//  https://github.com/dev1008iharsh?tab=repositories

import Foundation


final class QueViewModel{
    
    var arrQuestions : [QueModel] = []
    
    var eventHandler : ((_ event : Event) -> Void)?
 
    func fetchQuestionsApi(){
         
        eventHandler?(.loading)

        ApiManager.shared.request(modelType: [QueModel].self, type: QuestionEndPointItem.questions) { [ weak self ] response in
            
            guard let self else { return }
            
            eventHandler?(.stopLoading)
             
            switch response{
            case .success(let quesFromApi):
                
                if Constant.shared.totalQuestionToBeAsked <= quesFromApi.count{
                    self.arrQuestions = quesFromApi[randomPick: Constant.shared.totalQuestionToBeAsked]
                }else{
                    print("not enought element in array to be fetched")
                    self.arrQuestions = []
                }
                
                eventHandler?(.dataLoaded)
                
            case .failure(let error):
                
                print(error)
                eventHandler?(.network(error))
                
            }
        }
    }
}


extension QueViewModel{
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case network(Error?)
    }

}
