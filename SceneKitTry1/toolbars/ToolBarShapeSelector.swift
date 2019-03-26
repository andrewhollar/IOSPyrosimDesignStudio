//
//  ToolBarShapeSelector.swift
//  SceneKitTry1
//
//  Created by William Sutton on 2/28/19.
//  Copyright © 2019 ahollar. All rights reserved.
//

import Foundation
import UIKit
import SceneKit

class ToolBarShapeSelector {
    
    var viewController: StudioViewController
    var shapeManager: ShapeManager
    var toolBarRobotParts: ToolBarRobotParts

    init(controller: StudioViewController){
        self.viewController = controller
        self.shapeManager = controller.getShapeManager()
        self.toolBarRobotParts = controller.getToolBarRobotParts()
        draw()
    }
    
    func draw(){
        let toolbar = CGRect(x:0,y:800,width:800,height:100)
        let toolView = UIView(frame:toolbar)
        toolView.backgroundColor = UIColor.gray
        
        //sphere button
        let sphereButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        sphereButton.backgroundColor = UIColor.purple
        sphereButton.setTitle("Circle", for: .normal)
        sphereButton.addTarget(self, action: #selector(handleButtonPress), for: .primaryActionTriggered)
        sphereButton.setImage(UIImage(named: "cylinderButton"), for: UIControl.State.normal)
        toolView.addSubview(sphereButton)
        
        //rectangle button
        let rectButton = UIButton(frame: CGRect(x: 100, y: 0, width: 100, height: 50))
        rectButton.backgroundColor = UIColor.purple
        rectButton.setTitle("Rectangle", for: .normal)
        rectButton.addTarget(self, action: #selector(handleButtonPress), for: .primaryActionTriggered)
        rectButton.setImage(UIImage(named: "boxButton"), for: UIControl.State.normal)
        toolView.addSubview(rectButton)
        viewController.view.addSubview(toolView)
    }
    
    @objc
    func handleButtonPress(sender: UIButton!) {
        switch(sender.currentTitle) {
        case "Circle":
            toolBarRobotParts.addShapeNode(node:shapeManager.spawnCircle())
        case "Rectangle":
            toolBarRobotParts.addShapeNode(node:shapeManager.spawnRect())
        default:
            print("Button press could not be handled, unrecognized name.")
        }
    }
    
    
    
    
    
}
