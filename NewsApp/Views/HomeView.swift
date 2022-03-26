//
//  HomeView.swift
//  NewsApp
//
//  Created by Yermek Sabyrzhan on 26.03.2022.
//

import SwiftUI
import URLImage

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel(network: NetworkManager())
    @Environment(\.openURL) var openURL

    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .success(let articles):
                NavigationView {
                    List(articles) { article in
                        ArticleView(article: article)
                            .onTapGesture {
                                load(url: article.url)
                            }
                    }
                    .navigationTitle(Text("News"))
                }
            case .failed(let error):
                ErrorView(error: error) {
                    viewModel.getArticles()
                }
            }
        }.onAppear { viewModel.getArticles() }
    }

    func load(url: String?) {
        guard let link = url,
              let url = URL(string: link)
        else {
            return
        }
        openURL(url)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
