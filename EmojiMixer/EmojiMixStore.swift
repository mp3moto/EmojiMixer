import UIKit
import CoreData

class EmojiMixStore {
    private let context: NSManagedObjectContext
    private let converter = ColorConverter()
    
    convenience init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.init(context: appDelegate.persistentContainer.viewContext)
    }
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func addNewEmojiMix(_ emojiMix: EmojiMix) throws {
        guard let color = converter.toHEX(color: emojiMix.backgroundColor.cgColor) else { return }
        let newSet = EmojiMixCoreData(context: context)
        newSet.emojies = emojiMix.emojies
        newSet.colorHex = color
        
        try context.save()
    }
    
    func fetchEmojiMixes() throws -> [EmojiMix] {
        let request = NSFetchRequest<EmojiMixCoreData>(entityName: "EmojiMixCoreData")
        var emojiMix: [EmojiMix] = []
        do {
            let emojies = try context.fetch(request)
            emojies.forEach {
                let color = $0.colorHex ?? "FFFFFF"
                emojiMix.append(EmojiMix(
                    emojies: $0.emojies ?? "",
                    backgroundColor: UIColor(cgColor: converter.fromHEX(color: color) ?? UIColor.white.cgColor)
                ))
            }
        } catch let error {
            print(error.localizedDescription)
        }
        return emojiMix
    }
}
