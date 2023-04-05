//
//  APIService.swift
//  OneLabHW3
//
//  Created by Gazinho Dos Santos on 04.04.2023.
//

import UIKit

struct Response: Decodable {
    let data: [ImageURL]
}

struct ImageURL: Decodable {
    let url: String
}

enum APIError: Error {
    case unableToCreateImageURL
    case unableToConvertDataIntoImage
    case unableToCreateURLForURLRequest
}

final class APIService {
    
    let apiKey = "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"
    
    func fetchImageForPrompt(_ prompt: String) async throws -> UIImage {
        let fetchImageURL = "https://api.openai.com/v1/images/generations"
        let urlRequest = try createURLRequestFor(httpMethod: "POST", url: fetchImageURL, prompt: prompt)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        let decoder = JSONDecoder()
        let results = try decoder.decode(Response.self, from: data)
        
        let imageURL = results.data[0].url
        guard let imageURL = URL(string: imageURL) else {
            throw APIError.unableToCreateImageURL
        }
        
        let (imageData, imageResponse) = try await URLSession.shared.data(from: imageURL)
        
        guard let image = UIImage(data: imageData) else {
            throw APIError.unableToConvertDataIntoImage
        }
        
        return image
    }
    
    func createURLRequestFor(httpMethod: String, url: String, prompt: String) throws -> URLRequest {
        guard let url = URL(string: url) else {
            throw APIError.unableToCreateURLForURLRequest
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = httpMethod
        
        urlRequest.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonBody: [String: Any] = [
            "prompt": "\(prompt)",
            "n": 1,
            "size": "1024x1024"
        ]
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: jsonBody)
        
        return urlRequest
    }
}
