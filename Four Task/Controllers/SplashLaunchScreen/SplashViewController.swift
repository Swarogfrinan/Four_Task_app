import UIKit

final class SplashViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var FourTaskLogo: UIImageView!
    @IBOutlet weak var textImageView: UIImageView!
    
    var textImage: UIImage?
    
    var logoIsHidden: Bool = false
    
    static let logoImageBig: UIImage = UIImage(named: "tomatoTimer")!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textImageView.image = textImage
        logoImageView.isHidden = logoIsHidden
    }
}
