//
//  Constants.swift
//  MyChat
//
//  Created by Dwi Bonggo Pribadi on 12/19/19.
//  Copyright © 2019 Dwi Bonggo Pribadi. All rights reserved.
//

import Foundation

struct Constants {
    static let loginSegue = "loginToChattLaunch"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
