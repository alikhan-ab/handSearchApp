//
//  SignKeyboardView.swift
//  SmartFingers
//
//  Created by DCLab on 10/10/19.
//  Copyright © 2019 Aigerim Janaliyeva. All rights reserved.
//

import Foundation
import UIKit

protocol KeyboardDelegate {
    func didPressButton(button: LetterButton)
}

class SignKeyboardView: UIView {
    //MARK: - Letter Buttons
    var button0: LetterButton = {
        let button = LetterButton()
        button.letter = "А"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "A_letter"), for: .normal)
        return button
    }()
    var button1: LetterButton = {
        let button = LetterButton()
        button.letter = "Б"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "A_letter"), for: .normal)
        return button
    }()
    var button2: LetterButton = {
        let button = LetterButton()
        button.letter = "В"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "A_letter"), for: .normal)
        return button
    }()
    var button3: LetterButton = {
        let button = LetterButton()
        button.letter = "Г"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "A_letter"), for: .normal)
        return button
    }()
    var button4: LetterButton = {
        let button = LetterButton()
        button.letter = "А"
        return button
    }()
    var button5: LetterButton = {
        let button = LetterButton()
        button.letter = "А"
        return button
    }()
    var button6: LetterButton = {
        let button = LetterButton()
        button.letter = "А"
        return button
    }()
    var button7: LetterButton = {
        let button = LetterButton()
        button.letter = "А"
        return button
    }()
    var button8: LetterButton = {
        let button = LetterButton()
        button.letter = "А"
        return button
    }()
    var button9: LetterButton = {
        let button = LetterButton()
        button.letter = "А"
        return button
    }()
    var button10: LetterButton = {
        let button = LetterButton()
        button.letter = "А"
        return button
    }()
    var button11: LetterButton = {
        let button = LetterButton()
        button.letter = "А"
        return button
    }()
    var button12: LetterButton = {
        let button = LetterButton()
        button.letter = "А"
        return button
    }()
    var button13: LetterButton = {
        let button = LetterButton()
        button.letter = "А"
        return button
    }()
    var button14: LetterButton = {
        let button = LetterButton()
        button.letter = "А"
        return button
    }()
    var button15: LetterButton = {
        let button = LetterButton()
        button.letter = "А"
        return button
    }()
    var button16: LetterButton = {
        let button = LetterButton()
        button.letter = "А"
        return button
    }()
    var button17: LetterButton = {
        let button = LetterButton()
        button.letter = "А"
        return button
    }()
    var button18: LetterButton = {
        let button = LetterButton()
        button.letter = "А"
        return button
    }()
    var button19: LetterButton = {
        let button = LetterButton()
        button.letter = "А"
        return button
    }()
    var button20: LetterButton = {
        let button = LetterButton()
        button.letter = "А"
        return button
    }()
    var button21: LetterButton = {
        let button = LetterButton()
        button.letter = "А"
        return button
    }()
    var button22: LetterButton = {
        let button = LetterButton()
        button.letter = "А"
        return button
    }()
    var button23: LetterButton = {
        let button = LetterButton()
        button.letter = "А"
        return button
    }()
    var button24: LetterButton = {
        let button = LetterButton()
        button.letter = "А"
        return button
    }()
    var button25: LetterButton = {
        let button = LetterButton()
        button.letter = "А"
        return button
    }()
    var button26: LetterButton = {
        let button = LetterButton()
        button.letter = "А"
        return button
    }()
    var button27: LetterButton = {
        let button = LetterButton()
        button.letter = "А"
        return button
    }()
    var button28: LetterButton = {
        let button = LetterButton()
        button.letter = "А"
        return button
    }()
    var button29: LetterButton = {
        let button = LetterButton()
        button.letter = "А"
        return button
    }()
    var button30: LetterButton = {
        let button = LetterButton()
        button.letter = "А"
        return button
    }()
    var button31: LetterButton = {
        let button = LetterButton()
        button.letter = "А"
        return button
    }()
    var button32: LetterButton = {
        let button = LetterButton()
        button.letter = "А"
        return button
    }()
    var button33: LetterButton = {
        let button = LetterButton()
        button.letter = "А"
        return button
    }()
    
    let screenSize: CGRect = UIScreen.main.bounds
    var delegate: KeyboardDelegate!

  //MARK: - Methods:
    override init (frame : CGRect) {
        super.init(frame : frame)
        self.backgroundColor = .blue
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonPress(button: LetterButton) {
        print("Pressed in View")
        delegate.didPressButton(button: button)
    }
    
    func setupView(){
        [button0, button1, button2, button3].forEach({ item in
            item.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(item)
        })
        button0.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        button0.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        button0.widthAnchor.constraint(equalToConstant: screenSize.width*0.25).isActive = true
        button0.heightAnchor.constraint(equalTo: button0.widthAnchor).isActive = true
        
        button1.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        button1.leftAnchor.constraint(equalTo: button0.rightAnchor).isActive = true
        button1.widthAnchor.constraint(equalToConstant: screenSize.width*0.25).isActive = true
        button1.heightAnchor.constraint(equalTo: button0.widthAnchor).isActive = true
        
        button2.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        button2.leftAnchor.constraint(equalTo: button1.rightAnchor).isActive = true
        button2.widthAnchor.constraint(equalToConstant: screenSize.width*0.25).isActive = true
        button2.heightAnchor.constraint(equalTo: button0.widthAnchor).isActive = true
        
        button3.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        button3.leftAnchor.constraint(equalTo: button2.rightAnchor).isActive = true
        button3.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        button3.widthAnchor.constraint(equalToConstant: screenSize.width*0.25).isActive = true
        button3.heightAnchor.constraint(equalTo: button0.widthAnchor).isActive = true
        
        
        
    }
    
    
    
}
