//
//  ViewController.swift
//  MapApplication
//
//  Created by Анастасия Корнеева on 15.04.21.
//

import UIKit

class ViewController: UIViewController {

    var controllerTitle: String? {
        get {
            self.navigationItem.title
        }
        set {
            self.navigationItem.title = newValue
            self.navigationController?.navigationBar.backItem?.title = " "
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self._initController()
        self.initController()
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func _initController() {
        self.view.backgroundColor = .white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    func initController() {}
    
}
