//
//  OnboardingPageControl.swift
//  Nobar
//
//  Created by 김수연 on 2022/07/22.
//

import UIKit

final class OnboardingPageControl: UIView {

  // MARK: - property

  var pages: Int = 0 {
    didSet {
      invalidateIntrinsicContentSize()
      setNeedsDisplay()
    }
  }

  var selectedPage: Int = 0 {
    didSet { setNeedsDisplay() }
  }

  var dotColor = Color.gray02.getColor() {
    didSet { setNeedsDisplay() }
  }

  var selectedColor = Color.pink01.getColor() {
    didSet { setNeedsDisplay() }
  }

  private let dotSize: CGFloat = 10
  private let selectedDotSize: CGFloat = 30
  private let spacing: CGFloat = 10

  // MARK: - init

  override init(frame: CGRect) {
    super.init(frame: .zero)
    isOpaque = false
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("Unsupported")
  }

  override var intrinsicContentSize: CGSize {
    let width = CGFloat(pages) * dotSize + CGFloat(pages - 1) * spacing
    let height = dotSize

    return CGSize(width: width, height: height)
  }

  override func draw(_ rect: CGRect) {
    (0..<pages).forEach { page in
      var center = CGPoint(x: 0, y: 0)

      let currentDotSize = (page == selectedPage ? selectedDotSize : dotSize)
      (page == selectedPage ? selectedColor : dotColor).setFill()

      if page > selectedPage {
        center = CGPoint(x: rect.minX + (dotSize + spacing) * CGFloat(page) + (currentDotSize + spacing), y: 0)
      } else {
        center = CGPoint(x: rect.minX + (dotSize + spacing) * CGFloat(page), y: 0)
      }

      let size = CGSize(width: currentDotSize, height: 10)
      let rect = CGRect(origin: center, size: size)
      UIBezierPath(roundedRect: rect, cornerRadius: 8).fill()
    }
  }
}
