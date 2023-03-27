import UIKit

@objcMembers
final class EmojiMixViewModel: NSObject {
    dynamic private(set) var emojies: String?
    dynamic private(set) var backgroundColor: UIColor?
    
    init(emojies: String? = nil, backgroundColor: UIColor? = nil) {
        self.emojies = emojies
        self.backgroundColor = backgroundColor
        super.init()
    }
}
