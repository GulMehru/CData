//
//  ViewController.swift
//  CData
//
//  Created by Gul Mehru on 2/12/18.
//  Copyright © 2018 Gul Mehru. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController{

    var data = [User]()
    
    let textViewName: UITextField = {
        let text = UITextField()
        text.frame = CGRect(x: 0, y: 0, width: 400, height: 50)
        text.placeholder = "Enter your name"
        text.backgroundColor = UIColor.lightGray
        text.layer.masksToBounds = true
        
        text.textAlignment = .left
        return text
    }()
    
    let textViewClass: UITextField = {
        let text = UITextField()
        text.backgroundColor = UIColor.lightGray
        text.frame = CGRect(x: 0, y: 0, width: 400, height: 50)
        text.placeholder = "Enter your class"
        text.layer.masksToBounds = true
     
        text.textAlignment = .left
        return text
    }()
    
    let enterButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    let showButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(showAction), for: .touchUpInside)
        return button
    }()
    
    @objc func buttonAction() {
        insertData()
    }
    
    @objc func showAction() {
    
    fetchData()
    
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textViewName)
        view.addSubview(textViewClass)
        view.addSubview(enterButton)
        view.addSubview(showButton)
        
        view.addConstraintsWithFormat(format: "H:[v0(400)]", views: textViewName)
        view.addConstraintsWithFormat(format: "V:|-20-[v0(35)]-20-[v1(35)]-20-[v2(50)]-20-[v3(50)]", views: textViewName, textViewClass, enterButton, showButton)
        textViewName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textViewClass.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.addConstraintsWithFormat(format: "H:[v0(80)]", views: enterButton)
        enterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.addConstraintsWithFormat(format: "H:[v0(400)]", views: textViewClass)
        //view.addConstraintsWithFormat(format: "H:|[v0]|", views: myTableView)
        view.addConstraintsWithFormat(format: "H:[v0(80)]", views: showButton)
        showButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
      
    }

    func insertData() {
        
       
        let entityDescription = NSEntityDescription.entity(forEntityName: "User", in: context)
        
        let user = User(entity: entityDescription!,
                               insertInto: context)
        
        user.name = textViewName.text
        user.abclass = textViewClass.text
        
        do{
            try context.save()
            textViewName.text = ""
            textViewClass.text = ""
            
        }
        catch let error {
            //handle error
        }
        
        
        appdelegate.saveContext()
        
    }
    
    func fetchData() {
        do {
            data = try context.fetch(User.fetchRequest())
            for each in data {
                
                print("Name: \(String(describing: each.name))\n")
                print("Class: \(String(describing: each.abclass))\n")
                
            }
            
        }
        
        catch {
            //handle error
        }
    }

    
}
extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        for(index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}


