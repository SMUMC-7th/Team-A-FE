//
//  SceneDelegate.swift
//  TimeCapsule
//
//  Created by 김민지 on 10/29/24.
//

import UIKit
import KakaoSDKAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene

        window = UIWindow(windowScene: windowScene)          // UIWindow 초기화 및 설정
        
        // Keychain에서 accessToken 가져오기
        if let accessToken = KeychainService.load(for: "RefreshToken"), !accessToken.isEmpty {
            // AccessToken이 유효한 경우
            let homeVC = HomeViewController()
            let navigationController = UINavigationController(rootViewController: homeVC)
            window?.rootViewController = navigationController
        } else {
            // AccessToken이 없거나 빈 값인 경우
            window?.rootViewController = LoginViewController()
        }

        window?.makeKeyAndVisible()
        
    }
    
    // 카카오톡/ 네이버 로그인을 위한 설정
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.#imageLiteral(resourceName: "simulator_screenshot_91C4B62A-3B59-413B-90EE-94F6F2BF4001.png")
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

