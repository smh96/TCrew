//
//  Helper.swift
//  TCrew
//
//  Created by Sander Haug on 09/02/2024.
//

import Foundation

func convertToDate(from String: String) -> Date? {
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: Locale.current.identifier)
    dateFormatter.dateFormat = "EEE ddMMyy HH:mm"
    
    let parsedDate = dateFormatter.date(from: String )
    
    return parsedDate
}
