//
//  Solar.swift
//  BattleField
//
//  Created by Jared Stevens2 on 5/2/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

//import Foundation

//
//  Solar.swift
//  SolarExample
//
//  Created by Chris Howell on 16/01/2016.
//  Copyright © 2016 Chris Howell. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the “Software”), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}


public final class Solar: NSObject {
    
    /// The timezone for the Solar object
    public fileprivate(set) var timeZone: TimeZone = TimeZone.autoupdatingCurrent
    
    /// The latitude that is used for the calculation
    public fileprivate(set) var latitude: Double = 0
    
    /// The longitude that is used for the calculation
    public fileprivate(set) var longitude: Double = 0
    
    /// The date to generate sunrise / sunset times for
    public fileprivate(set) var date: Date
    
    public fileprivate(set) var sunrise: Date? = nil
    public fileprivate(set) var sunset: Date? = nil
    public fileprivate(set) var civilSunrise: Date? = nil
    public fileprivate(set) var civilSunset: Date? = nil
    public fileprivate(set) var nauticalSunrise: Date? = nil
    public fileprivate(set) var nauticalSunset: Date? = nil
    public fileprivate(set) var astronomicalSunrise: Date? = nil
    public fileprivate(set) var astronomicalSunset: Date? = nil
    
    /// Whether the location specified by the `latitude` and `longitude` is in daytime on `date`
    /// - Complexity: O(1)
    public var isDaytime: Bool {
        let beginningOfDay = sunrise?.timeIntervalSince1970
        let endOfDay = sunset?.timeIntervalSince1970
        let currentTime = Date().timeIntervalSince1970
        
        if currentTime >= beginningOfDay && currentTime <= endOfDay {
            return true
        }
        return false
    }
    
    /// Whether the location specified by the `latitude` and `longitude` is in nighttime on `date`
    /// - Complexity: O(1)
    public var isNighttime: Bool {
        return !isDaytime
    }
    
    // MARK: Init
    
    public init?(forDate date: Date = Date(), withTimeZone timeZone: TimeZone = TimeZone.autoupdatingCurrent, latitude: Double, longitude: Double) {
        self.date = date
        self.timeZone = timeZone
        self.latitude = latitude
        self.longitude = longitude
        super.init()
        
        guard latitude >= -90.0 && latitude <= 90.0 else {
            return nil
        }
        
        guard longitude >= -180.0 && longitude <= 180.0 else {
            return nil
        }
        
        // Fill this Solar object with relevant data
        calculate()
    }
    
    // MARK: - Public functions
    
    /// Sets all of the Solar object's sunrise / sunset variables, if possible.
    /// - Note: Can return `nil` objects if sunrise / sunset does not occur on that day.
    public func calculate() {
        sunrise = calculate(.sunrise, forDate: date, andZenith: .official)
        sunset = calculate(.sunset, forDate: date, andZenith: .official)
        civilSunrise = calculate(.sunrise, forDate: date, andZenith: .civil)
        civilSunset = calculate(.sunset, forDate: date, andZenith: .civil)
        nauticalSunrise = calculate(.sunrise, forDate: date, andZenith: .nautical)
        nauticalSunset = calculate(.sunset, forDate: date, andZenith: .nautical)
        astronomicalSunrise = calculate(.sunrise, forDate: date, andZenith: .astronimical)
        astronomicalSunset = calculate(.sunset, forDate: date, andZenith: .astronimical)
    }
    
    // MARK: - Private functions
    
    fileprivate enum SunriseSunset {
        case sunrise
        case sunset
    }
    
    /// Used for generating several of the possible sunrise / sunset times
    fileprivate enum Zenith: Double {
        case official = 90.83
        case civil = 96
        case nautical = 102
        case astronimical = 108
    }
    
