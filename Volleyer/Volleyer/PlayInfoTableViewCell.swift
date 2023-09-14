//
//  FindPlayerTableViewCell.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/14.
//

import Foundation
import UIKit

let standardMargin = 16.0

class PlayInfoTableViewCell: UITableViewCell {
    
    static let identifier = "PlayInfoTableViewCell"

    let titleLable: UILabel = {
        let label = UILabel()
        label.text = "IU「亂穿」竟美出新境界!笑稱自己品味奇怪 網笑:靠顏值撐住女神氣場"
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let authorLable: UILabel = {
        let label = UILabel()
        label.text = "author"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let tagLable: UILabel = {
        let label = UILabel()
        let padding = 3
        label.text = String(repeating: " ", count: padding) + "tag" + String(repeating: " ", count: padding)
        label.textColor = UIColor.systemBlue
        label.backgroundColor = UIColor.lightGray
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let dateLable: UILabel = {
        let label = UILabel()
        label.text = "2023-09-09 10:19"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let contentLable: UILabel = {
        let label = UILabel()
        label.text = "南韓歌手IU(李知恩)無論在歌唱方面或是近期的戲劇作品都有亮眼的成績，但俗話說人無完美、美玉微瑕，曾再跟工作人員的互動影片中坦言自己品味很奇怪，近日在IG上分享了宛如「媽媽們青春時代的玉女歌手」超復古穿搭造型，卻意外美出新境界。"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLable)
        contentView.addSubview(authorLable)
        contentView.addSubview(tagLable)
        contentView.addSubview(dateLable)
        contentView.addSubview(contentLable)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        NSLayoutConstraint.activate([
            titleLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: standardMargin),
            titleLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: standardMargin),
            titleLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -standardMargin),
            
            authorLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: standardMargin),
            authorLable.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: standardMargin/2),
            
            tagLable.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: standardMargin/2),
            tagLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -standardMargin),
            
            dateLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: standardMargin),
            dateLable.topAnchor.constraint(equalTo: authorLable.bottomAnchor, constant: standardMargin/2),
            
            contentLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: standardMargin),
            contentLable.topAnchor.constraint(equalTo: dateLable.bottomAnchor, constant: standardMargin/2),
            contentLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -standardMargin),
            contentLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -standardMargin),
        ])
    }
}
