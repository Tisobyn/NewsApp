//
//  HomeViewModel.swift
//  NewsApp
//
//  Created by Yermek Sabyrzhan on 26.03.2022.
//

import Foundation
import Combine

protocol HomeVMP{
    func getArticles()
}

class HomeViewModel: ObservableObject, HomeVMP {

    private let network: NetworkManager
    private(set) var articles = [Article]()
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var state: ResultState = .loading

    init(network: NetworkManager) {
        self.network = network
        getArticles()
    }

    func getArticles() {
        self.state = .loading
        let cancellable = network
            .request(from: NewsAPI.getArticles, object: NewsResponse.self)
            .sink { result in
                switch result {
                case .finished:
                    self.state = .success(content: self.articles)
                    print(self.articles)
                case .failure(let error):
                    self.state = .failed(error: error)
                }
            } receiveValue: { response in
                self.articles = response.articles
            }

        self.cancellables.insert(cancellable)
    }


}


