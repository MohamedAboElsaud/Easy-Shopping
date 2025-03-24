//
//  NotificationViewModel.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 16/03/2025.
//

import SwiftUI

class NotificationViewModel: ObservableObject {
    static var shared: NotificationViewModel = .init()

    @Published var showAlert = false
    @Published var alertMessage = ""

    @Published var listArr: [NotificationModel] = []

    init() {
        serviceCallList()
    }

    // MARK: ServiceCall

    func serviceCallList() {
        ServiceCall.post(parameter: [:], path: Globs.SV_NOTIFICATION_LIST, isToken: true) {
            [weak self] response in
            guard let self else {
                return
            }
            switch response {
            case let .success(value):
                if value.value(forKey: Key.status) as? String ?? "" == "1" {
                    self.listArr = (value.value(forKey: Key.payload) as? NSArray ?? []).map { obj in
                        NotificationModel(dict: obj as? NSDictionary ?? [:])
                    }

                } else {
                    self.alertMessage = value.value(forKey: Key.message) as? String ?? "Fail"
                    self.showAlert = true
                }
            case let .failure(error):
                alertMessage = error.localizedDescription
                showAlert = true
            }
        }
    }

    func serviceCallReadAll() {
        ServiceCall.post(parameter: [:], path: Globs.SV_NOTIFICATION_READ_ALL, isToken: true) {
            [weak self] response in
            guard let self else {
                return
            }
            switch response {
            case let .success(value):
                if value.value(forKey: Key.status) as? String ?? "" == "1" {
                    self.serviceCallList()
                } else {
                    self.alertMessage = value.value(forKey: Key.message) as? String ?? "Fail"
                    self.showAlert = true
                }
            case let .failure(error):
                alertMessage = error.localizedDescription
                showAlert = true
            }
        }
    }
}
