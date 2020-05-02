//
//  AnimatableCircleView.swift
//  CircleBorderAnimation
//
//  Created by Akshit Zaveri on 02/05/20.
//  Copyright © 2020 Akshit Zaveri. All rights reserved.
//

import UIKit

final class AnimatableCircleView: UIView {

  // MARK: - UI objects

  private lazy var circleView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .red
    view.clipsToBounds = true
    return view
  }()

  private lazy var miniCircleView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .orange
    return view
  }()

  // MARK: - Initializers and Life cycle

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.setup()
  }

  private func setup() {
    self.clipsToBounds = false

    self.addSubview(self.circleView)
    NSLayoutConstraint.activate([
      self.circleView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.circleView.topAnchor.constraint(equalTo: self.topAnchor),
      self.circleView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      self.circleView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])

    self.addSubview(self.miniCircleView)
    NSLayoutConstraint.activate([
      self.miniCircleView.widthAnchor.constraint(equalToConstant: 24),
      self.miniCircleView.heightAnchor.constraint(equalToConstant: 24)
    ])
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    self.circleView.layer.cornerRadius = self.circleView.frame.width / 2.0
    self.miniCircleView.layer.cornerRadius = self.miniCircleView.frame.width / 2.0

    self.miniCircleView.center = self.getPoint(for: -90)
  }

  // MARK: - Animation

  func startAnimating() {
    // 1
    let path = UIBezierPath()

    // 2
    let initialPoint = self.getPoint(for: -90)
    path.move(to: initialPoint)

    // 3
    for angle in -89...0 { path.addLine(to: self.getPoint(for: angle)) }
    for angle in 1...270 { path.addLine(to: self.getPoint(for: angle)) }

    // 4
    path.close()

    // 5
    self.animate(view: self.miniCircleView, path: path)
  }

  private func animate(view: UIView, path: UIBezierPath) {
    // 1
    let animation = CAKeyframeAnimation(keyPath: "position")

    // 2
    animation.path = path.cgPath

    // 3
    animation.repeatCount = 1

    // 4
    animation.duration = 5

    // 5
    view.layer.add(animation, forKey: "animation")
  }

  private func getPoint(for angle: Int) -> CGPoint {
    // 1
    let radius = Double(self.circleView.layer.cornerRadius)

    // 2
    let radian = Double(angle) * Double.pi / Double(180)

    // 3
    let newCenterX = radius + radius * cos(radian)
    let newCenterY = radius + radius * sin(radian)

    return CGPoint(x: newCenterX, y: newCenterY)
  }
}
