//
//  ThemeUtils.swift
//  AesyBite
//
//  Created by Filippo Giove on 23/04/2020.
//  Copyright © 2020 Filippo Giove. All rights reserved.
//

import Foundation
import UIKit

class ThemeUtils {
    
    static func apply(for application: UIApplication) {
        ThemeUtils.applyAll()
        //application.windows.reload()
    }
    
    
    
    private static func applyAll() {
            
        //MARK: Labels

        
        Bold8Label.appearance().themeFont = Font.bold8.uiFont
        Bold8Label.appearance().themed = true
        
        Bold20Label.appearance().themeFont = Font.bold20.uiFont
        Bold20Label.appearance().themed = true
        
        
        Medium8Label.appearance().themeFont = Font.medium8.uiFont
        Medium8Label.appearance().themed = true
        
        Medium10Label.appearance().themeFont = Font.medium10.uiFont
        Medium10Label.appearance().themed = true
        
        Medium12Label.appearance().themeFont = Font.medium12.uiFont
        Medium12Label.appearance().themed = true
        
        Medium14Label.appearance().themeFont = Font.medium14.uiFont
        Medium14Label.appearance().themed = true
        
        Medium15Label.appearance().themeFont = Font.medium15.uiFont
        Medium15Label.appearance().themed = true
        
        Medium16Label.appearance().themeFont = Font.medium16.uiFont
        Medium16Label.appearance().themed = true
        
        Medium18Label.appearance().themeFont = Font.medium18.uiFont
        Medium18Label.appearance().themed = true
        
        Medium20Label.appearance().themeFont = Font.medium20.uiFont
        Medium20Label.appearance().themed = true
        
        
        Medium22Label.appearance().themeFont = Font.medium22.uiFont
        Medium22Label.appearance().themed = true
        
        
        Book8Label.appearance().themeFont = Font.book8.uiFont
        Book8Label.appearance().themed = true
        
        Book12Label.appearance().themeFont = Font.book12.uiFont
        Book12Label.appearance().themed = true
        
        RedBook12Label.appearance().themeFont = Font.book12.uiFont
        RedBook12Label.appearance().themed = true
        
        Book14Label.appearance().themeFont = Font.book14.uiFont
        Book14Label.appearance().themed = true
        
        Book16Label.appearance().themeFont = Font.book16.uiFont
        Book16Label.appearance().themed = true
        
        Book22Label.appearance().themeFont = Font.book22.uiFont
        Book22Label.appearance().themed = true
        
        Book44Label.appearance().themeFont = Font.book44.uiFont
        Book44Label.appearance().themed = true

        RedBook44Label.appearance().themeFont = Font.book44.uiFont
        RedBook44Label.appearance().themed = true
        
        Book48Label.appearance().themeFont = Font.book48.uiFont
        Book48Label.appearance().themed = true
        

        
        

      
      
    }
    
    

}
