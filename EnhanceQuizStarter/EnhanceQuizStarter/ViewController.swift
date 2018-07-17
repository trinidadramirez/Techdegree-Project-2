// ViewController.swift
// EnhanceQuizStarter
// Created by Pasan Premaratne on 3/12/18.
// Revised by Trinidad Ramirez on 07/13/2018
// Copyright © 2018 Treehouse. All rights reserved.

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion = 0
    var gameSound: SystemSoundID = 0
    var questionsAskedArray : Array<Int> = []
    
    // MARK: - Outlets
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var firstChoice: UIButton!
    @IBOutlet weak var secondChoice: UIButton!
    @IBOutlet weak var thirdChoice: UIButton!
    @IBOutlet weak var fourthChoice: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var nextQuestionButton : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGameStartSound()
        playGameStartSound()
        displayQuestionAndChoices()
    }
    
    // MARK: - Helpers
    
    func loadGameStartSound() {
        let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    func displayQuestionAndChoices() {
        // Continuously generate randomn numbers until the number doesnt equal an integer
        // that is already stored in the questionsAskedArray
        enableButtons()
        nextQuestionButton.isEnabled = false
        
        repeat {
            indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: questionsArray.count)
        } while questionsAskedArray.contains(indexOfSelectedQuestion)
        
        // Append the question asked into an array
        questionsAskedArray.append(indexOfSelectedQuestion)
        
        let questionDictionary = questionsArray[indexOfSelectedQuestion]
        questionField.text = questionDictionary.question
        playAgainButton.isHidden = true
        
        firstChoice.setTitle(questionDictionary.choice1, for: .normal)
        secondChoice.setTitle(questionDictionary.choice2, for: .normal)
        thirdChoice.setTitle(questionDictionary.choice3, for: .normal)
        fourthChoice.setTitle(questionDictionary.choice4, for: .normal)
    }
    
    func displayScore() {
        // Hide the answer buttons
        firstChoice.isHidden = true
        secondChoice.isHidden = true
        thirdChoice.isHidden = true
        fourthChoice.isHidden = true
        nextQuestionButton.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            questionsAskedArray.removeAll()
            displayScore()
        } else {
            // Continue game
            displayQuestionAndChoices()
        }
    }
    
    func loadNextRound(delay seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        let selectedQuestionDict = questionsArray[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict.answer
        
        if (sender.titleLabel!.text == correctAnswer) {
            correctQuestions += 1
            questionField.text = "Correct!"
            disableButtons()
            nextQuestionButton.isEnabled = true
        } else {
            questionField.text = "Sorry, wrong answer!"
        }
        sender.isEnabled = true
    }
    
    // This action loads another round when the user presses the "Next Question" button
    @IBAction func nextQuestion(_ sender : UIButton) -> Void {
        if sender.titleLabel!.text == "Next Question" {
            loadNextRound(delay: 0)
        }
    }
    
    @IBAction func playAgain(_ sender: UIButton) {
        // Show the answer buttons
        questionsAsked = 0
        correctQuestions = 0
        firstChoice.isHidden = false
        secondChoice.isHidden = false
        thirdChoice.isHidden = false
        fourthChoice.isHidden = false
        nextQuestionButton.isHidden = false
        nextRound()
    }
    // Function for disabling all buttons at once
    func disableButtons() -> Void {
        firstChoice.isEnabled = false
        secondChoice.isEnabled = false
        thirdChoice.isEnabled = false
        fourthChoice.isEnabled = false
    }
    // Function for enabling buttons all at once
    func enableButtons() -> Void {
        firstChoice.isEnabled = true
        secondChoice.isEnabled = true
        thirdChoice.isEnabled = true
        fourthChoice.isEnabled = true
    }
}
