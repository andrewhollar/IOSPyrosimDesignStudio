//
//  ToolBarShapeEditor.swift
//  SceneKitTry1
//
//  Created by William Sutton on 3/7/19.
//  Copyright © 2019 ahollar. All rights reserved.
//

import UIKit
import SceneKit

class ToolBarShapeEditor {
    
    var viewController: StudioViewController
    var toolBarRobotParts: ToolBarRobotParts
    
    init(controller: StudioViewController){
        self.viewController = controller
        self.toolBarRobotParts = controller.getToolBarRobotParts()
        draw()
    }
    
    func draw(){
        let toolbar = CGRect(x:0,y:700,width:800,height:100)
        let toolView = UIView(frame:toolbar)
        toolView.backgroundColor = UIColor.init(red:150,green:150,blue:150, alpha: 1)
        
        //sphere button
        let sphereButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        sphereButton.backgroundColor = UIColor.purple
        sphereButton.setTitle("addX", for: .normal)
        sphereButton.addTarget(self, action: #selector(handleButtonPress), for: .primaryActionTriggered)
        toolView.addSubview(sphereButton)
        
        //rectangle button
        let rectButton = UIButton(frame: CGRect(x: 100, y: 0, width: 100, height: 50))
        rectButton.backgroundColor = UIColor.purple
        rectButton.setTitle("subX", for: .normal)
        rectButton.addTarget(self, action: #selector(handleButtonPress), for: .primaryActionTriggered)
        toolView.addSubview(rectButton)
        viewController.view.addSubview(toolView)
    }
    
    @objc
    func handleButtonPress(sender: UIButton!) {
        switch(sender.currentTitle) {
        case "addX":
            print("adding x")
            viewController.getCurrentShape().position.x += 1
        case "subX":
            print("subtracting x")
            viewController.getCurrentShape().position.x -= 1
        case "addY":
            print("adding y")
            viewController.getCurrentShape().position.y += 1
        case "subY":
            print("subtracting y")
            viewController.getCurrentShape().position.y -= 1
        case "addZ":
            print("adding z")
            viewController.getCurrentShape().position.z += 1
        case "subZ":
            print("subtracting z")
            //if z < ground height, do not lower futher
            viewController.getCurrentShape().position.z -= 1
            
        default:
            print("Button press could not be handled, unrecognized name.")
        }
    }
    
    
    
    
    
}
