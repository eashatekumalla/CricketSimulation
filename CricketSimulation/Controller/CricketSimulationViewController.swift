//
//  ViewController.swift
//  CricketSimulation
//
//  Created by Easha.T on 16/09/19.
//  Copyright © 2019 Easha.T. All rights reserved.
//
import UIKit

class CricketSimulationViewController: UIViewController {

    static let TOTAL_NUMBER_OF_RUNS_TO_WIN = 40
    
    static let TOTAL_NUMBER_OF_OVERS = 4
    
    static let TEAM_NAME = "Bengaluru"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let team = Team(teamName: CricketSimulationViewController.TEAM_NAME)
        let playersArray = buildPlayersArray(team: team)
        startMatchSimulation(playersArray: playersArray)
    }
    
    func buildPlayersArray(team: Team) -> [Player] {
        var playersArray = [Player]()

        let playerOne = Player(name: "Kirat",
                               probability: buildProbabilityDictionary(5, 30, 25, 10, 15, 1, 9, 5),
                               team: team)
        let playerTwo = Player(name: "Nodhi", probability: buildProbabilityDictionary(10, 40, 20, 5, 10, 1, 4, 10),
                               team: team)
        let playerThree = Player(name: "Rumrah", probability: buildProbabilityDictionary(20, 30, 15, 5, 5, 1, 4, 20), team: team)
        let playerFour = Player(name: "Shashi", probability: buildProbabilityDictionary(30, 25, 5, 0, 5, 1, 4, 30), team: team)

        playersArray.append(playerOne)
        playersArray.append(playerTwo)
        playersArray.append(playerThree)
        playersArray.append(playerFour)
        return playersArray
    }

    func buildProbabilityDictionary(_ probs: Double...) -> OrderedDictionary<ProbabilityCategory, Double> {
        var probabilityCategoryDict = OrderedDictionary<ProbabilityCategory, Double>()
        probabilityCategoryDict[ProbabilityCategory.dot] = probs[0]
        probabilityCategoryDict[ProbabilityCategory.one] = probs[1]
        probabilityCategoryDict[ProbabilityCategory.two] = probs[2]
        probabilityCategoryDict[ProbabilityCategory.three] = probs[3]
        probabilityCategoryDict[ProbabilityCategory.four] = probs[4]
        probabilityCategoryDict[ProbabilityCategory.five] = probs[5]
        probabilityCategoryDict[ProbabilityCategory.six] = probs[6]
        probabilityCategoryDict[ProbabilityCategory.out] = probs[7]
        return probabilityCategoryDict
    }
    
    func startMatchSimulation(playersArray: [Player]) {
        let matchSimulator = MatchSimulator(playersArray: playersArray,
                                            totalNumberOfRunsToWin: CricketSimulationViewController.TOTAL_NUMBER_OF_RUNS_TO_WIN,
                                            totalNumberOfOvers: CricketSimulationViewController.TOTAL_NUMBER_OF_OVERS)
        matchSimulator.startMatch()
    }
}
