//
//  MatchStatistics.swift
//  CricketSimulation
//
//  Created by Easha.T on 16/09/19.
//  Copyright © 2019 Easha .T. All rights reserved.
//

class MatchStatistics {
    let totalNumberOfRunsToWin: Int!
    let totalNumberOfBalls: Int!
    let totalNumberOfWickets: Int!
    
    var currentStriker: Player!

    var currentNonStriker: Player!

    var totalNumberOfRunsScoredTillNow: Int!

    var totalNumberOfBallsPlayedTillNow: Int!

    var totalNumberOfWicketsLostTillNow: Int!

    var totalNumberOfRunsLeftToWin: Int! {
        get {
            return self.totalNumberOfRunsToWin - self.totalNumberOfRunsScoredTillNow
        }
    }
    var totalNumberOfBallsLeft: Int! {
        get {
            return self.totalNumberOfBalls - self.totalNumberOfBallsPlayedTillNow
        }
    }
    var totalNumberOfWicketsLeft: Int! {
        get {
            return self.totalNumberOfWickets - self.totalNumberOfWicketsLostTillNow
        }
    }
    
    init(totalNumberOfRunsToWin: Int, totalNumberOfBalls: Int, totalNumberOfWickets: Int) {
        self.totalNumberOfRunsToWin = totalNumberOfRunsToWin
        self.totalNumberOfBalls = totalNumberOfBalls
        self.totalNumberOfWickets = totalNumberOfWickets
    }
}
