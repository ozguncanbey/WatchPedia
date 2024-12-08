import SwiftUI

struct MessageBubble: View {
    let message: ChatMessage
    let isCurrentUser: Bool
    
    var body: some View {
        HStack {
            if isCurrentUser {
                Spacer()
                VStack(alignment: .trailing) {
                    HStack {
                        Text("You")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
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
                        .background(message.isAdmin ? Color.yellow.opacity(0.8) : Color.blue.opacity(0.7))
                        .cornerRadius(12)
                        .foregroundColor(message.isAdmin ? .black : .white)
                }
            } else {
                VStack(alignment: .leading) {
                    HStack {
                        Text(message.username)
                            .font(.caption)
                            .foregroundColor(.gray)
                        
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
                        .background(message.isAdmin ? Color.yellow.opacity(0.8) : Color.gray.opacity(0.3))
                        .cornerRadius(12)
                        .foregroundColor(message.isAdmin ? .black : .white)
                }
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}
