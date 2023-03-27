import UIKit

class EmojiMixerViewController: UIViewController {
    private let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var visibleEmojiMixes: [EmojiMix] = []
    private let viewModel = EmojiMixesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewMix))
        
        title = "EmojiMixer"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = addButton
        
        collection.register(EmojiMixCell.self, forCellWithReuseIdentifier: EmojiMixCell.reuseIdentifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        
        _ = viewModel.observe(\.emojiMixes,
                           options: [.new],
                           changeHandler: { [weak self] _, change in
            print("data changed!")
            self?.collection.reloadData()
        })
        
        view.addSubview(collection)
        
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func updateCollection() {
        
    }
    
    @objc func addNewMix() {
        let result = viewModel.addNewMix()
        switch result {
        case .success(_):
            print("success")
        case .failure(_):
            print("error")
        }
    }
}

extension EmojiMixerViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.emojiMixes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiMixCell.reuseIdentifier, for: indexPath) as? EmojiMixCell else { return EmojiMixCell() }
        
        cell.prepareForReuse()
        let cellViewModel = EmojiMixViewModel(
            emojies: viewModel.emojiMixes?[indexPath.row].emojies,
            backgroundColor: viewModel.emojiMixes?[indexPath.row].backgroundColor
        )
        cell.initiate(viewModel: cellViewModel)
        
        cell.itemBackground.backgroundColor = cellViewModel.backgroundColor
        cell.mix.text = cellViewModel.emojies
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width / 2) - 4
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
 
}

