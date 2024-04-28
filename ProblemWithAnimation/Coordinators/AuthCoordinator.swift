//
//  AuthCoordinator.swift
//  SwiftUINavigation
//
//  Created by Павел on 03.04.2024.
//

import Foundation
import SwiftUI

enum AuthenticationPage {
    case login
}

final class AuthenticationCoordinator: Hashable {
    @Binding var navigationPath: NavigationPath
    
    private var id: UUID
    private var output: Output?
    private var page: AuthenticationPage
    
    struct Output {
        var goToMenuScreen: () -> Void
    }
    
    init(
        page: AuthenticationPage,
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
        case .login:
            loginScreen()
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (
        lhs: AuthenticationCoordinator,
        rhs: AuthenticationCoordinator
    ) -> Bool {
        lhs.id == rhs.id
    }
    
    private func loginScreen() -> some View {
        let loginScreen = LoginScreen()
        return loginScreen
    }
    
    func push<V>(_ value: V) where V : Hashable {
        navigationPath.append(value)
    }
}
