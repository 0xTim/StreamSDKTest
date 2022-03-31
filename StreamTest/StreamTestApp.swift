//
//  StreamTestApp.swift
//  StreamTest
//
//  Created by Tim Condon on 22/03/2022.
//

import SwiftUI
import StreamChatUI
import StreamChat

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
 
/// you can grab your API Key from https://getstream.io/dashboard/
let config = ChatClientConfig(apiKey: .init("uykdzqamca7z"))
 
 
let userID = "tim"
 
/// you can generate the token for this user from https://getstream.io/chat/docs/ios-swift/token_generator/?language=swift
let token: Token = "﻿eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoidGltIn0.kKN6tKi0OeLb_yM8yLX9ZcoT02NhPPkNybsPAhrYtek"
 
func callStream() {
    LogConfig.level = .debug
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
                userInfo: .init(id: userID),
                token: token
    ) { error in
      if let error = error {
         print("Connection failed with: \(error)")
      } else {
         // User successfully connected
      }
    }
    
    /// Step 3: create the ChannelList view controller
    let channelList = DemoChannelList()
    let query = ChannelListQuery(filter: .containMembers(userIds: [userID]))
    channelList.controller = ChatClient.shared.channelListController(query: query)
}

class DemoChannelList: ChatChannelListVC {}
