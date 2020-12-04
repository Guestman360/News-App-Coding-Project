//
//  SectionViewModel.swift
//  News App
//
//  Created by Matthew Guest on 12/3/20.
//

import Foundation

struct SectionViewModel {
    private let sectionItem : SectionItem
    
    var id : String {
        return self.sectionItem.id ?? ""
    }
    
    var type : String {
        return self.sectionItem.type ?? ""
    }
    
    var header : String? {
        return self.sectionItem.header ?? " "
    }
    
    var items : [Article] {
        return self.sectionItem.items ?? []
    }
    
    init(_ sectionItem : SectionItem) {
        self.sectionItem = sectionItem
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsForSection(_ sectionIndex: Int) -> Int {
        return items.count
    }
    
    func articleAtIndex(_ index : Int) -> ArticleViewModel? {
        guard let article = sectionItem.items?[index] else {
            return nil
        }
        return ArticleViewModel(article)
    }
}
