//
//  SwitchTableViewCell.swift
//  Four Task
//
//  Created by Ilya Vasilev on 22.07.2022.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    //MARK: - Let/var
    static let identifier = "SwitchTableViewCell"
    ///Фоновой цвет позади иконки.
    private let iconContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    ///Иконка-картинка в ячейке.
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
    ///Switch кнопка смена состояния.
    private let mySwitch: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.onTintColor = .systemRed
        mySwitch.addTarget(SwitchTableViewCell.self, action: #selector(changeAppSwitchValue), for: .valueChanged)
        return mySwitch
    }()
    
    @objc func changeAppSwitchValue() {
        if mySwitch.isOn {
            print("mySwith is ON switched")
            
        } else {
            print("mySwith is OF switched")
        }
    }
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        contentView.addSubview(mySwitch)
        contentView.clipsToBounds = true
        accessoryType = .none
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        let size: CGFloat = contentView.frame.size.height - 12
        let imageSize: CGFloat = size/1.5
        ///Icon image in tableView
        iconContainer.frame = CGRect(
            x: 15,
            y: 6,
            width: size,
            height: size)
        ///background color outside icon image.
        iconImageView.frame = CGRect(
            x: (size - imageSize)/2,
            y: (size - imageSize)/2,
            width: imageSize,
            height: imageSize)
        ///Switch Button Pomadoro
        mySwitch.sizeToFit()
        mySwitch.frame = CGRect(
            x: contentView.frame.size.width - mySwitch.frame.size.width - 20,
            y: (contentView.frame.size.height - mySwitch.frame.size.height) / 2,
            width: mySwitch.frame.size.width,
            height: mySwitch.frame.size.height)
        
        label.frame = CGRect(
            x: 25 + iconContainer.frame.size.width,
            y: 0,
            width: contentView.frame.size.width - 20 - iconContainer.frame.size.width,
            height: contentView.frame.size.height
        )
    }
    //MARK: - PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        iconContainer.backgroundColor = nil
        label.text = nil
        iconImageView.image = nil
        mySwitch.isOn = false
    }
    //MARK: - Configure
    public func configure(with model: SettingsSwitchOption) {
        label.text = model.title
        iconImageView.image = model.icon
        iconImageView.backgroundColor = model.iconBackgroundColor
        mySwitch.isOn = model.isOn
    }
}



