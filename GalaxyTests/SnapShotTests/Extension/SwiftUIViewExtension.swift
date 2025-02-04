////
////  SwiftUIViewExtension.swift
////  Galaxy
////
////  Created by Sowrirajan Sugumaran on 24/01/25.
////

import Foundation
import SwiftUI
import SnapshotTesting

extension SwiftUI.View {
    func toViewController() -> UIViewController {
        let viewController = UIHostingController(rootView: self)
        viewController.view.frame = UIScreen.main.bounds
        return viewController
    }
}

extension UIViewController {
    func performSnapshotTests(
            named name: String,
            testName: String = "Snapshot") {
            assertSnapshot(
                of: self,
                as: .image(precision: 0.9),
                named: name,
                testName: testName)
        }
}

