//
//  String+extention.swift
//  twitterCounter
//
//  Created by Abshalom Salama on 04/04/2023.
//

import Foundation

extension String {
    
    func nsRange(from range: Range<String.Index>) -> NSRange {
        guard
            let from = range.lowerBound.samePosition(in: utf16),
            let to = range.upperBound.samePosition(in: utf16)
        else {
            return .init()
        }
        
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from),
                       length: utf16.distance(from: from, to: to))
    }
}
