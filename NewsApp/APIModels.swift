//
//  APIModels.swift
//  NewsApp
//
//  Created by Ahmet Hamamcioglu on 15.06.2022.
//

import Foundation

struct APIResponse: Codable {//bunların hepsini API diye bir klasöre koy ve modelleri ayrı koy
    let articles: [Article]
    
}

struct Article: Codable{
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
    let source: Source
    //var favorited: Bool = false
    
}


struct Source: Codable {
    let name: String
}


