//
//  Users.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 5.12.2024.
//

import SwiftUI

struct Users {
    let username: String
    let email: String
    let password: String
    let isAdmin: Bool
    
    init(username: String, email: String, password: String, isAdmin: Bool) {
        self.username = username
        self.email = email
        self.password = password
        self.isAdmin = isAdmin
    }
}
