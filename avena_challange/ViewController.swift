//
//  ViewController.swift
//  avena_challange
//
//  Created by Omer Kaya on 26.07.2020.
//  Copyright © 2020 Omer Kaya. All rights reserved.
//

import UIKit

let COLOR1 = "#d8ddefff"
let COLOR2 = "#39a2aeff"
let COLOR3 = "#084c61ff"
let COLOR4 = "#fe5f55ff"
let NUMBER_OF_CHARACTERS = 4

class ViewController: UIViewController, UITextFieldDelegate {
    
    var gameNumber: [Character] = []
    var guessNumbers: [[Character]] = []
    
    var newGameButton: UIButton = {
        let b = UIButton()
        
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitleColor(UIColor(hex: COLOR1), for: .normal)
        b.setTitle("Yeni Oyun", for: .normal)
        b.titleLabel?.font = UIFont(name: "Galvji-Bold", size: 20)
        b.backgroundColor = UIColor(hex: COLOR3)
        b.addTarget(self, action: #selector(NewGameAction), for: .touchUpInside)
        
        return b
    } ()
    
    var guessViewContainer: UIView = {
        let gv: UIView = UIView()
        
        gv.translatesAutoresizingMaskIntoConstraints = false
        
        return gv
    } ()
    
    var guessText: UITextField = {
        let tf: UITextField = UITextField()
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.masksToBounds = true
        tf.layer.cornerRadius = 20
        tf.backgroundColor = UIColor(hex: COLOR1)
        
        tf.font = UIFont(name: "Galvji-Bold", size: 18)
        tf.textColor = UIColor(hex: COLOR3)
        tf.keyboardType = .numberPad
        tf.textAlignment = .center
        
        return tf
    } ()
    
    var guessResultTableContainer: UIView = {
        let v: UIView = UIView()
        
        v.translatesAutoresizingMaskIntoConstraints = false
        v.isHidden = true
        v.backgroundColor = UIColor(hex: COLOR1)
        v.clipsToBounds = true
        v.layer.cornerRadius = 20
        
        return v
    } ()
    
    var guessResultTable: UITableView = {
        let tv = UITableView()
        
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(GuessResultTableViewCell.self, forCellReuseIdentifier: "GuessResultTableViewCell")
        
        return tv
    } ()
    
    var congratsContainer: UIView = {
        let v: UIView = UIView()
        
        v.translatesAutoresizingMaskIntoConstraints = false
        
        return v
    } ()
    
    var congratsLabel: UILabel = {
        let congratsLabel: UILabel = UILabel()
        congratsLabel.translatesAutoresizingMaskIntoConstraints = false
        congratsLabel.textAlignment = .center
        congratsLabel.font = UIFont(name: "Galvji-Bold", size: 30)
        congratsLabel.textColor = UIColor(hex: COLOR4)
        
        return congratsLabel
    } ()
    
    var keyboardChooseButton: UIBarButtonItem = {
        let bi: UIBarButtonItem = UIBarButtonItem(title: "SEÇ", style: .done, target: self, action: #selector(TextDoneButtonAction))
        
        return bi
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: COLOR2)
        
        CreateButton()
    }
    
    func InitUI() {
        
        CreateGuessView()
        CreateGuessResultTable()
        CreateCongratsView()
    }
    
    // Creates button to start or restart a game
    func CreateButton() {
        self.view.addSubview(newGameButton)
        
        newGameButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
        newGameButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        newGameButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        newGameButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        newGameButton.layoutIfNeeded()
        
        newGameButton.layer.cornerRadius = newGameButton.frame.size.height / 2
    }
    
    // Creates container which user can enter their guesses
    func CreateGuessView() {
        self.view.addSubview(guessViewContainer)
        
        guessViewContainer.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        guessViewContainer.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50).isActive = true
        guessViewContainer.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -50).isActive = true
        
        let guessLabel: UILabel = UILabel()
        guessLabel.translatesAutoresizingMaskIntoConstraints = false
        guessViewContainer.addSubview(guessLabel)
        
        guessLabel.topAnchor.constraint(equalTo: guessViewContainer.topAnchor, constant: 0).isActive = true
        guessLabel.leftAnchor.constraint(equalTo: guessViewContainer.leftAnchor, constant: 0).isActive = true
        guessLabel.rightAnchor.constraint(equalTo: guessViewContainer.rightAnchor, constant: 0).isActive = true
        
        guessLabel.textColor = UIColor(hex: COLOR1)
        guessLabel.font = UIFont(name: "Galvji-Bold", size: 20)
        guessLabel.text = "Tahmininiz:"
        
        guessViewContainer.addSubview(guessText)
        
        guessText.topAnchor.constraint(equalTo: guessLabel.bottomAnchor, constant: 10).isActive = true
        guessText.leftAnchor.constraint(equalTo: guessViewContainer.leftAnchor, constant: 0).isActive = true
        guessText.rightAnchor.constraint(equalTo: guessViewContainer.rightAnchor, constant: 0).isActive = true
        guessText.bottomAnchor.constraint(equalTo: guessViewContainer.bottomAnchor, constant: -10).isActive = true
        guessText.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        guessText.delegate = self
        
