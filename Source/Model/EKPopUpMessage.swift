//
//  EKPopUpMessage.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/21/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

public struct EKPopUpMessage {
    
    /** Code block that is executed as the user taps the popup button */
    public typealias EKPopUpMessageAction = () -> ()
    
    /** Popup theme image */
    public struct ThemeImage {
        
        /** Position of the theme image */
        public enum Position {
            case topToTop(offset: CGFloat)
            case centerToTop(offset: CGFloat)
        }
        
        /** The content of the image */
        public var image: EKProperty.ImageContent
        
        /** The psotion of the image */
        public var position: Position
        
        /** Initializer */
        public init(image: EKProperty.ImageContent,
                    position: Position = .topToTop(offset: 40)) {
            self.image = image
            self.position = position
        }
    }
    
    public var themeImage: ThemeImage?
    public var title: EKProperty.LabelContent
    public var description: EKProperty.LabelContent
    public var actionButton: EKProperty.ButtonContent
    public var cancelButton: EKProperty.ButtonContent?
    public var action: EKPopUpMessageAction
    public var cancelAction: EKPopUpMessageAction?
    
    var containsImage: Bool {
        return themeImage != nil
    }
    
    public init(themeImage: ThemeImage? = nil,
                title: EKProperty.LabelContent,
                description: EKProperty.LabelContent,
                actionButton: EKProperty.ButtonContent,
                cancelButton: EKProperty.ButtonContent? = nil,
                action: @escaping EKPopUpMessageAction,
                cancelAction: @escaping EKPopUpMessageAction) {
        self.themeImage = themeImage
        self.title = title
        self.description = description
        self.actionButton = actionButton
        self.cancelButton = cancelButton
        self.action = action
        self.cancelAction = cancelAction
    }
}
