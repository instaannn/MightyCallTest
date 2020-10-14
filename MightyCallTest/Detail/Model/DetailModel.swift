//
//  DetailModel.swift
//  MightyCallTest
//
//  Created by Анна Сычева on 13.10.2020.
//  Copyright © 2020 Анна Сычева. All rights reserved.
//

// MARK: - DetailModel

struct DetailModel: Decodable {
    let id: String
    let state: String
    let client: Client
    let type: String
    let created: String
    let businessNumber: BusinessNumber
    let origin: String
    let favorite: Bool
    let duration: String
}

// MARK: - BusinessNumber

struct BusinessNumber: Decodable {
    let number: String
    let label: String
}

// MARK: - Client

struct Client: Decodable {
    let address: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case address
        case name = "Name"
    }
}
