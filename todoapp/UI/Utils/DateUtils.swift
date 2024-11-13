//
//  DateUtils.swift
//  todoapp
//
//  Created by admin on 6/11/24.
//

import Foundation

struct DateUtils {
    
    // Converts date from format "MMM-dd-yyyy" (e.g. "Nov-21-2024") to "yyyy-MM-dd" (e.g. "2024-11-21")
    static func convertDateString(input: String) -> String? {
        // Step 1: Initialize the input DateFormatter to parse the input date string
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "MMM-dd-yyyy"  // Input format (e.g., "Nov-21-2024")
        
        // Step 2: Convert the input string to Date
        guard let dateFromString = inputFormatter.date(from: input) else {
            print("Invalid date format!")
            return nil
        }
        
        // Step 3: Initialize the output DateFormatter to format the Date into the desired output format
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd"  // Desired output format (e.g., "2024-11-21")
        
        // Step 4: Convert the Date object to the formatted string
        return outputFormatter.string(from: dateFromString)
    }
    
    
    static func formatTimeTo12Hour(_ time: String) -> String {
        let dateFormatter = DateFormatter()
        
        
        dateFormatter.dateFormat = "HH:mm:ss"
        
        
        guard let date = dateFormatter.date(from: time) else {
            return time
        }
        
        dateFormatter.locale = Locale(identifier: "en")

        dateFormatter.dateFormat = "h:mm a"
        
        return dateFormatter.string(from: date)
    }
}
