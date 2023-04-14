import UIKit

class TotalTableViewCell: UITableViewCell {
    //MARK: - Properties
    
    static let identifier = "TotalTableViewCell"
    ///Текстовое описание настройки
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Date"
        return label
    }()
    ///progressViewBar
    let progressView = UIProgressView()
    
    //MARK: - Init
    
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
    
    //MARK: - methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size: CGFloat = contentView.frame.size.height - 12
        
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



