//
//  main.swift
//  DateCalculator
//
//  Created by Emad A. on 22/03/2016.
//  Copyright © 2016 BCG Digital Ventures. All rights reserved.
//

import Foundation

struct BCGDate {
    private(set) var day: Int
    private(set) var month: Int
    private(set) var year: Int
    
    init?(_ date: String) {
        let components = date.componentsSeparatedByString("/")
        guard components.count == 3 else {
            return nil
        }
        
        guard let m = Int(components[1]), y = Int(components[2])
            where m > 0 && m <= 12 && y >= 1900 && y <= 2999 else
        {
            return nil
        }
        
        var daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        if y % 4 == 0 && y % 100 > 0 {
            daysInMonth[1] = 29
        }
        
        guard let d = Int(components[0]) where d > 0 && d <= daysInMonth[m - 1] else {
            return nil
        }
        
        day = d
        month = m
        year = y
    }
}

enum InvalidDateError: ErrorType {
    case InvalidDate
}

private func julianDay(date: BCGDate!) -> Int {
    let d = date.day
    var m = date.month
    var y = date.year
    
    if m > 2 {
        m = m - 3
    } else {
        m = m + 9
        y = y - 1
    }
    
    let c = y / 100
    let ya = y - 100 * c
    
    return (146097 * c) / 4 + (1461 * ya) / 4 + (153 * m + 2) / 5 + d + 1721119
}

func diff(from from: String, until: String) throws -> Int {
    let fromBCGDate = BCGDate(from)
    let untilBCGDate = BCGDate(until)
    
    guard let f = fromBCGDate, u = untilBCGDate else {
        throw InvalidDateError.InvalidDate
    }
    
    let fjd = julianDay(f)
    let ujd = julianDay(u)
    let diff = ujd - fjd
    if diff > 0 {
        return diff - 1
    }
    else if diff < 0 {
        return abs(diff + 1)
    } else {
        return 0
    }
}

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
