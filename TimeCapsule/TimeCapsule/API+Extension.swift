//
//  API+Extension.swift
//  TimeCapsule
//
//  Created by 김민지 on 11/7/24.
//

import Alamofire
import Foundation

// APIClient 클래스 정의
class APIClient {
    static let shared = APIClient()         // 앱 어디에서든 접근 가능하도록 설정
    private init() {}
}

extension APIClient {
    
    // Base URL 설정
    private static let baseURL = "https://api-echo.shop/api"

    // MARK: Headers
    // 기본 json형식에 맞는 헤더 생성 함수
    private static func getHeaders(withToken token: String? = nil) -> HTTPHeaders {
        var headers: HTTPHeaders = [
            "accept": "*/*",
            "Content-Type": "application/json"
        ]
        if let token = token {
            headers["Authorization"] = "Bearer \(token)"
        }
        return headers
    }
    
    // multipart/form-data에 맞는 헤더 생성 함수
    private static func getMultipartHeaders(withToken token: String? = nil) -> HTTPHeaders {
        var headers: HTTPHeaders = [
            "accept": "*/*",
            "Content-Type": "multipart/form-data"
        ]
        if let token = token {
            headers["Authorization"] = "Bearer \(token)"
        }
        return headers
    }
    
    // MARK: GET
    // 공통 GET 요청 함수
    static func getRequest<T: Decodable>(endpoint: String, token: String? = nil, completion: @escaping (Result<T, AFError>) -> Void) {
        let url = "\(baseURL)\(endpoint)"
        let headers = getHeaders(withToken: token)
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
    
    // 공통 GET 요청 함수 (parameters 추가)
    static func getRequest<T: Decodable>(endpoint: String, parameters: [String: Any]? = nil, token: String? = nil, completion: @escaping (Result<T, AFError>) -> Void) {
        let url = "\(baseURL)\(endpoint)"
        let headers = getHeaders(withToken: token)
        
        AF.request(url, method: .get, parameters: parameters, headers: headers).responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }

    // MARK: POST
    // 공통 POST 요청 함수
    static func postRequest<T: Decodable, U: Encodable>(endpoint: String, parameters: U, token: String? = nil, completion: @escaping (Result<T, AFError>) -> Void) {
        let url = "\(baseURL)\(endpoint)"
        let headers = getHeaders(withToken: token)
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
    
    // 공통 POST 요청 함수 (parameters가 필요없을 때)
    static func postRequestWithoutParameters<T: Decodable>(endpoint: String, token: String? = nil, completion: @escaping (Result<T, AFError>) -> Void) {
        let url = "\(baseURL)\(endpoint)"
        let headers = getHeaders(withToken: token)
        
        AF.request(url, method: .post, headers: headers).responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
    
    // 이미지 업로드 POST 요청 함수
    static func postImageRequest<T: Decodable>(endpoint: String, imageData: Data, token: String? = nil, completion: @escaping (Result<T, AFError>) -> Void) {
        let url = "\(baseURL)\(endpoint)"
        let headers = getMultipartHeaders(withToken: token)
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "uploadFiles", fileName: "image.jpeg", mimeType: "image/jpeg")
        }, to: url, method: .post, headers: headers)
        .responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
    
    // MARK: PUT
    // PUT 요청 함수
    static func putRequest<T: Decodable, U: Encodable>(endpoint: String, parameters: U, token: String? = nil, completion: @escaping (Result<T, AFError>) -> Void) {
       
        let url = "\(baseURL)\(endpoint)"
        let headers = getHeaders(withToken: token)

        AF.request(url, method: .put, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
    
    // 공통 DELETE 요청 함수
    static func deleteRequest<T: Decodable>(endpoint: String, token: String? = nil, completion: @escaping (Result<T, AFError>) -> Void) {
        let url = "\(baseURL)\(endpoint)"
        let headers = getHeaders(withToken: token)
        
        AF.request(url, method: .delete, headers: headers).responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
    
    // MARK: PATCH
    // 공통 PATCH 요청 함수 (parameters 추가)
    static func patchRequest<T: Decodable, U: Encodable>(endpoint: String, parameters: U, token: String? = nil, completion: @escaping (Result<T, AFError>) -> Void) {
        let url = "\(baseURL)\(endpoint)"
        let headers = getHeaders(withToken: token)
        
        AF.request(url, method: .patch, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
    
    // 공통 PATCH 요청 함수 (parmeters가 필요없을때)
    static func patchRequestWithoutParameters<T: Decodable>(endpoint: String, token: String? = nil, completion: @escaping (Result<T, AFError>) -> Void) {
        let url = "\(baseURL)\(endpoint)"
        let headers = getHeaders(withToken: token)
        
        AF.request(url, method: .patch, headers: headers).responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
}
