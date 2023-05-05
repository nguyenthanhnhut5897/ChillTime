//
//  StringExtensions.swift
//  ChillTime
//
//  Created by Nguyen Thanh Nhut on 2023/04/11.
//

import UIKit

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    var youtubeID: String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)
        
        guard let result = regex?.firstMatch(in: self, range: range) else {
            return nil
        }
    
        return (self as NSString).substring(with: result.range)
    }
    
    var isValidEmail: Bool {
        let laxString = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,63}"
        let emailTest: NSPredicate = NSPredicate(format:"SELF MATCHES %@", laxString)
        return emailTest.evaluate(with: self)
    }
    
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.endIndex.utf16Offset(in: self))) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.endIndex.utf16Offset(in: self)
        } else {
            return false
        }
    }
    
    func grouping(every groupSize: Int, with separator: String) -> String {
        let cleanedUpCopy = replacingOccurrences(of: separator, with: "")

        return String(cleanedUpCopy.enumerated().map() {
            $0.offset % groupSize == 0 ? "\(separator)\($0.element)" : "\($0.element)"
            }.joined().dropFirst())
    }
    
    func makeSampleCardNumber() -> String {
        var result = self
        
        if self.isEmpty {
            result = String(repeating: "X", count: 16)
        }

        return result
    }
    
    func makeSampleExpireNumber() -> String {
        var result = self
        
        if self.isEmpty {
            result = "MMYY"
        }

        return result
    }
    
    func trimmed() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func convertToDict() -> [String: Any]? {
        guard let jsonData = self.data(using: .utf8) else {
            return nil
        }
        
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
            guard let dictionary = jsonObject as? [String: Any] else {
                return nil
            }
            
            return dictionary
        } catch {
            print("Error deserializing JSON: \(error.localizedDescription)")
            return nil
        }
    }
}
