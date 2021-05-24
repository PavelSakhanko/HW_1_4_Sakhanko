//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by Pavel Sakhanko on 24.05.21.
//

import UIKit
import Social
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController {

    override func isContentValid() -> Bool {
        true
    }

    override func didSelectPost() {
        let attachments = (self.extensionContext?.inputItems.first as? NSExtensionItem)?.attachments ?? []
        let contentType = kUTTypeData as String
        for provider in attachments {
            if provider.hasItemConformingToTypeIdentifier(contentType) {
                provider.loadItem(
                  forTypeIdentifier: contentType,
                  options: nil
                ) { [weak self] (data, error) in
                    if let stringData = data as? String {
                      self?.save(stringData)
                    } else {
                      print(error?.localizedDescription ?? "")
                    }
                }}
        }
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        return []
    }

    private func save(_ stringData: String) {
        let userDefaults = UserDefaults(suiteName: "group.Pavel-Sakhanko.HW_1_4_Sakhanko")
        userDefaults?.set(stringData, forKey: "text")
        userDefaults?.synchronize()
    }
}
