import SwiftUI

struct MessageInputField: View {
    @Binding var newMessage: String
    let onSend: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            TextField("Type your message...", text: $newMessage)
                .padding(14)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.systemGray6))
                )
                .overlay(
                    HStack {
                        Spacer()
                        if !newMessage.isEmpty {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 12)
                                .onTapGesture {
                                    newMessage = ""
                                }
                        }
                    }
                )
                .padding(.horizontal, 8)
            
            Button(action: onSend) {
                Image(systemName: "paperplane.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding()
                    .background(Circle().fill(newMessage.isEmpty ? Color.gray : Color.blue))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
            }
            .disabled(newMessage.trimmingCharacters(in: .whitespaces).isEmpty)
        }
        .padding(.horizontal)
        .padding(.vertical, 6)
        .background(Color(.systemBackground))
        .cornerRadius(30)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}
