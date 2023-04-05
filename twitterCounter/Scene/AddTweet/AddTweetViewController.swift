//
//  AddTweetViewController.swift
//  twitterCounter
//
//  Created by Abshalom Salama on 31/03/2023.
//

import UIKit
import IQKeyboardManagerSwift
import ASTwitterText

class AddTweetViewController: UIViewController {
    
    
    @IBOutlet private weak var tweetTextView: IQTextView!
    @IBOutlet private weak var typedCharactersView: UIView!
    @IBOutlet private weak var remainingCharactersView: UIView!
    @IBOutlet private weak var charactersCountLimitLabel: UILabel!
    @IBOutlet private weak var typedCharactersCountLabel: UILabel!
    @IBOutlet private weak var postTweetButton: UIButton!
    
   private let charactersCountLimit = 280
   private var typedCharactersCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    private func setUpViews() {
        
        navigationItem.title = "Twitter character count"
        
        tweetTextView.delegate = self
        tweetTextView.placeholder = "Start typing! You can enter up to 280 characters"
        
        typedCharactersView.layer.cornerRadius = 12
        typedCharactersView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        remainingCharactersView.layer.cornerRadius = 12
        remainingCharactersView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
    }
    
    
   private func setUpButtons() {
        if typedCharactersCount > charactersCountLimit {
            postTweetButton.isUserInteractionEnabled = false
            postTweetButton.backgroundColor = .gray
        } else {
            postTweetButton.isUserInteractionEnabled = true
            postTweetButton.backgroundColor = UIColor(hex: 0x03A9F4)
        }
    }
    
    private func setUpText(text: String?) {
        
        guard
            let text = text
        else {
            typedCharactersCount = 0
            typedCharactersCountLabel.text = "\(typedCharactersCount) / \(charactersCountLimit)"
            return
        }
        countText(text: text)
    }
    
    private func countText(text: String) {
        let typedTextCount = ASTwitterText.checkTextCount(text: text)
        typedCharactersCount = typedTextCount
        typedCharactersCountLabel.text = "\(typedCharactersCount) / \(charactersCountLimit)"
    }
    
    
    @IBAction private func didTapCopyText(_ sender: Any) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = tweetTextView.text
    }
    
    
    @IBAction private func didTapClearText(_ sender: Any) {
        tweetTextView.text = nil
        setUpText(text: nil)
        setUpButtons()

    }
    
    @IBAction private func didTapPostTweet(_ sender: Any) {
        
    }
    
}

extension AddTweetViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        setUpText(text: textView.text)
        setUpButtons()

    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        if UIApplication.shared.canOpenURL(URL) {
            UIApplication.shared.open(URL)
        }
        
        return false
    }
}

