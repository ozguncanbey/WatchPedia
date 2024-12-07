import SwiftUI

struct MessageBubble: View {
    let message: ChatMessage
    let isCurrentUser: Bool
    let isAdmin: Bool // Yeni eklenen özellik
    
    var body: some View {
        HStack {
            if isCurrentUser {
                Spacer()
                VStack(alignment: .trailing) {
                    HStack {
                        Text("You")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        if isAdmin {
                            Text("(admin)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Text(message.message)
                        .padding()
                        .background(Color.blue.opacity(0.7))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                }
            } else {
                VStack(alignment: .leading) {
                    HStack {
                        Text(message.username)
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        if isAdmin {
                            Text("(admin)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Text(message.message)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                }
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}
