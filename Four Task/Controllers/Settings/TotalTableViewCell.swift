//
//  TotalTableViewCell.swift
//  Four Task
//
//  Created by Ilya Vasilev on 23.07.2022.
//

import UIKit
import MultiProgressView

class TotalTableViewCell: UITableViewCell {
    
    static let identifier = "TotalTableViewCell"
    ///Текстовое описание настройки
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    ///progressViewBar
    let progressView = MultiProgressView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(progressView)
        
        contentView.clipsToBounds = true
        accessoryType = .checkmark
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size: CGFloat = contentView.frame.size.height - 12
        let imageSize: CGFloat = size/1.5
        
        label.frame = CGRect(x: 15, y: 6, width: size, height: size)
        
        progressView.frame = CGRect(
            x: 25 + label.frame.size.width,
            y: 0,
            width: contentView.frame.size.width - 20 - label.frame.size.width,
            height: contentView.frame.size.height
        )
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    public func configure(with model: SettingsOption) {
        label.text = model.title
    }
}



