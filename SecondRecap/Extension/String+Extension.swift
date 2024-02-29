//
//  String+Extension.swift
//  SecondRecap
//
//  Created by Greed on 2/29/24.
//

import Foundation

extension String {
    func asAttributedString() -> NSMutableAttributedString? {
            guard let data = self.data(using: .utf8) else {
                return nil
            }

            return try? NSMutableAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil
            )
        }
}
