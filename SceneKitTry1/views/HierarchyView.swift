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
        shapeScroll = UIScrollView()
        jointScroll = UIScrollView()
        let toolbar = CGRect(x:0,y:800,width:100,height:500)

        super.init(frame: toolbar)
        
        let contentWidth = bounds.width
        let contentHeight = bounds.height * 5
        shapeScroll.contentSize = CGSize(width: contentWidth, height: contentHeight)
        shapeScroll.layer.borderWidth = 2
        shapeScroll.layer.borderColor = UIColor.black.cgColor
        shapeScroll.layer.backgroundColor = UIColor.yellow.cgColor
        shapeScroll.translatesAutoresizingMaskIntoConstraints = false
        //controller.getView.addSubview(shapeScroll)
        controller.view.addSubview(shapeScroll)
        shapeScroll.leftAnchor.constraint(equalTo: controller.view.leftAnchor, constant: 0).isActive = true
        shapeScroll.topAnchor.constraint(equalTo: controller.view.topAnchor, constant: 0).isActive = true
        shapeScroll.widthAnchor.constraint(equalTo: controller.view.widthAnchor, multiplier: 0.1).isActive = true
        shapeScroll.heightAnchor.constraint(equalTo: controller.view.heightAnchor, multiplier: 0.2).isActive = true
        
       
        jointScroll.contentSize = CGSize(width: contentWidth, height: contentHeight)
        jointScroll.layer.borderWidth = 2
        jointScroll.layer.borderColor = UIColor.black.cgColor
        jointScroll.layer.backgroundColor = UIColor.yellow.cgColor
        jointScroll.translatesAutoresizingMaskIntoConstraints = false
        //controller.getView.addSubview(shapeScroll)
        controller.view.addSubview(jointScroll)
        jointScroll.leftAnchor.constraint(equalTo: controller.view.leftAnchor, constant: 0).isActive = true
        jointScroll.topAnchor.constraint(equalTo: shapeScroll.bottomAnchor, constant: 0).isActive = true
        jointScroll.widthAnchor.constraint(equalTo: controller.view.widthAnchor, multiplier: 0.1).isActive = true
        jointScroll.heightAnchor.constraint(equalTo: controller.view.heightAnchor, multiplier: 0.2).isActive = true
        
        //addSubview(shapeScroll)

        /*
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(StudioViewController.cameraChanged(_:)), for: .valueChanged)
        scnView.addSubview(segmentedControl)
        
        segmentedControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant:  -15).isActive = true
        segmentedControl.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
 */
        /*        let shapeFrame = CGRect(x:0,y:33,width:77,height:150)
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
        addSubview(jointScroll) */
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
