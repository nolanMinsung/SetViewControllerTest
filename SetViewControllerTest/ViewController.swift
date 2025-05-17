//
//  ViewController.swift
//  SetViewControllerTest
//
//  Created by 김민성 on 5/16/25.
//

import UIKit

class ViewController: UIViewController {
    
    var redViewController: UIViewController = {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .red
        return viewController
    }()
    
    var blueViewController: UIViewController = {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .blue
        return viewController
    }()
    
    let buttonToRed: UIButton = {
        let button = UIButton()
        button.setTitle("toRed", for: .normal)
        button.backgroundColor = .systemGray6
        button.setTitleColor(.red, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.layer.cornerCurve = .continuous
        return button
    }()
    
    let buttonToBlue: UIButton = {
        let button = UIButton()
        button.setTitle("toBlue", for: .normal)
        button.backgroundColor = .systemGray6
        button.setTitleColor(.blue, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.layer.cornerCurve = .continuous
        return button
    }()
    
    lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [buttonToRed, buttonToBlue])
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let label = UILabel()
    
    let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    var pageVCView: UIView { pageVC.view }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting Style
        view.backgroundColor = .systemBackground
        
        // Setting View Hierarchy
        view.addSubview(pageVCView)
        view.addSubview(buttonsStackView)
        view.addSubview(label)
        addChild(pageVC)
        
        // Setting AutoLayout
        pageVCView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageVCView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pageVCView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pageVCView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pageVCView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200),
            
            buttonsStackView.centerXAnchor.constraint(equalTo: pageVCView.centerXAnchor),
            buttonsStackView.topAnchor.constraint(equalTo: pageVCView.bottomAnchor, constant: 30),
            buttonsStackView.widthAnchor.constraint(equalToConstant: 300),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 80),
            
            label.centerXAnchor.constraint(equalTo: pageVCView.centerXAnchor),
            label.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: 20),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor),
            label.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        pageVC.dataSource = self
        
        pageVC.setViewControllers([redViewController], direction: .forward, animated: true)
        
        buttonToRed.addTarget(self, action: #selector(moveToRed), for: .touchUpInside)
        buttonToBlue.addTarget(self, action: #selector(moveToBlue), for: .touchUpInside)
    }
    
    @objc func  moveToRed() {
        label.text = ""
        pageVC.setViewControllers([redViewController], direction: .reverse, animated: true) { [weak self] _ in
            self?.label.text = "(toRed) completion callback func called."
            print(#function)
        }
    }
    
    @objc func moveToBlue() {
        label.text = ""
        pageVC.setViewControllers([blueViewController], direction: .forward, animated: true) { [weak self] _ in
            self?.label.text = "(toBlue) completion callback func called."
            print(#function)
        }
    }

}

extension ViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController == redViewController {
            return blueViewController
        } else if viewController == blueViewController {
            return redViewController
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController == redViewController {
            return blueViewController
        } else if viewController == blueViewController {
            return redViewController
        } else {
            return nil
        }
    }
    
}
