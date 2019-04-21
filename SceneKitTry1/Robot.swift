//
//  Robot.swift
//  SceneKitTry1
//
//  Created by William Sutton on 3/29/19.
//  Copyright © 2019 ahollar. All rights reserved.
//

import Foundation
import UIKit
import SceneKit

class Robot{
    
    var shapeNodes = [SCNNode]()
    var jointNodes = [Joint]()
    var sensorNodes = [Sensor]()
    //synapse matrix

    func addShapeNode(node: SCNNode){
        shapeNodes.append(node)
    }
    
    func removeShapeNode(node: SCNNode){
        if let index = shapeNodes.index(of:node) {
            shapeNodes.remove(at: index)
        }
    }
    
    func addJointNode(joint: Joint){
        jointNodes.append(joint)
    }
    
    func removeJointNode(joint: Joint){
        if let index = jointNodes.index(of:joint) {
            jointNodes.remove(at: index)
        }
    }
    
    func getJointNodes() -> [Joint]{
        return jointNodes
    }
    
    func getShapeNodes() -> [SCNNode]{
        return shapeNodes
    }
    
    func removeCurrentShape(node: SCNNode){
        if(node.isKind(of: Joint.self)){
            removeJointNode(joint: node as! Joint)
        }else{
            removeShapeNode(node: node)
        }
        
    }
}

class Joint: SCNNode {
    var from: SCNNode?
    var to: SCNNode?
    var direction: vector_double3
    

    init(jointGeometry: SCNGeometry) {
        self.direction = vector_double3(1,1,1)
        super.init()
        geometry = jointGeometry
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class Sensor: SCNNode {
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
