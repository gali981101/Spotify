//
//  ViewController.swift
//  Spotify
//
//  Created by Terry Jason on 2023/12/2.
//

import UIKit


// MARK: - ChildVC

class MusicViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
    }
}

class PodcastViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
    }
}

// MARK: - TitleBarController

class TitleBarController: UIViewController {
    
    var musicBarButtonItem: UIBarButtonItem!
    var podCastBarButtonItem: UIBarButtonItem!
    
    let container = Container()
    let viewControllers: [UIViewController] = [MusicViewController(), PodcastViewController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        musicBarButtonItem = makeBarButtonItem(text: "Music", selector: #selector(musicTapped))
        podCastBarButtonItem = makeBarButtonItem(text: "Podcasts", selector: #selector(podcastTapped))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - SetUp

extension TitleBarController {
    
    private func setUp() {
        setUpNavBar()
        setUpView()
    }
    
    private func setUpNavBar() {
        navigationItem.leftBarButtonItems = [musicBarButtonItem, podCastBarButtonItem]
        
        // hide bottom shade pixel
        let img = UIImage()
        self.navigationController?.navigationBar.shadowImage = img
        self.navigationController?.navigationBar.setBackgroundImage(img, for: .default)
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    private func setUpView() {
        guard let containerView = container.view else { return }
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .systemMint
        
        view.addSubview(containerView)
        
        layOutView(containerView)
        musicTapped()
    }
    
    private func layOutView(_ layOutView: UIView) {
        NSLayoutConstraint.activate([
            layOutView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            layOutView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            layOutView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            layOutView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

// MARK: - @Objc Func

extension TitleBarController {
    
    @objc private func musicTapped() {
        if container.children.first == viewControllers[0] { return }
        container.add(viewControllers[0])
        
        animateTransition(fromVC: viewControllers[1], toVC: viewControllers[0]) { _ in
            self.viewControllers[1].remove()
        }
        
        UIView.animate(withDuration: 0.5) {
            self.musicBarButtonItem.customView?.alpha = 1.0
            self.podCastBarButtonItem.customView?.alpha = 0.5
        }
    }
    
    @objc private func podcastTapped() {
        if container.children.first == viewControllers[1] { return }
        container.add(viewControllers[1])
        
        animateTransition(fromVC: viewControllers[0], toVC: viewControllers[1]) { _ in
            self.viewControllers[0].remove()
        }
        
        UIView.animate(withDuration: 0.5) {
            self.musicBarButtonItem.customView?.alpha = 0.5
            self.podCastBarButtonItem.customView?.alpha = 1.0
        }
    }
    
}

// MARK: - Func

extension TitleBarController {
    
    func makeBarButtonItem(text: String, selector: Selector) -> UIBarButtonItem {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: selector, for: .primaryActionTriggered)
        
        let attributes = [
            NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .largeTitle).withTraits(traits: [.traitBold]),
            NSAttributedString.Key.foregroundColor: UIColor.label
        ]
        
        let attributeText = NSMutableAttributedString(string: text, attributes: attributes)
        button.setAttributedTitle(attributeText, for: .normal)
        
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        button.configuration = configuration
        
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }
    
    // MARK: - Animate
    
    func animateTransition(fromVC: UIViewController, toVC: UIViewController, completion: @escaping ((Bool) -> Void)) {
        guard
            let fromView = fromVC.view,
            let fromIndex = getIndex(forViewController: fromVC),
            let toView = toVC.view,
            let toIndex = getIndex(forViewController: toVC)
        else {
            return
        }
        
        let frame = fromVC.view.frame
        var fromFrameEnd = frame
        var toFrameStart = frame
        fromFrameEnd.origin.x = toIndex > fromIndex ? frame.origin.x - frame.width : frame.origin.x + frame.width
        toFrameStart.origin.x = toIndex > fromIndex ? frame.origin.x + frame.width : frame.origin.x - frame.width
        toView.frame = toFrameStart
        
        UIView.animate(withDuration: 0.2, animations: {
            fromView.frame = fromFrameEnd
            toView.frame = frame
        }, completion: {success in
            completion(success)
        })
    }
    
    func getIndex(forViewController vc: UIViewController) -> Int? {
        for (index, thisVC) in viewControllers.enumerated() {
            if thisVC == vc { return index }
        }
        return nil
    }
    
}








