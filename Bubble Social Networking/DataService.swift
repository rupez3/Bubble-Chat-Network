//
//  DataService.swift
//  Bubble Social Networking
//
//  Created by Chhetri, Rupesh (Contractor) on 10/25/16.
//  Copyright © 2016 RupeshChhetri. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper

let DB_BASE = FIRDatabase.database().reference()
// i.e. https://bubble-social-networking.firebaseio.com/

let STORAGE_BASE = FIRStorage.storage().reference()
// gs://bubble-social-networking.appspot.com

class DataService {
    
    static let ds = DataService()
    
    //DB Refs
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    
    // STORAGE Ref
    private var _REF_POST_IMAGES = STORAGE_BASE.child("post-images")
    
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_POSTS: FIRDatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    var REF_USER_CURRENT: FIRDatabaseReference {
        let uid = KeychainWrapper.standard.string(forKey: KEY_UID)
        let user = REF_USERS.child(uid!)
        return user
    }
    
    var REF_POST_IMAGES: FIRStorageReference {
        return _REF_POST_IMAGES
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
}
