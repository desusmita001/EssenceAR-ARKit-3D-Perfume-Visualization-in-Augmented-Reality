//
//  ViewController.swift
//  EssenceAR
//
//  Created by Susmita De on 10/15/25.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the view's delegate
        sceneView.delegate = self

        // Show statistics (fps, timing, etc.)
        sceneView.showsStatistics = true

        // Enable default lighting so model looks good
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]

        // Run the AR session
        sceneView.session.run(configuration)

        // Load your Perfume.usdz model
        if let scene = try? SCNScene(named: "Perfume.usdz") {
            let node = SCNNode()

            // Get the model's root node
            let modelNode = scene.rootNode.clone()

            // Optional: adjust model size and position
            modelNode.scale = SCNVector3(0.01, 0.01, 0.01) // adjust scale if too large
            modelNode.position = SCNVector3(0, -0.1, -0.5) // slightly in front of camera

            node.addChildNode(modelNode)
            sceneView.scene.rootNode.addChildNode(node)
        } else {
            print("❌ Failed to load Perfume.usdz")
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate

    func session(_ session: ARSession, didFailWithError error: Error) {
        print("AR session failed: \(error.localizedDescription)")
    }

    func sessionWasInterrupted(_ session: ARSession) {
        print("AR session interrupted")
    }

    func sessionInterruptionEnded(_ session: ARSession) {
        print("AR session resumed")
    }
}

