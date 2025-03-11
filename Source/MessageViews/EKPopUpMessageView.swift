//
//  EKPopUpMessageView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/20/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

final public class EKPopUpMessageView: UIView {

    // MARK: - Properties
    
    private var imageView: UIImageView!
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let extraLabel = UILabel()
    private let actionButton = UIButton()
    private let cancelButton = UIButton()
    private let specialNoteLabel = UILabel()
    private lazy var specialNotesView: UIStackView = {
        let stackView = UIStackView()
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.backgroundColor = UIColor(rgb: 0xFFEEDB)
        stackView.layer.cornerRadius = 8
        stackView.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        return stackView
    }()
    
    
    private let message: EKPopUpMessage
    
    // MARK: - Setup
    
    public init(with message: EKPopUpMessage) {
        self.message = message
        super.init(frame: UIScreen.main.bounds)
        setupImageView()
        setupTitleLabel()
        setupDescriptionLabel()
        setupExtraLabel()
        setupSpecialNotesView()
        setupActionButton()
        setupInterfaceStyle()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        guard let themeImage = message.themeImage else {
            return
        }
        imageView = UIImageView()
        addSubview(imageView)
        imageView.layoutToSuperview(.centerX)
        switch themeImage.position {
        case .centerToTop(offset: let value):
            imageView.layout(.centerY, to: .top, of: self, offset: value)
        case .topToTop(offset: let value):
            imageView.layoutToSuperview(.top, offset: value)
        }
        imageView.imageContent = themeImage.image
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.content = message.title
        titleLabel.layoutToSuperview(axis: .horizontally, offset: 20)
        if let imageView = imageView {
            titleLabel.layout(.top, to: .bottom, of: imageView, offset: 20)
        } else {
            titleLabel.layoutToSuperview(.top, offset: 20)
        }
        titleLabel.forceContentWrap(.vertically)
    }
    
    private func setupDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.content = message.description
        descriptionLabel.layoutToSuperview(axis: .horizontally, offset: 20)
        descriptionLabel.layout(.top, to: .bottom, of: titleLabel, offset: 16)
        descriptionLabel.forceContentWrap(.vertically)
    }
    
    private func setupExtraLabel() {
        if let attributedText = message.extraAttributedText {
            addSubview(extraLabel)
            extraLabel.attributedText = attributedText
            extraLabel.textAlignment = .center
            extraLabel.layoutToSuperview(axis: .horizontally, offset: 20)
            extraLabel.layout(.top, to: .bottom, of: descriptionLabel, offset: 16)
            extraLabel.forceContentWrap(.vertically)
        }
    }
    
    private func setupSpecialNotesView() {
        if let attributedText = message.specialNoteText {
            addSubview(specialNotesView)
            if message.extraAttributedText != nil {
                specialNotesView.layout(.top, to: .bottom, of: extraLabel, offset: 20)
            } else {
                specialNotesView.layout(.top, to: .bottom, of: descriptionLabel, offset: 20)
            }
            specialNotesView.layoutToSuperview(axis: .horizontally, offset: 20)
            specialNoteLabel.translatesAutoresizingMaskIntoConstraints = false
            specialNoteLabel.attributedText = attributedText
            specialNoteLabel.numberOfLines = 0
            specialNoteLabel.textAlignment = .center
            specialNotesView.addArrangedSubview(specialNoteLabel)
        }
    }
    
    private func setupActionButton() {
        addSubview(actionButton)
        if message.cancelButton != nil {
            addSubview(cancelButton)
            let height: CGFloat = 40
            actionButton.set(.height, of: height)
            if message.specialNoteText != nil {
                actionButton.layout(.top, to: .bottom, of: specialNotesView, offset: 30)
            } else if message.extraAttributedText != nil {
                actionButton.layout(.top, to: .bottom, of: extraLabel, offset: 30)
            } else {
                actionButton.layout(.top, to: .bottom, of: descriptionLabel, offset: 30)
            }
            actionButton.layoutToSuperview(.bottom, offset: -30)
            actionButton.layoutToSuperview(.trailing, offset: -20)
            if message.equalWidthButton {
                actionButton.set(.width, of: (self.bounds.width - 40 - message.horizontalOffset * 2 ) / 2 - 4)
            }
            
            let buttonAttributes = message.actionButton
            actionButton.buttonContent = buttonAttributes
            actionButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            actionButton.layer.cornerRadius = message.roundedButton ? (height * 0.5) : 8
            actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
            cancelButton.set(.height, of: height)
            if message.specialNoteText != nil {
                cancelButton.layout(.top, to: .bottom, of: specialNotesView, offset: 30)
            } else if message.extraAttributedText != nil {
                cancelButton.layout(.top, to: .bottom, of: extraLabel, offset: 30)
            } else {
                cancelButton.layout(.top, to: .bottom, of: descriptionLabel, offset: 30)
            }
            cancelButton.layoutToSuperview(.bottom, offset: -30)
            cancelButton.layoutToSuperview(.leading, offset: 20)
            cancelButton.layout(.trailing, to: .leading, of: actionButton, offset: -8)
            
            let cancelbuttonAttributes = message.cancelButton!
            cancelButton.buttonContent = cancelbuttonAttributes
            cancelButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            cancelButton.layer.cornerRadius = message.roundedButton ? (height * 0.5) : 8
            cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
            
            
        } else {
            let height: CGFloat = 40
            actionButton.set(.height, of: height)
            if message.specialNoteText != nil {
                actionButton.layout(.top, to: .bottom, of: specialNotesView, offset: 30)
            } else if message.extraAttributedText != nil {
                actionButton.layout(.top, to: .bottom, of: extraLabel, offset: 30)
            } else {
                actionButton.layout(.top, to: .bottom, of: descriptionLabel, offset: 30)
            }
            actionButton.layoutToSuperview(.bottom, offset: -30)
            actionButton.layoutToSuperview(.leading, offset: 16)
            actionButton.layoutToSuperview(.trailing, offset: -16)
            
            let buttonAttributes = message.actionButton
            actionButton.buttonContent = buttonAttributes
            actionButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
            actionButton.layer.cornerRadius = message.roundedButton ? (height * 0.5) : 8
            actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
        }
    }
    
    private func setupInterfaceStyle() {
        titleLabel.textColor = message.title.style.color(for: traitCollection)
        imageView?.tintColor = message.themeImage?.image.tintColor(for: traitCollection)
        let tapColor = message.actionButton.highlighedLabelColor(for: traitCollection)
        actionButton.setTitleColor(tapColor, for: .highlighted)
        actionButton.setTitleColor(tapColor, for: .selected)
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupInterfaceStyle()
    }
    
    // MARK: - User Interaction
    
    @objc func actionButtonPressed() {
        message.action()
    }

        
    @objc func cancelButtonPressed() {
        if let cancelAction = message.cancelAction {
            cancelAction()
        }
    }
}
