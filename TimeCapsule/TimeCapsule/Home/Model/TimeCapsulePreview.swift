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
    
    func fetchTimeCapsules(token: String, completion: @escaping (Result<[TimeCapsulePreview], Error>) -> Void) {
        let url = "https://api-echo.shop/api/timecapsules"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
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
    
    func deleteTimeCapsule(id: Int, token: String, completion: @escaping (Result<DeleteResponse, Error>) -> Void) {
        let url = "https://api-echo.shop/api/timecapsules/\(id)"
        
        let headers: HTTPHeaders = [
            "accept": "*/*",
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(url, method: .delete, headers: headers)
            .validate()
            .responseDecodable(of: DeleteResponse.self) { response in
                switch response.result {
                case .success(let deleteResponse):
                    completion(.success(deleteResponse))
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

struct DeleteResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: String
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
            let components = calendar.dateComponents([.day], from: Date(), to: deadlineDate)
            
            guard let dDay = components.day else {
                return "날짜 계산 오류"
            }
            
            return dDay+1 > 0 ? "D-\(dDay+1)" : "열람 가능"
        }
    }
    
    var progress: Float {
        get {
            let calendar = Calendar.current
            let totalDays = calendar.dateComponents([.day], from: createdDate, to: deadlineDate)
            let elapsedDays = calendar.dateComponents([.day], from: createdDate, to: Date())
            
            guard let total = totalDays.day, let elapsed = elapsedDays.day else {
                return 0.0
            }
            
            print("total : \(total+1), elapsed : \(elapsed+1)")
            
            return total == 0 ? 1.0 : Float(elapsed+1)/Float(total+1)
        }
    }
    
}
