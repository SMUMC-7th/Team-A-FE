//
//  TimeCapsulePreview.swift
//  TimeCapsule
//
//  Created by 이승준 on 11/11/24.
//

import Foundation
import Alamofire

let iSOdateFormatter = ISO8601DateFormatter()
let dateFormatter = DateFormatter()

class TimeCapsulePreviewService {
    static let shared = TimeCapsulePreviewService()
    private init() {}
    
    func fetchTimeCapsules(accessToken: String, completion: @escaping (Result<[TimeCapsulePreview], Error>) -> Void) {
        let url = "https://api-echo.shop/api/timecapsules"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        AF.request(url, method: .get, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                if let json = try? JSONDecoder().decode(TimeCapsulePreviewResponse.self, from: data) {
                    completion(.success(json.result))
                    //print(json)
                } else if let token = String(data: data, encoding: .utf8) {
                    print("Received unexpected token: \(token)")
                    // 토큰 갱신 로직 또는 에러 처리
                } else {
                    print("Unexpected response format")
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unexpected response format"])))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


struct TimeCapsulePreviewResponse: Codable {
    let isSuccess: Bool
    let code: String  // 이전에 Int였던 것을 String으로 변경
    let message: String
    let result: [TimeCapsulePreview]
}


struct TimeCapsulePreview: Codable {
    let id: Int
    let userId: Int
    let isOpened: Bool
    let title: String
    let tagName: String
    let createdAt: String
    let now: String
    let deadline: String

    enum CodingKeys: String, CodingKey {
        case id, userId, isOpened, title, tagName, createdAt, now, deadline
    }
    
    func isoToDate(_ dateString: String) -> Date? {
        iSOdateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return dateFormatter.date(from: dateString)
    }
    
    func stringToDate(_ dateString: String) -> Date?{
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSSS"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        return dateFormatter.date(from: dateString)
    }
    
    func parseDeadline(_ dateString: String) -> Date? {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.date(from: dateString)
    }
        
    var createdDate: Date {
        get {
            return self.stringToDate(self.createdAt)!
        }
    }
    
    var nowDate: Date {
        get {
            return Date()
        }
    }
    
    var deadlineDate: Date {
        get {
            return self.parseDeadline(self.deadline) ?? Date()
        }
    }
    
    var d_Day: String {
        get {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.day], from: nowDate, to: deadlineDate)
            
            guard let dDay = components.day else {
                return "날짜 계산 오류"
            }
                        
            return dDay > 0 ? "D-\(dDay)" : "열람 가능"
        }
    }
    
    var progress: Float {
        get {
            // 전체 기간
            // print("created : \(createdDate), dead : \(deadlineDate), now : \(nowDate)")
            let totalDuration = deadlineDate.timeIntervalSince(createdDate)
                    
            // 현재까지 경과한 시간
            let elapsedDuration = nowDate.timeIntervalSince(createdDate)
            
            // 진행률 계산
            let progress: Float = Float(elapsedDuration / totalDuration)
            
            // 0.0에서 1.0 사이의 값으로 제한
            // print("id : \(id), total : \(totalDuration), elapes : \(elapsedDuration), progress : \(progress)")
            return progress > 0 ? progress : 1.0
        }
    }
}
