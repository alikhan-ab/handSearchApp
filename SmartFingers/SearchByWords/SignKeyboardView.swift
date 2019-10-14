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
        button.setImage(UIImage(named: "letter_0"), for: .normal)
        return button
    }()
    var button1: LetterButton = {
        let button = LetterButton()
        button.letter = "Б"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "letter_1"), for: .normal)
        return button
    }()
    var button2: LetterButton = {
        let button = LetterButton()
        button.letter = "В"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "letter_2"), for: .normal)
        return button
    }()
    var button3: LetterButton = {
        let button = LetterButton()
        button.letter = "Г"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "letter_3"), for: .normal)
        return button
    }()
    var button4: LetterButton = {
        let button = LetterButton()
        button.letter = "Д"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "letter_4"), for: .normal)
        return button
    }()
    var button5: LetterButton = {
        let button = LetterButton()
        button.letter = "Е"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "letter_5"), for: .normal)
        return button
    }()
    var button6: LetterButton = {
        let button = LetterButton()
        button.letter = "Ж"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "letter_6"), for: .normal)
        return button
    }()
    var button7: LetterButton = {
        let button = LetterButton()
        button.letter = "З"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "letter_7"), for: .normal)
        return button
    }()
    var button8: LetterButton = {
        let button = LetterButton()
        button.letter = "И"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "letter_8"), for: .normal)
        return button
    }()
    var button9: LetterButton = {
        let button = LetterButton()
        button.letter = "Й"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "letter_9"), for: .normal)
        return button
    }()
    var button10: LetterButton = {
        let button = LetterButton()
        button.letter = "К"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "letter_10"), for: .normal)
        return button
    }()
    var button11: LetterButton = {
        let button = LetterButton()
        button.letter = "Л"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "letter_11"), for: .normal)
        return button
    }()
    var button12: LetterButton = {
        let button = LetterButton()
        button.letter = "М"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "letter_12"), for: .normal)
        return button
    }()
    var button13: LetterButton = {
        let button = LetterButton()
        button.letter = "Н"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "letter_13"), for: .normal)
        return button
    }()
    var button14: LetterButton = {
        let button = LetterButton()
        button.letter = "О"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "letter_14"), for: .normal)
        return button
    }()
    var button15: LetterButton = {
        let button = LetterButton()
        button.letter = "П"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "letter_15"), for: .normal)
        return button
    }()
    var button16: LetterButton = {
        let button = LetterButton()
        button.letter = "Р"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "letter_16"), for: .normal)
        return button
    }()
    var button17: LetterButton = {
        let button = LetterButton()
        button.letter = "С"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "letter_17"), for: .normal)
        return button
    }()
    var button18: LetterButton = {
        let button = LetterButton()
        button.letter = "Т"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "letter_18"), for: .normal)
        return button
    }()
    var button19: LetterButton = {
        let button = LetterButton()
        button.letter = "У"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "letter_19"), for: .normal)
        return button
    }()
    var button20: LetterButton = {
        let button = LetterButton()
        button.letter = "Ф"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "letter_20"), for: .normal)
        return button
    }()
    var button21: LetterButton = {
        let button = LetterButton()
        button.letter = "Х"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "letter_21"), for: .normal)
        return button
    }()
    var button22: LetterButton = {
        let button = LetterButton()
        button.letter = "Ц"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "letter_22"), for: .normal)
        return button
    }()
    var button23: LetterButton = {
        let button = LetterButton()
        button.letter = "Ч"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "letter_23"), for: .normal)
        return button
    }()
    var button24: LetterButton = {
        let button = LetterButton()
        button.letter = "Ш"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "letter_24"), for: .normal)
        return button
    }()
    var button25: LetterButton = {
        let button = LetterButton()
        button.letter = "Щ"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "letter_25"), for: .normal)
        return button
    }()
    var button26: LetterButton = {
        let button = LetterButton()
        button.letter = "Ъ"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "letter_26"), for: .normal)
        return button
    }()
    var button27: LetterButton = {
        let button = LetterButton()
        button.letter = "Ы"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "letter_27"), for: .normal)
        return button
    }()
    var button28: LetterButton = {
        let button = LetterButton()
        button.letter = "Ь"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "letter_28"), for: .normal)
        return button
    }()
    var button29: LetterButton = {
        let button = LetterButton()
        button.letter = "Э"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "letter_29"), for: .normal)
        return button
    }()
    var button30: LetterButton = {
        let button = LetterButton()
        button.letter = "Ю"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "letter_30"), for: .normal)
        return button
    }()
    var button31: LetterButton = {
        let button = LetterButton()
        button.letter = "Я"
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.setImage(UIImage(named: "letter_31"), for: .normal)
        return button
    }()
    
    let screenSize: CGRect = UIScreen.main.bounds
    var delegate: KeyboardDelegate!

  //MARK: - Methods:
    override init (frame : CGRect) {
        super.init(frame : frame)
        self.backgroundColor = .white
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonPress(button: LetterButton) {
        delegate.didPressButton(button: button)
    }
    
    func setupView(){
        [button0, button1, button2, button3, button4, button5, button6, button7, button8, button9, button10, button11, button12, button13, button14, button15, button16, button17, button18, button19, button20, button21, button22, button23, button24, button25, button26, button27, button28, button29, button30, button31].forEach({ item in
            item.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(item)
        })
//        print(screenSize.width) 375.0
        let width = screenSize.width/6
        [button0, button1, button2, button3, button4, button5, button6, button7, button8, button9, button10, button11, button12, button13, button14, button15, button16, button17, button18, button19, button20, button21, button22, button23, button24, button25, button26, button27, button28, button29, button30, button31].forEach({ button in
            button.widthAnchor.constraint(equalToConstant: width).isActive = true
            button.heightAnchor.constraint(equalToConstant: width).isActive = true
        })
        
        // first 3:
        button0.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        button0.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        button1.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        button1.leftAnchor.constraint(equalTo: button0.rightAnchor).isActive = true
        
        button2.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        button2.leftAnchor.constraint(equalTo: button1.rightAnchor).isActive = true
        
        // next 5:
        button3.topAnchor.constraint(equalTo: button0.bottomAnchor).isActive = true
        button3.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true

        button4.topAnchor.constraint(equalTo: button3.topAnchor).isActive = true
        button4.leftAnchor.constraint(equalTo: button3.rightAnchor).isActive = true
        
        button5.topAnchor.constraint(equalTo: button3.topAnchor).isActive = true
        button5.leftAnchor.constraint(equalTo: button4.rightAnchor).isActive = true
        
        button6.topAnchor.constraint(equalTo: button3.topAnchor).isActive = true
        button6.leftAnchor.constraint(equalTo: button5.rightAnchor).isActive = true
        
        button7.topAnchor.constraint(equalTo: button3.topAnchor).isActive = true
        button7.leftAnchor.constraint(equalTo: button6.rightAnchor).isActive = true
        
        //next 6: 1
        
        button8.topAnchor.constraint(equalTo: button7.bottomAnchor).isActive = true
        button8.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true

        button9.topAnchor.constraint(equalTo: button8.topAnchor).isActive = true
        button9.leftAnchor.constraint(equalTo: button8.rightAnchor).isActive = true
        
        button10.topAnchor.constraint(equalTo: button8.topAnchor).isActive = true
        button10.leftAnchor.constraint(equalTo: button9.rightAnchor).isActive = true
        
        button11.topAnchor.constraint(equalTo: button8.topAnchor).isActive = true
        button11.leftAnchor.constraint(equalTo: button10.rightAnchor).isActive = true
        
        button12.topAnchor.constraint(equalTo: button8.topAnchor).isActive = true
        button12.leftAnchor.constraint(equalTo: button11.rightAnchor).isActive = true
        
        button13.topAnchor.constraint(equalTo: button8.topAnchor).isActive = true
        button13.leftAnchor.constraint(equalTo: button12.rightAnchor).isActive = true
        
        //next 6: 2
        button14.topAnchor.constraint(equalTo: button13.bottomAnchor).isActive = true
        button14.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true

        button15.topAnchor.constraint(equalTo: button14.topAnchor).isActive = true
        button15.leftAnchor.constraint(equalTo: button14.rightAnchor).isActive = true
        
        button16.topAnchor.constraint(equalTo: button14.topAnchor).isActive = true
        button16.leftAnchor.constraint(equalTo: button15.rightAnchor).isActive = true
        
        button17.topAnchor.constraint(equalTo: button14.topAnchor).isActive = true
        button17.leftAnchor.constraint(equalTo: button16.rightAnchor).isActive = true
        
        button18.topAnchor.constraint(equalTo: button14.topAnchor).isActive = true
        button18.leftAnchor.constraint(equalTo: button17.rightAnchor).isActive = true
        
        button19.topAnchor.constraint(equalTo: button14.topAnchor).isActive = true
        button19.leftAnchor.constraint(equalTo: button18.rightAnchor).isActive = true
        
        //next 6: 3
        button20.topAnchor.constraint(equalTo: button19.bottomAnchor).isActive = true
        button20.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true

        button21.topAnchor.constraint(equalTo: button20.topAnchor).isActive = true
        button21.leftAnchor.constraint(equalTo: button20.rightAnchor).isActive = true
        
        button22.topAnchor.constraint(equalTo: button20.topAnchor).isActive = true
        button22.leftAnchor.constraint(equalTo: button21.rightAnchor).isActive = true
        
        button23.topAnchor.constraint(equalTo: button20.topAnchor).isActive = true
        button23.leftAnchor.constraint(equalTo: button22.rightAnchor).isActive = true
        
        button24.topAnchor.constraint(equalTo: button20.topAnchor).isActive = true
        button24.leftAnchor.constraint(equalTo: button23.rightAnchor).isActive = true
        
        button25.topAnchor.constraint(equalTo: button20.topAnchor).isActive = true
        button25.leftAnchor.constraint(equalTo: button24.rightAnchor).isActive = true
        
        //next 6: 3
        button26.topAnchor.constraint(equalTo: button25.bottomAnchor).isActive = true
        button26.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true

        button27.topAnchor.constraint(equalTo: button26.topAnchor).isActive = true
        button27.leftAnchor.constraint(equalTo: button26.rightAnchor).isActive = true
        
        button28.topAnchor.constraint(equalTo: button26.topAnchor).isActive = true
        button28.leftAnchor.constraint(equalTo: button27.rightAnchor).isActive = true
        
        button29.topAnchor.constraint(equalTo: button26.topAnchor).isActive = true
        button29.leftAnchor.constraint(equalTo: button28.rightAnchor).isActive = true
        
        button30.topAnchor.constraint(equalTo: button26.topAnchor).isActive = true
        button30.leftAnchor.constraint(equalTo: button29.rightAnchor).isActive = true
        
        button31.topAnchor.constraint(equalTo: button26.topAnchor).isActive = true
        button31.leftAnchor.constraint(equalTo: button30.rightAnchor).isActive = true
        
    }
    
    
    
}
