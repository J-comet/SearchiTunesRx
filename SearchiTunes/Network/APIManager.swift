//
//  APIManager.swift
//  SearchiTunes
//
//  Created by 장혜성 on 2023/11/06.
//

import Foundation

import RxSwift

enum APIError: Error {
    case invlidURL
    case unknown
    case statusError
}

final class APIManager {
    
    static func fetchData(term: String, limit: String) -> Observable<SearchAppModel> {
        
        return Observable<SearchAppModel>.create { value in
            let urlString = "https://itunes.apple.com/search?term=\(term)&country=KR&media=software&lang=ko_KR&limit=\(limit)"
            guard let url = URL(string: urlString) else {
                value.onError(APIError.invlidURL)
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                print("URLSession Succeed")
                if error != nil {
                    value.onError(APIError.unknown)
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                        value.onError(APIError.statusError)
                        return
                    }
                
                if let data, let appData = try? JSONDecoder().decode(SearchAppModel.self, from: data) {
                    value.onNext(appData)
                }
            }.resume()
            return Disposables.create()
        }
    }
}
