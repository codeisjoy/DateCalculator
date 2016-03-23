//
//  main.swift
//  DateCalculator
//
//  Created by Emad A. on 22/03/2016.
//  Copyright © 2016 BCG Digital Ventures. All rights reserved.
//

import Foundation

/**
 The date model
 
 - Parameter date: The date string in DD/MM/YYYY format
 
 - Returns: An initialised BCGDate or nil if the given date is not valid
 */

struct BCGDate {
    private(set) var day: Int
    private(set) var month: Int
    private(set) var year: Int
    
    init?(_ date: String) {
        // Seperate given date to day, month and year components.
        let components = date.componentsSeparatedByString("/")
        guard components.count == 3 else {
            return nil
        }
        
        // Make sure month and year are valid and in the right range.
        guard let m = Int(components[1]), y = Int(components[2])
            where m > 0 && m <= 12 && y >= 1900 && y <= 2999 else
        {
            return nil
        }
        
        var daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        // If the given year is a leap year Feb sould have 29 days.
        if y % 4 == 0 && y % 100 > 0 {
            daysInMonth[1] = 29
        }
        
        // Make sure given day is in the correct range according to the month
        guard let d = Int(components[0]) where d > 0 && d <= daysInMonth[m - 1] else {
            return nil
        }
        
        // Initialise the model
        day = d
        month = m
        year = y
    }
}

enum InvalidDateError: ErrorType {
    case InvalidDate
}

/**
 Convert the given date to the Julian Day Number
 which is the integer assigned to a whole solar day in the Julian day
 with Julian day number 0 assigned to the day starting at noon on January 1, 4713 BC.
 https://en.wikipedia.org/wiki/Julian_day
 
 - Parameter date: A not-null instance of BCGDate
 
 - Returns: The Julian Day Number associated with the given date which is an integer
 */

private func julianDay(date: BCGDate!) -> Int {
    let d = date.day
    var m = date.month
    var y = date.year
    
    // Julian Calendar starts from March
    if m > 2 {
        m = m - 3
    } else {
        m = m + 9
        y = y - 1
    }
    
    // The century of the year, e.g 20 for 2016
    let c = y / 100
    // The decades of the year, e.g 16 for 2016
    let ya = y - 100 * c
    
    // Calculate and return the Julian Day
    return (146097 * c) / 4 + (1461 * ya) / 4 + (153 * m + 2) / 5 + d + 1721119
}

/**
 Calculate the number of full days between two given dates
 
 - Parameter from: Date in DD/MM/YYYY format
 - Parameter until: Date in DD/MM/YYYY format
 
 - Throws: 'InvalidDateError.InvalidDate' if 'from' or 'until' is not valid
 
 - Returns: An integer that shown how many full days are in between given dates
 */

func diff(from from: String, until: String) throws -> Int {
    let fromBCGDate = BCGDate(from)
    let untilBCGDate = BCGDate(until)
    
    // Make sure given dates are valid and not null
    guard let f = fromBCGDate, u = untilBCGDate else {
        throw InvalidDateError.InvalidDate
    }
    
    let fjd = julianDay(f)
    let ujd = julianDay(u)
    let diff = ujd - fjd
    
    // Push the 'diff' toward zero to calculate the full days in between and remove days fractions.
    if diff > 0 {
        return diff - 1
    }
    else if diff < 0 {
        return abs(diff + 1)
    } else {
        return 0
    }
}

/**
 To run the script in commant line two arguments are needed
 that should be in the correct date format.
 */

let args = Process.arguments
if args.count < 3 {
    print("OVERVIEW: Date Calculator\n\nUSAGE: main.swift <date> <date>\n\nNOTE:\n  date\t Should be in DD/MM/YYYY format\n")
} else {
    do {
        let n = try diff(from: args[1], until: args[2])
        var output = "> Diff: \(n) day"
        if n > 1 {
            output = output.stringByAppendingString("s")
        }
        print(output)
    } catch InvalidDateError.InvalidDate {
        print("Can't calculate as given dates are not valid.")
    }
}
