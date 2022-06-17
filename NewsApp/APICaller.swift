//
//  APICaller.swift
//  NewsApp
//
//  Created by Ahmet Hamamcioglu on 14.06.2022.
//

import Foundation

final class APICaller{
    static let shared = APICaller()
    
    struct Constants{
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=de20eee328be4c04a1681ad117dc3733")
        static let searchURLString = "https://newsapi.org/v2/everything?sortBy=popularity&apiKey=de20eee328be4c04a1681ad117dc3733&q="
    }
    
    private init (){}
    
    public func getTopStories(completion: @escaping (Result<[Article], Error>) -> Void){
        guard let url = Constants.topHeadlinesURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(.success(result.articles))
                }
                catch{
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    public func search(with query: String, completion: @escaping (Result<[Article], Error>) -> Void){
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else{
            return
        }
        let urltring = Constants.searchURLString + query
        guard let url = URL(string: urltring) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(.success(result.articles))
                }
                catch{
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

