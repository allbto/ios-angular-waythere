//
//  CD_Wind.swift
//  
//
//  Created by Allan BARBATO on 5/18/15.
//
//

import Foundation
import SwiftyJSON
import CoreData

@objc(Wind)
public class Wind: AModel {

    @NSManaged public var degrees: NSNumber?
    @NSManaged public var direction: String?
    @NSManaged public var speedImperial: NSNumber?
    @NSManaged public var speedMetric: NSNumber?

    public static let windDirections = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE",
        "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
    
    public static var metricUnit = "km/h"
    public static var imperialUnit = "mph"

    
    public var degree : Float {
        get { return self.degrees?.floatValue ?? 0 }
        set {
            self.degrees = newValue

            // http://stackoverflow.com/questions/13220367/cardinal-wind-direction-from-degrees
            var i = (newValue + 11.25) / 22.5;
            self.direction = Wind.windDirections[Int(i % 16)]
        }
    }
    
    public var speed : Float {
        get { return self.speedMetric?.floatValue ?? 0 }
        set {
            self.speedMetric = newValue
            self.speedImperial = newValue / 1.609 // 1 mph = 1.609 km/h
        }
    }
    
    public override func fromJson(json: JSON)
    {
        if let deg = json["deg"].float, speed = json["speed"].float {
            self.degree = deg
            self.speed = speed
        }
    }
}
