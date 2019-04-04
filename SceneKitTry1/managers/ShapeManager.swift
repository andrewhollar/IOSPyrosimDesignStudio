//
//  ShapeManager.swift
//  SceneKitTry1
//
//  Created by William Sutton on 2/28/19.
//  Copyright © 2019 ahollar. All rights reserved.
//

import Foundation
import UIKit
import SceneKit


class ShapeManager {
    
    var viewController: StudioViewController
    
    init(controller: StudioViewController){
        self.viewController = controller    }
    
    func spawnCircle() -> SCNNode{
        print("spawning circle")
        let scnView = viewController.view as! SCNView
        let sphereGeometry = SCNSphere(radius: 5)
        let r = 0.9
        let g = 0.9
        let b = 0.9
        sphereGeometry.firstMaterial?.diffuse.contents = UIColor.init(red:CGFloat(r), green:CGFloat(g), blue:CGFloat(b), alpha:1)
        let sphereNode = SCNNode(geometry: sphereGeometry)
        scnView.scene?.rootNode.addChildNode(sphereNode)
        return sphereNode
    }
    
    func removeNode(node: SCNNode){
        node.removeFromParentNode()
    }
    
    func spawnRect() -> SCNNode{
        print("spawning rectangle")
        let scnView = viewController.view as! SCNView
        let rectangleGeometry = SCNBox(width: 3, height: 5, length: 3, chamferRadius: 0)
        let rectangleNode = SCNNode(geometry: rectangleGeometry)
        rectangleNode.eulerAngles = SCNVector3(0,0,0)
        scnView.scene?.rootNode.addChildNode(rectangleNode)
        return rectangleNode
    }
    
}
