//
//  MatchMateVIew.swift
//  MatchMate
//
//  Created by Shubh Jain on 18/07/25.
//

import SwiftUI

struct MatchMateView: View {
    @StateObject private var viewModel = FindMateViewModel()
    @StateObject private var networkManager = NetworkMonitor()
    @State private var wasDisconnected = false
    var body: some View {
        List {
            ForEach(viewModel.profiles) { profile in
                CardView(user: profile){ action in
                    handleAction(action, for: profile)
                }
            }
        }
        .onChange(of: networkManager.isConnected) { wasConnected, isConnected in
            if isConnected && !wasConnected {
                print(" Connection restored!")
                viewModel.syncDataToServer()
            }
            wasDisconnected = !isConnected
        }

    }

    private func handleAction(_ action: ActionType, for user: UserEntity) {
        switch action {
        case .accept:
            viewModel.accept(user: user)
            viewModel.syncDataToServer()
        case .decline:
            viewModel.reject(user: user)
            viewModel.syncDataToServer()
        }
    }

}
#Preview {
    MatchMateView()
}
