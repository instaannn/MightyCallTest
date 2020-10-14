//
//  NetworkService.swift
//  MightyCallTest
//
//  Created by Анна Сычева on 13.10.2020.
//  Copyright © 2020 Анна Сычева. All rights reserved.
//

import Foundation

// MARK: - NetworkService

final class NetworkService: INetworkService {
    
    // MARK: - Public methods
    
    func fetchMainData(complition: @escaping(Result<DetailModel, Error>) -> Void) {
        downloadJson(url: ApiUrl.Url, complition: complition)
    }
    
    // MARK: - Private methods
    
    private func downloadJson(url: String, complition: @escaping(Result<DetailModel, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                complition(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let object = try JSONDecoder().decode(DetailModel.self, from: data)
                complition(.success(object))
            } catch {
                complition(.failure(error))
            }
        }.resume()
    }
    
}
