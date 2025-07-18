//
//  CardView.swift
//  MatchMate
//
//  Created by Shubh Jain on 18/07/25.
//
import SwiftUI

enum ActionType {
    case accept
    case decline
}

struct CardView: View {
    let user: UserEntity
    var onAction: (ActionType) -> Void

    // Computed property to safely convert status string to enum
    var personStatus: PersonStatus? {
        guard let status = user.status else { return nil }
        return PersonStatus(rawValue: status)
    }

    var body: some View {
        VStack {
            userImageView
            userInfoView
            
            // Debug: show current status string for troubleshooting
            Text("\(user.status ?? "nil")")
                .foregroundColor(.red)
                .font(.caption)
                .padding(.top, 4)
            
            actionButtons
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)))
        )
        .shadow(radius: 5)
    }

    // MARK: - Subviews

    private var userImageView: some View {
        Group {
            if let imageURL = user.image, let url = URL(string: imageURL) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: 200)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: 200)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                .background(Color.black.opacity(0.4))
            }
        }
    }

    private var userInfoView: some View {
        VStack {
            Text("\(user.firstName ?? "") \(user.lastName ?? "")")
                .multilineTextAlignment(.center)
                .font(.headline)
                .padding(.top, 4)

            Text("\(user.city ?? "") \(user.state ?? "") \(user.country ?? "")")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }

    private var actionButtons: some View {
        HStack {
            if personStatus != .rejected {
                acceptButton
            }

            if personStatus != .accepted {
                declineButton
            }
        }
        .padding(.top, 8)
    }

    private var acceptButton: some View {
        Button(action: {
            onAction(.accept)
        }) {
            HStack {
                Image("accept")
                    .foregroundColor(personStatus == .accepted ? .white : .green)
                Text(personStatus == .accepted ? "Accepted" : "Accept")
                    .foregroundColor(personStatus == .accepted ? .white : .green)
            }
            .padding()
            .background(personStatus == .accepted ? Color.green : Color.white)
            .cornerRadius(8)
            .shadow(radius: 1)
        }
        .buttonStyle(PlainButtonStyle())
    }

    private var declineButton: some View {
        Button(action: {
            onAction(.decline)
        }) {
            HStack {
                Image("reject")
                    .foregroundColor(personStatus == .rejected ? .white : .red)
                Text("Reject")
                    .foregroundColor(personStatus == .rejected ? .white : .red)
            }
            .padding()
            .background(personStatus == .rejected ? Color.red : Color.white)
            .cornerRadius(8)
            .shadow(radius: 1)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
