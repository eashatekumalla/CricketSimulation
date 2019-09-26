//
//  MatchSimulator.swift
//  CricketSimulation
//
//  Created by Easha.T on 16/09/19.
//  Copyright © 2019 Easha .T. All rights reserved.
//

class MatchSimulator {
    
    var matchStatistics: MatchStatistics!
    
    var playersArray: [Player] = [Player]()
    
    var totalNumberOfRunsToWin: Int!
    
    var totalNumberOfOvers: Int!
    
    init(playersArray: [Player], totalNumberOfRunsToWin: Int, totalNumberOfOvers: Int) {
        self.playersArray = playersArray
        self.totalNumberOfRunsToWin = totalNumberOfRunsToWin
        self.totalNumberOfOvers = totalNumberOfOvers
        self.matchStatistics = self.initialiseMatchStatistics()
    }
    
    func initialiseMatchStatistics() -> MatchStatistics {
        let matchStatistics = MatchStatistics(totalNumberOfRunsToWin: self.totalNumberOfRunsToWin,
                                              totalNumberOfBalls: self.totalNumberOfOvers * 6,
                                              totalNumberOfWickets: self.playersArray.count)
        matchStatistics.currentStriker = playersArray[0]
        matchStatistics.currentNonStriker = playersArray[1]
        matchStatistics.totalNumberOfRunsScoredTillNow = 0
        matchStatistics.totalNumberOfBallsPlayedTillNow = 0
        matchStatistics.totalNumberOfWicketsLostTillNow = 0
        return matchStatistics
    }
    
    func startMatch() {
        logOverEvent()
        while canContinueMatch() {
            let currentStriker = matchStatistics.currentStriker!
            let event = ProbabilityGenerator.generateRandomProbabilityEventForPlayer(player: currentStriker)
            handleEvent(event: event)
            
            logMatchEvent(event: buildMatchEvent(fromEvent: event, currentStriker: currentStriker))
            
            updateMatchStatistics(probabilityCategory: event)
            if endOfOver() {
                logOverEvent()
                changeStrike()
            }
        }
        logMatchResult()
    }

    func handleEvent(event: ProbabilityCategory) {
        if event == .out {
            swapPlayerWhenOut()
        } else if event == .one || event == .three || event == .five {
            changeStrike()
        }
    }
    
    func buildMatchEvent(fromEvent event: ProbabilityCategory, currentStriker: Player) -> MatchEvent {
        let matchEvent = MatchEvent()
        matchEvent.currentStriker = currentStriker
        matchEvent.currentNonStriker = matchStatistics.currentNonStriker
        matchEvent.numbersScored = getNumberOfRunsScored(probabilityCategory: event)
        matchEvent.isOut = event == .out
        matchEvent.ballNumber = matchStatistics.totalNumberOfBallsPlayedTillNow + 1
        return matchEvent
    }

    func logMatchResult() {
        let teamName = playersArray.first?.team?.teamName ?? ""
        if isBattingSideTheWinner() {
            let wicketsLeft = matchStatistics.totalNumberOfWicketsLeft
            let ballsLeft = matchStatistics.totalNumberOfBallsLeft
            print("\(teamName) team won by \(wicketsLeft ?? 0) wicket and \(ballsLeft ?? 0) balls remaining.")
        } else {
            let runsLeft = matchStatistics.totalNumberOfRunsLeftToWin
            print("\(teamName) team lost by \(runsLeft ?? 0) runs.")
        }
    }
    
    func logOverEvent() {
        let oversLeft = matchStatistics.totalNumberOfBallsLeft / 6
        print("\(oversLeft) overs left. \(matchStatistics.totalNumberOfRunsLeftToWin ?? 0) runs to win.")
    }

    func endOfOver() -> Bool {
        return matchStatistics.totalNumberOfBallsPlayedTillNow % 6 == 0
    }
    
    func isBattingSideTheWinner() -> Bool {
        if matchStatistics.totalNumberOfRunsLeftToWin <= 0 {
            return true
        } else if matchStatistics.totalNumberOfWicketsLeft <= 1 {
            return false
        } else if matchStatistics.totalNumberOfBallsLeft <= 0 {
            if matchStatistics.totalNumberOfRunsLeftToWin > 0 {
                return false
            } else {
                return true
            }
        }
        return true
    }
    
    func canContinueMatch() -> Bool {
        if matchStatistics.totalNumberOfBallsLeft == 0 {
            return false
        }
        if matchStatistics.totalNumberOfWicketsLeft <= 1 {
            return false
        }
        if matchStatistics.totalNumberOfRunsLeftToWin <= 0 {
            return false
        }
        return true
    }
    
    func getNumberOfRunsScored(probabilityCategory: ProbabilityCategory) -> Int {
        var numberOfRunsScored = 0
        if probabilityCategory == .one {
            numberOfRunsScored = 1
        } else if probabilityCategory == .two {
            numberOfRunsScored = 2
        } else if probabilityCategory == .three {
            numberOfRunsScored = 3
        } else if probabilityCategory == .four {
            numberOfRunsScored = 4
        } else if probabilityCategory == .five {
            numberOfRunsScored = 5
        } else if probabilityCategory == .six {
            numberOfRunsScored = 6
        }
        return numberOfRunsScored
    }
    
    
    func updateMatchStatistics(probabilityCategory: ProbabilityCategory) {
        let numberOfRunsScored = getNumberOfRunsScored(probabilityCategory: probabilityCategory)
        matchStatistics.totalNumberOfRunsScoredTillNow = matchStatistics.totalNumberOfRunsScoredTillNow + numberOfRunsScored
        matchStatistics.totalNumberOfBallsPlayedTillNow = matchStatistics.totalNumberOfBallsPlayedTillNow + 1
    }
    
    func changeStrike() {
        let newNonStriker = matchStatistics.currentStriker
        matchStatistics.currentStriker = matchStatistics.currentNonStriker
        matchStatistics.currentNonStriker = newNonStriker
    }
    
    func swapPlayerWhenOut() {
        matchStatistics.totalNumberOfWicketsLostTillNow = matchStatistics.totalNumberOfWicketsLostTillNow + 1
        if matchStatistics.totalNumberOfWicketsLeft > 1 {
            matchStatistics.currentStriker = getNextPlayer()
        }
    }
    
    func getNextPlayer() -> Player {
        let currentStriker = matchStatistics.currentStriker
        let currentNonStriker = matchStatistics.currentNonStriker
        var currentPlayerIndex = 0
        for (index, player) in self.playersArray.enumerated() {
            if player.name == currentStriker?.name || player.name == currentNonStriker?.name{
                if currentPlayerIndex < index {
                    currentPlayerIndex = index
                }
            }
        }
        return playersArray[currentPlayerIndex + 1]
    }

    func logMatchEvent(event: MatchEvent) {
        let isLastBallOfOver = event.ballNumber % 6 == 0
        let overNumber = event.ballNumber / 6
        let displayOverNumber = isLastBallOfOver ? overNumber - 1 : overNumber
        let displayBallNumber = isLastBallOfOver ? 6 : event.ballNumber % 6
        if event.isOut {
            print("\(displayOverNumber).\(displayBallNumber) \(event.currentStriker.name ?? "") is out ")
        } else {
            print("\(displayOverNumber).\(displayBallNumber) \(event.currentStriker.name ?? "") scores \(event.numbersScored ?? 0) runs ")
        }
    }
}
