//
//  Untitled.swift
//  todoapp
//
//  Created by admin on 6/11/24.
//

import Foundation
import RxSwift
import Supabase

class TodoService {
    private let supabaseClient: SupabaseClient
    
    init(supabaseClient: SupabaseClient) {
        self.supabaseClient = supabaseClient
    }
    
    
    func getItems() -> Single<[TaskData]> {
        return Single.create { single in
            Task {
                do {
                    let uid = self.supabaseClient.auth.currentUser?.id
                    let tasks: [TaskData] = try await self.supabaseClient
                        .from("tasks")
                        .select()
                        .eq("uid", value: uid)
                        .execute()
                        .value
                    single(.success(tasks))
                } catch {
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    func addItem(task: TaskInsertData) -> Single<TaskInsertData> {
        return Single.create { single in
            Task {
                do {
                    
                    _ = try await self.supabaseClient
                        .from("tasks")
                        .insert([task])
                        .execute()
                    
                    single(.success(task))
                } catch {
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    func updateItem(id: Int) -> Single<Int> {
        return Single.create { single in
            Task {
                do {
                    let uid = self.supabaseClient.auth.currentUser?.id

                    _ = try await self.supabaseClient
                        .from("tasks")
                        .update(["isCompleted": true])
                        .eq("id", value: id)
                        .eq("uid", value: uid)
                        .execute()
                    single(.success(id))
                } catch {
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}
