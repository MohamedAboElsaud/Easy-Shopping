//
//  CountryPickerUI.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 14/02/2025.
//

import CountryPicker
import SwiftUI

struct CountryPickerUI: UIViewControllerRepresentable {
    @Binding var country: Country?
    class Coordinator: NSObject, CountryPickerDelegate {
        var parent: CountryPickerUI

        init(_ parent: CountryPickerUI) {
            self.parent = parent
        }

        func countryPicker(didSelect country: Country) {
            parent.country = country
        }
    }

    func makeUIViewController(context: Context) -> some CountryPickerViewController {
        let countryPicker = CountryPickerViewController()
        countryPicker.selectedCountry = "EG"
        countryPicker.delegate = context.coordinator
        return countryPicker
    }

    func updateUIViewController(_: UIViewControllerType, context _: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
