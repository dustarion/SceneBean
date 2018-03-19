/**
 *  SceneBean Library
 *  Description :
 *  This is a little layer I built above SceneKit to make some of the most used
 *  functions easier to implement quickly and neatly and increase readibility. This is especially useful for Prototyping in Playgrounds.
 *  I've opensourced this library on my GitHub @Dustarion. Nicknamed it SceneBean because it rhymes.
 */

import Foundation
import SceneKit
import SceneKit.ModelIO


public class SceneBean {
    // MARK:- Easy Camera Tools
    
    /// Adds a camera to the scene with the attributes listed in its arguments.
    public static func SBAddCameras(ToScene: SCNScene, FieldOfView: CGFloat, XPos: Float, YPos: Float, ZPos: Float, XOri: Float, YOri: Float, ZOri: Float, WOri: Float) {
        let Camera = SCNCamera()
        Camera.fieldOfView = FieldOfView
        let CameraNode = SCNNode()
        CameraNode.camera = Camera
        CameraNode.position = SCNVector3(x: XPos, y: YPos, z: ZPos)
        CameraNode.orientation = SCNQuaternion(x: XOri, y: YOri, z: ZOri, w: WOri)
        ToScene.rootNode.addChildNode(CameraNode)
    }
    
    /// Returns the POVCoordinates of the main camera in a specified SCNView as an array of [x,y,z]
    public static func SBCameraPOVCoordinates(SceneView: SCNView) -> [Float] {
        let x = SceneView.pointOfView?.position.x
        let y = SceneView.pointOfView?.position.y
        let z = SceneView.pointOfView?.position.z
        return ([x!, y!, z!])
    }
    
    /// Returns the POVOrientation of the main camera in a specified SCNView as an array of [x,y,z]
    public static func SBCameraPOVOrientation(SceneView: SCNView) -> [Float] {
        let x = SceneView.pointOfView?.orientation.x
        let y = SceneView.pointOfView?.orientation.y
        let z = SceneView.pointOfView?.orientation.z
        return ([x!, y!, z!])
    }
    
    /// Zooms the specified Node out. Currently Does Nothing.
    /// This Function is specifically meant to be used in EarthViewController
    /// TODO: Make this a universal zoom function based on current orientation and position etc.
    //public static func SBZoomOutOnYAxis(Camera: SCNCamera, ZoomAmount: Float) {
    //}
    
    // MARK:- Easy Environment Creation
    
    /// Create a floor with advanced properties.
    /// Recommended to use a static body and a position of 0,0,0
    /// Example declaration of .static and (x: 0, y: 0, z: 0)
    /// Node Name is "Floor"
    public static func SBCreateFloorWithCollision(inScene: SCNScene, withPhysicsType: SCNPhysicsBodyType , withNodeCollisionArray: inout [SCNNode], withPosition: SCNVector3, withName : String) {
        let Floor = SCNNode(geometry: SCNFloor())
        Floor.position = withPosition
        let physicsBody = SCNPhysicsBody(type: withPhysicsType, shape: nil)
        Floor.physicsBody = physicsBody
        Floor.name = withName
        //Add it to our Array for Collision Detection
        withNodeCollisionArray.append(Floor)
        inScene.rootNode.addChildNode(Floor)
    }
    
    /// Create a floor at standard coordinates of 0,0,0.
    /// Static Physics Body, use CreateFloorWithCollision() to change the Physics Body and Coordinates
    /// Node Name is "Floor"
    public static func SBCreateFloor(inScene: SCNScene, withNodeCollisionArray: [SCNNode]) {
        let Floor = SCNNode(geometry: SCNFloor())
        Floor.position = SCNVector3(x: 0, y: 0, z: 0)
        let physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        Floor.physicsBody = physicsBody
        Floor.name = "Floor"
        inScene.rootNode.addChildNode(Floor)
    }
    
    // MARK:- Easy 3D Object Creation and Rendering
    
    /// Create an SCNNode with advanced Parameters in the specified Scene
    /// withObject is the SCNScene you are adding as a node. inScene is the Scene you are adding the node into
    /// Example declarations for withObject : SCNScene(named: "rocketship.scn")
    public static func SBCreatePhysicsNode(withObject: SCNScene, withChildNodeName: String, inScene: SCNScene, atPosition: SCNVector3, setName: String, setPhysicsBodyType: SCNPhysicsBodyType ) {
        let ObjectScene = withObject
        guard let ObjectNode = ObjectScene.rootNode.childNode(withName: withChildNodeName, recursively: false) else { return }
        ObjectNode.position = atPosition
        let physicsBody = SCNPhysicsBody(type: setPhysicsBodyType, shape: nil)
        ObjectNode.physicsBody = physicsBody
        ObjectNode.name = setName
        inScene.rootNode.addChildNode(ObjectNode)
    }
    
    /// Apply a force onto an SCNNode
    /// Example direction declaration : (x: 0, y:3, z:0)
    public static func SBApplyForce(ontoChildNodeWithName: String, inScene: SCNScene, inDirection: SCNVector3, asImpulse: Bool) {
        guard let ObjectNode = inScene.rootNode.childNode(withName: ontoChildNodeWithName, recursively: false) ,
            let physicsBody = ObjectNode.physicsBody
        else {
            print("SBApplyForce Failed, Attempted to apply force to: ", ontoChildNodeWithName)
                return
        }
    
        let direction = inDirection
        physicsBody.applyForce(direction, asImpulse: asImpulse)
    }
    
    // MARK:- Easy Particle Field Rendering
    
    /// Easily add a particle field to any node or child node.
    /// Example Declaration of toNode:
    public static func SBAddParticleField(toNode: SCNNode, withSCNParticleSystemNamed: String, withNodeCollisionArray: [SCNNode]) {
        guard let objectParticleSystem = SCNParticleSystem(named: withSCNParticleSystemNamed, inDirectory: nil)
            else { return }
        objectParticleSystem.colliderNodes = withNodeCollisionArray
        toNode.addParticleSystem(objectParticleSystem)
        
    }
    
    // MARK:- Easy Node Manipulation
    
    /// Easily obtain a node
    //TODO: Add a guard statement to prevent an unexpected crashes and for safety.
    public static func SBObtainNode(Scene: SCNScene, ChildNodeName: String) -> SCNNode {
        return Scene.rootNode.childNode(withName: ChildNodeName, recursively: false)!
    }
    
    // MARK:- Easy Movement of Nodes
    
    /// Launches the object endlessly upwards
    public static func SBLaunchNodeUpwards(Node: SCNNode) {
        guard let physicsBody = Node.physicsBody
            else { return }
        physicsBody.isAffectedByGravity = false
        physicsBody.damping = 0
        let action = SCNAction.moveBy(x: 0, y: 0.3, z: 0, duration: 3)
        action.timingMode = .easeInEaseOut
        Node.runAction(action)
    }
}

