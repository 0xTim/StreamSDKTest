import StreamChat
import StreamChatSwiftUI
import SwiftUI
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {

    ///  SwiftUI client
    var streamChat: StreamChat?

    /// LLC (Low level client) Chat client
    var chatClient: ChatClient = {
        let config = ChatClientConfig(apiKey: .init("uykdzqamca7z"))
        let client = ChatClient(config: config)
        return client
    }()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {

        streamChat = StreamChat(chatClient: chatClient)

        connectUser()

        return true
    }

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }

    // The `connectUser` function we need to add.
    private func connectUser() {
        // This is a hardcoded token valid on Stream's tutorial environment.
        let token = try! Token(rawValue: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoidGltIn0.kKN6tKi0OeLb_yM8yLX9ZcoT02NhPPkNybsPAhrYtek")

        // Call `connectUser` on our SDK to get started.
        chatClient.connectUser(
                userInfo: .init(id: "tim",
                                name: "Tim Condon",
                                imageURL: nil),
                token: token
        ) { error in
            if let error = error {
                // Some very basic error handling only logging the error.
                log.error("connecting the user failed \(error)")
                return
            }
        }
    }
}
