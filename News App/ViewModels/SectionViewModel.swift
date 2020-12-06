//
//  SectionViewModel.swift
//  News App
//
//  Created by Matthew Guest on 12/3/20.
//

import Foundation
import UIKit

struct SectionViewModel {
    private let sectionItem: SectionItem
    private var rowItems: [RowItem]?
    
    var id: String {
        return self.sectionItem.id ?? ""
    }
    
    var type: String {
        return self.sectionItem.type ?? ""
    }
    
    var header: String? {
        return self.sectionItem.header ?? "News"
    }
    
    var items: [Article] {
        return self.sectionItem.items ?? []
    }
    
    var rowsForSection: [RowItem] {
        return self.rowItems ?? []
    }
    
    init(_ sectionItem: SectionItem) {
        self.sectionItem = sectionItem
        self.rowItems = convertArticlesToRowItems()
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsForSection(_ sectionIndex: Int) -> Int {
        return items.count
    }
    
    func articleAtIndex(_ index: Int) -> ArticleViewModel? {
        guard let article = sectionItem.items?[index] else {
            return nil
        }
        return ArticleViewModel(article)
    }
    
    func rowAtIndex(_ index: Int) -> RowItem? {
        let rowItem = rowsForSection[index]
        return rowItem
    }
    
    func convertArticlesToRowItems() -> [RowItem] {
        guard self.items.count > 0 else {
            return []
        }
        
        var rowItems: [RowItem] = []
        let itemsPerRow = UIDevice.isPhone ? 2 : 3
        
        let firstItem = self.items.first!
        let firstRowItem = RowItem(items: [firstItem])
        rowItems.append(firstRowItem)
        
        let groupItems = Array(self.items.dropFirst()).chunked(into: itemsPerRow)
        
        for groups in groupItems {
            let rowItem = RowItem(items: groups)
            rowItems.append(rowItem)
        }
        return rowItems
    }
}
