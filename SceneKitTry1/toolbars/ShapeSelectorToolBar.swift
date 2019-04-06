//
//  ShapeSelectorToolBar.swift
//  SceneKitTry1
//
//  Created by William Sutton on 3/29/19.
//  Copyright © 2019 ahollar. All rights reserved.
//

import Foundation
import UIKit
import SceneKit

class ShapeSelectorToolBar: UIView{
    
    var viewController: StudioViewController
    var shapeManager: ShapeManager
    var robot: Robot
    
    var buttonSize = 75

    init(controller: StudioViewController){
        self.viewController = controller
        self.shapeManager = controller.getShapeManager()
        self.robot = controller.getRobot()
        
        let toolbar = CGRect(x:0,y:700,width:800,height:buttonSize)
        super.init(frame: toolbar)
        backgroundColor = UIColor.init(red:0.7,green:0.7,blue:0.7, alpha: 1)
        populateWithButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populateWithButtons(){
        
        let sphereButton = UIButton(frame: CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)) //sphere button
        sphereButton.addTarget(self, action: #selector(addSphere), for: .primaryActionTriggered)
        sphereButton.setImage(UIImage(named: "sphereButton"), for: UIControl.State.normal)
        addSubview(sphereButton)
        
        let cylinderButton = UIButton(frame: CGRect(x: buttonSize, y: 0, width: buttonSize, height: buttonSize)) //cylinder button
        cylinderButton.addTarget(self, action: #selector(addCylinder), for: .primaryActionTriggered)
        cylinderButton.setImage(UIImage(named: "cylinderButton"), for: UIControl.State.normal)
        addSubview(cylinderButton)
        
        let rectButton = UIButton(frame: CGRect(x: 2*buttonSize, y: 0, width: buttonSize, height: buttonSize)) //rectangle button
        rectButton.addTarget(self, action: #selector(addRectangle), for: .primaryActionTriggered)
        rectButton.setImage(UIImage(named: "boxButton"), for: UIControl.State.normal)
        addSubview(rectButton)
        
        let jointButton = UIButton(frame: CGRect(x: 3*buttonSize, y: 0, width: buttonSize, height: buttonSize)) //rectangle button
        jointButton.addTarget(self, action: #selector(addJoint), for: .primaryActionTriggered)
        jointButton.setImage(UIImage(named: "hingeJointButton"), for: UIControl.State.normal)
        addSubview(jointButton)
    }
    
    @objc
    func addSphere() {
        let sphere = shapeManager.spawnSphere()
        robot.addShapeNode(node: sphere)
        viewController.setCurrentShape(node: sphere)
    }
    
    @objc
    func addCylinder() {
        let cylinder = shapeManager.spawnCylinder()
        robot.addShapeNode(node: cylinder)
        viewController.setCurrentShape(node: cylinder)
    }
    
    @objc
    func addRectangle() {
        let rect = shapeManager.spawnRect()
        robot.addShapeNode(node: rect)
        viewController.setCurrentShape(node: rect)
    }
    
    @objc
    func addJoint() {
        let joint = shapeManager.spawnJoint()
        robot.addJointNode(joint: joint)
        viewController.setCurrentShape(node: joint)
    }
    
}
