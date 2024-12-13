import SwiftUI

struct MessageBubble: View {
    let message: ChatMessage
    let isCurrentUser: Bool
    let onDeleteMessage: (ChatMessage) -> Void
    
    @State private var showActions = false
    @State private var showTime = false
    @State private var showConfirmationAlert = false
    
    var body: some View {
        VStack(alignment: isCurrentUser ? .trailing : .leading, spacing: 8) {
            HStack {
                if isCurrentUser {
                    Spacer()
                }
                
                VStack(alignment: isCurrentUser ? .trailing : .leading) {
                    HStack {
                        if !isCurrentUser {
                            Text(message.username)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        if message.isAdmin {
                            Image(systemName: "crown.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12, height: 12)
                                .foregroundColor(.yellow)
                        }
                    }
                    
                    Text(message.message)
                        .padding()
                        .background(message.isAdmin ? Color.yellow.opacity(0.8) : isCurrentUser ? Color.blue.opacity(0.7) : Color.gray.opacity(0.3))
                        .cornerRadius(12)
                        .foregroundColor(message.isAdmin ? .black : isCurrentUser ? .white : .white)
                    
                    if showTime {
                        Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                            .font(.caption2)
                            .foregroundColor(.gray)
                            .padding(.top, 4)
                    }
                }
                
                if !isCurrentUser {
                    Spacer()
                }
            }
            
            if showActions {
                HStack {
                    if isCurrentUser {
                        Spacer()
                    }
                    ActionButton(
                        text: "Delete",
                        iconName: "trash",
                        role: .destructive
                    ) {
                        showConfirmationAlert = true
                    }
                    
                    if !isCurrentUser {
                        Spacer()
                    }
                }
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .onTapGesture {
            showTime.toggle()
        }
        .onLongPressGesture {
            guard isCurrentUser else { return }
            withAnimation {
                showActions.toggle()
            }
        }
        .alert("Are you sure you want to delete your message?", isPresented: $showConfirmationAlert) {
            Button("Yes", role: .destructive) {
                onDeleteMessage(message)
            }
            Button("No", role: .cancel) {}
        } message: {
            Text("This action cannot be undone.")
        }
        .padding(.horizontal)
    }
}
