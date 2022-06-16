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
    
    init(
        title: String,
        subtitle: String,
        imageURL: URL?

    ){//initilizers require a body
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
        //do not need to assign casue it is going to start at nill
    }
}
