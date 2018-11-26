//
//  ArmyGeneralIntroScene.swift
//  BattleField
//
//  Created by Jared Stevens2 on 4/5/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit

class ArmyGeneralIntroScene: SCNScene {
    var cameraNode: SCNNode?
    
    override init() {
        super.init()
        
        
        /*
         let sphereGeometry = SCNSphere(radius: 1.0)
         sphereGeometry.firstMaterial?.diffuse.contents = UIColor.orangeColor()
         let sphereNode = SCNNode(geometry: sphereGeometry)
         self.rootNode.addChildNode(sphereNode)
         
         */
        //  var scene = SCNScene(named: "PlayerSceneKit/playerOBJ.scn")
        //var scene = SCNScene(named: "playerModel")
        // var scene = SCNScene(named: "playerOBJ.scn")
        
        //   let bundle = NSBundle.mainBundle()
        //  let path = bundle.pathForResource("playerobj2", ofType: "obj")
        //   let url = NSURL(fileURLWithPath: path!)
        
        
        let scene = SCNScene(named: "ArmyUser3D.dae")
        
        
        let camera = SCNCamera()
        camera.usesOrthographicProjection = true
        camera.orthographicScale = 0.35
        camera.zNear = 0
        camera.zFar = 30
        camera.xFov = 50
        
        
        
        let node = SCNNode()
        node.camera = camera
        scene?.rootNode.addChildNode(node)
        print("Scene Root = \(scene?.rootNode.childNodes)")
        
        node.position = SCNVector3(0.0, 0.0, 50.0)
        
        let cur = node.rotation
        
        
        
        print("root node name = \(scene?.rootNode)")
        
        
        let MilitaryModel = scene?.rootNode.childNode(withName: "MDL_Obj", recursively: true)
        MilitaryModel?.position = SCNVector3(0.0, -0.3, -20.0)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "Army Soldier_DIFF.png")
        //  material.specular.contents = UIColor.whiteColor()
        MilitaryModel?.geometry?.firstMaterial = material
        
        
        node.addChildNode(MilitaryModel!)
        
        
        // let view = SCNView(frame: self.view.bounds)
        //    view.scene = scene
        //  let characterTopLevelNode = scene?.rootNode.childNodes[0]
        //characterTopLevelNode.l
        
        //    scene.position = SCNVector3(x: 3.0, y: 0.0, z: 0.0)
        // self.rootNode.addChildNode(characterTopLevelNode!)
        
        self.rootNode.addChildNode(node)
        //self.rootNode.ad
        
        
        let secondSphereGeometry = SCNSphere(radius: 0.5)
        secondSphereGeometry.firstMaterial?.diffuse.contents = UIColor.purple
        let secondSphereNode = SCNNode(geometry: secondSphereGeometry)
        secondSphereNode.position = SCNVector3(x: 0.0, y: 0.0, z: -10.0)
        //  self.rootNode.addChildNode(secondSphereNode)
        
        self.background.contents = UIImage(named: "FOShelterBG.png")
        
        
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "paused" {
            self.isPaused = change![NSKeyValueChangeKey.newKey] as! Bool
        }
    }
    
    
    
    
}
