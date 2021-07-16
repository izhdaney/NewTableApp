//
//  Service.swift
//  NewTableApp
//
//  Created by Ilya Zhdaney on 16.07.2021.
//

import Foundation
import Alamofire
 
class Service{
    fileprivate var baseUrl = ""
    
    typealias drinksCallBack = (_ drinks:[CocktailResults],_ status: Bool, _ messasge:String) -> Void
    
    var callBack:drinksCallBack?
    
    // https://www.thecocktaildb.com/api/json/v1/1/search.php?s=rum
    //www.thecocktaildb.com/api/json/v1/1/search.php?i=
    
    init(baseUrl: String){
        self.baseUrl = baseUrl
    }
    
    
    func getAllDrinksList(){
        AF.request(self.baseUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).response { (responseData) in

            guard let data = responseData.data else {return}
            do {
                let drinks = try JSONDecoder().decode(DrinksResults.self, from: data)
                self.callBack?(drinks.drinks, true, "")
            }catch{
                print("Error decoding == \(error)")
                let drinks = [CocktailResults]()
                
                self.callBack?(drinks, false, error.localizedDescription)
            }
        }
    }
    
    func completionHandler(callBack: @escaping drinksCallBack) {
        self.callBack = callBack
    }
    
}
