//
//  UserPoints.swift
//  BattleField
//
//  Created by Jared Stevens on 7/29/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//



import Foundation
import MapKit
import AddressBook

class UserLabel: NSObject, MKAnnotation {
    let title: String?
    let userHealth: String
    let discipline: String
    let stealth: String
    let coordinate: CLLocationCoordinate2D
    let image: UIImage
    let lat: Double
    let long: Double
    let alt: Double
    let PinType: String
    let GoldAmount: String
    let isMission: Bool
    let missionID: String
    
    let xp: String
    let objective: String
    let missionLevel: String
    let imageName: String
    
    let TotalPlayerAttributesTemp: TotalPlayerAttributes
    let killcount: String
    let killedcount: String
    
    init(title: String, userHealth: String, discipline: String, stealth: String, coordinate: CLLocationCoordinate2D, image: UIImage, PinType: String, GoldAmount: String, isMission: Bool, missionID: String, xp: String, objective: String, missionLevel: String, imageName: String, TotalPlayerAttributesTemp: TotalPlayerAttributes, killcount: String, killedcount: String, altitude: Double) {
        self.title = title
        self.userHealth = userHealth
        self.discipline = discipline
        self.coordinate = coordinate
        self.stealth = stealth
        self.image = image
        self.lat = coordinate.latitude
        self.long = coordinate.longitude
        self.alt = altitude
        self.PinType = PinType
        self.GoldAmount = GoldAmount
        self.isMission = isMission
        self.missionID = missionID
        self.xp = xp
        self.objective = objective
        self.missionLevel = missionLevel
        
        self.imageName = imageName
        
        self.TotalPlayerAttributesTemp = TotalPlayerAttributesTemp
        self.killcount = killcount
        self.killedcount = killedcount
        
        super.init()
}
    var subtitleNEW: String {
        return userHealth
    }

    func pinColor() -> MKPinAnnotationColor  {
        switch stealth {
        case "yes":
            return .red
        case "Mural", "Monument":
            return .purple
        default:
            return .green
            //return .Red
        }
    }
    
    // annotation callout opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDict = [String(kABPersonAddressStreetKey): self.subtitleNEW]
        let placemark = MKPlacemark(coordinate: self.coordinate, addressDictionary: addressDict)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = self.title
        
        return mapItem
    }
    
}



class TargetLabel: NSObject, MKAnnotation {
    let title: String?
    let userHealth: String
    let discipline: String
    let stealth: String
    let coordinate: CLLocationCoordinate2D
    let image: UIImage
    let lat: Double
    let long: Double
    let alt: Double
    let PinType: String
    let GoldAmount: String
    let isMission: Bool
    let missionID: String
    
    init(title: String, userHealth: String, discipline: String, stealth: String, coordinate: CLLocationCoordinate2D, image: UIImage, PinType: String, GoldAmount: String, isMission: Bool, missionID: String, altitude: Double) {
        self.title = title
        self.userHealth = userHealth
        self.discipline = discipline
        self.coordinate = coordinate
        self.stealth = stealth
        self.image = image
        self.lat = coordinate.latitude
        self.long = coordinate.longitude
        self.alt = altitude
        self.PinType = PinType
        self.GoldAmount = GoldAmount
        self.isMission = isMission
        self.missionID = missionID
        super.init()
    }
    var subtitleNEW: String {
        return userHealth
    }
    
    func pinColor() -> MKPinAnnotationColor  {
        switch stealth {
        case "yes":
            return .red
        case "Mural", "Monument":
            return .purple
        default:
            return .green
            //return .Red
        }
    }
    
    // annotation callout opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDict = [String(kABPersonAddressStreetKey): self.subtitleNEW]
        let placemark = MKPlacemark(coordinate: self.coordinate, addressDictionary: addressDict)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = self.title
        
        return mapItem
    }
    
}



class MyLabel: NSObject, MKAnnotation {
    let title: String?
    let userHealth: String
    let discipline: String
    let stealth: String
    let coordinate: CLLocationCoordinate2D
    let image: UIImage
    
    init(title: String, userHealth: String, discipline: String, stealth: String, coordinate: CLLocationCoordinate2D, image: UIImage) {
        self.title = title
        self.userHealth = userHealth
        self.discipline = discipline
        self.coordinate = coordinate
        self.stealth = stealth
        self.image = image
        
        super.init()
    }
    var subtitle: String? {
        return userHealth
    }
    
