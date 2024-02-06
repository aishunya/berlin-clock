//
//  MainLogic.swift
//  BerlinClockApp
//
//  Created by Aisha Nurgaliyeva on 30.01.2024.
//

import Foundation

class MainLogic {
    func parseSeconds(_ seconds: Int) -> String {
        return seconds % 2 == 0 ? "Y" : "O"
    }

    func parseHours(_ hours: Int) -> String {
        let upper = String(repeating: "R", count: hours / 5).padding(toLength: 4, withPad: "O" , startingAt: 0)
        let lower = String(repeating: "R", count: hours % 5).padding(toLength: 4, withPad: "O" , startingAt: 0)
        return upper + lower
    }

    func parseMinutes(_ minutes: Int) -> String {
        let upperLightsNumber = minutes / 5
        let lowerLightsNumber = minutes % 5
        
        return parseUpperMinutes(upperLightsNumber) + parseLowerMinutes(lowerLightsNumber)
    }
    
    func parseUpperMinutes(_ minutes: Int) -> String {
        var upper = ""
        
        for i in 1...11 {
            var current = ""
            if minutes >= i {
                current = i % 3 == 0 ? "R" : "Y"
            } else {
                current = "O"
            }
            upper += current
        }
        
        return upper
    }
    
    func parseLowerMinutes(_ minutes: Int) -> String {
        return String(repeating: "Y", count: minutes).padding(toLength: 4, withPad: "O" , startingAt: 0)
    }
    
    func parseToBerlinClockTime(hours: Int, minutes: Int, seconds: Int) -> String {
        return parseSeconds(seconds) + parseHours(hours) + parseMinutes(minutes)
    }
}
