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
    var shapeManager: ShapeManager
    var robot: Robot
    
    var jointScroll: UIScrollView
    var shapeScroll: UIScrollView
    var trashButton: UIButton
    
    init(controller: StudioViewController){
        self.viewController = controller
        self.shapeManager = controller.getShapeManager()
        
        self.robot = controller.getRobot()
        
        let toolbar = CGRect(x:0,y:0,width:50,height:350)
        self.trashButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50)) //sensors
        
        let shapeFrame = CGRect(x:0,y:50,width:50,height:0)
        shapeScroll = UIScrollView(frame: shapeFrame)
        shapeScroll.backgroundColor = UIColor.init(red:1,green:1,blue:1,alpha:0.3)
        
        let jointFrame = CGRect(x:0,y:200,width:50,height:0)
        jointScroll = UIScrollView(frame: jointFrame)
        jointScroll.backgroundColor = UIColor.init(red:1,green:1,blue:1,alpha:0.3)
        
        

        super.init(frame: toolbar)
        //backgroundColor = UIColor.darkGray
        
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
        
        trashButton.addTarget(self, action: #selector(throwAwayCurrentObject), for: .primaryActionTriggered)
        trashButton.setImage(UIImage(named: "trashButton"), for: UIControl.State.normal)
        addSubview(trashButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func update(){
        //reset frames
        resetFrames()
        
        //Update Shapes
        for view in shapeScroll.subviews{
            view.removeFromSuperview()
        }
        var i = 0;
        for node in robot.getShapeNodes(){
            let selectPartButton = UIButton(frame: CGRect(x: 12, y: (i*(25+12))+12, width: 25, height: 25))
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
            let selectPartButton = UIButton(frame: CGRect(x: 12, y: (i*(25+12))+12, width: 25, height: 25))
            selectPartButton.backgroundColor = node.geometry?.firstMaterial?.diffuse.contents as! UIColor
            selectPartButton.setTitle("J\(i)", for: .normal)
            selectPartButton.addTarget(self, action: #selector(setCurrentShape), for: .primaryActionTriggered)
            jointScroll.addSubview(selectPartButton)
            i+=1
        }
        
    }
    
    func resetFrames(){
        var shapeScrollHeight = robot.getShapeNodes().count * (25+12)+12
        if(shapeScrollHeight == 12){
            shapeScrollHeight = 0
        }
        let phoneHeight = viewController.view.bounds.maxY - viewController.view.bounds.minY
        if(shapeScrollHeight > Int(0.25*phoneHeight)){
            shapeScrollHeight = Int(phoneHeight * 0.25)
        }
        //shapeScrollHeight = shapeScrollHeight/50 * 50 //rounds down to nearest 50
        shapeScroll.frame = CGRect(x:0,y:0 + 55,width:50,height:shapeScrollHeight)
        
        var jointScrollHeight = robot.getJointNodes().count * (25+12) + 12
        if(jointScrollHeight == 12){
            jointScrollHeight = 0
        }
        if(jointScrollHeight > Int(0.25*phoneHeight)){
            jointScrollHeight = Int(phoneHeight * 0.25)
        }
        //jointScrollHeight = jointScrollHeight/50 * 50 //rounds down to nearest 50
        jointScroll.frame = CGRect(x:0,y:shapeScrollHeight + 55 + 2,width:50,height:jointScrollHeight)
        
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
    
    @objc func throwAwayCurrentObject(sender: UIButton){
        if(viewController.getCurrentShape() != nil){
            //Remove from view
            shapeManager.removeNode(node: viewController.getCurrentShape()!)
            
            //Delete from Robot Management
            robot.removeCurrentShape(node: viewController.getCurrentShape()!)
            
            ///OTHER PLACES STORED
            viewController.hideDraggers()
            
            //Delete from heirarchy view
            update()
            
            //Set the current shape to the first in the list (if it's there)
            if(viewController.getCurrentShape()!.isKind(of: Joint.self)){
                if robot.getJointNodes().first != nil {
                    viewController.setCurrentShape(node: robot.getJointNodes().first!)
                }
            }else{
                if robot.getShapeNodes().first != nil {
                    viewController.setCurrentShape(node: robot.getShapeNodes().first!)
                }
            }
            
            
        }

    }
}
