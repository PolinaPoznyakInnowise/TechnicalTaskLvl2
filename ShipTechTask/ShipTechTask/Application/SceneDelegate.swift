import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        self.window = window

        let diContainer = DependencyFactory(window: window)

        let appCoordinator = diContainer.makeAppCoordinator(
            authenticationProvider: diContainer.makeAuthenticationProvider(),
            dataProvider: diContainer.makeDataProvider()
        )

        self.appCoordinator = appCoordinator
        appCoordinator.start()
    }
}