    fileprivate func calculate(_ sunriseSunset: SunriseSunset, forDate date: Date, andZenith zenith: Zenith) -> Date? {
        // Get the day of the year
        var calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.timeZone = timeZone
        let day = Double((calendar as NSCalendar).ordinality(of: .day, in: .year, for: date))
        
        // Convert longitude to hour value and calculate an approx. time
        let lngHour = longitude / 15
        
        let hourTime: Double = sunriseSunset == .sunrise ? 6 : 18
        let t = day + ((hourTime - lngHour) / 24)
        
        // Calculate the suns mean anomaly
        let M = (0.9856 * t) - 3.289
        
        // Calculate the sun's true longitude
        var L = M + (1.916 * sin(M.degreesToRadians)) + (0.020 * sin(2 * M.degreesToRadians)) + 282.634
        
        // Normalise L into [0, 360] range
        L = normalise(L, withMaximum: 360)
        
        // Calculate the Sun's right ascension
        var RA = atan(0.91764 * tan(L.degreesToRadians)).radiansToDegrees
        
        // Normalise RA into [0, 360] range
        RA = normalise(RA, withMaximum: 360)
        
        // Right ascension value needs to be in the same quadrant as L...
        let Lquadrant = floor(L / 90) * 90
        let RAquadrant = floor(RA / 90) * 90
        RA = RA + (Lquadrant - RAquadrant)
        
        // Convert RA into hours
        RA = RA / 15
        
        // Calculate Sun's declination
        let sinDec = 0.39782 * sin(L.degreesToRadians)
        let cosDec = cos(asin(sinDec))
        
        // Calculate the Sun's local hour angle
        let cosH = (cos(Zenith.official.rawValue.degreesToRadians) - (sinDec * sin(latitude.degreesToRadians))) / (cosDec * cos(latitude.degreesToRadians))
        
        // No sunrise
        guard cosH < 1 else {
            return nil
        }
        
        // No sunset
        guard cosH > -1 else {
            return nil
        }
        
        // Finish calculating H and convert into hours
        let tempH = sunriseSunset == .sunrise ? 360 - acos(cosH).radiansToDegrees : acos(cosH).radiansToDegrees
        let H = tempH / 15.0
        
        // Calculate local mean time of rising
        let T = H + RA - (0.06571 * t) - 6.622
        
        // Adjust time back to UTC
        var UT = T - lngHour
        
        // Normalise UT into [0, 24] range
        UT = normalise(UT, withMaximum: 24)
        
        // Convert UT value to local time zone of lat/long provided
        let localT = UT + (Double(timeZone.secondsFromGMT()) / 3600.0)
        
        let hour = floor(localT)
        let minute = floor((localT - hour) * 60.0)
        let second = (((localT - hour) * 60) - minute) * 60.0
        
        var components = (calendar as NSCalendar).components([.day, .month, .year], from: date)
        components.hour = Int(hour)
        components.minute = Int(minute)
        components.second = Int(second)
        
        var date = calendar.date(from: components)
        
        // Add a day to account for potential timezone issues
        if sunriseSunset == .sunset && date?.timeIntervalSince1970 < sunrise?.timeIntervalSince1970 {
            date = date?.addingTimeInterval(60 * 60 * 24)
        }
        
        return date
    }
    
    /// Normalises a value between 0 and `maximum`, by adding or subtracting `maximum`
    fileprivate func normalise(_ value: Double, withMaximum maximum: Double) -> Double {
        var value = value
        
        if value < 0 {
            value += maximum
        }
        
        if value > maximum {
            value -= maximum
        }
        
        return value
    }
    
}

// MARK: - Helper extensions

private extension Double {
    var degreesToRadians: Double {
        return Double(self) * (M_PI / 180.0)
    }
    
    var radiansToDegrees: Double {
        return (Double(self) * 180.0) / M_PI
    }
}


func <=(lhs: Date, rhs: Date) -> Bool {
    return lhs.timeIntervalSince1970 <= rhs.timeIntervalSince1970
}
func >=(lhs: Date, rhs: Date) -> Bool {
    return lhs.timeIntervalSince1970 >= rhs.timeIntervalSince1970
}
func >(lhs: Date, rhs: Date) -> Bool {
    return lhs.timeIntervalSince1970 > rhs.timeIntervalSince1970
}
func <(lhs: Date, rhs: Date) -> Bool {
    return lhs.timeIntervalSince1970 < rhs.timeIntervalSince1970
}
func ==(lhs: Date, rhs: Date) -> Bool {
    return lhs.timeIntervalSince1970 == rhs.timeIntervalSince1970
}



