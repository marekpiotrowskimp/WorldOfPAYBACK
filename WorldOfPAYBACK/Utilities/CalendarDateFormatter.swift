//
//  CalendarDateFormatter.swift
//  WorldOfPAYBACK
//
//  Created by Marek Piotrowski on 17/02/2024.
//

import Foundation

enum CalendarDateFormatter {
    case dateTime
    
    static let defualtFormat: CalendarDateFormatter = .dateTime
    
    private static let baseDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = CalendarDateFormatter.defualtFormat.dateFormat
        return formatter
    }()
    
    var dataFormatter: DateFormatter {
        CalendarDateFormatter.baseDateFormatter.dateFormat = self.dateFormat
        return CalendarDateFormatter.baseDateFormatter
    }
    
    var dateFormat: String {
        switch self {
        case .dateTime: return "yyyy-MM-dd'T'HH:mm:ssZ"
        }
    }
}
