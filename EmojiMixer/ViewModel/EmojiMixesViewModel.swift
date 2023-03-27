import UIKit

@objcMembers
class EmojiMixesViewModel: NSObject {
    dynamic private(set) var emojiMixes: [EmojiMixViewModel]?
    let factory = EmojiMixFactory()
    let data = EmojiMixStore()
    
    func updateData() -> [EmojiMixViewModel] {
        print("updateData called")
        var result: [EmojiMixViewModel] = []
        try? data.fetchEmojiMixes().forEach {
            result.append(EmojiMixViewModel(
                emojies: $0.emojies,
                backgroundColor: $0.backgroundColor
            ))
        }
        return result
    }
    
    func addNewMix() -> Result<Bool, Error> {
        do {
            let item = try factory.makeNewMix()
            emojiMixes?.append(EmojiMixViewModel(
                emojies: item?.emojies,
                backgroundColor: item?.backgroundColor
            ))
            return .success(true)
        } catch let error {
            return .failure(error)
        }
    }
    
    override init() {
        super.init()
        emojiMixes = updateData()
    }
}
