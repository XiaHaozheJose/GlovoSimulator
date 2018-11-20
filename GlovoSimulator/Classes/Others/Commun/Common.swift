//
//  Common.swift
//  GlovoSimulator
//
//  Created by JS_Coder on 11/6/18.
//  Copyright © 2018 JS_Coder. All rights reserved.
//

import UIKit

let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height

var globalSelectedSingle: [String:IndexPath] = [:]
var globalSelectedNonSingle: [String: IndexPath] = [:]
// tags
let dishes: [String] = ["Americana",
                        "Arabe",
                        "Asiatica",
                        "Burger",
                        "Carne",
                        "china",
                        "Hindu",
                        "Internacional",
                        "Italiana",
                        "Japonesa",
                        "Kebab",
                        "Latina",
                        "Libanesa",
                        "Mediterranea"]
// key = image value = tags
let resDatas: [String: String] = ["burger": "Americana/Burger/Carne",
                                "burrito": "Americana/Kebab/Carne",
                                "mahalo":"Asiatica/Japonesa/Carne",
                                "pizza":"Americana/Internacional/Italiana/Mediterranea",
                                "subway":"Americana/Carne/Internacional",
                                "test": "Americana/Burger/Carne",
                                "test1": "Americana/Kebab/Carne",
                                "test2":"Asiatica/Japonesa/Carne",
                                "test3":"Americana/Internacional/Italiana/Mediterranea",
                                "test4":"Americana/Carne/Internacional",
                                "test5": "Americana/Burger/Carne",
                                "test6": "Americana/Kebab/Carne",
                                "test7":"Asiatica/Japonesa/Carne",
                                "test8":"Americana/Internacional/Italiana/Mediterranea",
                                "test9":"Americana/Carne/Internacional"]


let types: [String] = ["TOP VENTAS", "PARA COMPARTIR", "ENTRANTES", "PLATOS"]

let menuDatas: [[String: Any]] = [["title": "Combo", "price": "9.5", "descriptionMenu": "Elige tu menu con carne + 1", "isSubMenu": 1, "type": 0],
                                  ["title": "Nachos con todo", "price": "10.5", "descriptionMenu": "Chips, frijoles salsa de queso, pico de gallo, crema agria y guacamole", "isSubMenu": 1, "type": 1],
                                    ["title": "Nachos con todo", "price": "10.5", "descriptionMenu": "Chips, frijoles salsa de queso, pico de gallo, crema agria y guacamole", "isSubMenu": 1, "type": 2],
                                    ["title": "Nachos con todo", "price": "10.5", "descriptionMenu": "Chips, frijoles salsa de queso, pico de gallo, crema agria y guacamole", "isSubMenu": 1, "type": 3],
                                    ["title": "Nachos con todo", "price": "10.5", "descriptionMenu": "Chips, frijoles salsa de queso, pico de gallo, crema agria y guacamole", "isSubMenu": 1, "type": 0],
                                    ["title": "Combo", "price": "9.5", "descriptionMenu": "Elige tu menu con carne + 1", "isSubMenu": 1, "type": 0],
                                    ["title": "Combo", "price": "9.5", "descriptionMenu": "Elige tu menu con carne + 1", "isSubMenu": 1, "type": 2],
                                    ["title": "Combo", "price": "9.5", "descriptionMenu": "Elige tu menu con carne + 1", "isSubMenu": 1, "type": 1]]

