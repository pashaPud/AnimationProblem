
import SwiftUI
enum CurrentFlow: CaseIterable {
    case menu, auth, editing
    
    static func random<G: RandomNumberGenerator>(using generator: inout G) -> CurrentFlow {
            return CurrentFlow.allCases.randomElement(using: &generator)!
        }
    
        static func random() -> CurrentFlow {
            var g = SystemRandomNumberGenerator()
            return CurrentFlow.random(using: &g)
        }
}
final class AppCoordinator: ObservableObject {
    @Published var path: NavigationPath
    @Published var currentFlow: CurrentFlow
    init(path: NavigationPath, currentFlow: CurrentFlow) {
        self.path = path
        self.currentFlow = currentFlow
    }
    func changeFlow(to flow: CurrentFlow) {
            self.currentFlow = flow
    }
    private func clearNavigationPath() {
        path = NavigationPath()
    }
    
    @ViewBuilder
    func view() -> some View {
        MainView()
    }
}
