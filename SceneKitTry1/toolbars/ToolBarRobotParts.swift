//
//  ToolBarRobotParts.swift
//  SceneKitTry1
//
//  Created by William Sutton on 2/28/19.
//  Copyright © 2019 ahollar. All rights reserved.
//

import Foundation
import UIKit
import SceneKit

class ToolBarRobotParts{
    var viewController: StudioViewController
    var shapeNodes = [SCNNode]()
    let toolView: UIView
    
    init(controller: StudioViewController){
        self.viewController = controller
        let toolbar = CGRect(x:0,y:33,width:77,height:300)
        toolView = UIView(frame:toolbar)
        toolView.backgroundColor = UIColor.darkGray
        viewController.view.addSubview(toolView)
    }
    
    func update(){
        for view in toolView.subviews{
            view.removeFromSuperview()
        }
        var i = 0;
        for node in shapeNodes{
            i+=1;
            let displayShape = CGRect(x:15,y:(i*30)+15,width:25,height:25)
            let displayView = UIView(frame:displayShape)
            displayView.backgroundColor = UIColor.white
            toolView.addSubview(displayView)
        }
        
    }
    
    func addShapeNode(node: SCNNode){
        shapeNodes.append(node)
        viewController.setCurrentShape(node: node)
        update()
    }
    
    func removeShapeNode(node: SCNNode){
        if let index = shapeNodes.index(of:node) {
            shapeNodes.remove(at: index)
            update()
        }
    }
    
}
