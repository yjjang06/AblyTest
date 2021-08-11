//
//  GoodsCollectionViewCell.swift
//  AblyTest
//
//  Created by yjjang on 2021/08/08.
//

import UIKit
import SDWebImage

@objc protocol GoodsCollectionViewCellDelegate {
    @objc optional func goodsCollectionViewCellDidSelectZzim(cell: GoodsCollectionViewCell, index: Int)
}

class GoodsCollectionViewCell: UICollectionViewCell {
    enum CellType {
        case Default
        case Zzim
    }
    var cellType: CellType = .Default {
        didSet {
            if cellType == .Default {
                zzimButton.isHidden = false
            }
            else {
                zzimButton.isHidden = true
            }
        }
    }
    
    var itemIndex: Int?
    weak var delegate: GoodsCollectionViewCellDelegate?
    
    private var goodsImageView: UIImageView!
    private var rateLabel: UILabel!
    private var priceLabel: UILabel!
    private var nameLabel: UILabel!
    private var goodsInfoStackView: UIStackView!
    private var newImageView: UIImageView!
    private var countLabel: UILabel!
    
    private var zzimButton: UIButton!
    
    private var borderLineView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        goodsImageView = UIImageView()
        contentView.addSubview(goodsImageView)
        goodsImageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(16)
        }
        goodsImageView.layer.cornerRadius = 4
        goodsImageView.layer.masksToBounds = true
        
        zzimButton = UIButton(type: .custom)
        zzimButton.setImage(UIImage(named: "iconCardZzim"), for: .normal)
        zzimButton.setImage(UIImage(named: "iconCardZzimSelected"), for: .selected)
        contentView.addSubview(zzimButton)
        zzimButton.snp.makeConstraints { make in
            make.top.equalTo(goodsImageView.snp.top).offset(8)
            make.trailing.equalTo(goodsImageView.snp.trailing).offset(-8)
        }
        zzimButton.addTarget(self, action: #selector(touchedZzimButton), for: .touchUpInside)
        
        rateLabel = UILabel()
        rateLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18.0)
        rateLabel.textColor = ConstantColor.watermelon
        contentView.addSubview(rateLabel)
        rateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalTo(goodsImageView.snp.trailing).offset(12)
            make.height.equalTo(21)
        }
        
        priceLabel = UILabel()
        priceLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18.0)
        priceLabel.textColor = ConstantColor.black
        contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.leading.equalTo(rateLabel.snp.trailing).offset(5)
            make.centerY.equalTo(rateLabel.snp.centerY)
            make.height.equalTo(rateLabel.snp.height)
        }
        
        nameLabel = UILabel()
        //TODO: 여러줄 표시 처리 필요
        //nameLabel.numberOfLines = 0
        nameLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.0)
        nameLabel.textColor = ConstantColor.brownishGrey
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(rateLabel.snp.bottom).offset(5)
            make.leading.equalTo(goodsImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-22)
        }
        
        goodsInfoStackView = UIStackView()
        goodsInfoStackView.axis = .horizontal
        goodsInfoStackView.spacing = 4
        contentView.addSubview(goodsInfoStackView)
        goodsInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(17)
            make.leading.equalTo(goodsImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-22)
            make.height.equalTo(17)
        }
        
        let newImage = UIImage(named: "imgBadgeNew")!
        newImageView = UIImageView(image: newImage)
        newImageView.snp.makeConstraints { make in
            make.width.equalTo(newImage.size.width)
            make.height.equalTo(newImage.size.height)
        }
        goodsInfoStackView.addArrangedSubview(newImageView)
        
        countLabel = UILabel()
        countLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13.0)
        countLabel.textColor = ConstantColor.brownishGrey
        goodsInfoStackView.addArrangedSubview(countLabel)
        
        borderLineView = UIView()
        borderLineView.backgroundColor = ConstantColor.veryLightPink
        contentView.addSubview(borderLineView)
        borderLineView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Set UI
    func setGoodsImage(url: String?) {
        if let tmpUrl = url, let imgUrl = URL(string: tmpUrl) {
            goodsImageView.sd_setImage(with: imgUrl, completed: nil)
        }
        else {
            goodsImageView.image = nil
        }
    }
    
    func setRateText(actualPrice: Int?, price: Int?) {
        if let a = actualPrice, let p = price {
            let rate = 100 - Int(CGFloat(p) / (CGFloat(a)) * 100)
            let text = String(format: "%d%%", rate)
            rateLabel.attributedText = getAttrString(text: text, letterSpacing: -0.6)
        }
        else {
            rateLabel.attributedText = nil
        }
    }
    
    func setPriceText(_ price: Int?) {
        if let p = price {
            let text = decimalFommattingStr(p)
            priceLabel.attributedText = getAttrString(text: text, letterSpacing: -0.6)
        }
        else {
            priceLabel.attributedText = nil
        }
    }
    
    func setGoodsName(_ name: String?) {
        nameLabel.attributedText = getAttrString(text: name, letterSpacing: -0.4)
    }
    
    func setIsNewHidden(_ isHidden: Bool) {
        newImageView.isHidden = isHidden
    }
    
    func setSellCountText(_ count: Int?) {
        if let c = count, let countText = decimalFommattingStr(c) {
            let text = String(format: "%@개 구매중", countText)
            countLabel.attributedText = getAttrString(text: text, letterSpacing: -0.4)
        }
    }
    
    func setIsZzim(_ isZzim: Bool) {
        zzimButton.isSelected = isZzim
    }
    
    //MARK:- Button actions
    @objc private func touchedZzimButton() {
        if itemIndex != nil {
            delegate?.goodsCollectionViewCellDidSelectZzim?(cell: self, index: itemIndex!)
        }
    }
    
    //MARK:- Util
    private func getAttrString(text: String?, letterSpacing: CGFloat) -> NSAttributedString? {
        if let t = text, t.count > 0 {
            let attrStr = NSMutableAttributedString(string: t)
            attrStr.addAttribute(NSAttributedString.Key.kern,
                                 value: letterSpacing,
                                 range: NSRange(location: 0,
                                                length: attrStr.length))
            return attrStr
        }
        return nil
    }
    
    private func decimalFommattingStr(_ n: Int) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        let text = formatter.string(from: NSNumber(value: n))
        return text
    }
}
