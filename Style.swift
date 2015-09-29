//
//  Style.swift
//  Style
//
//  Created by Mikhail Vroubel on 9/29/15.
//  Copyright © 2015 Mikhail Vroubel. All rights reserved.
//

import UIKit
import Utils

@objc(AStyle) public class Style : NSObject {
    override public class func memoKey()-> String {
        return "Style"
    }
    public let apply:(NSObject)->()
    public init(apply:(NSObject)->()) {
        self.apply = apply
        super.init()
    }
    public convenience init(map:[String:AnyObject]) {
        self.init {target in
            _ = map.map { (key,val) in
                target.setValue(val, forKeyPath:key)
            }
        }
    }
}

extension UIResponder {
    public var styleName:String? {
        set {
            let styles = styleName?.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            _ = styles?.map {
                Style.memo($0)?.apply(self)
            }
        }
        get {return nil}
    }
}
