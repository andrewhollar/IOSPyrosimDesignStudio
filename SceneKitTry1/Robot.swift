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
    var neuronNodes = [SCNNode]()
    //joints
    //synapse matrix
    
    init(){
    
    }
    
    func addShapeNode(node: SCNNode){
        shapeNodes.append(node)
    }
    
    func removeShapeNode(node: SCNNode){
        if let index = shapeNodes.index(of:node) {
            shapeNodes.remove(at: index)
        }
    }
    
    func addNeuronNode(node: SCNNode){
        neuronNodes.append(node)
    }
    
    func removeNeuronNode(node: SCNNode){
        if let index = neuronNodes.index(of:node) {
            neuronNodes.remove(at: index)
        }
    }
    
    func getNeuronNodes() -> [SCNNode]{
        return neuronNodes
    }
    
    func getShapeNodes() -> [SCNNode]{
        return shapeNodes
    }
    
}
