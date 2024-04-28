
import Foundation
import SwiftUI

enum MenuPage {
    case menu
}

final class MenuCoordinator: Hashable {
    @Binding var navigationPath: NavigationPath
    
    private var id: UUID
    private var output: Output?
    private var page: MenuPage
    
    struct Output {
        var goToAuthScreen: () -> Void
    }
    
    init(
        page: MenuPage,
        navigationPath: Binding<NavigationPath>,
        output: Output? = nil
    ) {
        id = UUID()
        self.page = page
        self.output = output
        self._navigationPath = navigationPath
    }
    
    @ViewBuilder
    func view() -> some View {
        switch self.page {
        case .menu:
            menuScreen()
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (
        lhs: MenuCoordinator,
        rhs: MenuCoordinator
    ) -> Bool {
        lhs.id == rhs.id
    }
    
    private func menuScreen() -> some View {
        let menuScreen = MenuScreen()
        return menuScreen
    }
    
    func push<V>(_ value: V) where V : Hashable {
        navigationPath.append(value)
    }
}
