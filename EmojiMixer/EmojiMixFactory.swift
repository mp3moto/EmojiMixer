import UIKit

class EmojiMixFactory {
    private let emoji = ["🍇", "🍈", "🍉", "🍊", "🍋", "🍌", "🍍", "🥭", "🍎", "🍏", "🍐", "🍒",
                         "🍓", "🫐", "🥝", "🍅", "🫒", "🥥", "🥑", "🍆", "🥔", "🥕", "🌽", "🌶️",
                         "🫑", "🥒", "🥬", "🥦", "🧄", "🧅", "🍄"]
    
    func rand255() -> CGFloat {
        let value = CGFloat.random(in: 0..<1)
        return CGFloat(value)
    }
    
    func makeNewMix() throws -> EmojiMix? {
        var mix: String = ""
        for _ in 1...3 {
            if let element = emoji.randomElement() {
                mix += element
            }
        }
        
        guard mix.count == 3 else { return nil }
        
        let color = CGColor(red: rand255(), green: rand255(), blue: rand255(), alpha: 1)
        let emojiMix = EmojiMix(
            emojies: mix,
            backgroundColor: UIColor(cgColor: color)
        )
        
        let storage = EmojiMixStore()
        
        do {
            try storage.addNewEmojiMix(emojiMix)
        } catch let error {
            print(error.localizedDescription)
        }
        
        return emojiMix
    }
}
