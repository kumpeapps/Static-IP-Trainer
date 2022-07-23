//
//  TutorialManager.swift
//  Static IP Trainer
//
//  Created by Justin Kumpe on 7/23/22.
//  Copyright © 2022 Justin Kumpe. All rights reserved.
//

import Foundation
import KumpeHelpers
import PBTutorialManager

extension MainViewController {
    func tutorial() {
        let tutorialManager = TutorialManager(parent: view.window!)
        let lastBuild = UserDefaults.standard.integer(forKey: "lastBuildMain")
        UserDefaults.standard.set(KumpeHelpers.KumpeAPIClient.appBuild, forKey: "lastBuildMain")

        // Create Targets
        let targetStartIP = createTutorialTarget(view: labelStartIP, message: "Enter the first IP in the block", position: .top, breakPoint: false)
        let targetBlockSize = createTutorialTarget(view: BlockSizePicker, message: "Select Block Size", position: .bottom, breakPoint: true)
        let targetNext = createTutorialTarget(view: buttonNext, message: "Click Next to view IP Info and Uverse Gateway Instructions", position: .bottom)

        // Add Targets since build 16
        if lastBuild < 16 {
            tutorialManager.addTargets([targetStartIP,targetBlockSize,targetNext])
        }

        // Show Tutorial
        tutorialManager.fireTargets()
    }
}

public func createTutorialTarget(view: UIView?, message: String, position: TutorialTarget.TargetPosition, shape: HoleShape = .roundedRect, breakPoint: Bool = true) -> TutorialTarget {
    let target = TutorialTarget(view: view)
        .withArrow(true)
        .widthArrow(50)
        .heightArrow(50)
        .labelWidth(200)
        .position(position)
        .shape(shape)
        .message(message)
        .breakPoint(breakPoint)
    return target
}

extension UIBarButtonItem {

    var view: UIView? {
        guard let view = self.value(forKey: "view") as? UIView else {
            return nil
        }
        return view
    }

}
