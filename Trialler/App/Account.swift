//
//  Account.swift
//  Trialler
//
//  Created by Conlagh Finnegan on 10/02/2023.
//

import os.log
import CloudKit
import Combine

class Account: ObservableObject {
    
    //MARK: Properties
    
    public static var shared = Account()
    
    @Published public var loggedInUser: User? {
        didSet {
            UserDefaults.standard.set(isLoggedIn, forKey: Config.userDefaultsLoggedInKey)
        }
    }
    
    public var isLoggedIn: Bool {
        loggedInUser != nil
    }
    
    public var userPublisher: Published<User?>.Publisher?
    
    private let container = CKContainer(identifier: Config.ckContainerID)
    
    private lazy var database = container.privateCloudDatabase
    
    private let userRecordID: CKRecord.ID
    
    //MARK: Lifecycle
    
    private init() {
        userRecordID = CKRecord.ID(recordName: Config.ckUserRecordKey)
        Task {
            try? await self.fetchUser()
        }
        userPublisher = $loggedInUser
    }
    
    //MARK: Public Functions
    
    public func login() async throws {
        try await fetchUser()
    }
    
    public func registerAndLogin(user: User) async throws {
        try await saveUser(user)
    }
    
    public func logout() async throws {
        do {
            let recordID = try await database.deleteRecord(withID: userRecordID)
            os_log("Record with ID \(recordID.recordName) was deleted.")
            DispatchQueue.main.async {
                self.loggedInUser = nil
            }
            UserDefaults.standard.set(nil, forKey: Config.userDefaultsLoggedInKey)
        } catch {
            self.reportError(error)
            throw error
        }
    }
    
    //MARK: Operations
    
    private func saveUser(_ user: User) async throws {
        let userRecord = CKRecord(recordType: "UserData", recordID: userRecordID)
        userRecord["forename"] = user.forename
        userRecord["surname"] = user.surname
        userRecord["emailAddress"] = user.emailAddress
        
        let recordResult: Result<CKRecord, Error>
        do {
            let (saveResults, _) = try await database.modifyRecords(saving: [userRecord],
                                                                    deleting: [],
                                                                    savePolicy: .allKeys)
            recordResult = saveResults[userRecordID]!
        } catch let functionError {
            self.reportError(functionError)
            throw functionError
        }
        
        switch recordResult {
        case .success(let savedRecord):
            os_log("Record with ID \(savedRecord.recordID.recordName) was saved.")
            try await self.fetchUser()
            
        case .failure(let recordError):
            self.reportError(recordError)
            throw recordError
        }
    }
        
    private func fetchUser() async throws {
        do {
            let record = try await database.record(for: userRecordID)
            os_log("Record with ID \(record.recordID.recordName) was fetched.")
            DispatchQueue.main.async {
                self.loggedInUser = User(record)
            }
        } catch {
            self.reportError(error)
            throw error
        }
    }
    
    //MARK: Error Handling
    
    private func reportError(_ error: Error) {
        guard let ckerror = error as? CKError else {
            os_log("Not a CKError: \(error.localizedDescription)")
            return
        }
        
        switch ckerror.code {
        case .partialFailure:
            // Iterate through error(s) in partial failure and report each one.
            let dict = ckerror.userInfo[CKPartialErrorsByItemIDKey] as? [NSObject: CKError]
            if let errorDictionary = dict {
                for (_, error) in errorDictionary {
                    reportError(error)
                }
            }
            
        case .unknownItem:
            os_log("CKError: Record not found.")
            
        case .notAuthenticated:
            os_log("CKError: An iCloud account must be signed in on device or Simulator to write to a PrivateDB.")
            
        case .permissionFailure:
            os_log("CKError: An iCloud account permission failure occured.")
            
        case .networkUnavailable:
            os_log("CKError: The network is unavailable.")
            
        default:
            os_log("CKError: \(error.localizedDescription)")
        }
    }
}
