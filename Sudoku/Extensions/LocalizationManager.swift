
import Foundation
import SwiftUI

class LocalizationManager: ObservableObject {
    @Published var language: String = UserDefaults.standard.string(forKey: "language") ?? "en" {
        didSet {
            UserDefaults.standard.set(language, forKey: "language")
        }
    }
}

extension String {
    func localized(for language: String) -> String {
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return self
        }
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}
