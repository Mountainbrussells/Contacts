//
//  ViewController.swift
//  ContactList
//
//  Created by BenRussell on 8/8/17.
//  Copyright © 2017 BenRussell. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var contactView: UIView!
    @IBOutlet weak var contactViewTopContstraint: NSLayoutConstraint!
    @IBOutlet weak var contactViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var keyBoardHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var contactNameTextView: UITextField!
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    
    let coreDataController = CoreDataController.sharedInstance
    
    
    let names = ["Bob James", "Ralph Machio", "Jenny Lane", "Def Jam"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView!.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        contactView.isHidden = true
        self.view.layoutSubviews()
        contactViewTopContstraint.constant = contactViewTopContstraint.constant + self.view.bounds.height
        
        contactViewBottomConstraint.constant = contactViewBottomConstraint.constant - self.view.bounds.height
        self.view.layoutSubviews()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        contactView.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)

        
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        contactNameTextView.text = names[indexPath.row]
        contactView.isHidden = false
        saveButton.isHidden = true
        self.view.layoutSubviews()
        contactViewTopContstraint.constant = contactViewTopContstraint.constant - self.view.bounds.height
        
        contactViewBottomConstraint.constant = contactViewBottomConstraint.constant + self.view.bounds.height
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.view.layoutSubviews()
        }, completion: nil)
        
    }
    
    // MARK: UICollectionViewDAtaSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.nameLabel.text = names[indexPath.row]
        return cell
    }
    
    
    @IBAction func addButton(_ sender: Any) {
        contactView.isHidden = false
        editButton.isHidden = true
        mapButton.isHidden = true
        self.view.layoutSubviews()
        contactViewTopContstraint.constant = contactViewTopContstraint.constant - self.view.bounds.height
        
        contactViewBottomConstraint.constant = contactViewBottomConstraint.constant + self.view.bounds.height
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.view.layoutSubviews()
        }, completion: nil)
    }
    
    @IBAction func doneWithContact(_ sender: Any) {
        self.view.layoutIfNeeded()
        self.contactViewTopContstraint.constant = self.contactViewTopContstraint.constant + self.view.bounds.height
        
        self.contactViewBottomConstraint.constant = self.contactViewBottomConstraint.constant - self.view.bounds.height
        
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            
            self.view.layoutIfNeeded()
        }, completion: nil)
        editButton.isHidden = false
        saveButton.isHidden = false
        mapButton.isHidden = false
        
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        contactView.endEditing(true)
    }

    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.keyBoardHeightLayoutConstraint?.priority = 750
                self.keyBoardHeightLayoutConstraint?.constant = 0.0
            } else {
                self.keyBoardHeightLayoutConstraint?.priority = 999
                self.keyBoardHeightLayoutConstraint?.constant = endFrame?.size.height ?? 0.0
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
}

