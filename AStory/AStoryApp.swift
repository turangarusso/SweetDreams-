//
//  AStoryApp.swift
//  AStory
//
//  Created by giovanni russo on 14/02/23.
//

import SwiftUI

@main
struct AStoryApp: App {
    
    var contenitore: TranslationResponse = TranslationResponse(id: "id", object: "object", created: 1, model: "model", choices: [TranslationResponse.TextCompletionChoice(text: "text", index: 0, finish_reason: "finish")])
    
    var body: some Scene {
        WindowGroup {
            ContentView(network: Network(users: contenitore))
        }
    }
}
