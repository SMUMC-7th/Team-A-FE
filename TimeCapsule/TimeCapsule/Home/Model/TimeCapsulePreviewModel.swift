import UIKit

class TimeCapsulePreviewModel {
    
    static let shared = TimeCapsulePreviewModel()
    
    static var original: [TimeCapsulePreview] = []
    
    static var filtered: [TimeCapsulePreview] = []
    
    static var selectedTag: UIButton?
    static var selectedState: UIButton?
    
    init(){}
    
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
    
    static func filter(){
        filterTag()
        filterState()
    }
    
}
