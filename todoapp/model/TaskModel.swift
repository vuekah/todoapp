//
//  TaskModel.swift
//  todoapp
//
//  Created by admin on 1/11/24.
//
import Foundation

struct TaskModel: Decodable {
    let data: [TaskData]
    
    func count() -> Int {
        data.count
    }
}

struct TaskData: Decodable {
    let id: Int?
    let category:CategoryType
    let taskTitle: String
    let date: String
    let time: String
    let notes: String
    let isCompleted: Bool
    let uid:UUID?
    
    
    
}

struct TaskInsertData: Encodable {
    let uid :UUID?
    let category: Int
    let taskTitle: String
    let date: String
    let time: String
    let notes: String
    let isCompleted: Bool
    
    var description: String {
           return """
           TaskInsertData(
               category: \(category),
               taskTitle: "\(taskTitle)",
               date: "\(date)",
               time: "\(time)",
               notes: "\(notes)",
               isCompleted: \(isCompleted)
           )
           """
       }
}

enum CategoryType: Int, Decodable {
    case one = 1
    case two = 2
    case three = 3
}
