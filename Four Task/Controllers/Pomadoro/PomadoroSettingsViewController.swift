import UIKit

class PomadoroSettingsViewController: UIViewController {
    
    // MARK: - Properties
    var models = [Section]()
    var count = Count()
    
    // Dynamic container constraint
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    /// define lazy views
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.titleLabel
        label.font = .bold
        return label
    }()
    ///TableView с статичной и свитч ячейкой.
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        table.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
        return table
    }()
    ///Стак-вью содержащий лейбл и таблицу с ячейками.
    lazy var contentStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [titleLabel, tableView, spacer])
        stackView.axis = .vertical
        stackView.spacing = Constants.Inset.spacing
        return stackView
    }()
    ///Контейнер-Вью на половину экрана.
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.Design.cornerRadiusMain
        view.clipsToBounds = true
        return view
    }()
    
    lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = Constants.Design.maxDimmedAplha
        return view
    }()
    
    
    
    // MARK: - Lifecycle ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        ///Подписываемся на delegat и dataSource
        tableView.delegate = self
        tableView.dataSource = self
        ///Устанавливаем Вью, конфигурируем ячейки таблицы.
        setupView()
        setupConstraints()
        configureCells()
        
        // MARK: - TapGesture
        // tap gesture on dimmed view to dismiss
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleCloseAction))
        dimmedView.addGestureRecognizer(tapGesture)
        setupPanGesture()
    }
    
    @objc func handleCloseAction() {
        animateDismissView()
    }
    // MARK: - Lifecycle viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateShowDimmedView()
        animatePresentContainer()
    }
    // MARK: - Methods
    private func setupView() {
        view.backgroundColor = .clear
    }
    private func setupPanGesture() {
        // add pan gesture recognizer to the view controller's view (the whole screen)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
        // change to false to immediately listen on gesture movement
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }
    
    // MARK: Pan gesture handler
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        // Drag to top will be minus value and vice versa
        print("Pan gesture y offset: \(translation.y)")
        
        // Get drag direction
        let isDraggingDown = translation.y > .zero
        print("Dragging direction: \(isDraggingDown ? "going down" : "going up")")
        
        // New height is based on value of dragging plus current container height
        let newHeight = Constants.currentContainerHeight - translation.y
        
        // Handle based on gesture state
        switch gesture.state {
        case .changed:
            // This state will occur when user is dragging
            if newHeight < Constants.maximumContainerHeight {
                // Keep updating the height constraint
                containerViewHeightConstraint?.constant = newHeight
                // refresh layout
                view.layoutIfNeeded()
            }
        case .ended:
            // This happens when user stop drag,
            // so we will get the last height of container
            
            // Condition 1: If new height is below min, dismiss controller
            if newHeight < Constants.dismissibleHeight {
                self.animateDismissView()
            }
            else if newHeight < Constants.defaultHeight {
                // Condition 2: If new height is below default, animate back to default
                animateContainerHeight(Constants.defaultHeight)
            }
            else if newHeight < Constants.maximumContainerHeight && isDraggingDown {
                // Condition 3: If new height is below max and going down, set to default height
                animateContainerHeight(Constants.defaultHeight)
            }
            else if newHeight > Constants.defaultHeight && !isDraggingDown {
                // Condition 4: If new height is below max and going up, set to max height at top
                animateContainerHeight(Constants.maximumContainerHeight)
            }
        default:
            break
        }
    }
    
    private func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            // Update container height
            self.containerViewHeightConstraint?.constant = height
            // Call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
        // Save current height
        Constants.currentContainerHeight = height
    }
    
    // MARK: Present and dismiss animation
    private func animatePresentContainer() {
        // update bottom constraint in animation block
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = .zero
            // call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
    }
    
    private func animateShowDimmedView() {
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = Constants.Design.maxDimmedAplha
        }
    }
    
    func animateDismissView() {
        // hide blur view
        dimmedView.alpha = Constants.Design.maxDimmedAplha
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            // once done, dismiss without animation
            self.dismiss(animated: false)
        }
        // hide main view by updating bottom constraint in animation block
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = Constants.defaultHeight
            // call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
    }
    
    private func formatTimeFocus() -> String {
        let minutes = Int(count.focusCount * 25) / 60 % 60
        let seconds = Int(count.focusCount * 25) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    private func formatTimeRelax() -> String {
        let minutes = Int(count.relaxCount * 5) / 60 % 60
        let seconds = Int(count.relaxCount * 5) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    ///Установка ячеек таблиц
    private func configureCells() {
        models.append(Section(title: Constants.Cells.tomatoTitle, options: [
            
            .staticCell(model: SettingsOption(
                title: "\(Constants.Cells.fokusTitle) \(formatTimeFocus()), \(Constants.Cells.relaxTitle) = \(formatTimeRelax())",
                //
                icon: UIImage(named: "tomatoTimer"),
                iconBackgroundColor: .systemIndigo) {
                })
        ]))
        
        models.append(Section(title: Constants.Cells.soundTitle, options: [
            .switchCell(model: SettingsSwitchOption(
                title: "Звук",
                icon: UIImage(systemName:"speaker.wave.3.fill"),
                iconBackgroundColor: .systemIndigo,
                handler: {
                    
                },
                isOn: true)),
            
                .switchCell(model: SettingsSwitchOption(
                    title: Constants.Cells.notificationTitle,
                    icon: UIImage(systemName: "bell.badge.fill"),
                    iconBackgroundColor: .systemPink,
                    handler: {
                        print("Notificati, in PomadoroTimer ON")
                    },
                    isOn: true)),
            
                .staticCell(model: SettingsOption(
                    title: Constants.Cells.backgroundWorkTitle,
                    icon: UIImage(systemName: "bag"),
                    iconBackgroundColor: .systemPink) {
                    }),
        ]))
    }
    ///Layout
    func setupConstraints() {
        // Add subviews
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
  ])
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.Inset.huge),
            contentStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Constants.Inset.classic),
            contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.Inset.classic),
            contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.Inset.classic),
        ])

        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: Constants.defaultHeight)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.defaultHeight)
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }
}

// MARK: - UITableViewDelegate

extension PomadoroSettingsViewController : UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.heightForRow
    }
}

// MARK: - UITableViewDataSource

extension PomadoroSettingsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model.self {
            
        case .staticCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingsTableViewCell.identifier,
                for: indexPath
            ) as? SettingsTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: model)
            return cell
            
            
        case .switchCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SwitchTableViewCell.identifier,
                for: indexPath
            ) as? SwitchTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.section].options[indexPath.row]
        switch type.self {
        case .switchCell(let model):
            model.handler()
        case .staticCell(let model):
            model.handler()
        }
    }
}

private extension Constants {
    
    static let defaultHeight: CGFloat = 300
    static let dismissibleHeight: CGFloat = 200
    static let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64
    static var currentContainerHeight: CGFloat = 300
    static let heightForRow: CGFloat = 80
    static let titleLabel = "Настройки 🍅"
    
    struct Cells {
       static let tomatoTitle = "Итоги томата"
        static let fokusTitle = "Фокус ="
        static let  relaxTitle = "Отдых ="
        static let soundTitle = "Звуки"
        static let notificationTitle = "Уведомления"
        static let backgroundWorkTitle = "Фоновая работа"
    }
}
