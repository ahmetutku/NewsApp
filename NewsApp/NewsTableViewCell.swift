//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Ahmet Hamamcioglu on 15.06.2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    var link: ViewController?

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
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .ultraLight)
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
    
    private let starButton: UIButton = {
        let starButton = UIButton()
        starButton.setImage(UIImage(systemName: "heart"),for: .normal)
        starButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        starButton.tintColor = .systemBlue
        starButton.addTarget(self, action: #selector(markAsFavorite), for: .touchUpInside)
        return starButton
    }()
    
    @objc private func markAsFavorite(){
        print("Marking as Favorite")
        link?.methodCalled(cell: self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(newsImageView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(starButton)
        
     
        
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
        
        dateLabel.frame = CGRect(     x: 10,
                                      y: 30,
                                      width: contentView.frame.size.width - 170,
                                      height: contentView.frame.size.height/2)
        
        starButton.frame = CGRect(x: 350, y: 0, width: 50, height: 50)
        
        
    }
    
    //the youtube man said this idk
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsTitleLabel.text = nil
        subtitleLabel.text = nil
        newsImageView.image = nil
        dateLabel.text = nil
        
    }
    
    func configure(with viewModel: NewsTableViewCellViewModel){
        newsTitleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        dateLabel.text = viewModel.publishedAt
        
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
