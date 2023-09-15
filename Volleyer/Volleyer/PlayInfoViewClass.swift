//
//  File.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/14.
//
//
//import Foundation
//import UIKit
//
//class PlayInfoView: UIView {
//
//    weak var dataSource: PlayInfoViewDataSource? {
//        didSet {
//            setUI()
//        }
//    }
//
//    weak var delegate: PlayInfoViewDelegate? {
//        didSet {
//            delegate?.didSelectedButton?(self, at: 0)
//            delegate?.shouldSelectedButton?(self, at: 0)
//        }
//    }
//
//    var allButtons = [UIButton]()
//
//    var allButtonColor = [UIColor]()
//
//    private var underlineViewLeadingConstraint: NSLayoutConstraint?
//
//    func setUI() {
//
//        self.backgroundColor = UIColor.black
//
//        let numberOfButtons = dataSource?.numberOfButtons(self) ?? 1
//
//        let widthOfButton = frame.width / CGFloat(numberOfButtons)
//
//        var previousObject = UIButton()
//        var firstButton = UIButton()
//
//        for i in 0...numberOfButtons-1 {
//            let button = UIButton()
//
////            button.setTitle(dataSource?.buttonModels(self)[i].title, for: .normal)
////            allButtonColor.append(dataSource?.buttonModels(self)[i].color ?? UIColor.clear)
//            button.tintColor = dataSource?.textColor()
//            button.addTarget(self, action: #selector(selectAButton), for: .touchUpInside)
//            button.translatesAutoresizingMaskIntoConstraints = false
//            addSubview(button)
//            if i == 0 {
//                NSLayoutConstraint.activate([
//                    button.widthAnchor.constraint(equalToConstant: widthOfButton),
//                    button.topAnchor.constraint(equalTo: topAnchor),
//                    button.leadingAnchor.constraint(equalTo: leadingAnchor),
//                    button.centerYAnchor.constraint(equalTo: centerYAnchor)
//                ])
//                firstButton = button
//            } else {
//                NSLayoutConstraint.activate([
//                    button.widthAnchor.constraint(equalToConstant: widthOfButton),
//                    button.topAnchor.constraint(equalTo: topAnchor),
//                    button.leadingAnchor.constraint(equalTo: previousObject.trailingAnchor),
//                    button.centerYAnchor.constraint(equalTo: centerYAnchor)
//                ])
//            }
//
//            allButtons.append(button)
//            previousObject = button
//        }
//
//        let indicatorView = UIView()
//
//        indicatorView.backgroundColor = dataSource?.underlineColor()
//        indicatorView.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(indicatorView)
//
//        underlineViewLeadingConstraint = indicatorView.centerXAnchor.constraint(equalTo: firstButton.centerXAnchor)
//        NSLayoutConstraint.activate([
//            underlineViewLeadingConstraint!,
//            indicatorView.widthAnchor.constraint(equalToConstant: 100),
//            indicatorView.heightAnchor.constraint(equalToConstant: 5),
//            indicatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
//        ])
//
//    }
//
//    @objc func selectAButton(_ sender: UIButton) {
//
//        guard let index = allButtons.firstIndex(of: sender) else {
//            return
//        }
//
//        if delegate?.shouldSelectedButton?(self, at: index) ?? true {
//
//            delegate?.didSelectedButton?(self, at: index)
//
//            UIView.animate(withDuration: 0.2) {
//                self.underlineViewLeadingConstraint?.constant = sender.frame.origin.x
//                self.layoutIfNeeded()
//            }
//        }
//    }
//}
//
//protocol PlayInfoViewDataSource: AnyObject {
//    func underlineColor() -> UIColor
//    func textColor() -> UIColor
//    func textFont() -> UIFont
//    func numberOfButtons(_ selectionView: PlayInfoView) -> Int
//    //func buttonModels(_ selectionView: PlayInfoView) -> [ButtonModel]
//}
//
//extension PlayInfoViewDataSource {
//    func underlineColor() -> UIColor { return UIColor.blue }
//    func textColor() -> UIColor { return UIColor.white }
//    func textFont() -> UIFont { return UIFont.systemFont(ofSize: 18) }
//    func numberOfButtons(_ selectionView: PlayInfoView) -> Int { return 2 }
//}
//
//@objc protocol PlayInfoViewDelegate: AnyObject {
//
//    @objc optional func didSelectedButton(_ selectionView: PlayInfoView, at index: Int)
//
//    @objc optional func shouldSelectedButton(_ selectionView: PlayInfoView, at index: Int) -> Bool
//}
