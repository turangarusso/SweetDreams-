//
//  OpenAi.swift
//  AStory
//
//  Created by giovanni russo on 14/02/23.
//

import Foundation
import SwiftUI

final class Network: ObservableObject {
    @Published var users: TranslationResponse
    @Published var key: String = "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"
    @Published var finito: Bool = false
    //@Published var selected : Int = 0
    
    init(users: TranslationResponse){
        self.users = users
    }
    
    func getUsers() {
        guard let url = URL(string: "https://api.openai.com/v1/completions") else { fatalError("Missing URL") }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("Bearer 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", forHTTPHeaderField: "Authorization")
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let requestData = RequestData(model: "text-davinci-003" ,prompt: "Crea una storia per bambini con una morale ed un titolo. Scegli il tema amicizia con protagonista un cavallo chiamato furia e come antagonista holly.",temperature: 1 , max_tokens: 50)
        
        let encoder = JSONEncoder()
        guard let httpBody = try? encoder.encode(requestData) else {
            print("Error encoding JSON data")
            return
        }
        urlRequest.httpBody = httpBody

        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else { return }

                DispatchQueue.main.async {
                    do {
                        let decodedUsers = try JSONDecoder().decode(TranslationResponse.self, from: data)
                        self.users = decodedUsers
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
}

struct RequestData: Codable {
      var model: String
      var prompt: String
      var temperature: Int
      var max_tokens: Int
  }

struct TranslationResponse: Decodable {
    var id: String
    var object: String
    var created: Int
    var model: String
    var choices: [TextCompletionChoice]
// var usage: TextCompletionUsage
    
    var resultText: String {
        choices.map(\.text).joined(separator: "\n")
    }
}

extension TranslationResponse {
    struct TextCompletionChoice: Decodable{
        var text: String
        var index: Int
//        var logprobs: String?
        var finish_reason: String
    }
}




//
//struct TextCompletionUsage: Codable {
//    let prompt_tokens: Int
//    let completion_tokens: Int
//    let total_tokens: Int
//}
