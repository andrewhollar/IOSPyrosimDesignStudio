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
    var neuronNodes = [SCNNode]()
    let toolView: UIScrollView!
    
    init(controller: StudioViewController){
        self.viewController = controller
        let toolbar = CGRect(x:0,y:33,width:77,height:300)
        //toolView = UIView(frame:toolbar)
        //toolView.backgroundColor = UIColor.darkGray
        //viewController.view.addSubview(toolView)
        
        toolView = UIScrollView(frame: toolbar)
        toolView.backgroundColor = UIColor.darkGray
        
        let contentWidth = toolView.bounds.width
        let contentHeight = toolView.bounds.height * 5
        toolView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        
        viewController.view.addSubview(toolView)
        
    }
    
    func update(){
        for view in toolView.subviews{
            view.removeFromSuperview()
        }
        var i = 0;
        for node in shapeNodes{
            let selectPartButton = UIButton(frame: CGRect(x: 15, y: (i*30)+15, width: 25, height: 25))
            selectPartButton.backgroundColor = node.geometry?.firstMaterial?.diffuse.contents as! UIColor
            selectPartButton.setTitle("O\(i)", for: .normal)
            selectPartButton.addTarget(self, action: #selector(setCurrentShape), for: .primaryActionTriggered)
            toolView.addSubview(selectPartButton)
            i+=1
        }
        
    }
    
    @objc
    func setCurrentShape(sender: UIButton!) {
        var title = sender.currentTitle!
        let objectType = title.first!
        let index = Int(title.dropFirst())!
        if(objectType == "O"){
            viewController.setCurrentShape(node: shapeNodes[index])
        }
        update()
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
