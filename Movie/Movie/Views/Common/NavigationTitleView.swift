//
//  NavigationTitleView.swift
//  Movie
//
//  Created by Giorgi Berozashvili on 26.06.21.
//

import UIKit

class NavigationLeftView: UIView {
    private let stack: UIStackView = {
        let stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.distribution = .fill
            stack.axis = .horizontal
            stack.spacing = Spacing.S
            stack.alignment = .fill
        return stack
    }()
    
    private let backView: UIButton = {
        let view = UIButton()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            view.setImage(UIImage(named: "ic_back_button"), for: .normal)
        return view
    }()
    
    private let backImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "ic_back_button")
        return view
    }()
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "welcome"
        title.textColor = .white
        return title
    }()
    
    init() {
        super.init(frame: .zero)
        
        configureLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backView.layer.cornerRadius = self.backView.frame.height / 2.0
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.backView.layer.cornerRadius = self.backView.frame.height / 2.0
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        self.addSubview(stack)
        //self.backView.addSubview(backImage)
        stack.addArrangedSubview(backImage)
        stack.addArrangedSubview(titleLabel)
        
        
        NSLayoutConstraint.activate([
            self.stack.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.stack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Spacing.XS),
            self.stack.topAnchor.constraint(equalTo: self.topAnchor, constant: Spacing.XS),
            self.stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Spacing.XS),
            backImage.heightAnchor.constraint(equalToConstant: 28),
            backImage.widthAnchor.constraint(equalToConstant: 28)
            /*
            backImage.leftAnchor.constraint(equalTo: self.backView.leftAnchor, constant: Spacing.XXS),
            backImage.rightAnchor.constraint(equalTo: self.backView.rightAnchor, constant: -Spacing.XXS),
            backImage.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: Spacing.XXS),
            backImage.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor, constant: -Spacing.XXS),
            backImage.widthAnchor.constraint(equalToConstant: 16),
            backImage.heightAnchor.constraint(equalTo: backImage.widthAnchor)*/
        ])
    }
}