    func pinColor() -> MKPinAnnotationColor  {
        switch stealth {
        case "yes":
            return .red
        case "Mural", "Monument":
            return .green
        default:
            return .purple
            //return .Red
        }
    }
    
    // annotation callout opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDict = [String(kABPersonAddressStreetKey): self.subtitle]
        let placemark = MKPlacemark(coordinate: self.coordinate, addressDictionary: addressDict as! [String: String])
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = self.title
        
        return mapItem
    }
    
}

class ItemLabel: NSObject, MKAnnotation {
    let title: String?
    let itemStatus: String
    let discipline: String
    let itemType: String
    let coordinate: CLLocationCoordinate2D
    let lat: Double
    let long: Double
    let alt: Double
    let itemCode: String
    let itemID: String
    let image: UIImage
    let amount: String
    let PinType: String
    
    let category: String
    let count: String
    let level: String
    let health: String
    let stamina: String
    let ammoCount: String
    let speed: String
    let power: String
    let range: String
    let viewrange: String
    
    let isMission: Bool
    let missionID: String
    let xp: String
    let objective: String
    let missionLevel: String
    let imageName: String
    
   
    let TotalPlayerAttributesTemp: TotalPlayerAttributes
    let killcount: String
    let killedcount: String
    
    init(title: String, itemStatus: String, discipline: String, itemType: String, coordinate: CLLocationCoordinate2D, itemCode: String, itemID: String, image: UIImage, amount: String, PinType: String, category: String, count: String, level: String, health: String, stamina: String, ammoCount: String, speed: String, power: String, range: String, viewrange: String, isMission: Bool, missionID: String, xp: String, objective: String, missionLevel: String, imageName: String, TotalPlayerAttributesTemp: TotalPlayerAttributes, killcount: String, killedcount: String, altitude: Double) {
        self.title = title
        self.itemStatus = itemStatus
        self.discipline = discipline
        self.coordinate = coordinate
        self.itemType = itemType
        self.lat = coordinate.latitude
        self.long = coordinate.longitude
        self.alt = altitude
        self.itemCode = itemCode
        self.itemID = itemID
        self.image = image
        self.amount = amount
        self.PinType = PinType
        
        self.category = category
        self.count = count
        self.level = level
        self.health = health
        self.stamina = stamina
        self.ammoCount = ammoCount
        self.speed = speed
        self.power = power
        self.range = range
        self.viewrange = viewrange
        
        self.isMission = isMission
        self.missionID = missionID
        self.xp = xp
        self.objective = objective
        self.missionLevel = missionLevel
        
        self.imageName = imageName
        
        self.TotalPlayerAttributesTemp = TotalPlayerAttributesTemp
        self.killcount = killcount
        self.killedcount = killedcount
        
        super.init()
    }
    var subtitle: String? {
        if itemType == "gold" {
            return amount
        } else {
        return itemType
        }
        }
    
    func pinColor() -> MKPinAnnotationColor  {
        switch itemType {
        case "yes":
            return .purple
        case "Mural", "Monument":
            return .green
        default:
            return .red
            //return .Red
        }
    }
    
    // annotation callout opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDict = [String(kABPersonAddressStreetKey): self.subtitle]
        let placemark = MKPlacemark(coordinate: self.coordinate, addressDictionary: addressDict as! [String: String])
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = self.title
        
        //mapItem.name = "Item"
        
        return mapItem
    }
    
}

class MissionLabel: NSObject, MKAnnotation {
    let title: String?
    let objective: String
    let discipline: String
    let level: String
    let coordinate: CLLocationCoordinate2D
    let image: UIImage
    let lat: Double
    let long: Double
    let alt: Double
    let PinType: String
    let xp: String
    let mapURL: String
    let objectURL: String
    let isMission: Bool
    let missionID: String
    
    let missionLevel: String
    let imageName: String
    
   
    let TotalPlayerAttributesTemp: TotalPlayerAttributes
    let killcount: String
    let killedcount: String
    
    init(title: String, objective: String, discipline: String, level: String, coordinate: CLLocationCoordinate2D, image: UIImage, PinType: String, xp: String, mapURL: String, objectURL: String, isMission: Bool, missionID: String, missionLevel: String, imageName: String, TotalPlayerAttributesTemp: TotalPlayerAttributes, killcount: String, killedcount: String, altitude: Double) {
        self.title = title
        self.objective = objective
        self.discipline = discipline
        self.coordinate = coordinate
        self.level = level
        self.image = image
        self.lat = coordinate.latitude
        self.long = coordinate.longitude
        self.alt = altitude
        self.PinType = PinType
        self.xp = xp
        self.mapURL = mapURL
        self.objectURL = objectURL
        self.isMission = isMission
        self.missionID = missionID
        self.missionLevel = missionLevel
        
        self.imageName = imageName
        
        self.TotalPlayerAttributesTemp = TotalPlayerAttributesTemp
        self.killcount = killcount
        self.killedcount = killedcount
        super.init()
    }
    var subtitleNEW: String {
        return objective
    }
    