func SunLightEffect(_ CurrentTime: Date, SunsetTime: Date, SunriseTime: Date, IsDayTime: Bool) -> Double {
    
    var DimValue = Double()
    let CurrentTimeInterval = CurrentTime.timeIntervalSince1970
    let SunsetTimeInterval = SunsetTime.timeIntervalSince1970
    let SunriseTimeInterval = SunriseTime.timeIntervalSince1970
    
    
    let SunriseOffsetTime = CurrentTime.timeIntervalSince(SunriseTime)
    let SunsetOffsetTime = CurrentTime.timeIntervalSince(SunsetTime)
   // print("TimeSince Sunrise = \(SunriseOffsetTime)")
   // print("TimeTill Sunset = \(SunsetOffsetTime)")
    
    
   
    
    var AdjSunriseOffsetTime = TimeInterval()
    var AdjSunsetOffsetTime = TimeInterval()
    
    if SunsetOffsetTime < 0 {
        AdjSunsetOffsetTime = SunsetOffsetTime * -1
    } else {
        AdjSunsetOffsetTime = SunsetOffsetTime
    }
    
    if SunriseOffsetTime < 0 {
        AdjSunriseOffsetTime = SunriseOffsetTime * -1
    } else {
        AdjSunriseOffsetTime = SunriseOffsetTime
    }
    
    
    let TotalTimeScale = AdjSunriseOffsetTime + AdjSunsetOffsetTime
    
   // let TotalTimeScaleInterval = TotalTimeScale / 100
    let HighNoon = TotalTimeScale / 2
    
    let HighNoonScaleInterval = HighNoon / 100
    
    
   // print("TotalTime Scale = \(TotalTimeScale)!!!!!!")
    
   // print("high noon time: \(HighNoon)")
   // print("high noon Scale Interval = \(HighNoonScaleInterval)!!!!!!")
    
    
    
    
    var TimeOfDay = String()
    var AlphaTimeScale = Double()
    //var DimValue = Double()
    
    var DayOrNight = String()
    
    if IsDayTime {
        DayOrNight = "day"
    } else {
        DayOrNight = "night"
    }
    
    if CurrentTime >= SunriseTime {
        
        
       // print("Current Time: \(CurrentTime)")
       // print("Current Time: \(SunriseTime)")
      //  if CurrentTime ==
        
       // if checkTimeStamp(date: SunriseTime) == true {
            
           // if CurrentTime
        if CurrentTime != SunriseTime {
           // print("Sun is rising Now")
            
            
            
            AlphaTimeScale = (AdjSunriseOffsetTime / HighNoonScaleInterval) / 100
            
            DimValue = GetDimValue(AlphaTimeScale, DayTime: DayOrNight)
            
            /*
            AlphaTimeScale = 0.7
            DimValue = GetDimValue(AlphaTimeScale, DayTime: DayOrNight)
            */
        } else {
        print("MidDay")
            
            /*
            AlphaTimeScale = (AdjSunriseOffsetTime / HighNoonScaleInterval) / 100
            DimValue = GetDimValue(AlphaTimeScale, DayTime: DayOrNight)
            */
            
            AlphaTimeScale = 0.7
            DimValue = GetDimValue(AlphaTimeScale, DayTime: DayOrNight)
            
          //  print("Alpha Time Scale: \(AlphaTimeScale)")
        }
  
    } else if CurrentTime <= SunriseTime {
        
        
        //print("Current Time: \(CurrentTime)")
        //print("Current Time: \(SunriseTime)")
        
       // if checkTimeStamp(date: SunsetTime.) == true {
       // if (checkTimeStamp(date:"2016-11-21 12:00:00") == false) {
            // Do something
       
        
        if CurrentTime != SunsetTime {
            //print("Sun is setting Now")
            /*
            AlphaTimeScale = 0.7
            DimValue = GetDimValue(AlphaTimeScale, DayTime: DayOrNight)
            */
            AlphaTimeScale = (AdjSunsetOffsetTime / HighNoonScaleInterval) / 100
            // print("Alpha Time Scale: \(AlphaTimeScale)")
            DimValue = GetDimValue(AlphaTimeScale, DayTime: DayOrNight)
            
        } else {
        print("MidNight")
            
            /*
            AlphaTimeScale = (AdjSunsetOffsetTime / HighNoonScaleInterval) / 100
           // print("Alpha Time Scale: \(AlphaTimeScale)")
            DimValue = GetDimValue(AlphaTimeScale, DayTime: DayOrNight)
            */
            
            AlphaTimeScale = 0.7
            DimValue = GetDimValue(AlphaTimeScale, DayTime: DayOrNight)
            
        }
    }
    
    
  return DimValue
    
}

