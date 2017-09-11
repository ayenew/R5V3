//
//  NoteTakerVC.swift
//  RM53
//
//  Created by Ayu on 9/8/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit
import jot

protocol PassDelegate {
    func setFont(font : CGFloat)
    func setColor(color : UIColor)
}

class NoteTakerVC: UIViewController,JotViewControllerDelegate, UIPopoverPresentationControllerDelegate, PassDelegate {
    var fontSize : CGFloat = 11
    var drawColor : UIColor = UIColor.red
    let jotViewController = JotViewController()
    
    @IBOutlet weak var drawingBoard: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 00/255.0, green: 24/255.0, blue: 168/255.0, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.view.backgroundColor = UIColor.white
        self.jotViewController.delegate = self
        self.addChildViewController(jotViewController)
        self.drawingBoard.addSubview(self.jotViewController.view)
        self.jotViewController.didMove(toParentViewController: self)
        self.jotViewController.view.frame = self.drawingBoard.frame
        self.jotViewController.state = JotViewState.drawing
        self.jotViewController.textColor = UIColor.black
        self.jotViewController.font = UIFont.boldSystemFont(ofSize: fontSize)
        self.jotViewController.textEditingInsets = UIEdgeInsetsMake(6, 6, 6, 6)
        self.jotViewController.initialTextInsets = UIEdgeInsetsMake(6, 6, 6, 6)
        self.jotViewController.fitOriginalFontSizeToViewWidth = false
        self.jotViewController.textAlignment = .left
        self.jotViewController.drawingColor = drawColor
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.jotViewController.state == JotViewState.text {
            self.jotViewController.state = JotViewState.editingText
        }
        
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    func jotViewController(_ jotViewController: JotViewController!, isEditingText isEditing: Bool) {
        //self.clearButton.isHidden = isEditing
        //self.saveButton.isHidden = isEditing
        // self.toggleDrawingButton.isHidden = isEditing
    }
    
    @IBAction func save(_ sender: Any) {
        let drawnImage = self.jotViewController.renderImage(withScale: 2, on: self.view.backgroundColor)
        self.jotViewController.clearAll()
        UIImageWriteToSavedPhotosAlbum(drawnImage!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    @IBAction func clear(_ sender: Any) {
        self.jotViewController.clearAll()
    }
    
    @IBAction func edit(_ sender: Any) {
        if self.jotViewController.state == JotViewState.drawing {
            if self.jotViewController.textString.characters.count == 0 {
                self.jotViewController.state = JotViewState.editingText
                self.jotViewController.textColor = drawColor
            } else {
                self.jotViewController.state = JotViewState.text
                self.jotViewController.textColor = drawColor
            }
            
        }
        //        else if (self.jotViewController.state == JotViewState.text) {
        //            self.jotViewController.state = JotViewState.drawing
        //            self.jotViewController.drawingColor = drawColor
        //        }
    }
    
    @IBAction func switchToDrawMode(_ sender: UIBarButtonItem) {
        if (self.jotViewController.state == JotViewState.text) {
            self.jotViewController.state = JotViewState.drawing
            self.jotViewController.drawingColor = drawColor
        }
    }
    
    
    
    @IBAction func changeColor(_ sender: UIBarButtonItem) {
        let popover = self.storyboard?.instantiateViewController(withIdentifier: "ColorSelectionVC") as! ColorSelectionVC
        popover.delegate = self
        popover.modalPresentationStyle = .popover
        if let presentation = popover.popoverPresentationController {
            presentation.barButtonItem = navigationItem.rightBarButtonItem
            presentation.delegate = self
        }
        present(popover, animated: true, completion: nil)
    }
    
    
    @IBAction func changeFont(_ sender: UIBarButtonItem) {
        let popover = self.storyboard?.instantiateViewController(withIdentifier: "FontSelectionVC") as! FontSelectionVC
        popover.modalPresentationStyle = .popover
        popover.delegate = self
        if let presentation = popover.popoverPresentationController {
            presentation.barButtonItem = navigationItem.leftBarButtonItem
            presentation.delegate = self
        }
        present(popover, animated: true, completion: nil)
    }
    
    
    @IBAction func clearText(_ sender: Any) {
        self.jotViewController.clearText()
        self.jotViewController.textString = ""
        if self.jotViewController.state == JotViewState.drawing {
            if self.jotViewController.textString.characters.count == 0 {
                self.jotViewController.state = JotViewState.editingText
                self.jotViewController.textColor = UIColor.black
            } else {
                self.jotViewController.state = JotViewState.text
            }
            
        } else if (self.jotViewController.state == JotViewState.text) {
            self.jotViewController.state = JotViewState.drawing
            self.jotViewController.drawingColor = drawColor
        }
    }
    
    func setFont(font : CGFloat) {
        fontSize = font
        changeFont()
    }
    
    func setColor(color : UIColor){
        drawColor = color
        changeDrawColor()
    }
    func changeDrawColor(){
        self.jotViewController.drawingColor = drawColor
    }
    
    func changeFont(){
        self.jotViewController.fontSize = fontSize
    }
}