    func pinColor() -> MKPinAnnotationColor  {
        switch level {
        case "1":
            return .green
        case "2", "3":
            return .purple
        default:
            return .red
            //return .Red
        }
    }
    
    // annotation callout opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDict = [String(kABPersonAddressStreetKey): self.subtitleNEW]
        let placemark = MKPlacemark(coordinate: self.coordinate, addressDictionary: addressDict)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = self.title
        
        return mapItem
    }
    
}


class CameraLabel: NSObject, MKAnnotation {
    let title: String?
    let objective: String
    let discipline: String
    let level: String
    let coordinate: CLLocationCoordinate2D
    let image: UIImage
    let lat: Double
    let long: Double
    let alt: Double
    let PinType: String
    let xp: String
    let mapURL: String
    let objectURL: String
    let isMission: Bool
    let missionID: String
    

    let missionLevel: String
    let imageName: String
    
    let TotalPlayerAttributesTemp: TotalPlayerAttributes
    let killcount: String
    let killedcount: String
    
    
    init(title: String, objective: String, discipline: String, level: String, coordinate: CLLocationCoordinate2D, image: UIImage, PinType: String, xp: String, mapURL: String, objectURL: String, isMission: Bool, missionID: String, missionLevel: String, imageName: String, TotalPlayerAttributesTemp: TotalPlayerAttributes, killcount: String, killedcount: String, altitude: Double) {
        self.title = title
        self.objective = objective
        self.discipline = discipline
        self.coordinate = coordinate
        self.level = level
        self.image = image
        self.lat = coordinate.latitude
        self.long = coordinate.longitude
        self.alt = altitude
        self.PinType = PinType
        self.xp = xp
        self.mapURL = mapURL
        self.objectURL = objectURL
        self.isMission = isMission
        self.missionID = missionID
        self.missionLevel = missionLevel
        self.imageName = imageName
        
        self.TotalPlayerAttributesTemp = TotalPlayerAttributesTemp
        self.killcount = killcount
        self.killedcount = killedcount
        
        super.init()
    }
    var subtitleNEW: String {
        return objective
    }
    
    func pinColor() -> MKPinAnnotationColor  {
        switch level {
        case "1":
            return .green
        case "2", "3":
            return .purple
        default:
            return .red
            //return .Red
        }
    }
    
    // annotation callout opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDict = [String(kABPersonAddressStreetKey): self.subtitleNEW]
        let placemark = MKPlacemark(coordinate: self.coordinate, addressDictionary: addressDict)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = self.title
        
        return mapItem
    }
    
}

class OtherCameraLabel: NSObject, MKAnnotation {
    let title: String?
    let objective: String
    let discipline: String
    let level: String
    let coordinate: CLLocationCoordinate2D
    let image: UIImage
    let lat: Double
    let long: Double
    let alt: Double
    let PinType: String
    let xp: String
    let mapURL: String
    let objectURL: String
    let isMission: Bool
    let missionID: String
    

    let missionLevel: String
    let imageName: String
    
    let TotalPlayerAttributesTemp: TotalPlayerAttributes
    let killcount: String
    let killedcount: String
    
    
    init(title: String, objective: String, discipline: String, level: String, coordinate: CLLocationCoordinate2D, image: UIImage, PinType: String, xp: String, mapURL: String, objectURL: String, isMission: Bool, missionID: String, missionLevel: String, imageName: String, TotalPlayerAttributesTemp: TotalPlayerAttributes, killcount: String, killedcount: String, altitude: Double) {
        self.title = title
        self.objective = objective
        self.discipline = discipline
        self.coordinate = coordinate
        self.level = level
        self.image = image
        self.lat = coordinate.latitude
        self.long = coordinate.longitude
        self.alt = altitude
        self.PinType = PinType
        self.xp = xp
        self.mapURL = mapURL
        self.objectURL = objectURL
        self.isMission = isMission
        self.missionID = missionID
        self.missionLevel = missionLevel
        self.imageName = imageName
        
        self.TotalPlayerAttributesTemp = TotalPlayerAttributesTemp
        self.killcount = killcount
        self.killedcount = killedcount
        
        super.init()
    }
    var subtitleNEW: String {
        return objective
    }
    
