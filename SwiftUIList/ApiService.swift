//
//  ApiService.swift
//  SwiftUIList
//
//  Created by Karthi on 25/06/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import UIKit
import SwiftUI

enum JsonError: Error {
    case urlError(reason: String)
    case serializationError(reason: String)
}

struct Todo: Codable, Identifiable {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
    
    enum CodingKeys: CodingKey {
        case userId
        case id
        case title
        case completed
    }
    
}


class ApiService: NSObject {
    
    static func getTodoList<T>(apiRequest: URLRequest?, resultStruct: T.Type?, completion: @escaping((Any?, Error?) -> ())) where T: Decodable {
        guard let apiRequest = apiRequest, let requestUrl = apiRequest.url else {
            completion(nil, JsonError.urlError(reason: "Invalid Url"))
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: requestUrl) { (data, response, error) in
            guard let data = data else {
                completion(nil, JsonError.serializationError(reason: "Error in Json response"))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedJson = try decoder.decode(resultStruct!, from: data)
                DispatchQueue.main.async {
                    completion(decodedJson, nil)
                    return
                }
            }
            catch {
                completion(nil, JsonError.serializationError(reason: "Invalid Json"))
            }
        }
        dataTask.resume()
    }
    
//    static func toDoListItems() -> [Todo] {
//        var toDo = [Todo]()
//        let url = URL(string: "https://jsonplaceholder.typicode.com/todos")
//        let urlRequest = URLRequest.init(url: url!)
//        ApiService.getTodoList(apiRequest: urlRequest as URLRequest, resultStruct: [Todo].self, completion: { (toDoItems, error) in
//            DispatchQueue.main.async {
//                toDo = toDoItems as! [Todo]
//            }
//        });
//        return toDo
//    }
    
    static func toDoListItems(_ completion: @escaping(([Todo]?) -> ())){
        var toDo = [Todo]()
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos")
        let urlRequest = URLRequest.init(url: url!)
        ApiService.getTodoList(apiRequest: urlRequest as URLRequest, resultStruct: [Todo].self, completion: { (toDoItems, error) in
            DispatchQueue.main.async {
                toDo = toDoItems as! [Todo]
        completion(toDo)
            }
        });
        }
    
}
