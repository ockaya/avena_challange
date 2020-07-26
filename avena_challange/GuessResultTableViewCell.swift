//
//  GuessResultTableViewCell.swift
//  avena_challange
//
//  Created by Omer Kaya on 26.07.2020.
//  Copyright © 2020 Omer Kaya. All rights reserved.
//

import UIKit

class GuessResultTableViewCell: UITableViewCell {
    
    let guessLabel: UILabel = {
        let l: UILabel = UILabel()
        
        l.textAlignment = .center
        l.font = UIFont(name: "Galvji-Bold", size: 18)
        l.textColor = UIColor(hex: COLOR3)
        
        l.translatesAutoresizingMaskIntoConstraints = false
        
        return l
    } ()
    
    let resultLabel: UILabel = {
        let l: UILabel = UILabel()
        
        l.textAlignment = .center
        l.font = UIFont(name: "Galvji-Bold", size: 18)
        l.textColor = UIColor(hex: COLOR3)
        
        l.translatesAutoresizingMaskIntoConstraints = false
        
        return l
    } ()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        InitUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func InitUI() {
        
        self.backgroundColor = UIColor(hex: COLOR1)
        
        let containerStackView = UIStackView()
        containerStackView.axis = .horizontal
        containerStackView.alignment = .fill
        containerStackView.distribution = .fillEqually
        containerStackView.spacing = 5
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(containerStackView)
        
        containerStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        containerStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        containerStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        
        containerStackView.addArrangedSubview(guessLabel)
        containerStackView.addArrangedSubview(resultLabel)
    }
}
