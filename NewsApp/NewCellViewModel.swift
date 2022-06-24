//
//  NewCellViewModel.swift
//  NewsApp
//
//  Created by Ahmet Hamamcioglu on 15.06.2022.
//

import Foundation
//import UIKit

class NewsTableViewCellViewModel{//class so it can later be altered but you need an initilializer for classes
    let title: String//bunu al
    let subtitle: String
    let imageURL: URL?
    var imageData: Data? = nil
    let publishedAt: String
    //let isFaved: Bool
    
    
    init(
        title: String,
        subtitle: String,
        imageURL: URL?,
        publishedAt: String
       // isFaved: Bool
      

    ){//initilizers require a body
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
        self.publishedAt = publishedAt
        //self.isFaved = isFaved

    }
}
