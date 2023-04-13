import UIKit

class SwitchTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    static let identifier = "SwitchTableViewCell"
    ///Фоновой цвет позади иконки.
    private let iconContainerView: UIView = {
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
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    ///Switch кнопка смена состояния.
    private let switchControl: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.onTintColor = .systemRed
        mySwitch.addTarget(SwitchTableViewCell.self, action: #selector(changeAppSwitchValue), for: .valueChanged)
        return mySwitch
    }()
    
  
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(iconContainerView)
        iconContainerView.addSubview(iconImageView)
        contentView.addSubview(switchControl)
        contentView.clipsToBounds = true
        accessoryType = .none
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconContainerView.backgroundColor = nil
        descriptionLabel.text = nil
        iconImageView.image = nil
        switchControl.isOn = false
    }
    
    //MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size: CGFloat = contentView.frame.size.height - 12
        let imageSize: CGFloat = size/1.5
        ///Icon image in tableView
        iconContainerView.frame = CGRect(
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
        switchControl.sizeToFit()
        switchControl.frame = CGRect(
            x: contentView.frame.size.width - switchControl.frame.size.width - 20,
            y: (contentView.frame.size.height - switchControl.frame.size.height) / 2,
            width: switchControl.frame.size.width,
            height: switchControl.frame.size.height)
        
        descriptionLabel.frame = CGRect(
            x: 25 + iconContainerView.frame.size.width,
            y: 0,
            width: contentView.frame.size.width - 20 - iconContainerView.frame.size.width,
            height: contentView.frame.size.height
        )
    }

    //MARK: - Methods
    
    public func configure(with model: SettingsSwitchOption) {
        descriptionLabel.text = model.title
        iconImageView.image = model.icon
        iconImageView.backgroundColor = model.iconBackgroundColor
        switchControl.isOn = model.isOn
    }
    @objc func changeAppSwitchValue() {
        if switchControl.isOn {
            print("mySwith is ON switched")
            
        } else {
            print("mySwith is OF switched")
        }
    }
}



