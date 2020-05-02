//
//  ViewController.swift
//  CircleBorderAnimation
//
//  Created by Akshit Zaveri on 02/05/20.
//  Copyright © 2020 Akshit Zaveri. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

  @IBOutlet private weak var circleView: AnimatableCircleView!
  @IBOutlet private weak var button: UIButton!

  @IBAction private func buttonTapped(_ sender: UIButton) {
    self.circleView.startAnimating()
  }
}
