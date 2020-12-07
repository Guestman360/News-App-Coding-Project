//
//  Article.swift
//  News App
//
//  Created by Matthew Guest on 12/3/20.
//

import Foundation

struct Article: Decodable {
    let headline : String?
    let tease : String?
    let summary : String?
    let label : String?
    let url : String?

    enum CodingKeys: String, CodingKey {
        case headline = "headline"
        case tease = "tease"
        case summary = "summary"
        case label = "label"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        headline = try values.decodeIfPresent(String.self, forKey: .headline)
        tease = try values.decodeIfPresent(String.self, forKey: .tease)
        summary = try values.decodeIfPresent(String.self, forKey: .summary)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
}
