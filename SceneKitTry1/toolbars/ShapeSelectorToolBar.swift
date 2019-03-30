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

    init(controller: StudioViewController){
        self.viewController = controller
        self.shapeManager = controller.getShapeManager()
        self.robot = controller.getRobot()
        
        let toolbar = CGRect(x:0,y:700,width:800,height:100)
        super.init(frame: toolbar)
        backgroundColor = UIColor.init(red:0.7,green:0.7,blue:0.7, alpha: 1)
        populateWithButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populateWithButtons(){
        
        let sphereButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50)) //sphere button
        sphereButton.addTarget(self, action: #selector(addCircle), for: .primaryActionTriggered)
        sphereButton.setImage(UIImage(named: "cylinderButton"), for: UIControl.State.normal)
        addSubview(sphereButton)
        
        let rectButton = UIButton(frame: CGRect(x: 100, y: 0, width: 100, height: 50)) //rectangle button
        rectButton.addTarget(self, action: #selector(addRectangle), for: .primaryActionTriggered)
        rectButton.setImage(UIImage(named: "boxButton"), for: UIControl.State.normal)
        addSubview(rectButton)
    }
    
    @objc
    func addCircle() {
        let circle = shapeManager.spawnCircle()
        robot.addShapeNode(node: circle)
        viewController.setCurrentShape(node: circle)
    }
    
    @objc
    func addRectangle() {
        let rect = shapeManager.spawnRect()
        robot.addShapeNode(node: rect)
        viewController.setCurrentShape(node: rect)
    }
    
}
