//
//  PageViewController.swift
//  pageViewController
//
//  Created by Grandre on 16/6/25.
//  Copyright © 2016年 革码者. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {

    @IBOutlet weak var numberLabel: UILabel!
    var testLabel:UILabel!
    var index:Int
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(testLabel)
        
        switch self.index {
        case 0:
            self.view.backgroundColor = UIColor.blueColor()
        case 1:
            self.view.backgroundColor = UIColor ( red: 0.4467, green: 1.0, blue: 0.6033, alpha: 1.0 )
        case 2:
            self.view.backgroundColor = UIColor ( red: 0.3942, green: 0.5065, blue: 1.0, alpha: 1.0 )
        case 3:
            self.view.backgroundColor = UIColor ( red: 1.0, green: 0.6378, blue: 0.5503, alpha: 1.0 )
        case 4:
            self.view.backgroundColor = UIColor ( red: 1.0, green: 0.2147, blue: 0.2706, alpha: 1.0 )
        case 5:
            self.view.backgroundColor = UIColor ( red: 1.0, green: 0.7082, blue: 0.8528, alpha: 1.0 )
        case 6:
            self.view.backgroundColor = UIColor ( red: 0.9969, green: 0.2073, blue: 1.0, alpha: 1.0 )
        case 7:
            self.view.backgroundColor = UIColor ( red: 0.4323, green: 0.3706, blue: 1.0, alpha: 1.0 )
        case 8:
            self.view.backgroundColor = UIColor ( red: 0.8376, green: 1.0, blue: 0.2399, alpha: 1.0 )
        default:
            self.view.backgroundColor = UIColor ( red: 0.1854, green: 1.0, blue: 0.999, alpha: 1.0 )
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    init(text:String,index:Int){
        self.index = index
        testLabel = UILabel(frame: CGRectMake(50, 100, 200, 30))
        testLabel.backgroundColor = UIColor.darkGrayColor()
        testLabel.layer.borderWidth = 3
        testLabel.layer.borderColor = UIColor.blueColor().CGColor
        testLabel.layer.cornerRadius = 5
        testLabel.layer.masksToBounds = true
        self.testLabel.text = text
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 

}