let subMenuDatas: [[String: Any]] = [["title" :"¿QUE TE APETECE COMER?",
                                   "isRequied": true,
                                   "isSingleSelected": true,
                                   "subContent": [["name":"Burrito",
                                                   "price":0.00,
                                                   "isBebida": false,
                                                   ],
                                                  ["name":"Ensalada",
                                                   "price":0.00,
                                                   "isBebida": false,
                                                      ],
                                                  ["name":"Desnudo(sin tortilla)",
                                                   "price":0.00,
                                                   "isBebida": false,
                                                         ]]],
                                   ["title" :"ELIGE EL TIPO DE CARNE",
                                   "isRequied": true,
                                   "isSingleSelected": true,
                                   "subContent": [["name":"Pollo",
                                                   "price":0.00,
                                                   "isBebida": false,
                                                   ],
                                                  ["name":"Steak",
                                                   "price":0.40,
                                                   "isBebida": false,
                                                   ],
                                                  ["name":"Carnitas",
                                                   "price":0.00,
                                                   "isBebida": false,
                                                   ],
                                                  ["name":"Barbacoa",
                                                   "price":0.00,
                                                   "isBebida": false,
                                                   ]]],
                                  ["title" :"¿EXTRA DE CARNE?",
                                   "isRequied": false,
                                   "isSingleSelected": false,
                                   "subContent": [["name":"Extra de pollo",
                                                   "price":2.65,
                                                   "isBebida": false,
                                                   ],
                                                  ["name":"Extra de steak",
                                                   "price":2.65,
                                                   "isBebida": false,
                                                   ],
                                                  ["name":"Extra de carnitas",
                                                   "price":2.65,
                                                   "isBebida": false,
                                                   ],
                                                  ["name":"Extra de barbacoa",
                                                   "price":2.65,
                                                   "isBebida": false,
                                                   ]]],
                                   ["title" :"ELIGE LOS INGREDIENTES",
                                   "isRequied": true,
                                   "isSingleSelected": false,
                                   "subContent": [["name":"Arroz integral",
                                                   "price":0.00,
                                                   "isBebida": false,
                                                   ],
                                                  ["name":"Arroz blanco",
                                                   "price":0.00,
                                                   "isBebida": false,
                                                   ],
                                                  ["name":"Verduras",
                                                   "price":0.00,
                                                   "isBebida": false,
                                                   ],
                                                  ["name":"Frijoles",
                                                   "price":0.00,
                                                   "isBebida": false,
                                                   ],
                                                  ["name":"Salsa de queso",
                                                   "price":0.00,
                                                   "isBebida": false,
                                                   ],
                                                  ["name":"Guacamole",
                                                   "price":2.45,
                                                   "isBebida": false,
                                                   ],
                                                  ["name":"Pico de Gallo",
                                                   "price":0.00,
                                                   "isBebida": false,
                                                   ],
                                                  ["name":"Crema chipotle",
                                                   "price":0.00,
                                                   "isBebida": false,
                                                   ]]],
                                   ["title" :"BEBIDA EXTRA",
                                   "isRequied": false,
                                   "isSingleSelected": false,
                                   "subContent": [["name":"Agua Mineral(50cl)",
                                                   "price":1.60,
                                                   "isBebida": true,
                                                   ],
                                                  ["name":"San Pellegrino(50cl)",
                                                   "price":2.50,
                                                   "isBebida": true,
                                                   ],
                                                  ["name":"Pepsi(50cl)",
                                                   "price":2.50,
                                                   "isBebida": true,
                                                   ],
                                                  ["name":"7UP",
                                                   "price":1.50,
                                                   "isBebida": true,
                                                   ],
                                                  ["name":"Lipton Ice Tea Limon(50cl)",
                                                   "price":2.50,
                                                   "isBebida": true,
                                                   ],
                                                  ["name":"Kas Naranja",
                                                   "price":2.45,
                                                   "isBebida": true,
                                                   ],
                                                  ["name":"Alhambra(33cl)",
                                                   "price":2.95,
                                                   "isBebida": true,
                                                   ],
                                                  ["name":"La Virgen Lager(33cl)",
                                                   "price":3.95,
                                                   "isBebida": true,
                                                   ]]]]



extension UILabel {
    func setText(with normalString: String, lineSpacing: CGFloat?, frame: CGRect) {
        self.frame = frame
        self.numberOfLines = 0
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        if lineSpacing != nil {
            if (frame.height - font.lineHeight) <= lineSpacing! {
                paragraphStyle.lineSpacing = 0
            } else {
                paragraphStyle.lineSpacing = lineSpacing!
            }
        }
        let attributedString = NSMutableAttributedString(string: normalString)
        let range = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttributes([NSAttributedString.Key.font: font], range: range)
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
        
        self.attributedText = attributedString
    }
}

extension String {
    func boundingRect(with constrainedSize: CGSize, font: UIFont, lineSpacing: CGFloat? = nil) -> CGSize {
        let attritube = NSMutableAttributedString(string: self)
        let range = NSRange(location: 0, length: attritube.length)
        attritube.addAttributes([NSAttributedString.Key.font: font], range: range)
        if lineSpacing != nil {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing!
            attritube.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
        }
        
        let rect = attritube.boundingRect(with: constrainedSize, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        var size = rect.size
        
        if let currentLineSpacing = lineSpacing {
            // 文本的高度减去字体高度小于等于行间距，判断为当前只有1行
            let spacing = size.height - font.lineHeight
            if spacing <= currentLineSpacing && spacing > 0 {
                size = CGSize(width: size.width, height: font.lineHeight)
            }
        }
        
        return size
    }
    
    func boundingRect(with constrainedSize: CGSize, font: UIFont, lineSpacing: CGFloat? = nil, lines: Int) -> CGSize {
        if lines < 0 {
            return .zero
        }
        
        let size = boundingRect(with: constrainedSize, font: font, lineSpacing: lineSpacing)
        if lines == 0 {
            return size
        }
        
        let currentLineSpacing = (lineSpacing == nil) ? (font.lineHeight - font.pointSize) : lineSpacing!
        let maximumHeight = font.lineHeight*CGFloat(lines) + currentLineSpacing*CGFloat(lines - 1)
        if size.height >= maximumHeight {
            return CGSize(width: size.width, height: maximumHeight)
        }
        
        return size
        
    }
    
}

extension UIImage{
   static func imageWithColor(color: UIColor)->UIImage?{
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        
        UIGraphicsBeginImageContext(rect.size)
        let ref = UIGraphicsGetCurrentContext()
        ref?.setFillColor(color.cgColor)
        ref?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
