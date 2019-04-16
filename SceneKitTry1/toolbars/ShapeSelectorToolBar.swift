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
    
    var sphereButton: UIButton
    var cylinderButton: UIButton
    var rectButton: UIButton
    var jointButton: UIButton
    //var sensorsButton: UIButton
    
    var buttonSize = 75

    init(controller: StudioViewController){
        self.viewController = controller
        self.shapeManager = controller.getShapeManager()
        self.robot = controller.getRobot()
        
        let toolbar = CGRect(x:0,y:700,width:800,height:buttonSize)
        //backgroundColor = UIColor.init(red:0.7,green:0.7,blue:0.7, alpha: 1)
        sphereButton = UIButton(frame: CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)) //sphere button
        cylinderButton = UIButton(frame: CGRect(x: buttonSize, y: 0, width: buttonSize, height: buttonSize)) //cylinder button
        rectButton = UIButton(frame: CGRect(x: 2*buttonSize, y: 0, width: buttonSize, height: buttonSize)) //rectangle button
        jointButton = UIButton(frame: CGRect(x: 3*buttonSize, y: 0, width: buttonSize, height: buttonSize)) //rectangle button

        
        super.init(frame: toolbar)
        viewController.view.addSubview(self)
//        sphereButton.translatesAutoresizingMaskIntoConstraints = false
//        viewController.view.addSubview(sphereButton)
//        viewController.view.addSubview(cylinderButton)
//        viewController.view.addSubview(rectButton)
//        viewController.view.addSubview(jointButton)
//
        populateWithButtons()
        //addButtonsToView()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func addButtonsToView() {
//        viewController.view.addSubview(sphereButton)
//        viewController.view.addSubview(cylinderButton)
//        viewController.view.addSubview(rectButton)
//        viewController.view.addSubview(jointButton)
//
//
//    }
    
    func populateWithButtons(){
        
        //sphereButton = UIButton(frame: CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)) //sphere button
        sphereButton.addTarget(self, action: #selector(addSphere), for: .primaryActionTriggered)
        sphereButton.setImage(UIImage(named: "sphereButton"), for: UIControl.State.normal)
        addSubview(sphereButton)

//        sphereButton.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor, constant: -150).isActive = true
//        sphereButton.widthAnchor.constraint(equalToConstant: CGFloat(buttonSize)).isActive = true
//        sphereButton.heightAnchor.constraint(equalToConstant: CGFloat(buttonSize)).isActive = true
//        sphereButton.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor, constant: 0).isActive = true
    
        sphereButton.translatesAutoresizingMaskIntoConstraints = false
        //viewController.view.addSubview(sphereButton)
        //addSubview(sphereButton)
        sphereButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        //sphereButton.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor, constant: -300).isActive = true
        //shapeButton.leftAnchor.constraint(equalTo: controller.view.leftAnchor, constant: ).isActive = true
        sphereButton.heightAnchor.constraint(equalToConstant: CGFloat(buttonSize)).isActive = true
        sphereButton.widthAnchor.constraint(equalToConstant: CGFloat(buttonSize)).isActive = true
        
        //cylinderButton = UIButton(frame: CGRect(x: buttonSize, y: 0, width: buttonSize, height: buttonSize)) //cylinder button
        cylinderButton.addTarget(self, action: #selector(addCylinder), for: .primaryActionTriggered)
        cylinderButton.setImage(UIImage(named: "cylinderButton"), for: UIControl.State.normal)
        addSubview(cylinderButton)
        
        //rectButton = UIButton(frame: CGRect(x: 2*buttonSize, y: 0, width: buttonSize, height: buttonSize)) //rectangle button
        rectButton.addTarget(self, action: #selector(addRectangle), for: .primaryActionTriggered)
        rectButton.setImage(UIImage(named: "boxButton"), for: UIControl.State.normal)
        addSubview(rectButton)
        
        //jointButton = UIButton(frame: CGRect(x: 3*buttonSize, y: 0, width: buttonSize, height: buttonSize)) //rectangle button
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
