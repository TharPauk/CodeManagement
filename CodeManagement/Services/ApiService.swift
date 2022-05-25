//
//  ApiService.swift
//  CodeManagement
//
//  Created by Min Thet Maung on 25/05/2022.
//

import Foundation

class ApiService {
    
    static let shared = ApiService()
    
    private enum HttpMethod: String {
        case Post, Get, Put, Patch, Delete
    }
    
    private init() { }
    
    private func handleResponse<ResponseType: Decodable>(_ data: Data?, responseType: ResponseType.Type, _ error: Error?, completion: @escaping (Result<ResponseType, Error>) -> Void) {
        DispatchQueue.main.async {
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            
            do {
                let responseObject = try JSONDecoder().decode(ResponseType.self, from: data)
                completion(.success(responseObject))
            } catch let err {
                completion(.failure(err))
            }
        }
    }
    
    func get<ResponseType: Decodable>(_ endPoint: EndPoint, _ responseType: ResponseType.Type, _ completion: @escaping (Result<ResponseType, Error>) -> Void) {
        
        guard let url = URL(string: endPoint.stringValue),
              let request = createURLRequest(url: url, method: .Get)
        else { return }
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            self?.handleResponse(data, responseType: responseType, error, completion: completion)
        }.resume()
    }
    
    
    func post<RequestType: Encodable, ResponseType: Decodable>(_ endPoint: EndPoint, _ body: RequestType, _ responseType: ResponseType.Type, _ completion: @escaping (Result<ResponseType, Error>) -> Void) {
        guard let url = URL(string: endPoint.stringValue),
              var request = createURLRequest(url: url, method: .Post)
        else { return }
        do {
            request.httpBody = try JSONEncoder().encode(body)
            
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                self?.handleResponse(data, responseType: responseType, error, completion: completion)
            }.resume()
            
        } catch let err {
            completion(.failure(err))
        }
    }
    
    private func createURLRequest(url: URL, method: HttpMethod) -> URLRequest? {
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue.uppercased()
        request.addValue(ContentType.json.rawValue, forHTTPHeaderField: "Accept")
        request.addValue(ContentType.json.rawValue, forHTTPHeaderField: "Content-Type")
        return request
    }
    
}
