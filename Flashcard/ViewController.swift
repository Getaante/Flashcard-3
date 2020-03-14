//
//  ViewController.swift
//  Flashcardapp2
//
//  Created by mac on 3/6/20.
//  Copyright © 2020 Getaante. All rights reserved.
//

import UIKit
struct Flashcard {
    var question: String
    var answer: String
}



class ViewController: UIViewController {

    @IBOutlet weak var Backlabel: UILabel!
    
    @IBOutlet weak var Frontlabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var previousButton: UIButton!
    
    
    //Array to hold our flash cards
    var flashcards = [Flashcard]()
    
    //current flash card index
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        readSavedFlashcards()
        if flashcards.count == 0 {
        updateFlashcard(question: "What is the capital of Ethiopia?", answer: "Addis Abeba")
    }
        else {
            updateLabels()
            updateNextPrevButtons()
        }
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if Frontlabel.isHidden {
            Backlabel.isHidden = true
            Frontlabel.isHidden = false
        }
        else {
            Frontlabel.isHidden = true
            Backlabel.isHidden = false
        }
    }
    
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        updateNextPrevButtons()
        updateLabels()
        if Frontlabel.isHidden {
            Frontlabel.isHidden = false
            Backlabel.isHidden = true
        } else {
           
        }
        
    }
    
    
    
    @IBAction func didTapOnPrevious(_ sender: Any) {
        
        
        if Frontlabel.isHidden {
                 Frontlabel.isHidden = false
                 Backlabel.isHidden = true
             }
        
      
               currentIndex = currentIndex - 1
                      updateNextPrevButtons()
                      updateLabels()
      
                
  
        //currentIndex = currentIndex - 1
        
        
    }
    
    
    
    
    func updateFlashcard(question: String, answer:String){
        let flashcard = Flashcard(question: question, answer: answer)
        //adding flashcards in the flashcard array
        flashcards.append(flashcard)
        //Logging to the console
        print(" Added a new flashcard")
        print(" We not have \(flashcards.count) flashcards")
      //update current index
        currentIndex = flashcards.count - 1
        print(" Our current index is \(currentIndex)")
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
        
        
        
        
        
        Frontlabel.text = question
        Backlabel.text = answer
        
          dismiss(animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self
    }
    
    func updateNextPrevButtons(){
        //Disable next button if at the end
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        }
        else {
            nextButton.isEnabled  = true
        }
    }
    func updateLabels() {
        let currentFlashcard = flashcards [currentIndex]
        
        Frontlabel.text = currentFlashcard.question
        Backlabel.text = currentFlashcard.answer
        
    }
    func saveAllFlashcardsToDisk() {
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return [ "question" : card.question, "answer": card.answer]
        }
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        print("Flashcards saved to UserDefaults")
        
    }
   func readSavedFlashcards() {
    if let dictionaryarray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
        let savedCards = dictionaryarray.map { dictionary -> Flashcard in
            return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
        }
        flashcards.append(contentsOf: savedCards)
    }
    }

    
}

