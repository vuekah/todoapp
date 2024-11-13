//
//  ImageUtils.swift
//  todoapp
//
//  Created by admin on 7/11/24.
//

class ImageUtils{
    static  func convertCategoryTypeToImage(_ type: CategoryType) -> String {
        switch type {
        case .one: return "book"
        case .two: return "date"
        case .three: return "cup"
        default: return "book"
        }
    }
}
