//
//  stepsTableViewCell.swift
//  Nobar
//
//  Created by Sua Han on 2022/07/17.
//

import UIKit

private final class RecipeStepContentView: BaseView {
  private let contentStackView = UIStackView().then {
    $0.axis = .horizontal
    $0.alignment = .center
    $0.spacing = 12.f
  }
  
  private let stepLabel = UILabel().then {
    $0.font = Pretendard.size12.semibold()
    $0.textColor = Color.white.getColor()
    $0.backgroundColor = Color.pink01.getColor()
    $0.textAlignment = .center
    $0.layer.cornerRadius = 10.f
    $0.clipsToBounds = true
  }
  
  private let descriptionLabel = UILabel().then {
    $0.font = Pretendard.size14.regular()
    $0.textColor = Color.black.getColor()
    $0.numberOfLines = 0
  }
  
  init(
    floatValue: CGFloat,
    step: String,
    description: String
  ) {
    stepLabel.backgroundColor = Color.pink01.withAlphaColor(alpha: floatValue)
    stepLabel.text = step
    descriptionLabel.text = description
    
    super.init(frame: .zero)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func initialize() {
    super.initialize()
    
    addSubview(contentStackView)
    
    contentStackView.addArrangedSubviews([
      stepLabel,
      descriptionLabel
    ])
  }
  
  override func setLayouts() {
    super.setLayouts()
    
    contentStackView.snp.makeConstraints {
      $0.top.bottom.equalToSuperview()
      $0.leading.trailing.equalToSuperview().inset(26.f)
    }
    
    stepLabel.snp.makeConstraints {
      $0.width.equalTo(54.f)
      $0.height.equalTo(24.f)
    }
  }
}

final class StepsTableViewCell: UITableViewCell {
  
  private enum StepCountType: Int {
    case three
    case four
    case five
    
    var alpha: [CGFloat] {
      switch self {
      case .three: return [
        0.2.f,
        0.6.f,
        1.f
      ]
      case .four: return [
        0.2.f,
        0.45.f,
        0.75.f,
        1.f
      ]
      case .five: return [
        0.2.f,
        0.4.f,
        0.6.f,
        0.8.f,
        1.f
      ]
      }
    }
    
    init(value: Int) {
      switch value {
      case 3: self = .three
      case 4: self = .four
      case 5: self = .five
      default: self = .five
      }
    }
  }
  
  private let stepsStackView = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = 16.f
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    initialize()
    setupLayouts()
  }
  
  private func initialize() {
    addSubview(stepsStackView)
  }
  
  private func setupLayouts() {
    stepsStackView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

extension StepsTableViewCell {
  func addRecipeStep(with steps: [String]) {
    let stepCountType = StepCountType(value: steps.count)
      
    zip(steps, stepCountType.alpha)
      .enumerated()
      .forEach { index, zipped in
        let contentView = RecipeStepContentView(
          floatValue: zipped.1,
          step: "step\(index)",
          description: zipped.0
        )
        
        stepsStackView.addArrangedSubview(contentView)
      }
  }
}
