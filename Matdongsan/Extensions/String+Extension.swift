//
//  String+Extension.swift
//  Matdongsan
//
//  Created by sujeong on 6/8/26.
//

import Foundation

extension String {
    var removingHTMLTags: String {
        replacingOccurrences(
            of: "<[^>]+>",
            with: "",
            options: .regularExpression
        )
    }
}
