//
//  SectionItem.swift
//  News App
//
//  Created by Matthew Guest on 12/3/20.
//

import Foundation

struct SectionItem: Decodable {
    let id : String?
    let type : String?
    let header : String?
    let items : [Article]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case header = "header"
        case items = "items"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        header = try values.decodeIfPresent(String.self, forKey: .header)
        items = try values.decodeIfPresent([Article].self, forKey: .items)
    }
}
