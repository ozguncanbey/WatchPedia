import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct ChatScreen: View {
    @State var contentTitle: String
    @State private var messages: [ChatMessage] = []
    @State private var newMessage: String = ""
    @State private var currentUser: String = ""
    @State private var isAdmin: Bool = false
    
    private let db = Firestore.firestore()
    
    var body: some View {
        NavigationStack {
            VStack {
                MessagesList(messages: messages)
                MessageInputField(
                    newMessage: $newMessage,
                    onSend: sendMessage
                )
            }
            .background(Color.black.ignoresSafeArea())
            .navigationTitle(contentTitle)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: loadChat)
        }
    }
    
    private func loadChat() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        // Fetch current user's data to check if they are admin
        db.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                print("Error fetching user: \(error.localizedDescription)")
                return
            }
            guard let data = snapshot?.data() else { return }
            currentUser = data["username"] as? String ?? "Unknown"
            isAdmin = data["isAdmin"] as? Bool ?? false
        }
        
        // Fetch chat messages
        db.collection("chats")
            .document(contentTitle)
            .collection("messages")
            .order(by: "timestamp", descending: false)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error fetching chat messages: \(error.localizedDescription)")
                    return
                }
                guard let documents = snapshot?.documents else { return }
                messages = documents.map { doc in
                    let data = doc.data()
                    return ChatMessage(
                        id: doc.documentID,
                        username: data["username"] as? String ?? "Unknown",
                        message: data["message"] as? String ?? "",
                        isAdmin: data["isAdmin"] as? Bool ?? false,
                        senderId: data["senderId"] as? String ?? "",
                        timestamp: (data["timestamp"] as? Timestamp)?.dateValue() ?? Date()
                    )
                }
            }
    }
    
    private func sendMessage() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let messageData: [String: Any] = [
            "username": currentUser,
            "message": newMessage,
            "isAdmin": isAdmin,
            "senderId": uid,
            "timestamp": FieldValue.serverTimestamp()
        ]

        db.collection("chats")
            .document(contentTitle)
            .collection("messages")
            .addDocument(data: messageData) { error in
                if let error = error {
                    print("Error sending message: \(error.localizedDescription)")
                } else {
                    newMessage = ""
                }
            }
    }
}

#Preview {
    ChatScreen(contentTitle: "Example Content")
        .preferredColorScheme(.dark)
}
