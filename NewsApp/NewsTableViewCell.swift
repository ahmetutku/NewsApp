//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Ahmet Hamamcioglu on 15.06.2022.
//

import UIKit
/*class NewsTableViewCellViewModel{//class so it can later be altered but you need an initilializer for classes
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
}*/

class NewsTableViewCell: UITableViewCell {

    static let identifier = "NewTableViewCell"
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 0//to line wrap
        //label.sizeToFit()
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(newsImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()//super is used to access superclass' members
        
        newsTitleLabel.frame = CGRect(x: 10,
                                      y: 0,
                                      width: contentView.frame.size.width - 170,
                                      height: 70)//the youtube man said this idk
        
        subtitleLabel.frame = CGRect( x: 10,
                                      y: 70,
                                      width: contentView.frame.size.width - 170,
                                      height: contentView.frame.size.height/2)
        
        newsImageView.frame = CGRect( x: contentView.frame.size.width - 150,
                                      y: 5,
                                      width: 145,
                                      height: contentView.frame.size.height - 10)
    }
    
    //the youtube man said this idk
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsTitleLabel.text = nil
        subtitleLabel.text = nil
        newsImageView.image = nil
    }
    
    func configure(with viewModel: NewsTableViewCellViewModel){
        newsTitleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        
        //Image
        if let data = viewModel.imageData{
            newsImageView.image = UIImage(data: data)
        }
        else if let url = viewModel.imageURL{
            //fetch
            URLSession.shared.dataTask(with: url) {data, _, error in
                guard let data = data, error == nil else{
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
    
}
