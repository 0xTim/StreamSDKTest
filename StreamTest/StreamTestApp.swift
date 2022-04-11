//
//  StreamTestApp.swift
//  StreamTest
//
//  Created by Tim Condon on 22/03/2022.
//

import SwiftUI
import StreamChatSwiftUI
import StreamChat

@main
struct StreamTestApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ChatChannelListView()
        }
    }
}
