//
//  SKButtons.swift
//  SKPhotoBrowser
//
//  Created by 鈴木 啓司 on 2016/08/09.
//  Copyright © 2016年 suzuki_keishi. All rights reserved.
//

import Foundation

// helpers which often used
private let bundle = Bundle(for: SKPhotoBrowser.self)

class SKButton: UIButton {
    internal var showFrame: CGRect!
    internal var hideFrame: CGRect!
    
    fileprivate var insets: UIEdgeInsets {
        if UI_USER_INTERFACE_IDIOM() == .phone {
            return UIEdgeInsets(top: 15.25, left: 15.25, bottom: 15.25, right: 15.25)
        } else {
            return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        }
    }
    fileprivate let size: CGSize = CGSize(width: 44, height: 44)
    fileprivate var marginX: CGFloat = 0
    fileprivate var marginY: CGFloat = 0
    
    func setup(_ image: UIImage) {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = true
        autoresizingMask = [.flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin]
        
        setImage(image, for: .normal)
    }
  
    func setFrameSize(_ size: CGSize? = nil) {
        guard let size = size else { return }
        
        let newRect = CGRect(x: marginX, y: marginY, width: size.width, height: size.height)
        frame = newRect
        showFrame = newRect
        hideFrame = CGRect(x: marginX, y: -marginY, width: size.width, height: size.height)
    }
    
    func updateFrame(_ frameSize: CGSize) { }
}

class SKImageButton: SKButton {
    fileprivate var image: UIImage { return UIImage() }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup(image)
        showFrame = CGRect(x: marginX, y: marginY, width: size.width, height: size.height)
        hideFrame = CGRect(x: marginX, y: -marginY, width: size.width, height: size.height)
    }
}

class SKCloseButton: SKImageButton {
    override var image: UIImage { return SKButtonOptions.closeButtonImage }
    override var marginX: CGFloat {
        get {
            return SKPhotoBrowserOptions.swapCloseAndDeleteButtons
                ? SKMesurement.screenWidth - SKButtonOptions.closeButtonPadding.x - self.size.width
                : SKButtonOptions.closeButtonPadding.x
        }
        set { super.marginX = newValue }
    }
    override var marginY: CGFloat {
        get { return SKButtonOptions.closeButtonPadding.y }
        set { super.marginY = newValue }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup(image)
        showFrame = CGRect(x: marginX, y: marginY, width: size.width, height: size.height)
        hideFrame = CGRect(x: marginX, y: -marginY, width: size.width, height: size.height)
    }
}

class SKDeleteButton: SKImageButton {
    override var image: UIImage {
        return UIImage(named: "SKPhotoBrowser.bundle/images/btn_common_delete_wh", in: Bundle(for: SKPhotoBrowser.self), compatibleWith: nil) ?? UIImage()
    }
    override var marginX: CGFloat {
        get {
            return SKPhotoBrowserOptions.swapCloseAndDeleteButtons
                ? SKButtonOptions.deleteButtonPadding.x
                : SKMesurement.screenWidth - SKButtonOptions.deleteButtonPadding.x - self.size.width
        }
        set { super.marginX = newValue }
    }
    override var marginY: CGFloat {
        get { return SKButtonOptions.deleteButtonPadding.y }
        set { super.marginY = newValue }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup(image)
        showFrame = CGRect(x: marginX, y: marginY, width: size.width, height: size.height)
        hideFrame = CGRect(x: marginX, y: -marginY, width: size.width, height: size.height)
    }
}
