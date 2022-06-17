//
//  ViewController.swift
//  NewsApp
//
//  Created by Ahmet Hamamcioglu on 14.06.2022.
//

import UIKit
import SafariServices//to present the news asrticles
//Table View
//Custom Cell
//API Caller
//Open the News Story
//Search for the news story

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(NewsTableViewCell.self,
                       forCellReuseIdentifier: NewsTableViewCell.identifier)
        return table
    }()
    private var searchVC = UISearchController(searchResultsController: nil)
    private var viewModels = [NewsTableViewCellViewModel]()
    private var articles = [Article]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        view.addSubview(tableView)
        tableView.delegate = self//conforming to data types in the class section
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
        
        createSearchBar()
        
        
        
        APICaller.shared.getTopStories { [weak self] result in
            switch result{//dolar 0 first arguman demek oluyor ++ imageURL'e empty string verdik
                case .success(let articles):
                    self?.articles = articles
                    self?.viewModels = articles.compactMap({
                        NewsTableViewCellViewModel(
                            title: $0.title,
                            subtitle: $0.description ?? "No Description",
                            imageURL: URL(string: $0.urlToImage ?? "")
                        )
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()//tells it to return itself
                }
                case .failure(let error):
                    print(error)
                
            }
        }
    }
    private func createSearchBar(){
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
    override func viewDidLayoutSubviews() {//to give tableview a frame
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
    //Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else{
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {//deselect checkbox seçimini kaldırmak için
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        
        guard let url = URL(string: article.url ?? "")else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    //search
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else{
            return
        }
        APICaller.shared.search(with: text){ [weak self] result in
            switch result{//dolar 0 first arguman demek oluyor ++ imageURL'e empty string verdik
                case .success(let articles):
                    self?.articles = articles
                    self?.viewModels = articles.compactMap({
                        NewsTableViewCellViewModel(
                            title: $0.title,
                            subtitle: $0.description ?? "No Description",
                            imageURL: URL(string: $0.urlToImage ?? "")
                        )
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()//tells it to return itself
                }
                case .failure(let error):
                    print(error)
                
            }//return için cancellı özelleştir (cancel'a basılıdğında ana sayfaya dönsün)
        }
        print(text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            //get topStories fonkisyonunu çağır
        //APICaller.shared.getTopStories(completion: <#T##(Result<[Article], Error>) -> Void#>)
    }
}

