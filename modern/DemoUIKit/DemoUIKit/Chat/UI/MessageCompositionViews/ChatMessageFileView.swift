//
//  ChatMessageFileView.swift
//  DemoUIKit
//
//  Created by Andrei Kasykhin on 2022-11-24.
//

import UIKit
import Anchorage

protocol ChatMessageFileViewDelegate: AnyObject {
    func onDownload()
}

class ChatMessageFileView: UIView {
    private var downloadButton: UIButton!
    private var fileSizeLabel: UILabel!
    private var fileNameLabel: UILabel!
    private var fileIconView: UIView!
    private var fileIconImageView: UIImageView!
    
    private var isSetUpConstraints = false
    
    private var downloadActionClosure: () -> Void = {}

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func onDownload() {
        downloadActionClosure()
    }
    
}

extension ChatMessageFileView {
    
    func setUp(item: ChatMessageFileViewItem, downloadActionClosure: @escaping () -> Void) {
        self.downloadActionClosure = downloadActionClosure
        
        fileIconImageView.image = UIImage(named: item.type.imageName)
        fileIconView.backgroundColor = item.tintColor
        fileNameLabel.text = item.fileName
        fileSizeLabel.text = item.fileSize
        
        let isLeadingLayout = item.direction == .leading
        fileNameLabel.textAlignment = isLeadingLayout ? .left : .right
        fileSizeLabel.textAlignment = isLeadingLayout ? .left : .right
    }
}

extension ChatMessageFileView {
    func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        setContentHuggingPriority(.defaultHigh, for: .horizontal)
        setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        fileNameLabel = setup(UILabel(),
                              addToView: self,
                              setupBlock: {
            $0.font = UIFont.preferredFont(forTextStyle: .body).weight(.regular)
            $0.textColor = UIColor(hex: "#FCFCFC")
            $0.numberOfLines = 1
            $0.allowsDefaultTighteningForTruncation = true
            $0.lineBreakMode = .byTruncatingMiddle
        })
        fileNameLabel.setContentHuggingPriority(.required, for: .horizontal)
        fileNameLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        fileSizeLabel = setup(UILabel(),
                              addToView: self,
                              setupBlock: {
            $0.font = UIFont.preferredFont(forTextStyle: .caption1).weight(.regular)
            $0.textColor = UIColor(hex: "#FCFCFC")
        })
        
        downloadButton = setup(UIButton(),
                               addToView: self,
                               setupBlock: {
            $0.titleLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline).weight(.bold)
            $0.setTitle("Download", for: .normal)
            $0.setTitleColor(UIColor(hex: "#FCFCFC"), for: .normal)
        })
        downloadButton.addTarget(self, action: #selector(onDownload), for: .touchUpInside)
        
        fileIconView = setup(UIView(),
                             addToView: self,
                             setupBlock: {
            $0.cornerRadius = 8
            $0.backgroundColor = UIColor.clear
        })
        
        fileIconImageView = setup(UIImageView(),
                                  addToView: fileIconView,
                                  setupBlock: {
            $0.contentMode = .scaleToFill
        })
        
        setupConstraints()
    }

    func setupConstraints() {
        guard !isSetUpConstraints else { return }
        isSetUpConstraints = true
        heightAnchor /==/ 46
        fileIconView.leftAnchor == leftAnchor + 4
        fileIconView.sizeAnchors == CGSize(width: 40, height: 40)
        fileIconView.centerYAnchor == centerYAnchor

        fileIconImageView.sizeAnchors == CGSize(width: 21.5, height: 21.5)
        fileIconImageView.centerXAnchor == fileIconView.centerXAnchor
        fileIconImageView.centerYAnchor == fileIconView.centerYAnchor

        fileNameLabel.leftAnchor == fileIconView.rightAnchor + 8
        fileNameLabel.topAnchor == topAnchor + 2
        fileNameLabel.rightAnchor />=/ rightAnchor + 4
        
        fileSizeLabel.topAnchor == fileNameLabel.bottomAnchor + 2
        fileSizeLabel.leftAnchor == fileNameLabel.leftAnchor
        
        downloadButton.sizeAnchors == CGSize(width: 86, height: 28)
        downloadButton.leftAnchor == fileSizeLabel.rightAnchor + 2
        downloadButton.rightAnchor == rightAnchor
        downloadButton.firstBaselineAnchor == fileSizeLabel.firstBaselineAnchor
    }
}
