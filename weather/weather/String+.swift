//
//  String+.swift
//  weather
//
//  Created by Денис Кононов on 19.08.2024.
//

import Foundation

extension String {
    func toDayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "EEEE"
            return dateFormatter.string(from: date)
        }
        return nil
    }
}
