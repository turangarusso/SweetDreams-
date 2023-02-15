//
//  ContentView.swift
//  AStory
//
//  Created by giovanni russo on 14/02/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var network: Network
    
    var contenitore: TranslationResponse = TranslationResponse(id: "id", object: "object", created: 1, model: "model", choices: [TranslationResponse.TextCompletionChoice(text: "text", index: 0, finish_reason: "finish")])
    
    @State var animazione: Bool = false
    
    var body: some View {
        
        Text("Sweet Story")
            .bold()
            .font(.title)
            .padding(.top)
        
        if animazione {
            
                Home()
                .onChange(of: network.users.id) { newValue in
                    animazione = false
                }
        }else{
            
            VStack {
                
                Text(network.users.resultText)
                
                Button(action: {
                    network.getUsers()
                    animazione = true
                }, label: {
                    Text("Start")})
                
                
            }
            .padding()
            
        }//End else
    }// End Body
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}


//{
//    let body: [String: Any] = ["model": "text-davinci-003" ,"prompt": "Say this is a test","temperature": 1 , "max_tokens": 100]
//    
//    guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else {
//        print("Error encoding JSON data")
//        return
//    }
//
//
//    guard let url = URL(string: "https://api.openai.com/v1/completions") else { fatalError("Missing URL") }
//    
//    var urlRequest = URLRequest(url: url)
//    
//    urlRequest.httpMethod = "POST"
//    
//    urlRequest.addValue("Bearer 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", forHTTPHeaderField: "Authorization")
//    
//    urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//    urlRequest.httpBody = jsonData
//
//
//    
//    let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
//        print("-----> data: \(data)")
//                   print("-----> error: \(error)")
//                   
//                   guard let data = data, error == nil else {
//                       print(error?.localizedDescription ?? "No data")
//                       return
//                   }
//
//                   let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//                   print("-----1> responseJSON: \(responseJSON)")
//                   if let responseJSON = responseJSON as? [String: Any] {
//                   print("-----2> responseJSON: \(responseJSON)")
//                   }
//    }
//    dataTask.resume()
//}
