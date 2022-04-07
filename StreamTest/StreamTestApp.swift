//
//  StreamTestApp.swift
//  StreamTest
//
//  Created by Tim Condon on 22/03/2022.
//

import SwiftUI
import StreamChatUI
import StreamChat

/// Leverage https://proxyman.io along with `Atlantis` to capture websocket traffic
//import Atlantis

@main
struct StreamTestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().onAppear() {
                callStream()
            }
        }
    }
}
 
/// for sake of simplicity we are extending ChatClient and add a static var `shared`
extension ChatClient {
    static var shared: ChatClient!
}

func callStream() {
/// Uncomment this line + the import to capture websocket traffic via https://proxyman.io
//    Atlantis.start()

    /// you can grab your API Key from https://getstream.io/dashboard/
    let config = ChatClientConfig(apiKey: .init("uykdzqamca7z"))

    /// user id
    let userID = "tim"

    /// token
    let token = try! Token(rawValue: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoidGltIn0.kKN6tKi0OeLb_yM8yLX9ZcoT02NhPPkNybsPAhrYtek")
    LogConfig.level = .debug
    LogConfig.formatters = [
        PrefixLogFormatter(prefixes: [.info: "ℹ️", .debug: "🛠", .warning: "⚠️", .error: "🚨"])
    ]
    /// create an instance of ChatClient and share it using the singleton
    ChatClient.shared = ChatClient(config: config) { completion in
                /// This closure will be called when the token is expired
                /// You don't need to provide a closure if you're not using expired tokens
                /// You need to fetch a valid token for your Stream user here
                    /// and call the completion closure with the token
                    completion(.success(token))
            }
     
    /// connect the user using a closure function
    ChatClient.shared.connectUser(
        userInfo: .init(id: userID, name: userID),
                token: token
    ) { error in
      if let error = error {
         print("Connection failed with: \(error)")
      } else {
         // User successfully connected
         print("Connected")
      }
    }
    
    /// Step 3: create the ChannelList view controller
    let channelList = DemoChannelList()
    let query = ChannelListQuery(filter: .containMembers(userIds: [userID]))
    channelList.controller = ChatClient.shared.channelListController(query: query)
}

class DemoChannelList: ChatChannelListVC {}
