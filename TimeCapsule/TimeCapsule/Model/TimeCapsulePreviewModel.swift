//
//  TimeCapsulePreviewModel.swift
//  TimeCapsule
//
//  Created by 이승준 on 11/11/24.
//

import UIKit

class TimeCapsulePreviewModel {
    
    static let shared = TimeCapsulePreviewModel()
    static var original: [TimeCapsulePreview] = []
    static var filtered: [TimeCapsulePreview] = []
    
    static var selectedTag: UIButton?
    static var selectedState: UIButton?
    
    init(){}
    
    static func filterTag () {
        if let selectedTag = selectedTag { // 선택된 태그가 있는 경우
            
        }
        // 선택된 태그가 없는 경우, original을 불러옴
        TimeCapsulePreviewModel.filtered = TimeCapsulePreviewModel.original
        return
    }
    
    static func filterState () {
        if let selectedState = selectedState {
            
        }
        // 선택된 태그가 없는 경우
        return
    }
    
    static func filter(){
        filterTag()
        filterState()
    }
    
}
