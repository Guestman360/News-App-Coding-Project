//
//  NewsData.swift
//  News App
//
//  Created by Matthew Guest on 12/3/20.
//

import Foundation

struct NewsData: Decodable {
    let data : [SectionItem]?

    enum CodingKeys: String, CodingKey {
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([SectionItem].self, forKey: .data)
    }
}
