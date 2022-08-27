//
//  Constants.swift
//  WatchListPro
//
//  Created by Alexander Khazzam on 7/14/22.
//

import Foundation

struct K {
    
    static let apiKey = 78628677
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MovieDetailCell"
    
    struct Segues {
        static let welcomeToRegister = "WelcomeToRegister"
        static let registerToAuth = "RegisterToAuth"
        static let registerToHome = "RegisterToHome"
        static let welcomeToLogin = "WelcomeToLogin"
        static let loginToHome = "LoginToHome"
        static let homeToSearch = "HomeToSearch"
        static let homeToWatchlist = "HomeToWatchlist"
        static let watchlistToSearch = "WatchlistToSearch"
    }
    
    struct Firestore {
        static let collectionName = "Movies"
        static let movieField = "movieTitle"
    }
    
}

