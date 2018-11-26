//
//  Map.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/6/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

//import Foundation

//
//  Map.swift
//  FPSControls
//
//  Created by Nick Lockwood on 06/11/2014.
//  Copyright (c) 2014 Nick Lockwood. All rights reserved.
//

import UIKit

class Map {
    
    let width: Int, height: Int
    fileprivate (set) var tiles: [Tile]
    var entities = [Entity]()
    
    init(width: Int, height: Int) {
        
        self.width = width
        self.height = height
        
        tiles = [Tile]()
        for y in 0 ..< height {
            for x in 0 ..< width {
                tiles.append(Tile(map: self, x: x, y: y))
            }
        }
    }
    
    convenience init(image: UIImage) {
        
        //create image context
        let width = Int((image.cgImage?.width)!)
        let height = Int((image.cgImage?.height)!)
        let bytesPerPixel = 4
        let bytesPerRow = width * bytesPerPixel
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let info = CGImageAlphaInfo.premultipliedFirst.rawValue
        
        let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: info);
        
        //let pixelData: NSData = context!.data
        
        
     //   let dataTemp = context!.data
       // let data = UnsafePointer<UInt8>(dataTemp)
       
        
        //data.bytes.assumingMemoryBound(to: UInt8.self)
        
        // let pixelData = image.cgImage!.dataProvider!.data
        
       // let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData as! CFData!)
        //let data: UnsafePointer<UInt8> = CFDataGetBytePtr(context?.data as! CFData!)
        
        //let data = context.assumin
        
       // let pixelData = newImage?.dataProvider!.data
      //  let data: UnsafePointer<UInt8> = CFDataGetBytePtr(context!.data)
        
       // let data: UnsafePointer<UInt8> = UnsafePointer<UInt8>(context?.data)
        
     //   let data = uncastedData?.assumingMemoryBound(to: UInt8.self)
        
        
        
        
       // let uint8Ptr = UnsafeMutablePointer<UInt8>.allocate(capacity: data.count)
       // uint8Ptr.initialize(from: data) //<-copying the data
        //You need to keep `uint8Ptr` and `data.count` for future management
      //  let uint8PtrCount = data.count
        //You can convert it to `UnsafeRawPointer`
       // let data = UnsafeRawPointer(uint8Ptr)
        
        //let data = pixelData.uns
        
        
      //  let data = UnsafePointer<UInt8>(context?.data)
        
        
       let data = context!.data?.assumingMemoryBound(to: UInt8.self)

        
        //draw image into context
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        context?.draw(image.cgImage!, in: rect)
        
