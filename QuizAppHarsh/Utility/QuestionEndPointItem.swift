//
//  ProductEndPointItem.swift
//  SwiftApiMVVM
//
//  Created by My Mac Mini  HARSH DARJI on 09/01/24.
//  https://github.com/dev1008iharsh?tab=repositories

import Foundation

enum QuestionEndPointItem {
    case questions // get questions
}

//https://run.mocky.io/v3/8787374e-76f5-4506-bcf1-506720e2e04d
extension QuestionEndPointItem : EndPointType {
    
    var body: Encodable? {
        switch self{
        case .questions :
            return nil
            
        }
    }
    
    var headers: [String : String]? {
        return ApiManager.commanHeaders
    }
    
    var path: String {
        switch self{
        case .questions :
            return "v3/8787374e-76f5-4506-bcf1-506720e2e04d"
            
        }
        
    }
     
    var baseUrl: String {
        
        switch self{
        case .questions :
            return "https://run.mocky.io/"
            
        }
    }
    
    var url: URL? {
        return URL(string: "\(baseUrl)\(path)")
    }
    
    var method: HttpMehtod {
        switch self{
        case .questions :
            return .get
            
        }
        
    }
    
    
}
