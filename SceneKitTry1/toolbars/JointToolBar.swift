//
//  NeuronToolBar.swift
//  SceneKitTry1
//
//  Created by William Sutton on 4/2/19.
//  Copyright © 2019 ahollar. All rights reserved.
//

import Foundation
import UIKit
import SceneKit

class JointToolBar: UIView{
    
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
        let jointButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50)) //joint button
        jointButton.addTarget(self, action: #selector(addJoint), for: .primaryActionTriggered)
        jointButton.setImage(UIImage(named: "hingeJointButton"), for: UIControl.State.normal)
        addSubview(jointButton)
    }
    
    func addButtonsToView() {
        
    }
    
    @objc
    func addJoint() {
        let joint = shapeManager.spawnJoint()
        robot.addJointNode(joint: joint)
        viewController.setCurrentShape(node: joint)
    }
    
}
