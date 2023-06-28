import UIKit
import SDWebImage
import Util

public struct UserSearchCellViewModel: Equatable {
    public let name: String
    public let profileImageUrl: URL
}

public final class UserSearchCell: UITableViewCell, Identifiable {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!

    public override func awakeFromNib() {
        super.awakeFromNib()
        configureImageView()
    }

    private func configureImageView() {
        profileImageView.layer.cornerRadius = 22
        profileImageView.layer.masksToBounds = true
        profileImageView.sd_imageIndicator = SDWebImageActivityIndicator()
    }

    func setContent(_ viewModel: UserSearchCellViewModel) {
        titleLbl.text = viewModel.name
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
    }
}
