import SwiftUI

struct MessageBubble: View {
    let message: ChatMessage
    let isCurrentUser: Bool
    @State private var showTime = false
    
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
                    
                    if showTime {
                        Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                            .font(.caption2)
                            .foregroundColor(.gray)
                            .padding(.leading, 25)
                    }
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
                    
                    if showTime {
                        Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                            .font(.caption2)
                            .foregroundColor(.gray)
                            .padding(.trailing, 25)
                    }
                }
                Spacer()
            }
        }
        .onTapGesture {
            showTime.toggle()
        }
        .padding(.horizontal)
    }
}
