//
//  HierarchyView.swift
//  SceneKitTry1
//
//  Created by William Sutton on 3/29/19.
//  Copyright © 2019 ahollar. All rights reserved.
//

import Foundation
import UIKit
import SceneKit

class HierarchyView: UIView{
    var viewController: StudioViewController
    var robot: Robot
    var jointScroll: UIScrollView
    var shapeScroll: UIScrollView
    
    init(controller: StudioViewController){
        self.viewController = controller
        self.robot = controller.getRobot()
        
        let shapeFrame = CGRect(x:0,y:33,width:77,height:150)
        shapeScroll = UIScrollView(frame: shapeFrame)
        
        let neuronFrame = CGRect(x:0,y:183,width:77,height:150)
        jointScroll = UIScrollView(frame: neuronFrame)
        
        let toolbar = CGRect(x:0,y:33,width:77,height:350)
        super.init(frame: toolbar)
        backgroundColor = UIColor.darkGray
        
        let contentWidth = bounds.width
        let contentHeight = bounds.height * 5
        shapeScroll.contentSize = CGSize(width: contentWidth, height: contentHeight)
        shapeScroll.layer.borderWidth = 2
        shapeScroll.layer.borderColor = UIColor.black.cgColor
        jointScroll.contentSize = CGSize(width: contentWidth, height: contentHeight)
        jointScroll.layer.borderWidth = 2
        jointScroll.layer.borderColor = UIColor.black.cgColor
        addSubview(shapeScroll)
        addSubview(jointScroll)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(){
        //update Shapes
        for view in shapeScroll.subviews{
            view.removeFromSuperview()
        }
        var i = 0;
        for node in robot.getShapeNodes(){
            let selectPartButton = UIButton(frame: CGRect(x: 15, y: (i*30)+15, width: 25, height: 25))
            selectPartButton.backgroundColor = node.geometry?.firstMaterial?.diffuse.contents as! UIColor
            selectPartButton.setTitle("O\(i)", for: .normal)
            selectPartButton.addTarget(self, action: #selector(setCurrentShape), for: .primaryActionTriggered)
            shapeScroll.addSubview(selectPartButton)
            i+=1
        }
        
        //update Joints
        for view in jointScroll.subviews{
            view.removeFromSuperview()
        }
        i = 0;
        for node in robot.getJointNodes(){
            let selectPartButton = UIButton(frame: CGRect(x: 15, y: (i*30)+15, width: 25, height: 25))
            selectPartButton.backgroundColor = node.geometry?.firstMaterial?.diffuse.contents as! UIColor
            selectPartButton.setTitle("J\(i)", for: .normal)
            selectPartButton.addTarget(self, action: #selector(setCurrentShape), for: .primaryActionTriggered)
            jointScroll.addSubview(selectPartButton)
            i+=1
        }
        
    }
    
    @objc
    func setCurrentShape(sender: UIButton!) {
        let title = sender.currentTitle!
        let objectType = title.first!
        let index = Int(title.dropFirst())!
        if(objectType == "O"){
            viewController.setCurrentShape(node: robot.getShapeNodes()[index])
        }else if(objectType == "J"){
            viewController.setCurrentShape(node: robot.getJointNodes()[index])
        }
        update()
    }
    
}
