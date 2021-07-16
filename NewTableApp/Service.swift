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
    
    typealias imagesCallBack = (_ images:[PhotosResult],_ status: Bool, _ messasge:String) -> Void

    // https://www.thecocktaildb.com/api/json/v1/1/search.php?s=rum
    //www.thecocktaildb.com/api/json/v1/1/search.php?i=
    
    init(baseUrl: String){
        self.baseUrl = baseUrl
    }
    
    
    func getAllDrinksList(callBack: @escaping drinksCallBack){
        
        let callBackSelf:drinksCallBack? = callBack
        
        AF.request(self.baseUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).response { (responseData) in

            guard let data = responseData.data else {return}
            do {
                let drinks = try JSONDecoder().decode(DrinksResults.self, from: data)
                callBackSelf?(drinks.drinks, true, "")
            }catch{
                let drinks = [CocktailResults]()
                
                callBackSelf?(drinks, false, error.localizedDescription)
            }
        }
    }
    
    
    func getSearchImages(searchText: String, callBack: @escaping imagesCallBack){
        
        let callBackSelf:imagesCallBack? = callBack

        let headers: HTTPHeaders = ["Authorization": "563492ad6f91700001000001f6f17d55eab6469a919bd2a5f8f299ff"]
        
        let parameters: Parameters = [
            "query": searchText,
            "orientation": "landscape"
            ]
        
        
        AF.request("https://api.pexels.com/v1/search", method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers, interceptor: nil, requestModifier: nil).response { (responseData) in

            guard let data = responseData.data else {return}
            do {
                let images = try JSONDecoder().decode(ApiResponse.self, from: data)
                callBackSelf?(images.photos, true, "")
            }catch{
                let images = [PhotosResult]()
                callBackSelf?(images, false, error.localizedDescription)
            }
        }
    }
    
}
