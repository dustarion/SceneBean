# SceneBean
This is a little layer I built above SceneKit to make some of the most used functions easier to implement quickly and neatly and increase readibility. This is especially useful for Prototyping in Playgrounds. Built it for my wwdc18 playground but its such a neat idea I'm gonna work hard on expanding it.

Here's an example of how SceneBean makes life easier, take the two following functions:

*Without SceneBean*
'func ApplyForceToRocket() {
        guard let rocketshipNode = scene.rootNode.childNode(withName: "rocketship", recursively: false) ,
            let physicsBody = rocketshipNode.physicsBody
            else { print("Force Failed")
                return }
        
        let direction = SCNVector3(0, 3, 0)
        physicsBody.applyForce(direction, asImpulse: true)
    }'
    
*With SceneBean*
'func ApplyForceToRocket() {
SceneBean.SBApplyForce( ontoChildNodeWithName: "rocketship", 
                                      inScene: scene, 
                                  inDirection: SCNVector3(0, 3, 0), 
                                    asImpulse: true)
    }'
    
## Installation
Drag SceneBean.swift into your Project.
'SceneBean.SBFunctionOfChoice'
CocoaPods and Carthage coming soon.