    func pinColor() -> MKPinAnnotationColor  {
        switch level {
        case "1":
            return .green
        case "2", "3":
            return .purple
        default:
            return .red
            //return .Red
        }
    }
    
    // annotation callout opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDict = [String(kABPersonAddressStreetKey): self.subtitleNEW]
        let placemark = MKPlacemark(coordinate: self.coordinate, addressDictionary: addressDict)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = self.title
        
        return mapItem
    }
    
}


class HomeLabel: NSObject, MKAnnotation {
    let title: String?
    let objective: String
    let discipline: String
    let level: String
    let coordinate: CLLocationCoordinate2D
    let image: UIImage
    let lat: Double
    let long: Double
    let alt: Double
    let PinType: String
    let xp: String
    let mapURL: String
    let objectURL: String
    let isMission: Bool
    let missionID: String
    

    let missionLevel: String
    let imageName: String
    
    let TotalPlayerAttributesTemp: TotalPlayerAttributes
    let killcount: String
    let killedcount: String
    
    
    init(title: String, objective: String, discipline: String, level: String, coordinate: CLLocationCoordinate2D, image: UIImage, PinType: String, xp: String, mapURL: String, objectURL: String, isMission: Bool, missionID: String, missionLevel: String, imageName: String, TotalPlayerAttributesTemp: TotalPlayerAttributes, killcount: String, killedcount: String, altitude: Double) {
        self.title = title
        self.objective = objective
        self.discipline = discipline
        self.coordinate = coordinate
        self.level = level
        self.image = image
        self.lat = coordinate.latitude
        self.long = coordinate.longitude
        self.alt = altitude
        self.PinType = PinType
        self.xp = xp
        self.mapURL = mapURL
        self.objectURL = objectURL
        self.isMission = isMission
        self.missionID = missionID
        self.missionLevel = missionLevel
        self.imageName = imageName
        
        self.TotalPlayerAttributesTemp = TotalPlayerAttributesTemp
        self.killcount = killcount
        self.killedcount = killedcount
        
        super.init()
    }
    var subtitleNEW: String {
        return objective
    }
    
    func pinColor() -> MKPinAnnotationColor  {
        switch level {
        case "1":
            return .green
        case "2", "3":
            return .purple
        default:
            return .red
            //return .Red
        }
    }
    
    // annotation callout opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDict = [String(kABPersonAddressStreetKey): self.subtitleNEW]
        let placemark = MKPlacemark(coordinate: self.coordinate, addressDictionary: addressDict)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = self.title
        
        return mapItem
    }
    
}




class MyLabelPulse:  NSObject, MKAnnotation {
    let title: String?
    let userHealth: String
    let discipline: String
    let stealth: String
    let coordinate: CLLocationCoordinate2D
    let image: UIImage
    let isMission: Bool
    let missionID: String
    
    let xp: String
    let objective: String
    let missionLevel: String
    let imageName: String
    
    let TotalPlayerAttributesTemp: TotalPlayerAttributes
    let killcount: String
    let killedcount: String
    
    init(title: String, userHealth: String, discipline: String, stealth: String, coordinate: CLLocationCoordinate2D, image: UIImage, isMission: Bool, missionID: String, xp: String, objective: String, missionLevel: String, imageName: String, TotalPlayerAttributesTemp: TotalPlayerAttributes, killcount: String, killedcount: String, altitude: Double) {
        self.title = title
        self.userHealth = userHealth
        self.discipline = discipline
        self.coordinate = coordinate
        self.stealth = stealth
        self.image = image
        self.isMission = isMission
        self.missionID = missionID
        self.xp = xp
        self.objective = objective
        self.missionLevel = missionLevel
        self.imageName = imageName
        
        self.TotalPlayerAttributesTemp = TotalPlayerAttributesTemp
        self.killcount = killcount
        self.killedcount = killedcount
        
        super.init()
    }
    var subtitle: String? {
        return userHealth
    }
    
    func pinColor() -> MKPinAnnotationColor  {
        switch stealth {
        case "yes":
            return .red
        case "Mural", "Monument":
            return .green
        default:
            return .purple
            //return .Red
        }
    }
    
