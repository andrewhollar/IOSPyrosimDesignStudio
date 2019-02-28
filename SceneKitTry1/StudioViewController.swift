//
//  GameViewController.swift
//  SceneKitTry1
//
//  Created by andrew hollar on 2/8/19.
//  Copyright © 2019 ahollar. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class StudioViewController: UIViewController {
    
    var shapeManager: ShapeManager?
    func getShapeManager() -> ShapeManager{
        return shapeManager!
    }
    var toolBarShapeSelector: ToolBarShapeSelector?
    var toolBarRobotParts: ToolBarRobotParts?
    func getToolBarRobotParts() -> ToolBarRobotParts{
        return toolBarRobotParts!
    }
    
    // Geometry
    var axesNode: SCNNode = SCNNode()
    //var geometryNode: SCNNode = SCNNode()
    
    // Gestures
    var currentAngle: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        let scene = SCNScene()

        // create camera
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(25, 0, 25)
        
        let lookAt = SCNLookAtConstraint(target: axesNode)
        cameraNode.constraints = [lookAt]
        
        scene.rootNode.addChildNode(cameraNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
        
        let omniLightNode = SCNNode()
        omniLightNode.light = SCNLight()
        omniLightNode.light!.type = SCNLight.LightType.omni
        omniLightNode.light!.color = UIColor(white: 0.75, alpha: 1.0)
        omniLightNode.position = SCNVector3Make(0, 50, 50)
        scene.rootNode.addChildNode(omniLightNode)
        
        /*
        let boxGeometry = SCNBox(width: 10.0, height: 10.0, length: 10.0, chamferRadius: 1.0)
        let boxNode = SCNNode(geometry: boxGeometry)
        let boxMaterial = SCNMaterial()
        boxMaterial.diffuse.contents = UIColor.white
        boxMaterial.transparency = 0.75
        boxGeometry.materials = [boxMaterial]
        scene.rootNode.addChildNode(boxNode)
        
        geometryNode.addChildNode(boxNode)
 
        */
        let xGeom = SCNBox(width: 0.25, height: 10, length: 0.25, chamferRadius: 0.1)
        xGeom.firstMaterial?.diffuse.contents  = UIColor(red: 150.0 / 255.0, green: 30.0 / 255.0, blue: 30.0 / 255.0, alpha: 1)
        let xNode = SCNNode(geometry: xGeom)
        xNode.position = SCNVector3(0,0,5)
        xNode.rotation = SCNVector4(x: 1, y: 0, z: 0, w: Float(Double.pi / 2))
        
        axesNode.addChildNode(xNode)
        
        let yGeom = SCNBox(width: 0.25, height: 10, length: 0.25, chamferRadius: 0.1)
        yGeom.firstMaterial?.diffuse.contents  = UIColor(red: 30.0 / 255.0, green: 150.0 / 255.0, blue: 30.0 / 255.0, alpha: 1)
        let yNode = SCNNode(geometry: yGeom)
        yNode.position = SCNVector3(0,5,0)
        
        axesNode.addChildNode(yNode)
        
        let zGeom = SCNBox(width: 0.25, height: 10, length: 0.25, chamferRadius: 0.1)
        zGeom.firstMaterial?.diffuse.contents  = UIColor(red: 30.0 / 255.0, green: 30.0 / 255.0, blue: 150.0 / 255.0, alpha: 1)
        let zNode = SCNNode(geometry: zGeom)
        zNode.position = SCNVector3(5,0,0)
        zNode.rotation = SCNVector4(x: 0, y: 0, z: 1, w: Float(Double.pi / 2))
        
        axesNode.addChildNode(zNode)

        scene.rootNode.addChildNode(axesNode)
        //scene.rootNode.addChildNode(geometryNode)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture(sender:)))

        // retrieve the SCNView
        let scnView = self.view as! SCNView
        scnView.allowsCameraControl = false

        // set the scene to the view
        scnView.scene = scene
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.black
        
        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
        scnView.addGestureRecognizer(panGesture)
        
        toolBarRobotParts = ToolBarRobotParts(controller: self)
        shapeManager = ShapeManager(controller: self)
        toolBarShapeSelector = ToolBarShapeSelector(controller: self)
    }
    
    func log(message:String){
        print(message)
    }
    
    @objc
    func handleButtonPress(sender: UIButton!) {
        switch(sender.currentTitle) {
        case "Test Button":
            shapeManager!.spawnCircle()
        default:
            print("Button press could not be handled, unrecognized name.")
        }
    }
    
    @objc
    func panGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: sender.view!)
        var newAngle = (Float)(translation.x)*(Float)(Double.pi)/180.0
        newAngle += currentAngle
        
        //geometryNode.transform = SCNMatrix4MakeRotation(newAngle, 0, 1, 0)
        //axesNode.transform = SCNMatrix4MakeRotation(newAngle, 0, 1, 0)
        
        if(sender.state == UIGestureRecognizer.State.ended) {
            currentAngle = newAngle
        }
    }
    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // check what nodes are tapped
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result = hitResults[0]
            
            // get its material
            let material = result.node.geometry!.firstMaterial!
            
            // highlight it
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
            // on completion - unhighlight
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                
                material.emission.contents = UIColor.black
                
                SCNTransaction.commit()
            }
            
            material.emission.contents = UIColor.red
            
            SCNTransaction.commit()
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

}
