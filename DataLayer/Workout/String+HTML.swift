//
//  String+HTML.swift
//  WorkoutBrowser
//
//  Created by Yeongweon Park on 28.01.24.
//

import Foundation
import Down

extension String {
    var asAttributedString: AttributedString {
        if let percentRemoved = removingPercentEncoding, var htmlString = try? Down(markdownString: percentRemoved).toHTML() {
            htmlString = String.htmlTemplate.replacingOccurrences(of: "${html}", with: htmlString)
            if let htmlData = htmlString.data(using: .utf8) {
                let attributedString = try? NSAttributedString(
                    data: htmlData,
                    options: [.documentType: NSAttributedString.DocumentType.html],
                    documentAttributes: nil
                )
                if let attributedString = attributedString {
                    return AttributedString(attributedString)
                }
            }
        }
        return AttributedString(self)
    }
    
    private static let htmlTemplate = """
        <!doctype html>
        <html>
          <head>
            <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
            <style>
              body {
                font-family: TT Norms Pro;
                font-size: 16px;
                color: #231F20;
                line-height: 22px;
              }
              h3 {
                font-size: 18px;
                line-height: 24px;
              }
              li {
                margin-bottom: 12px;
              }
            </style>
          </head>
          <body>
            ${html}
          </body>
        </html>
    """
}