func checkTimeStamp(date: String!) -> Bool {
    let dateFormatter: DateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.locale = Locale(identifier:"en_US_POSIX")
    let datecomponents = dateFormatter.date(from: date)
    
    let now = Date()
    
    print("datecomponets: \(datecomponents)")
    
    if (datecomponents! >= now) {
        return true
    } else {
        return false
    }
}

func GetDimValue(_ TimeScaleValue: Double, DayTime: String) -> Double {
    
    var DimValue = Double()
    
   // print("Getting Dim Value: Time Scale value: \(TimeScaleValue)")
    
    switch TimeScaleValue {
    case _ where TimeScaleValue >= 0.5:
        if DayTime == "night" {
            DimValue = 0.5
        } else {
            DimValue = 0.0
        }
        
    case _ where ((TimeScaleValue >= 0.48) && (TimeScaleValue < 0.5)):
        if DayTime == "night" {
            DimValue = 0.85
        } else {
            DimValue = 0.0
        }
    case _ where ((TimeScaleValue >= 0.44) && (TimeScaleValue < 0.48)):
        if DayTime == "night" {
            DimValue = 0.8
        } else {
            DimValue = 0.0
        }
    case _ where ((TimeScaleValue >= 0.4) && (TimeScaleValue < 0.44)):
        if DayTime == "night" {
            DimValue = 0.75
        } else {
            DimValue = 0.0
        }
    case _ where ((TimeScaleValue >= 0.35) && (TimeScaleValue < 0.4)):
        if DayTime == "night" {
            DimValue = 0.7
        } else {
            DimValue = 0.0
        }
    case _ where ((TimeScaleValue >= 0.3) && (TimeScaleValue < 0.35)):
        if DayTime == "night" {
            DimValue = 0.6
        } else {
            DimValue = 0.0
        }
    case _ where ((TimeScaleValue >= 0.25) && (TimeScaleValue < 0.3)):
        if DayTime == "night" {
            DimValue = 0.5
        } else {
            DimValue = 0.0
        }
    case _ where ((TimeScaleValue >= 0.2) && (TimeScaleValue < 0.25)):
        if DayTime == "night" {
            DimValue = 0.4
        } else {
            DimValue = 0.0
        }
    case _ where ((TimeScaleValue >= 0.175) && (TimeScaleValue < 0.2)):
        if DayTime == "night" {
            DimValue = 0.3
        } else {
            DimValue = 0.05
        }
        
    case _ where ((TimeScaleValue >= 0.15) && (TimeScaleValue < 0.175)):
        if DayTime == "night" {
            DimValue = 0.3
        } else {
            DimValue = 0.2
        }
        
    case _ where ((TimeScaleValue >= 0.125) && (TimeScaleValue < 0.15)):
        if DayTime == "night" {
            DimValue = 0.2
        } else {
            DimValue = 0.35
        }
    case _ where ((TimeScaleValue >= 0.1) && (TimeScaleValue < 0.125)):
        if DayTime == "night" {
            DimValue = 0.1
        } else {
            DimValue = 0.45
        }
        
        
    case _ where ((TimeScaleValue >= 0.075) && (TimeScaleValue < 0.1)):
        if DayTime == "night" {
            DimValue = 0.1
        } else {
            DimValue = 0.55
        }
        
    case _ where ((TimeScaleValue >= 0.025) && (TimeScaleValue < 0.075)):
        if DayTime == "night" {
            DimValue = 0.1
        } else {
            DimValue = 0.62
        }
        
    case _ where ((TimeScaleValue >= 0.015) && (TimeScaleValue < 0.025)):
        if DayTime == "night" {
            DimValue = 0.1
        } else {
            DimValue = 0.68
        }
        
    case _ where ((TimeScaleValue >= 0.001) && (TimeScaleValue < 0.015)):
        if DayTime == "night" {
            DimValue = 0.1
        } else {
            DimValue = 0.72
        }
        
    default:
        if DayTime == "night" {
            DimValue = 0.5
        } else {
            DimValue = 0.0
        }
        //  DimValue = 1.0
        
    }
    /*
    switch TimeScaleValue {
    case _ where TimeScaleValue >= 0.5:
        if DayTime == "night" {
            DimValue = 0.9
        } else {
            DimValue = 0.0
        }
        
    case _ where ((TimeScaleValue >= 0.48) && (TimeScaleValue < 0.5)):
        if DayTime == "night" {
            DimValue = 0.85
        } else {
            DimValue = 0.0
        }
    case _ where ((TimeScaleValue >= 0.44) && (TimeScaleValue < 0.48)):
        if DayTime == "night" {
        DimValue = 0.8
        } else {
        DimValue = 0.0
        }
    case _ where ((TimeScaleValue >= 0.4) && (TimeScaleValue < 0.44)):
        if DayTime == "night" {
            DimValue = 0.75
        } else {
            DimValue = 0.0
        }
    case _ where ((TimeScaleValue >= 0.35) && (TimeScaleValue < 0.4)):
        if DayTime == "night" {
            DimValue = 0.7
        } else {
            DimValue = 0.0
        }
    case _ where ((TimeScaleValue >= 0.3) && (TimeScaleValue < 0.35)):
        if DayTime == "night" {
            DimValue = 0.6
        } else {
            DimValue = 0.0
        }
    case _ where ((TimeScaleValue >= 0.25) && (TimeScaleValue < 0.3)):
        if DayTime == "night" {
            DimValue = 0.5
        } else {
            DimValue = 0.0
        }
    case _ where ((TimeScaleValue >= 0.2) && (TimeScaleValue < 0.25)):
        if DayTime == "night" {
            DimValue = 0.4
        } else {
            DimValue = 0.0
        }
    case _ where ((TimeScaleValue >= 0.175) && (TimeScaleValue < 0.2)):
        if DayTime == "night" {
            DimValue = 0.3
        } else {
            DimValue = 0.05
        }
        
    case _ where ((TimeScaleValue >= 0.15) && (TimeScaleValue < 0.175)):
        if DayTime == "night" {
            DimValue = 0.3
        } else {
            DimValue = 0.2
        }
        
    case _ where ((TimeScaleValue >= 0.125) && (TimeScaleValue < 0.15)):
        if DayTime == "night" {
            DimValue = 0.2
        } else {
            DimValue = 0.35
        }
    case _ where ((TimeScaleValue >= 0.1) && (TimeScaleValue < 0.125)):
        if DayTime == "night" {
            DimValue = 0.1
        } else {
            DimValue = 0.45
        }
        
        
    case _ where ((TimeScaleValue >= 0.075) && (TimeScaleValue < 0.1)):
        if DayTime == "night" {
            DimValue = 0.1
        } else {
            DimValue = 0.55
        }
        
    case _ where ((TimeScaleValue >= 0.025) && (TimeScaleValue < 0.075)):
        if DayTime == "night" {
            DimValue = 0.1
        } else {
            DimValue = 0.62
        }
        
    case _ where ((TimeScaleValue >= 0.015) && (TimeScaleValue < 0.025)):
        if DayTime == "night" {
            DimValue = 0.1
        } else {
            DimValue = 0.68
        }
        
    case _ where ((TimeScaleValue >= 0.001) && (TimeScaleValue < 0.015)):
        if DayTime == "night" {
            DimValue = 0.1
        } else {
            DimValue = 0.72
        }
        
    default:
        if DayTime == "night" {
            DimValue = 0.9
        } else {
            DimValue = 0.0
        }
      //  DimValue = 1.0
        
    }
    */
    
    return DimValue
}
