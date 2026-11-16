//
//  ValidationClass.swift
//  Samksa
//
//  Created by Mac Mini on 17/12/14.
//  Copyright (c) 2014 Fullestop. All rights reserved.
//

import UIKit
import CRNotifications
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l <= r
    default:
        return !(rhs < lhs)
    }
}

class ValidationClass: NSObject {
    
    func validateUrl (_ stringURL : NSString) -> Bool {
        
        let urlRegEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[urlRegEx])
        //let urlTest = NSPredicate.predicateWithSubstitutionVariables(predicate)
        
        return predicate.evaluate(with: stringURL)
    }
    
    func isBlank (_ textfield:UITextField) -> Bool {
        
        let thetext = textfield.text
        let trimmedString = thetext!.trimmingCharacters(in: CharacterSet.whitespaces)
        
        if trimmedString.isEmpty {
            return true
        }
        return false
    }
    
    func isTextViewBlank(_ textview:UITextView) -> Bool {
        
        if textview.text.isEmpty {
            return true
        }
        return false
    }
    
    func isValidEmail(_ EmailStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let range = EmailStr.range(of: emailRegEx, options:.regularExpression)
        let result = range != nil ? true : false
        return !result
    }
    
    func isValidPhone(_ PhoneStr:String) -> Bool {
        
        let phoneRegex = "^((\\+)|(00))[0-9]{7,15}$"
        let trimmedString = phoneRegex.trimmingCharacters(in: .whitespaces)
        let validatePhone = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let isValidPhone = validatePhone.evaluate(with: trimmedString)
        return isValidPhone
    }

    func isValidPWD(_ PwdStr:String) -> Bool {
        
        let PwdRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{10,}"
        let range = PwdStr.range(of: PwdRegEx, options:.regularExpression)
        let result = range != nil ? true : false
        return !result
    }
    func success(message: String){
        CRNotifications.showNotification(type: CRNotifications.success, title: "Success!", message: message, dismissDelay: 3)
    }
    func error(message: String){
        CRNotifications.showNotification(type: CRNotifications.error, title: "Error", message: message, dismissDelay: 3)
    }
    
    
    func ValidateLoginEmailForm(_ loginVCValidateObj:LoginVC) -> Bool {
        if isBlank(loginVCValidateObj.EmailTxtField) {
            self.error(message: "Please enter your phone number.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else if isBlank(loginVCValidateObj.PasswordTxtField) {
            self.error(message: "Please enter your password.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else{
            return true
        }
    }
    func ValidateLoginIPADForm(_ loginVCValidateObj:LoginVC_iPod) -> Bool {
        if isBlank(loginVCValidateObj.EmailTxtField) {
            self.error(message: "Please enter your phone number.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else if isBlank(loginVCValidateObj.PasswordTxtField) {
            self.error(message: "Please enter your password.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else{
            return true
        }
    }
    
    func isValidPassword(_ testStr: String) -> Bool {
        let emailRegEx = "([(0-9)(A-Z)(!@#$%ˆ&*+-=<>)]+)([a-z]*){8,15}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
       // let result = emailTest.evaluate(with: testStr)
        return emailTest.evaluate(with: testStr)
    }
    
    
    func SignInForm_Form(_ loginVCValidateObj:SignUpVC) -> Bool {
        if isBlank(loginVCValidateObj.PhoneNumberTxtField) {
            self.error(message: "Please enter your phone number.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else if isBlank(loginVCValidateObj.EnterPINTxtField) {
            self.error(message: "Please enter your PIN.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else{
            return true
        }
    }
    
    func SignInForm_Form1(_ loginVCValidateObj:SignUpVC) -> Bool {
        if isBlank(loginVCValidateObj.PhoneNumberTxtField) {
            self.error(message: "Please enter your phone number.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else{
            return true
        }
    }
    
    
    func SignIn1Form_Form(_ loginVCValidateObj:SignUp1VC) -> Bool {
        if isBlank(loginVCValidateObj.EmailAddressTxtField) {
            self.error(message: "Please enter your email address.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }
        else if isBlank(loginVCValidateObj.PasswordTxtField) {
            self.error(message: "Please enter your password.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }
       
        else if isBlank(loginVCValidateObj.ReEnterPasswordTxtField) {
            self.error(message: "Please confirm your password.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }
        else if loginVCValidateObj.PasswordTxtField.text! != loginVCValidateObj.ReEnterPasswordTxtField.text!{
            self.error(message: "Password confirmation does not match.")
            return false
        }else if loginVCValidateObj.termndCondition .isEqual(to: "No") {
            self.error(message: "Please read and accept Terms & Conditions.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }
//        else if isValidPassword(loginVCValidateObj.strPass as String) {
//            self.error(message: "Password must have minimum 8 digits containing combination of upppercase,lowercase,number & spacial character.")
//                  // loginVCValidateObj.view.endEditing(true)
//            return false
//        }
        else{
            return true
        }
    }
    
    
 

    func SignInForm_IPAD_Form(_ loginVCValidateObj:SignUpVC_iPad) -> Bool {
        if isBlank(loginVCValidateObj.PhoneNumberTxtField) {
            self.error(message: "Please enter your phone number.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else if isBlank(loginVCValidateObj.EnterPINTxtField) {
            self.error(message: "Please enter your PIN.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else{
            return true
        }
    }
    
    func SignInForm_IPAD_Form1(_ loginVCValidateObj:SignUpVC_iPad) -> Bool {
        if isBlank(loginVCValidateObj.PhoneNumberTxtField) {
            self.error(message: "Please enter your phone number.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else{
            return true
        }
    }
    
    func SignIn2Form_IPAD_Form(_ loginVCValidateObj:SignUp2_iPad) -> Bool {
        if isBlank(loginVCValidateObj.EmailTxtField) {
            self.error(message: "Please enter your email address.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else if isBlank(loginVCValidateObj.EnterPasswordTxtField) {
            self.error(message: "Please enter your password.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else if isValidPassword(loginVCValidateObj.EnterPasswordTxtField.text!) {
            self.error(message: "Password must have minimum 8 digits containing combination of upppercase,lowercase,number & spacial character.")
           // loginVCValidateObj.view.makeToast(message: "Password must have minimum 6 digits containing combination of upppercase,lowercase,number & spacial character.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }
        else if isBlank(loginVCValidateObj.ReEnterPasswordTxtField) {
            self.error(message: "Please enter your confirm password.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else if isValidPassword(loginVCValidateObj.ReEnterPasswordTxtField.text!) {
            self.error(message: "Password must have minimum 8 digits containing combination of upppercase,lowercase,number & spacial character.")
           // loginVCValidateObj.view.makeToast(message: "Password must have minimum 6 digits containing combination of upppercase,lowercase,number & spacial character.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }
        else if loginVCValidateObj.EnterPasswordTxtField.text! != loginVCValidateObj.ReEnterPasswordTxtField.text!{
            self.error(message: "Password confirmation does not match.")
            loginVCValidateObj.view.makeToast(message: "Password & Re-enter password was mismatch.")
            return false
        }else if loginVCValidateObj.termndCondition .isEqual(to: "No") {
            self.error(message: "Please read and accept Terms & Conditions.")
            //loginVCValidateObj.view.makeToast(message: "I accept terms & conditions.")
            loginVCValidateObj.view.endEditing(true)
                       return false
        }
        else{
            return true
        }
    }

    func ValidateLostPinIPADForm(_ loginVCValidateObj:LostPINVC_iPad) -> Bool {
        if isBlank(loginVCValidateObj.EmailAddressTxtField) {
            self.error(message: "Please enter your email address.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else{
            return true
        }
    }
    func ValidateLostPinForm(_ loginVCValidateObj:ForgotPasswordVC) -> Bool {
        if isBlank(loginVCValidateObj.EmailAddressTxtField) {
            self.error(message: "Please enter your email address.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else{
            return true
        }
    }
    
    func Validate_OTP_IPADForm(_ loginVCValidateObj:EnterNewPasswordVC_iPad) -> Bool {
        if isBlank(loginVCValidateObj.OtpTxtField) {
            self.error(message: "Please enter your OTP.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }
        else{
            return true
        }
    }
    func Validate_OTPForm(_ loginVCValidateObj: NewPasswordVC) -> Bool {
        if isBlank(loginVCValidateObj.OtpTxtField) {
            self.error(message: "Please enter your OTP.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }
        else{
            return true
        }
    }
    
    func Validate_ResetPasswordForm(_ resetPasswordVCValidateObj:ResetPasswordVC) -> Bool {
              if isBlank(resetPasswordVCValidateObj.NewPasswordTxtField) {
                self.error(message: "Please enter your new password.")
                resetPasswordVCValidateObj.view.endEditing(true)
                return false
             }else if isValidPassword(resetPasswordVCValidateObj.NewPasswordTxtField.text!) {
                resetPasswordVCValidateObj.view.makeToast(message: "Password must have minimum 8 digits containing combination of upppercase,lowercase,number & spacial character.")
                resetPasswordVCValidateObj.view.endEditing(true)
                return false
            }
             else if isBlank(resetPasswordVCValidateObj.ReEnterPasswordTxtField) {
                self.error(message: "Please Re-enter password.")
                resetPasswordVCValidateObj.view.endEditing(true)
                return false
            }else if isValidPassword(resetPasswordVCValidateObj.ReEnterPasswordTxtField.text!) {
                resetPasswordVCValidateObj.view.makeToast(message: "Password must have minimum 8 digits containing combination of upppercase,lowercase,number & spacial character.")
                resetPasswordVCValidateObj.view.endEditing(true)
                return false
            }
            else if resetPasswordVCValidateObj.NewPasswordTxtField.text! != resetPasswordVCValidateObj.ReEnterPasswordTxtField.text!{
                resetPasswordVCValidateObj.view.makeToast(message: "Password Mismatch! Please enter the same password in both the fields.")
                resetPasswordVCValidateObj.view.endEditing(true)
                return false
            } else{
                return true
            }
        }
    
    
    func Validate_ResetPasswordForm1(_ resetPasswordVCValidateObj:ResetPassword_IpadVc) -> Bool {
                 if isBlank(resetPasswordVCValidateObj.enterPassTxt) {
                   self.error(message: "Please enter your new password.")
                   resetPasswordVCValidateObj.view.endEditing(true)
                   return false
                 }else if isValidPassword(resetPasswordVCValidateObj.enterPassTxt.text!) {
                   resetPasswordVCValidateObj.view.makeToast(message: "Password must have minimum 8 digits containing combination of upppercase,lowercase,number & spacial character.")
                   resetPasswordVCValidateObj.view.endEditing(true)
                    return false
                    return false
               }else if isBlank(resetPasswordVCValidateObj.reEnterPassTxt) {
                   self.error(message: "Please Re-enter password.")
                   resetPasswordVCValidateObj.view.endEditing(true)
                   return false
               }else if isValidPassword(resetPasswordVCValidateObj.reEnterPassTxt.text!) {
                   resetPasswordVCValidateObj.view.makeToast(message: "Password must have minimum 8 digits containing combination of upppercase,lowercase,number & spacial character.")
                   resetPasswordVCValidateObj.view.endEditing(true)
                    return false
               }else if resetPasswordVCValidateObj.enterPassTxt.text! != resetPasswordVCValidateObj.reEnterPassTxt.text!{
                   resetPasswordVCValidateObj.view.makeToast(message: "Password Mismatch! Please enter the same password in both the fields.")
                   resetPasswordVCValidateObj.view.endEditing(true)
                    
                   return false
               } else{
                   return true
               }
           }
    
    
    func Validate_Changepassword_IPADForm(_ loginVCValidateObj:ChangePasswordVC_iPad) -> Bool {
        if isBlank(loginVCValidateObj.OldPasswordTxtField) {
            self.error(message: "Please enter your old password.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else if isBlank(loginVCValidateObj.NewPasswordTxtField) {
            self.error(message: "Please enter your new password.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else if isValidPassword(loginVCValidateObj.NewPasswordTxtField.text!) {
            loginVCValidateObj.view.makeToast(message: "Password must have minimum 8 digits containing combination of upppercase,lowercase,number & spacial character.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }
        else if isBlank(loginVCValidateObj.ConfirmPassowordTxtField) {
            self.error(message: "Please enter your confirm password.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else if isValidPassword(loginVCValidateObj.ConfirmPassowordTxtField.text!) {
            loginVCValidateObj.view.makeToast(message: "Password must have minimum 8 digits containing combination of upppercase,lowercase,number & spacial character.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else if loginVCValidateObj.NewPasswordTxtField.text! != loginVCValidateObj.ConfirmPassowordTxtField.text!{
            loginVCValidateObj.view.makeToast(message: "Your new password and confirm password does not match.")
            return false
        }else{
            return true
        }
    }
    func Validate_Changepassword_Form(_ loginVCValidateObj:ChangePasswordVC) -> Bool {
        if isBlank(loginVCValidateObj.OldTxtField) {
            self.error(message: "Please enter your old password.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else if isBlank(loginVCValidateObj.NewPTxtField) {
            self.error(message: "Please enter your new password.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else if isValidPassword(loginVCValidateObj.NewPTxtField.text!) {
            loginVCValidateObj.view.makeToast(message: "Password must have minimum 8 digits containing combination of upppercase,lowercase,number & spacial character.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }
        else if isBlank(loginVCValidateObj.ConfirmTxtField) {
            self.error(message: "Please enter your confirm password.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else if isValidPassword(loginVCValidateObj.ConfirmTxtField.text!) {
            loginVCValidateObj.view.makeToast(message: "Password must have minimum 8 digits containing combination of upppercase,lowercase,number & spacial character.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }
        else if loginVCValidateObj.NewPTxtField.text! != loginVCValidateObj.ConfirmTxtField.text!{
            loginVCValidateObj.view.makeToast(message: "Your new password and confirm password does not match.")
            return false
        }else{
            return true
        }
    }
    
    func Validate_editProfile_iPad_Form(_ loginVCValidateObj:EditAccount_iPad) -> Bool {
        if isBlank(loginVCValidateObj.Telephone_NumberTxtField) {
            self.error(message: "Please enter your telephone number.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else if isBlank(loginVCValidateObj.Preferred_AddressTxtField) {
            self.error(message: "Please selecte your preferred address.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else{
            return true
        }
    }
    func Validate_Address_Form(_ loginVCValidateObj:EnterYourAddressVC) -> Bool {
//        if isBlank(loginVCValidateObj.TelephoneNumberTxtField) {
//            self.error(message: "Please enter your telephone number.")
//            loginVCValidateObj.view.endEditing(true)
//            return false
//        }
//         if loginVCValidateObj.TelephoneNumberTxtField.text?.count<7 || loginVCValidateObj.TelephoneNumberTxtField.text!.count>15 {
//            self.error(message: "Mobile number must be more than 7 and less than 15 numbers only.")
//            loginVCValidateObj.view.endEditing(true)
//            return false
//        }else if isBlank(loginVCValidateObj.BackUpTelephoneNumberTxtField) {
//            self.error(message: "Please enter your backup telephone number.")
//            loginVCValidateObj.view.endEditing(true)
//            return false
        //}
     if isBlank(loginVCValidateObj.AddressLine1TxtField) {
            self.error(message: "Please enter your full address line 1.")
                loginVCValidateObj.view.endEditing(true)
            return false
            
//        }else if isBlank(loginVCValidateObj.AddressLine2TxtField) {
//            self.error(message: "Please enter your address line 2.")
//            loginVCValidateObj.view.endEditing(true)
//            return false
        }else if isBlank(loginVCValidateObj.areaTxtField) {
            self.error(message: "Please select your area.")
            loginVCValidateObj.view.endEditing(true)
            return false
     }else if loginVCValidateObj.datenw == nil || loginVCValidateObj.datenw == ""{
            Config().error(message: "Please select date")
         return false
        }
     else{
            return true
        }
    }
    
    
     func Validate_Address_Form1(_ loginVCValidateObj:EnterAddress_IpadVC) -> Bool {
//            if isBlank(loginVCValidateObj.TelephoneNumberTxtField) {
//                self.error(message: "Please enter your telephone number.")
//                loginVCValidateObj.view.endEditing(true)
//                return false
//            }else if loginVCValidateObj.TelephoneNumberTxtField.text?.count<7 || loginVCValidateObj.TelephoneNumberTxtField.text!.count>15 {
//                self.error(message: "Mobile number must be more than 7 and less than 15 numbers only.")
//                loginVCValidateObj.view.endEditing(true)
//                return false
//    //        }else if isBlank(loginVCValidateObj.BackUpTelephoneNumberTxtField) {
//    //            self.error(message: "Please enter your backup telephone number.")
//    //            loginVCValidateObj.view.endEditing(true)
//    //            return false
//            }
             if isBlank(loginVCValidateObj.AddressLine1TxtField) {
                self.error(message: "Please enter your full address line 1.")
                    loginVCValidateObj.view.endEditing(true)
                return false
                
    //        }else if isBlank(loginVCValidateObj.AddressLine2TxtField) {
    //            self.error(message: "Please enter your address line 2.")
    //            loginVCValidateObj.view.endEditing(true)
    //            return false
            }else if isBlank(loginVCValidateObj.areaTxtField) {
                self.error(message: "Please select your area.")
                loginVCValidateObj.view.endEditing(true)
                return false
            }else if loginVCValidateObj.datenw == nil || loginVCValidateObj.datenw == ""{
                Config().error(message: "Please select date?")
             return false
            }
             else{
                return true
            }
        }
    
    
    func Validate_editProfile_Form(_ loginVCValidateObj:AddProfileVC) -> Bool {
        if isBlank(loginVCValidateObj.Telephone_NumberTxtField) {
            self.error(message: "Please enter your telephone number.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else if loginVCValidateObj.Telephone_NumberTxtField.text?.count<7 || loginVCValidateObj.Telephone_NumberTxtField.text!.count>15 {
            self.error(message: "Mobile number must be more than 7 and less than 15 numbers only.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }
        else{
            return true
        }
    }
    func Validate_Edit_Address_Form(_ loginVCValidateObj:AddProfileVC) -> Bool {

        if isBlank(loginVCValidateObj.EditStreetAddressTxtField) {
            self.error(message: "Please enter your address line 1.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else if isBlank(loginVCValidateObj.EditAreaTxtFielld) {
            self.error(message: "Please select your area.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else if let text = loginVCValidateObj.AddressContactNumberTxtField.text, text.isEmpty {
  //          self.error(message: "Please enter your contact number.")
            loginVCValidateObj.view.endEditing(false)
            return true
        }else if loginVCValidateObj.AddressContactNumberTxtField.text?.count<7 || loginVCValidateObj.AddressContactNumberTxtField.text!.count>15 {
            self.error(message: "Mobile number must be more than 7 and less than 15 numbers only.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else{
            return true
        }
    }
    func Validate_Add_Address_Form(_ loginVCValidateObj:EnterYourAddressVC) -> Bool {
    //        if let text = AddressContactNumberTxtField.text, text.isEmpty {
    //        //           resultLabel.text = "Text field is empty"
    //                }
            if let text = loginVCValidateObj.TelephoneNumberTxtField.text, text.isEmpty {
    //            self.error(message: "Please enter your contact number.")
                loginVCValidateObj.view.endEditing(false)
                return true
            }else if loginVCValidateObj.TelephoneNumberTxtField.text?.count<7 || loginVCValidateObj.TelephoneNumberTxtField.text!.count>15 {
                self.error(message: "Mobile number must be more than 7 and less than 15 numbers only.")
                loginVCValidateObj.view.endEditing(true)
                return false
            }else
    //        else if isBlank(loginVCValidateObj.ExtNumberTxtField) {
    //            self.error(message: "Please enter your ext number.")
    //            loginVCValidateObj.view.endEditing(true)
    //            return false
    //        }else if isBlank(loginVCValidateObj.EditBuildingAddressTxtField) {
    //            self.error(message: "Please enter your full address.")
    //            loginVCValidateObj.view.endEditing(true)
    //            return false }
            if isBlank(loginVCValidateObj.AddressLine1TxtField) {
                self.error(message: "Please enter your address line 1.")
                loginVCValidateObj.view.endEditing(true)
                return false
            }else if isBlank(loginVCValidateObj.areaTxtField) {
                self.error(message: "Please select your area.")
                loginVCValidateObj.view.endEditing(true)
                return false
            }else{
                return true
            }
        }
    func Validate_Edit_Address_iPad_Form(_ loginVCValidateObj:EditAccount_iPad) -> Bool {
//        if isBlank(loginVCValidateObj.AddressContactNumberTxtField) {
//            self.error(message: "Please enter your contact number.")
//            loginVCValidateObj.view.endEditing(true)
//            return false
//        }else if isBlank(loginVCValidateObj.ExtNumberTxtField) {
//            self.error(message: "Please enter your ext number.")
//            loginVCValidateObj.view.endEditing(true)
//            return false }else
         if isBlank(loginVCValidateObj.EditStreetAddressTxtField) {
            self.error(message: "Please enter your street address.")
            loginVCValidateObj.view.endEditing(true)
            return false
//        }else if isBlank(loginVCValidateObj.EditBuildingAddressTxtField) {
//            self.error(message: "Please enter your full address.")
//            loginVCValidateObj.view.endEditing(true)
//            return false
        }else if isBlank(loginVCValidateObj.EditAreaTxtFielld) {
            self.error(message: "Please select your area.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else{
            return true
        }
    }
    func Validate_Address_iPad_Form(_ loginVCValidateObj:EnterYourAddress_iPad) -> Bool {
        if isBlank(loginVCValidateObj.AddressTxtField) {
            self.error(message: "Please enter your delivery location.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else if isBlank(loginVCValidateObj.AddressLine1TxtField) {
            self.error(message: "Please enter your address.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else if isBlank(loginVCValidateObj.TelephoneNumberTxtField) {
            self.error(message: "Please enter your telephone number.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else if isBlank(loginVCValidateObj.BackUpTelephoneNumberTxtField) {
            self.error(message: "Please enter your backup telephone number.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else{
            return true
        }
    }

}