        //enumerate pixels to generate tiles
        self.init(width: width, height: height)
        for i in 0 ..< width * height {
            
            //get color components
            let offset = i * bytesPerPixel
            let redU = data?[offset + 1]
            let greenU = data?[offset + 2]
            let blueU = data?[offset + 3]
            
            let red: Int = toInt(unsigned: UInt(redU!))
            let green: Int = toInt(unsigned: UInt(greenU!))
            let blue: Int = toInt(unsigned: UInt(blueU!))
            
            print("***RED \(red)")
            
          //  let alpha = data.load(fromByteOffset: offset, as: UInt8.self)
          //  let red = data.load(fromByteOffset: offset+1, as: UInt8.self)
          //  let green = data.load(fromByteOffset: offset+2, as: UInt8.self)
          //  let blue = data.load(fromByteOffset: offset+3, as: UInt8.self)
            
            
            //print("Tiles: \(tiles)")
            
            //convert color to tile type
            let tile = tiles[i]
            
            print("Item i for x:\(tiles[i].x) and y:\(tiles[i].y): red =\(red) green=\(green) blue=\(blue)")
            
            
            
            switch (red, green, blue) {
            case (0, 0, 0):
                tile.type = .floor
            case (0, 255, 0):
                print("***HERO FOUND***")
                entities.append(Entity(type: .hero, x: Float(tile.x) + 0.5, y: Float(tile.y) + 0.5))
                tile.type = .floor
            case (255, 0, 0):
                entities.append(Entity(type: .monster, x: Float(tile.x) + 0.5, y: Float(tile.y) + 0.5))
                tile.type = .floor
            case (255, 255, 0):
                entities.append(Entity(type: .enemy, x: Float(tile.x) + 0.5, y: Float(tile.y) + 0.5))
                tile.type = .floor
            case (200, 200, 0):
                entities.append(Entity(type: .box, x: Float(tile.x) + 0.5, y: Float(tile.y) + 0.5))
                tile.type = .floor
            case (255, 255, 155):
               // print("Mission Item Entity Color found")
                entities.append(Entity(type: .missionItem, x: Float(tile.x) + 0.5, y: Float(tile.y) + 0.5))
                tile.type = .floor
            case (25, 25, 250):
                // print("Mission Item Entity Color found")
                //entities.append(Entity(type: .missionItem, x: Float(tile.x) + 0.5, y: Float(tile.y) + 0.5))
                //tile.type = .floor
                tile.type = .unlock
                
            case (128, 128, 128):
                tile.type = .wall
            case (10, 255, 10):
                tile.type = .grass
            default:
                print("Unique Color Found: x:\(tile.x) y: \(tile.y), Red:\(red) Blue:\(blue) Green:\(green)")
                
                tile.type = .rock
            }
            
            
            
            /*
            
            if red.description == "0" && blue.description == "255" && green.description == "0" {
                
                print("is hero")
                
                entities.append(Entity(type: .hero, x: Float(tile.x) + 0.5, y: Float(tile.y) + 0.5))

                
            } else {
               
                
                */
                /*
            
                print("is not hero")
             
             switch (red.description as String, green.description as String, blue.description as String) {
             case ("0", "0", "0"):
             tile.type = .floor
             case ("0", "255", "0"):
             print("***HERO FOUND***")
             entities.append(Entity(type: .hero, x: Float(tile.x) + 0.5, y: Float(tile.y) + 0.5))
             tile.type = .floor
             case ("255", "0", "0"):
             entities.append(Entity(type: .monster, x: Float(tile.x) + 0.5, y: Float(tile.y) + 0.5))
             tile.type = .floor
             case ("255", "255", "0"):
             entities.append(Entity(type: .enemy, x: Float(tile.x) + 0.5, y: Float(tile.y) + 0.5))
             tile.type = .floor
             case ("200", "200", "0"):
             entities.append(Entity(type: .box, x: Float(tile.x) + 0.5, y: Float(tile.y) + 0.5))
             tile.type = .floor
             case ("255", "255", "155"):
             // print("Mission Item Entity Color found")
             entities.append(Entity(type: .missionItem, x: Float(tile.x) + 0.5, y: Float(tile.y) + 0.5))
             tile.type = .floor
             case ("128", "128", "128"):
             tile.type = .wall
             case ("10", "255", "10"):
             tile.type = .grass
             default:
             print("Unique Color Found: x:\(tile.x) y: \(tile.y), Red:\(red) Blue:\(blue) Green:\(green)")
             
             tile.type = .rock
             }
 */
            
        //    }
            
            
            /*
            
            if red.description == "0" && green.description == "0" && blue.description == "0" {
                tile.type = .floor
            } else if red.description == "0" && green.description == "255" && blue.description == "2" {
                
                print("HERO FOUND")
                entities.append(Entity(type: .hero, x: Float(tile.x) + 0.5, y: Float(tile.y) + 0.5))
                tile.type = .floor
            } else if red.description == "255" && green.description == "0" && blue.description == "0" {
                entities.append(Entity(type: .monster, x: Float(tile.x) + 0.5, y: Float(tile.y) + 0.5))
                tile.type = .floor
            } else if red.description == "255" && green.description == "255" && blue.description == "0" {
                entities.append(Entity(type: .enemy, x: Float(tile.x) + 0.5, y: Float(tile.y) + 0.5))
                tile.type = .floor
            } else if red.description == "128" && green.description == "128" && blue.description == "128" {
                tile.type = .wall
                
            } else if red.description == "10" && green.description == "255" && blue.description == "10" {
                    
                tile.type = .grass
                
            } else {
                tile.type = .rock
            }
            
            */
           
        }
      //  }
      //  }
    }
    
    
    
    
    func processPixelsInImage(_ inputImage: UIImage, xLoc: CGFloat, yLoc: CGFloat, newRed: UInt8, newGreen: UInt8, newBlue: UInt8) -> UIImage {
        
        var tiles: [Tile]!
        var entities = [Entity]()
        
        
        
        
        let inputCGImage     = inputImage.cgImage
        let colorSpace       = CGColorSpaceCreateDeviceRGB()
        let width            = inputCGImage?.width
        let height           = inputCGImage?.height
        let bytesPerPixel    = 4
        let bitsPerComponent = 8
        let bytesPerRow      = bytesPerPixel * width!
        let bitmapInfo       = CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue
        
        let context = CGContext(data: nil, width: width!, height: height!, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo)!
        context.draw(inputCGImage!, in: CGRect(x: 0, y: 0, width: CGFloat(width!), height: CGFloat(height!)))
        
        //let pixelBuffer = UnsafeMutablePointer<UInt32>(context.data)
        
        
      //  let uncastedData = context.data
        
        //let data = context.assumin
       // let pixelBuffer = uncastedData?.assumingMemoryBound(to: Int.self)
        
        //let pixelBuffer: UnsafePointer<UInt8> = CFDataGetBytePtr(uncastedData as! CFData!)
        
      //  let pixelData = inputImage.cgImage!.dataProvider!.data
        
       // let pixelBuffer: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        
        let pixelBuffer = context.data?.assumingMemoryBound(to: UInt8.self)
        
       // let pixelBuffer = uncastedData?.assumingMemoryBound(to: UInt8.self)
        
        var currentPixel = pixelBuffer
        
        /*
         for var i = 0; i < Int(height); i++ {
         for var j = 0; j < Int(width); j++ {
         let pixel = currentPixel.memory
         if red(pixel) == 0 && green(pixel) == 0 && blue(pixel) == 0 {
         currentPixel.memory = rgba(red: 255, green: 0, blue: 0, alpha: 255)
         }
         currentPixel++
         }
         }
         
         */
        
        
        for j in 0 ..< width! * height! {
            
            //get color components
            let offset = j * bytesPerPixel
            let red = pixelBuffer?[offset + 1]
            let green = pixelBuffer?[offset + 2]
            let blue = pixelBuffer?[offset + 3]
            
            
            print("Tiles: \(tiles)")
            
            //convert color to tile type
            let tile = tiles[j]
            
            print("Item i for x:\(tiles![j].x) and y:\(tiles![j].y): red =\(red) green=\(green) blue=\(blue)")
            
            
            
            if (tiles![j].x == Int(xLoc)) && (tiles![j].y == Int(yLoc)) {
               // currentPixel.pointee = UInt8
                currentPixel?.pointee = UInt8(rgba(red: newRed, green: newGreen, blue: newBlue, alpha: 255))
                
            }
            
            print("UPDATED Item i for x:\(tiles![j].x) and y:\(tiles![j].y): newRed =\(newRed) newGreen=\(newGreen) newBlue=\(newBlue)")
            
           // let one = 1 as! UnsafeMutablePoint<Int>
            
            currentPixel = currentPixel! + 1
        }
        
        
        let outputCGImage = context.makeImage()
        let outputImage = UIImage(cgImage: outputCGImage!, scale: inputImage.scale, orientation: inputImage.imageOrientation)
        
        return outputImage
    }
    
    func alpha(_ color: UInt32) -> UInt8 {
        return UInt8((color >> 24) & 255)
    }
    
    func red(_ color: UInt32) -> UInt8 {
        return UInt8((color >> 16) & 255)
    }
    
    func green(_ color: UInt32) -> UInt8 {
        return UInt8((color >> 8) & 255)
    }
    
    func blue(_ color: UInt32) -> UInt8 {
        return UInt8((color >> 0) & 255)
    }
    
    func rgba(red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8) -> UInt32 {
        return (UInt32(alpha) << 24) | (UInt32(red) << 16) | (UInt32(green) << 8) | (UInt32(blue) << 0)
    }
    
    
    
    
    func tile(_ x: Int, _ y: Int) -> Tile {
        
        return tiles[y * width + x]
    }
}

func toInt(unsigned: UInt) -> Int {
    
    let signed = (unsigned <= UInt(Int.max)) ?
        Int(unsigned) :
        Int(unsigned - UInt(Int.max) - 1) + Int.min
    
    return signed
}
