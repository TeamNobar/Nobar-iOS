//
//  TastingNoteHeartRateView.swift
//  Nobar
//
//  Created by Ian on 2022/07/22.
//

import UIKit

final class TastingNoteHeartRateView: BaseView {
  private enum Metric {
    static let heartLength = 23.f
    static let heartSpacing = 7.f
  }
  
  private enum HeartRate {
    case zeroFive
    case one
    case oneFive
    case two
    case twoFive
    case three
    case threeFive
    case four
    case fourFive
    case five
    
    init(heartFactor: Double) {
      switch heartFactor {
      case 0.5: self = .zeroFive
      case 1.0: self = .one
      case 1.5: self = .oneFive
      case 2.0: self = .two
      case 2.5: self = .twoFive
      case 3.0: self = .three
      case 3.5: self = .threeFive
      case 4.0: self = .four
      case 4.5: self = .fourFive
      case 5.0: self = .five
      default: self = .zeroFive
      }
    }
    
    var images: [UIImage] {
      switch self {
      case .zeroFive: return [
        ImageFactory.property105Point, ImageFactory.property10Point, ImageFactory.property10Point,
        ImageFactory.property10Point, ImageFactory.property10Point
      ].compactMap { $0 }
      case .one: return [
        ImageFactory.property11Point, ImageFactory.property10Point, ImageFactory.property10Point,
        ImageFactory.property10Point, ImageFactory.property10Point
      ].compactMap { $0 }
      case .oneFive: return [
        ImageFactory.property11Point, ImageFactory.property105Point, ImageFactory.property10Point,
        ImageFactory.property10Point, ImageFactory.property10Point
      ].compactMap { $0 }
      case .two: return [
        ImageFactory.property11Point, ImageFactory.property11Point, ImageFactory.property10Point,
        ImageFactory.property10Point, ImageFactory.property10Point
      ].compactMap { $0 }
      case .twoFive: return [
        ImageFactory.property11Point, ImageFactory.property11Point, ImageFactory.property105Point,
        ImageFactory.property10Point, ImageFactory.property10Point
      ].compactMap { $0 }
      case .three: return [
        ImageFactory.property11Point, ImageFactory.property11Point, ImageFactory.property11Point,
        ImageFactory.property10Point, ImageFactory.property10Point
      ].compactMap { $0 }
      case .threeFive: return [
        ImageFactory.property11Point, ImageFactory.property11Point, ImageFactory.property11Point,
        ImageFactory.property105Point, ImageFactory.property10Point
      ].compactMap { $0 }
      case .four: return [
        ImageFactory.property11Point, ImageFactory.property11Point, ImageFactory.property11Point,
        ImageFactory.property11Point, ImageFactory.property10Point
      ].compactMap { $0 }
      case .fourFive: return [
        ImageFactory.property11Point, ImageFactory.property11Point, ImageFactory.property11Point,
        ImageFactory.property105Point, ImageFactory.property10Point
      ].compactMap { $0 }
      case .five: return [
        ImageFactory.property11Point, ImageFactory.property11Point, ImageFactory.property11Point,
        ImageFactory.property11Point, ImageFactory.property11Point
      ].compactMap { $0 }
      }
    }
  }
  
  private let containerStackView = UIStackView().then {
    $0.axis = .horizontal
    $0.spacing = Metric.heartSpacing
  }
  private var heartrate: HeartRate = .zeroFive
  
  override func initialize() {
    super.initialize()
    
    addSubview(containerStackView)
    layoutViews()
  }
  
  override func setLayouts() {
    super.setLayouts()
    
    containerStackView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }
}

extension TastingNoteHeartRateView {
  func updateHeartRate(with heartRateFactor: Double) {
    let compansatedValue = round(heartRateFactor * 10) / 10
    
    heartrate = HeartRate(heartFactor: compansatedValue)
    
    containerStackView.removeAllSubViews()
    layoutViews()
    layoutIfNeeded()
  }
}

extension TastingNoteHeartRateView {
  private func layoutViews() {
    heartrate.images.forEach {
      let imageView = UIImageView(image: $0)
      imageView.snp.makeConstraints { $0.size.equalTo(Metric.heartLength) }
      containerStackView.addArrangedSubview(imageView)
    }
  }
}
