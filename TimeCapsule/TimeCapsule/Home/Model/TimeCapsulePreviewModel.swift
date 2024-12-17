import UIKit

class TimeCapsulePreviewModel {
    
    static let shared = TimeCapsulePreviewModel()
    
    static var original: [TimeCapsulePreview] = []
    static var filtered: [TimeCapsulePreview] = []
    
    static var selectedTag: UIButton?
    static var selectedStandard: UIButton?
    static var selectedState: UIButton?
    static var cursor: Int = 0
    static var hasNext: Bool = true
    
    init(){}
    
    static func fetchTimeCapsulePreviews(new timeCapsulePreviews: [TimeCapsulePreview]) {
        self.original = combineArrays(self.original, timeCapsulePreviews)
        self.filtered = combineArrays(self.filtered, timeCapsulePreviews)
        self.filter()
    }
    
    static func sortByCreatedDateAsc() {
        self.original.sort{$0.createdDate < $1.createdDate}
        self.filtered.sort{$0.createdDate < $1.createdDate}
        self.filter()
    }
    
    static func sortByCreatedDateDesc() {
        self.original.sort{$0.createdDate > $1.createdDate}
        self.filtered.sort{$0.createdDate > $1.createdDate}
        self.filter()
    }
    
    static func sortByDeadlineAsc() {
        self.original.sort{$0.deadlineDate < $1.deadlineDate}
        self.filtered.sort{$0.deadlineDate < $1.deadlineDate}
        self.filter()
    }
    
    static func sortByDeadlineDesc() {
        self.original.sort{$0.deadlineDate > $1.deadlineDate}
        self.filtered.sort{$0.deadlineDate > $1.deadlineDate}
        self.filter()
    }
    
    static func sortByNameAsc() {
        self.original.sort{$0.title < $1.title}
        self.filtered.sort{$0.title < $1.title}
        self.filter()
    }

    static func sortByNameDesc() {
        self.original.sort{$0.title > $1.title}
        self.filtered.sort{$0.title > $1.title}
        self.filter()
    }

    static func combineArrays(_ leftArray: [TimeCapsulePreview], _ rightArray: [TimeCapsulePreview]) -> [TimeCapsulePreview] {
        var result: [TimeCapsulePreview] = leftArray
        
        for right in rightArray {
            var has = false
            for left in result {
                if (left.id == right.id) {
                    has = true
                    continue
                }
            }
            if !has {
                result.append(right)
            }
        }
        
        return result
    }
    
    static func removeDuplicate() {
        self.original = self.original.removingDuplicates()
        self.filtered = self.filtered.removingDuplicates()
    }
    
    static func filterTag () {
        if let tagButton = selectedTag { // tag 조건이 있는 경우
            let tag = K.String.tags[tagButton.tag]
            TimeCapsulePreviewModel.filtered = TimeCapsulePreviewModel.original
            filtered.removeAll {$0.tagName != tag}
            return
        }
        TimeCapsulePreviewModel.filtered = TimeCapsulePreviewModel.original
        return
    }
    
    static func filterState () {
        if let selectedButton = selectedState { // state 조건이 있는 경우
            if selectedButton.tag == 0 { // Only Closed
                TimeCapsulePreviewModel.filtered.removeAll { $0.isOpened }
            } else {
                TimeCapsulePreviewModel.filtered.removeAll { !$0.isOpened }
            }
        }
        return
    }
    
    static func filter() {
        filterTag()
        filterState()
    }
    
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var seen = Set<Element>()
        return self.filter { seen.insert($0).inserted }
    }
}

enum SortStandard: String {
    case deadline, created
}
