//
//  NotificationModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 16/03/2025.
//

import SwiftUI

struct NotificationModel: Identifiable, Equatable {
    var id: Int = 0
    var refId: Int = 0
    var isRead: Int = 0
    var notificationType: Int = 0
    var title: String = ""
    var message: String = ""
    var createdDate: Date = .init()

    init(dict: NSDictionary) {
        id = dict.value(forKey: "notification_id") as? Int ?? 0
        refId = dict.value(forKey: "ref_id") as? Int ?? 0
        isRead = dict.value(forKey: "is_read") as? Int ?? 0
        notificationType = dict.value(forKey: "notification_type") as? Int ?? 0
        title = dict.value(forKey: "title") as? String ?? ""
        message = dict.value(forKey: "message") as? String ?? ""
        createdDate = (dict.value(forKey: "created_date") as? String ?? "").stringDatetoDate() ?? Date()
    }

    static func == (lhs: NotificationModel, rhs: NotificationModel) -> Bool {
        return lhs.id == rhs.id
    }
}
