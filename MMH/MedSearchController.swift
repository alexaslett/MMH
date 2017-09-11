//
//  MedSearchController.swift
//  MMH
//
//  Created by Alex Aslett on 8/29/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import Foundation

class MedSearchController {
    
    static let shared = MedSearchController()
    
    static let baseURL = URL(string: "https://rxnav.nlm.nih.gov/REST/spellingsuggestions.json")
    
    func getMedNames(by searchTerm: String, completion: @escaping([String]?) -> Void){
        
        guard let unwrappedURL = MedSearchController.baseURL else { completion(nil); return }
        
        var components = URLComponents(url: unwrappedURL, resolvingAgainstBaseURL: true)
        let queryItem1 = URLQueryItem.init(name: "name", value: searchTerm)
        components?.queryItems = [queryItem1]
        guard let fullURL = components?.url else { completion(nil); return }
        
        var request = URLRequest(url: fullURL)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Somthing went wrong with that data task \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else { completion(nil); return }
            
            guard let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String:[String:Any]], let suggestionArray = jsonDictionary["suggestionGroup"]?["suggestionList"] as? [String:Any], let suggestion = suggestionArray["suggestion"] as? [String] else { completion(nil); return }
            completion(suggestion)
        }
        dataTask.resume()
        
    }

    
    
}
