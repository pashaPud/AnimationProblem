
import Foundation
import SwiftUI

enum EditingPage {
    case editing
}

final class EditingCoordinator: Hashable {
    @Binding var navigationPath: NavigationPath
    
    private var id: UUID
    private var output: Output?
    private var page: EditingPage
    
    struct Output {
        var goToMenuScreen: () -> Void
    }
    
    init(
        page: EditingPage,
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
        case .editing:
            editingScreen()
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (
        lhs: EditingCoordinator,
        rhs: EditingCoordinator
    ) -> Bool {
        lhs.id == rhs.id
    }
    
    private func editingScreen() -> some View {
        let editingScreen = EditingScreen()
        return editingScreen
    }
    
    func push<V>(_ value: V) where V : Hashable {
        navigationPath.append(value)
    }
}
