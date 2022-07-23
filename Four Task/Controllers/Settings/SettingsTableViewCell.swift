//
//  SettingsTableViewCell.swift
//  Four Task
//
//  Created by Ilya Vasilev on 21.07.2022.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
static let identifier = "SettingsTableViewCell"
    ///Фоновой цвет позади иконки.
    private let iconContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    ///Иконка.
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    ///Текстовое описание настройки
    private let label: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let size: CGFloat = contentView.frame.size.height - 12
        let imageSize: CGFloat = size/1.5
        
        iconContainer.frame = CGRect(x: 15, y: 6, width: size, height: size)
        
        iconImageView.frame = CGRect(x: (size - imageSize)/2, y: (size - imageSize)/2, width: imageSize, height: imageSize)
//        iconImageView.center = iconContainer.center
        
        label.frame = CGRect(
        x: 25 + iconContainer.frame.size.width,
        y: 0,
        width: contentView.frame.size.width - 20 - iconContainer.frame.size.width,
        height: contentView.frame.size.height
        )
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        iconContainer.backgroundColor = nil
        label.text = nil
        iconImageView.image = nil
    }
    public func configure(with model: SettingsOption) {
        label.text = model.title
        iconImageView.image = model.icon
        iconImageView.backgroundColor = model.iconBackgroundColor
}



}
