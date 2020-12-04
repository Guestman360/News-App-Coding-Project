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
    let sectionItems: [SectionItem]
    
    init(sectionItems: [SectionItem], type: Header) {
        self.sectionItems = sectionItems.filter { $0.type == type.rawValue }
    }
    
    func numberOfSections(section type: Header) -> Int {
        return sectionItems.count
    }
    
    func numberOfRowsForSection(_ sectionIndex: Int) -> Int {
        // Might refactor later
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 3
        }
        return 2
    }
    
    func sectionAtIndex(_ index: Int) -> SectionViewModel {
        return SectionViewModel(sectionItems[index])
    }
}
