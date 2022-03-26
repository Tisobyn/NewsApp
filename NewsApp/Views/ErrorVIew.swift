//
//  ErrorVIew.swift
//  NewsApp
//
//  Created by Yermek Sabyrzhan on 26.03.2022.
//

import SwiftUI

struct ErrorVIew: View {
    let error: Error
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.icloud.fill")
                .foregroundColor(.gray)
                .font(.system(size: 50, weight: .heavy))
                .padding(.bottom, 4)
            Text("Ooops")
                .foregroundColor(.black)
                .font(.system(size: 30, weight: .heavy))
                .multilineTextAlignment(.center)
            Text(error.localizedDescription)
                .foregroundColor(.gray)
                .font(.system(size: 15))
                .multilineTextAlignment(.center)
                .padding(.vertical, 4)
            Button {

            } label: {
                Text("Retry")
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 30)
            .background(.blue)
            .foregroundColor(.white)
            .font(.system(size: 15, weight: .heavy))
            .cornerRadius(8)
        }
    }
}

struct ErrorVIew_Previews: PreviewProvider {
    static var previews: some View {
        ErrorVIew(error: APIError.decodingError)
    }
}
