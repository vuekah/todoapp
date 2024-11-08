//
//  UserService.swift
//  todoapp
//
//  Created by admin on 6/11/24.
//
import Supabase
import RxSwift
class UserService{
    
    private let supabaseClient: SupabaseClient
    
    init(supabaseClient: SupabaseClient) {
        self.supabaseClient = supabaseClient
    }
    
    
    func addUser(u: UserModel) -> Single<UserModel> {
        return Single.create { single in
            Task {
                do {
                    _ = try await self.supabaseClient
                        .auth
                        .signUp(email:u.username, password:u.password)
                    
                    single(.success(u))
                } catch {
                    print("########: \(error)")
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    func getUser(u: UserModel) -> Single<UserModel> {
        return Single.create { single in
            Task{
                do{
                    _ = try await self.supabaseClient.auth.signIn(email: u.username, password: u.password)
                    single(.success(u))
                }catch {
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    func signOut() {
        Task{
            do{
                try await self.supabaseClient.auth.signOut()
                
            }catch{}
        }
    }
    
}
