//
//  QueViewModel.swift
//  QuizAppHarsh
//
//  Created by My Mac Mini on 30/01/24.
//

import Foundation


final class QueViewModel{
    
    var arrQuestions : [QueModel] = []
    
    var eventHandler : ((_ event : Event) -> Void)?
 
    func fetchQuestions(){
         
        eventHandler?(.loading)

        ApiManager.shared.request(modelType: [QueModel].self, type: QuestionEndPointItem.questions) { [ weak self ] response in
            
            guard let self else { return }
            
            eventHandler?(.stopLoading)
             
            switch response{
            case .success(let quesFromApi):
                
                self.arrQuestions = quesFromApi[randomPick: 10]
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
