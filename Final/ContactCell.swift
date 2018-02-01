import UIKit

class ContactCell: UITableViewCell {
    
    @IBOutlet var nameContact: UILabel!
    
    @IBOutlet var numberContact: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
