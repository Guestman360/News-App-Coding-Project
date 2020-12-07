//
//  SectionListViewModel.swift
//  News App
//
//  Created by Matthew Guest on 12/3/20.
//

import Foundation
import UIKit

public enum Header: String, Decodable {
    case section = "Section"
    case hero = "Hero"
    case videos = "Videos"
}

struct SectionListViewModel {
    var sectionItems: [SectionItem]
    var filteredSectionItems: [SectionItem]
    
    init(sectionItems: [SectionItem], type: Header) {
        self.sectionItems = sectionItems.filter { $0.type == type.rawValue }
        self.filteredSectionItems = self.sectionItems
    }
    
    func numberOfSections() -> Int {
        return filteredSectionItems.count
    }
    
    func sectionAtIndex(_ index: Int) -> SectionViewModel {
        return SectionViewModel(filteredSectionItems[index])
    }
    
    func filteredSectionItemsList() -> [SectionItem] {
        return filteredSectionItems
    }
}
