//
//  Api+Cosmetic.swift
//  Amir
//
//  Created by Map04 on 2021-04-15.
//

import Foundation


class CosmeticApi {
    static let shared = CosmeticApi()
    let urlString = "http://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline"
    func fetchRootObject (onCompletion :@escaping ([Cosmetic]) ->()){
        let url  = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { (data , response , error) in
            guard let data  = data  else {
                print(" data was nil")
                return
            }

            guard let jsonRoorObject = try? JSONDecoder().decode(Array<Cosmetic>.self, from: data) else {
                print("couldnt decode Json")
                  return }
            
            onCompletion(jsonRoorObject)
    }
        task.resume()
    }
}

struct Cosmetic : Decodable {
    let name : String?
    let price : String?
    let brand : String?
    let image_link : String?
}

