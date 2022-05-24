
import UIKit

class TableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterImageView: CharacterImageView! {
        didSet {
            characterImageView.contentMode = .scaleAspectFit
            characterImageView.clipsToBounds = true
            characterImageView.layer.cornerRadius = characterImageView.bounds.height / 2
            characterImageView.backgroundColor = .white
        }
    }
    
    // MARK: - Public methods
    func configure(with result: Result?) {
        nameLabel.text = result?.name
//        self.characterImageView.fetchImage(from: result?.image ?? "")
        DispatchQueue.global().async {
                guard let stringUrl = result?.image else { return }
                guard let imageURL = URL(string: stringUrl) else { return }
                guard let imageData = try? Data(contentsOf: imageURL) else { return }
                DispatchQueue.main.async {
                    self.characterImageView.image = UIImage(data: imageData)
                }
        }
    }
}
