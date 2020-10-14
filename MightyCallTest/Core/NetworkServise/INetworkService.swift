//
//  INetworkService.swift
//  MightyCallTest
//
//  Created by Анна Сычева on 13.10.2020.
//  Copyright © 2020 Анна Сычева. All rights reserved.
//

import Foundation

// MARK: - INetworkService

protocol INetworkService {
     func fetchMainData(complition: @escaping(Result<DetailModel, Error>) -> Void)
}
