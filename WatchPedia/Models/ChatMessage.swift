//
//  ChatMessage.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 7.12.2024.
//

import SwiftUI

struct ChatMessage: Identifiable {
    var id: String
    var username: String
    var message: String
    var isAdmin: Bool
    var senderId: String
    var timestamp: Date
}
