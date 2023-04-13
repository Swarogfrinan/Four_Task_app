import UIKit

class SettingsTableViewCell: UITableViewCell {
    //MARK: - Properties
    
    static let identifier = "SettingsTableViewCell"

    private let IconContainerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    ///Иконка-картинка в ячейке.
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    ///Текстовое описание настройки
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(IconContainerView)
        IconContainerView.addSubview(iconImageView)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        let size: CGFloat = contentView.frame.size.height - 12
        let imageSize: CGFloat = size/1.5
        
        IconContainerView.frame = CGRect(x: 15, y: 6, width: size, height: size)
        
        iconImageView.frame = CGRect(x: (size - imageSize)/2, y: (size - imageSize)/2, width: imageSize, height: imageSize)
        //        iconImageView.center = iconContainer.center
        
        descriptionLabel.frame = CGRect(
            x: 25 + IconContainerView.frame.size.width,
            y: 0,
            width: contentView.frame.size.width - 20 - IconContainerView.frame.size.width,
            height: contentView.frame.size.height
        )
    }
    //MARK: - PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        IconContainerView.backgroundColor = nil
        descriptionLabel.text = nil
        iconImageView.image = nil
    }
    //MARK: - Configure
    public func configure(with model: SettingsOption) {
        descriptionLabel.text = model.title
        iconImageView.image = model.icon
        iconImageView.backgroundColor = model.iconBackgroundColor
    }
    
    
    
}
