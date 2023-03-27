import UIKit

class EmojiMixCell: UICollectionViewCell {
    static let reuseIdentifier = "cell"
    
    /*private*/ var viewModel: EmojiMixViewModel?
    /*private*/ var emojies: NSObject?
    private var bgColor: NSObject?
    
    let itemBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = UIColor.cyan
        return view
    }()
    
    let mix: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "System", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(itemBackground)
        itemBackground.addSubview(mix)
        
        NSLayoutConstraint.activate([
            itemBackground.widthAnchor.constraint(equalTo:contentView.widthAnchor),
            itemBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            itemBackground.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mix.centerXAnchor.constraint(equalTo: itemBackground.centerXAnchor),
            mix.centerYAnchor.constraint(equalTo: itemBackground.centerYAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initiate(viewModel: EmojiMixViewModel) {
        self.viewModel = viewModel
        bind()
    }
    
    private func bind() {
        guard let viewModel = viewModel else { return }
        
        emojies = viewModel.observe(\.emojies,
                                     options: [.new],
                                     changeHandler: { [weak self] _, change in
            guard let newValue = change.newValue else { return }
            self?.mix.text = newValue
        })
        
        bgColor = viewModel.observe(\.backgroundColor,
                                     options: [.new],
                                     changeHandler: { [weak self] _, change in
            guard let newValue = change.newValue else { return }
            self?.itemBackground.backgroundColor = newValue
        })
    }
    
    override func prepareForReuse() {
        emojies = nil
        bgColor = nil
    }
}
