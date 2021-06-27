//
//  TripleLabelView.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 27.06.21.
//

import UIKit

class TripleLabelView: UIView {
    private typealias Color = ColorLibrary.MovieDetails
    
    private let stack: UIStackView = {
        let stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.distribution = .fill
            stack.axis = .vertical
            stack.spacing = Spacing.S
            stack.alignment = .fill
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = Color.titleLabelColor
            label.font = .boldSystemFont(ofSize: 20)
            label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = Color.descriptionLabelColor
            label.font = .italicSystemFont(ofSize: 14)
            label.textAlignment = .center
            label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return label
    }()
    
    private let additionalLabel: UILabel = {
        let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = Color.releaseDateLabelColor
            label.font = .systemFont(ofSize: 15)
            label.textAlignment = .center
        return label
    }()
    
    private let dummyView: UIView = {
        let view = UIView()
            view.setContentHuggingPriority(.init(200), for: .vertical)
            view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        
        self.configureHierarchy()
        self.configureLayout()
    }
    
    convenience init(with model: Model) {
        self.init()
        
        self.configure(with: model)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: Model) {
        self.titleLabel.text = model.title
        self.descriptionLabel.text = model.description
        self.additionalLabel.text = model.additional
    }
    
    private func configureHierarchy() {
        self.addSubview(stack)
        
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(descriptionLabel)
        stack.addArrangedSubview(additionalLabel)
        stack.addArrangedSubview(dummyView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.topAnchor, constant: Spacing.XS),
            stack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Spacing.XS),
            stack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Spacing.XS),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Spacing.XS),
        ])
    }
}