    // annotation callout opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDict = [String(kABPersonAddressStreetKey): self.subtitle]
        let placemark = MKPlacemark(coordinate: self.coordinate, addressDictionary: addressDict as! [String: String])
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = self.title
        
        return mapItem
    }
    
}

class MyBaseLabel: NSObject, MKAnnotation {
    let title: String?
    let userHealth: String
    let discipline: String
    let stealth: String
    let coordinate: CLLocationCoordinate2D
    let image: UIImage
    let lat: Double
    let long: Double
    let alt: Double
    let PinType: String
    let GoldAmount: String
    let isMission: Bool
    let missionID: String
    
    let xp: String
    let objective: String
    let missionLevel: String
    let imageName: String
    
    let TotalPlayerAttributesTemp: TotalPlayerAttributes
    let killcount: String
    let killedcount: String
    
    init(title: String, userHealth: String, discipline: String, stealth: String, coordinate: CLLocationCoordinate2D, image: UIImage, PinType: String, GoldAmount: String, isMission: Bool, missionID: String, xp: String, objective: String, missionLevel: String, imageName: String, TotalPlayerAttributesTemp: TotalPlayerAttributes, killcount: String, killedcount: String, altitude: Double) {
        self.title = title
        self.userHealth = userHealth
        self.discipline = discipline
        self.coordinate = coordinate
        self.stealth = stealth
        self.image = image
        self.lat = coordinate.latitude
        self.long = coordinate.longitude
        self.alt = altitude
        self.PinType = PinType
        self.GoldAmount = GoldAmount
        self.isMission = isMission
        self.missionID = missionID
        self.xp = xp
        self.objective = objective
        self.missionLevel = missionLevel
        self.imageName = imageName
        
        self.TotalPlayerAttributesTemp = TotalPlayerAttributesTemp
        self.killcount = killcount
        self.killedcount = killedcount
        
        super.init()
    }
    var subtitleNEW: String {
        return userHealth
    }
    
    func pinColor() -> MKPinAnnotationColor  {
        switch stealth {
        case "yes":
            return .red
        case "Mural", "Monument":
            return .purple
        default:
            return .green
            //return .Red
        }
    }
    
    // annotation callout opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDict = [String(kABPersonAddressStreetKey): self.subtitleNEW]
        let placemark = MKPlacemark(coordinate: self.coordinate, addressDictionary: addressDict)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = self.title
        
        return mapItem
    }
    
}


class OtherBaseLabel: NSObject, MKAnnotation {
    let title: String?
    let userHealth: String
    let discipline: String
    let stealth: String
    let coordinate: CLLocationCoordinate2D
    let image: UIImage
    let lat: Double
    let long: Double
    let alt: Double
    let PinType: String
    let GoldAmount: String
    let isMission: Bool
    let missionID: String
    
    let xp: String
    let objective: String
    let missionLevel: String
    let imageName: String
    
    let TotalPlayerAttributesTemp: TotalPlayerAttributes
    let killcount: String
    let killedcount: String

    
    init(title: String, userHealth: String, discipline: String, stealth: String, coordinate: CLLocationCoordinate2D, image: UIImage, PinType: String, GoldAmount: String, isMission: Bool, missionID: String, xp: String, objective: String, missionLevel: String, imageName: String, TotalPlayerAttributesTemp: TotalPlayerAttributes, killcount: String, killedcount: String, altitude: Double) {
        self.title = title
        self.userHealth = userHealth
        self.discipline = discipline
        self.coordinate = coordinate
        self.stealth = stealth
        self.image = image
        self.lat = coordinate.latitude
        self.long = coordinate.longitude
        self.alt = altitude
        self.PinType = PinType
        self.GoldAmount = GoldAmount
        self.isMission = isMission
        self.missionID = missionID
        self.xp = xp
        self.objective = objective
        self.missionLevel = missionLevel
        
        self.imageName = imageName
        
        self.TotalPlayerAttributesTemp = TotalPlayerAttributesTemp
        self.killcount = killcount
        self.killedcount = killedcount

        super.init()
    }
    var subtitleNEW: String {
        return userHealth
    }
    
    func pinColor() -> MKPinAnnotationColor  {
        switch stealth {
        case "yes":
            return .red
        case "Mural", "Monument":
            return .purple
        default:
            return .green
            //return .Red
        }
    }
    
    // annotation callout opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDict = [String(kABPersonAddressStreetKey): self.subtitleNEW]
        let placemark = MKPlacemark(coordinate: self.coordinate, addressDictionary: addressDict)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = self.title
        
        return mapItem
    }
    
}