        self.SetTextFieldToolbar()
    }
    
    // Creates container which lists user guesses and its results
    func CreateGuessResultTable() {
        self.view.addSubview(guessResultTableContainer)
        
        guessResultTableContainer.topAnchor.constraint(equalTo: guessViewContainer.bottomAnchor, constant: 10).isActive = true
        guessResultTableContainer.leftAnchor.constraint(equalTo: guessViewContainer.leftAnchor, constant: 0).isActive = true
        guessResultTableContainer.rightAnchor.constraint(equalTo: guessViewContainer.rightAnchor, constant: 0).isActive = true
        //        guessResultTableContainer.bottomAnchor.constraint(equalTo: newGameButton.topAnchor, constant: -20).isActive = true
        
        guessResultTableContainer.addSubview(guessResultTable)
        guessResultTable.topAnchor.constraint(equalTo: guessResultTableContainer.topAnchor, constant: 0).isActive = true
        guessResultTable.leftAnchor.constraint(equalTo: guessResultTableContainer.leftAnchor, constant: 0).isActive = true
        guessResultTable.rightAnchor.constraint(equalTo: guessResultTableContainer.rightAnchor, constant: 0).isActive = true
        guessResultTable.bottomAnchor.constraint(equalTo: guessResultTableContainer.bottomAnchor, constant: 0).isActive = true
        
        guessResultTable.backgroundColor = UIColor(hex: COLOR1)
        guessResultTable.separatorStyle = .none
        
        guessResultTable.dataSource = self
        guessResultTable.delegate = self
    }
    
    // Creates container which shows congratulation message when user find the number
    func CreateCongratsView() {
        self.view.addSubview(congratsContainer)
        
        congratsContainer.topAnchor.constraint(equalTo: guessResultTable.bottomAnchor, constant: 10).isActive = true
        congratsContainer.leftAnchor.constraint(equalTo: guessViewContainer.leftAnchor, constant: 0).isActive = true
        congratsContainer.rightAnchor.constraint(equalTo: guessViewContainer.rightAnchor, constant: 0).isActive = true
        congratsContainer.bottomAnchor.constraint(equalTo: newGameButton.topAnchor, constant: -10).isActive = true
        
        congratsContainer.addSubview(congratsLabel)
        congratsLabel.topAnchor.constraint(equalTo: congratsContainer.topAnchor, constant: 0).isActive = true
        congratsLabel.leftAnchor.constraint(equalTo: congratsContainer.leftAnchor, constant: 0).isActive = true
        congratsLabel.rightAnchor.constraint(equalTo: congratsContainer.rightAnchor, constant: 0).isActive = true
        congratsLabel.bottomAnchor.constraint(equalTo: congratsContainer.bottomAnchor, constant: 0).isActive = true
    }
    
    
    // Returns the number which has non repating NUMBER_OF_CHARACTERS characters
    var fourUniqueDigits: Set<Character> {
        var result = ""
        repeat {
            result = String(format:"%04d", Int.random(in: 1000..<10000))
        } while Set<Character>(result).count < NUMBER_OF_CHARACTERS
        
        let set = Set<Character>(result)
        print("Game Number: \(set)")
        return set
    }
    
    @objc func NewGameAction(sender: UIButton!) {
        self.InitUI()
        
        guessText.isUserInteractionEnabled = true
        guessResultTableContainer.isHidden = true
        congratsContainer.isHidden = true
        congratsLabel.text = ""
        
        gameNumber = Array(fourUniqueDigits)
        guessNumbers = []
    }
    
    @objc func TextDoneButtonAction(sender: UIButton!) {
        self.view.endEditing(true)
        
        let userText: String = guessText.text ?? ""
        guessNumbers.append(Array(userText))
        
        guessResultTableContainer.isHidden = false
        
        if guessNumbers.count == 1 {
            
            guessResultTable.reloadData()
            
        } else if guessNumbers.count > 1 {
            
            let newIndexPath: IndexPath = IndexPath(row: (guessNumbers.endIndex - 1), section: 0)
            
            guessResultTable.insertRows(at: [newIndexPath], with: .fade)
            guessResultTable.scrollToRow(at: newIndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
        }
        
        guessText.text = ""
    }
}

// MARK: TextField
extension ViewController {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if updatedText.count >= NUMBER_OF_CHARACTERS {
            keyboardChooseButton.isEnabled = true
        } else {
            keyboardChooseButton.isEnabled = false
        }
        
        return updatedText.count <= NUMBER_OF_CHARACTERS
    }
    
    func SetTextFieldToolbar() {
        
        let keyboardToolBar: UIToolbar = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: self.view.frame.width, height: 30)))
        
        let flexSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        keyboardToolBar.setItems([flexSpace, keyboardChooseButton], animated: false)
        keyboardToolBar.sizeToFit()
        
        keyboardChooseButton.isEnabled = false
        
        guessText.inputAccessoryView = keyboardToolBar
    }
}

// MARK: TableView
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guessNumbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"GuessResultTableViewCell", for: indexPath) as! GuessResultTableViewCell
        
        cell.guessLabel.text = String(guessNumbers[indexPath.row])
        cell.resultLabel.text = FindResult(guessNumber: guessNumbers[indexPath.row])
        
        return cell
    }
    
    func FindResult(guessNumber: [Character]) -> String {
        
        var result: String = ""
        var trueCount: Int = 0
        
        for i in 0..<guessNumber.count {
            
            if guessNumber[i] == gameNumber[i] {
                result += "+"
                trueCount = trueCount + 1
            } else {
                result += "-"
            }
        }
        
        if trueCount == NUMBER_OF_CHARACTERS {
            congratsContainer.isHidden = false
            congratsLabel.text = "TEBRİKLER"
            guessText.isUserInteractionEnabled = false
        }
        
        return result
    }
}
