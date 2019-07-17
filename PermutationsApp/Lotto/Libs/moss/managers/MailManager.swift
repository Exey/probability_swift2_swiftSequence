//
//  MailManager.swift
//  VEKA_Measurer
//
//  Created by Exey Panteleev on 05/06/15.
//  Copyright (c) 2015 Exey Panteleev. All rights reserved.
//

import Foundation
import MessageUI

struct MailManager {
    
    static func openMail(delegate:MFMailComposeViewControllerDelegate, subject:String, message:String, cantSendMessage:(String, String), attachment:(name: String, mime:String, data:NSData)? = nil)->UIViewController {
        let canSend = MFMailComposeViewController.canSendMail()
        print("MailManager CAN SEND \(canSend)")
        var vc:UIViewController!
        if(canSend) {
            let picker = MFMailComposeViewController()
            picker.mailComposeDelegate = delegate
            picker.setSubject(subject)
            picker.setMessageBody(message, isHTML: true)
            if attachment != nil {
                picker.addAttachmentData(attachment!.data, mimeType: attachment!.mime, fileName: attachment!.name)
            }
            vc = picker
        } else {
            vc = AlertManager.ok(cantSendMessage.0, message: cantSendMessage.1, ok: "OK")
        }
        return vc
    }
    
}