//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Liu bo on 30/08/18.
//  Copyright © 2018 Liu bo. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {


    let theme = [
        "Sports": "⚽️🏀🏈⚾️🎾🏐🏉🎱🏓⛷🎳⛳️",
        "Animals": "🐶🦆🐹🐸🐘🦍🐓🐩🐦🦋🐙🐏",
        "Faces": "😀😌😎🤓😠😤😭😰😱😳😜😇"
    ]
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }

    @IBAction func ChangeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = theme[themeName]{
                    cvc.theme = theme
            }
        }
        else if let cvc = lastSeguedToConcerntrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = theme[themeName]{
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        }
            
        else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    private var lastSeguedToConcerntrationViewController: ConcentrationViewController?
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = theme[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController{
                    cvc.theme = theme
                    lastSeguedToConcerntrationViewController = cvc
                }
            }
        }
    }
 

}
