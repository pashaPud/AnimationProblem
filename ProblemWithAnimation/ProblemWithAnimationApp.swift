
import SwiftUI

@main
struct ProblemWithAnimationApp: App {
    @StateObject private var appCoordinator = AppCoordinator(path: NavigationPath(), currentFlow: .auth)
    var body: some Scene {
        WindowGroup {
            switch appCoordinator.currentFlow {
            case .menu:
                NavigationStack(path: $appCoordinator.path) {
                    appCoordinator.view()
                        .navigationDestination(for: MenuCoordinator.self) { coordinator in
                            coordinator.view()
                        }
                        .overlay(alignment: .bottom) {
                            Button {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    withAnimation {
                                        self.appCoordinator.changeFlow(to: CurrentFlow.random())
                                    }
                                }
                            } label: {
                                Text("RANDOM")
                                    .font(.title)
                            }
                            .padding()
                            .buttonBorderShape(.roundedRectangle)
                        }
                }
                .environmentObject(appCoordinator)
            case .auth:
                NavigationStack(path: $appCoordinator.path) {
                    appCoordinator.view()
                        .navigationDestination(for: AuthenticationCoordinator.self) { coordinator in
                            coordinator.view()
                        }
                        .overlay(alignment: .bottom) {
                            Button {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    withAnimation {
                                        self.appCoordinator.changeFlow(to: CurrentFlow.random())
                                    }
                                }
                            } label: {
                                Text("RANDOM")
                                    .font(.title)
                            }
                            .padding()
                            .buttonBorderShape(.roundedRectangle)
                        }
                }
                .environmentObject(appCoordinator)
            case .editing:
                NavigationStack(path: $appCoordinator.path) {
                    appCoordinator.view()
                        .navigationDestination(for: EditingCoordinator.self) { coordinator in
                            coordinator.view()
                        }
                        .overlay(alignment: .bottom) {
                            Button {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    withAnimation {
                                        self.appCoordinator.changeFlow(to: CurrentFlow.random())
                                    }
                                }
                            } label: {
                                Text("RANDOM")
                                    .font(.title)
                            }
                            .padding()
                            .buttonBorderShape(.roundedRectangle)
                        }
                }
                .environmentObject(appCoordinator)
            }
        }
    }
}

struct MainView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    var body: some View {
        Group {
            switch appCoordinator.currentFlow {
            case .menu:
                MenuCoordinator(page: .menu, navigationPath: $appCoordinator.path, output: .init(goToAuthScreen: {
                    appCoordinator.changeFlow(to: .auth)
                })).view()
            case .auth:
                AuthenticationCoordinator(page: .login, navigationPath: $appCoordinator.path, output: .init(goToMenuScreen: {
                    appCoordinator.changeFlow(to: .menu)
                })).view()
            case .editing:
                EditingCoordinator(page: .editing, navigationPath: $appCoordinator.path, output: .init(goToMenuScreen: {
                    appCoordinator.changeFlow(to: .menu)
                })).view()
            }
        }
    }
}
