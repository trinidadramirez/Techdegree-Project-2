//  TriviaQuestions.swift
//  EnhanceQuizStarter
//  Created by Trinidad Ramirez on 7/5/18.
//  Copyright © 2018 Treehouse. All rights reserved.

/*
    The TriviaQuestions class allocates the question data into dictionaries first, and into an array, second.
 */

import Foundation

class TriviaQuestions {
    let question : String
    let choice1 : String
    let choice2 : String
    let choice3 : String
    let choice4 : String
    let answer : String
    
    init(question : String, choice1  : String, choice2 : String, choice3 : String, choice4 : String, answer : String) {
        self.question = question
        self.choice1 = choice1
        self.choice2 = choice2
        self.choice3 = choice3
        self.choice4 = choice4
        self.answer = answer
    }
}
    let question1 = TriviaQuestions(question: "This was the only US President to serve more than two consecutive terms.", choice1: "George Washington", choice2: "Franklin D. Roosevelt", choice3: "Woodrow Wilson", choice4: "Andrew Jackson", answer: "Franklin D. Roosevelt")
    
    let question2 = TriviaQuestions(question: "Which of the following countries has the most residents?", choice1: "Nigeria", choice2: "Russia", choice3: "Iran", choice4: "Vietnam", answer: "Nigeria")
    
    let question3 = TriviaQuestions(question: "Which country has most recently won consecutive World Cups in Soccer?", choice1: "Italy", choice2: "Brazil", choice3: "Argentina", choice4: "Spain", answer: "Brazil")
    
    let question4 = TriviaQuestions(question: "Which of these countries won the most medals in the 2012 Summer Games?", choice1: "France", choice2: "Germany", choice3: "Japan", choice4: "Great Britain", answer: "Great Britain")
    
    let questionsArray = [question1, question2, question3, question4]
