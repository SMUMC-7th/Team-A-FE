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
        // filter Array 초기화
        filtered = []
        if let selectedTag = selectedTag { // 선택된 태그가 있는 경우
            let selectedTagString = K.String.tags[selectedTag.tag] //
            
            for capsule in original {
                if capsule.tagName == selectedTagString {
                    filtered.append(capsule)
                }
            }
        } else { // 선택된 태그가 없는 경우 (해제된 경우), original을 불러옴
            TimeCapsulePreviewModel.filtered = TimeCapsulePreviewModel.original
        }
        return
    }
    
    static func filterState () { //
        if let selectedState = selectedState { // 선택된 토글이 있는 경우
            switch (selectedState.tag) {
            case CapsuleToggle.opend.rawValue :
                filtered = filtered.filter{ $0.isOpened }
            case CapsuleToggle.closed.rawValue :
                filtered = filtered.filter{ !$0.isOpened }
            default :
                print("deselect")
            }
        }
        // 선택된 태그가 없는 경우
        return
    }
    
    static func filter(){
        filterTag()
        filterState()
    }
    
}
