//
//  TextUtil
//  Created by Exey Panteleev on 29/08/14.
//

import Foundation
import UIKit

public struct TextUtil {
    
    static public func getAttributes(font:UIFont, color:UIColor, align:NSTextAlignment) -> [String : AnyObject]! {
        let paragraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.alignment = align
        let attr = [NSFontAttributeName: font,
            NSForegroundColorAttributeName: color,
            NSParagraphStyleAttributeName: paragraphStyle]
        return attr
    }
    
    static public func labelWithAutosize(text:String, x:CGFloat, y:CGFloat, font:UIFont, color:UIColor, align:NSTextAlignment)->UILabel {
        // calculate size
        let attr = TextUtil.getAttributes(font, color: color, align: align)
        let textSize:CGSize = text.sizeWithAttributes(attr)
        // create label
        let label:UILabel = UILabel(frame: CGRect(x: x, y: y, width: textSize.width, height: textSize.height))
        label.font = font
        label.textColor = color
        label.text = text
        label.textAlignment = align
        return label
    }
    
    static public func textView(text:String, font:UIFont, frame:CGRect, color:UIColor = UIColor.blackColor(), editable:Bool = true, maximumNumberOfLines:Int = 1)->UITextView {
        let tw = UITextView()
        tw.text = text
        tw.font = UIFont(name: "Arial", size: 15)
        tw.textColor = color
        tw.frame = frame
        tw.editable = editable
        tw.textContainer.maximumNumberOfLines = maximumNumberOfLines
        return tw
    }
    
    static public func textField(text:String, font:UIFont, frame:CGRect, color:UIColor = UIColor.blackColor(), editable:Bool = true, maximumNumberOfLines:Int = 1)->UITextField {
        let tf = UITextField()
        tf.text = text
        tf.font = UIFont(name: "Arial", size: 15)
        tf.textColor = color
        tf.frame = frame
        return tf
    }
    
}