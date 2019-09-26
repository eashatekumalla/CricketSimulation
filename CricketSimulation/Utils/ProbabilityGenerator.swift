//
//  ProbabilityGenerator.swift
//  CricketSimulation
//
//  Created by Easha.T on 26/09/19.
//  Copyright © 2019 Easha .T. All rights reserved.
//

import Foundation

class ProbabilityGenerator {
    static func generateRandomProbabilityEventForPlayer(player: Player) -> ProbabilityCategory {
        let sum = player.probability?.values.values.reduce(0, { (x, y) -> Double in
            return x + y
        })
        let random = Double.random(in: 0...sum!)
        var weightSum: Double = 0
        var probabilityCategory = ProbabilityCategory.dot
        
        for (_, value) in (player.probability!.keys.enumerated()) {
            let newWeightSum = weightSum + player.probability!.values[value]!
            if weightSum <= random && newWeightSum >= random {
                probabilityCategory = value
                break
            }
            weightSum = newWeightSum
        }
        return probabilityCategory
    }
}
