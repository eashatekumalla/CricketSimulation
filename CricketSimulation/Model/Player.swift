//
//  PLayer.swift
//  CricketSimulation
//
//  Created by Easha.T on 16/09/19.
//  Copyright © 2019 Easha.T. All rights reserved.
//
import Foundation

struct Player {
    let name : String?
    let probability: OrderedDictionary<ProbabilityCategory, Double>?
    let team: Team?
}
