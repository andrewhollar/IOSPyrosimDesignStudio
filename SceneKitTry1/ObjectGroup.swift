//
//  ObjectGroup.swift
//  SceneKitTry1
//
//  Created by William Sutton on 4/30/19.
//  Copyright © 2019 ahollar. All rights reserved.
//

import Foundation
import UIKit
import SceneKit

class ObjectGroup{
    
    var nodes = [SCNNode]()
    
    
    func addNode(node: SCNNode){
        nodes.append(node)
    }
    
    func removeNode(node: SCNNode){
        if let index = nodes.index(of:node) {
            nodes.remove(at: index)
        }
    }
    
    func setX(x: Float){
        for n in nodes{
            n.position.x = x
        }
    }
    
    func setY(y: Float){
        for n in nodes{
            n.position.y = y
        }
    }
    
    func setZ(z: Float){
        for n in nodes{
            n.position.z = z
        }
    }
    
    func setPos(x: Float, y: Float, z: Float){
        for n in nodes{
            n.position.x = x
            n.position.y = y
            n.position.z = z
        }
    }
    
}

