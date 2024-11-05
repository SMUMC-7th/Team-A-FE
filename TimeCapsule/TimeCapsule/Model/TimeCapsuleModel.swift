//
//  TimeCapsuleModel.swift
//  TimeCapsule
//
//  Created by 이승준 on 10/31/24.
//

import UIKit

struct TimeCapsuleTemp {
    let title: String
    let days: String
    let isAvailable: Bool
}

class TimeCapsuleModel {
    static let data: [TimeCapsuleTemp] = [
        TimeCapsuleTemp(title: "10년 후 나에게", days: "D-2123",isAvailable: false),
        TimeCapsuleTemp(title: "첫 캡슐", days: "열람 가능", isAvailable: true),
        TimeCapsuleTemp(title: "고등학교 졸업", days: "D-10", isAvailable: false),
        TimeCapsuleTemp(title: "대학교", days: "열람 가능", isAvailable: true),
        TimeCapsuleTemp(title: "찐친들", days: "열람 가능", isAvailable: true),
        TimeCapsuleTemp(title: "2024년의 다짐", days: "D-102", isAvailable: false),
        TimeCapsuleTemp(title: "10년 후 나에게", days: "D-2123",isAvailable: false),
        TimeCapsuleTemp(title: "첫 캡슐", days: "열람 가능", isAvailable: true),
        TimeCapsuleTemp(title: "고등학교 졸업", days: "D-10", isAvailable: false),
        TimeCapsuleTemp(title: "대학교", days: "열람 가능", isAvailable: true),
        TimeCapsuleTemp(title: "찐친들", days: "열람 가능", isAvailable: true),
        TimeCapsuleTemp(title: "2024년의 다짐", days: "D-102", isAvailable: false),
    ]
}

