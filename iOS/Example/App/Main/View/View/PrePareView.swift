//
//  PrePareView.swift
//
//  Created by aby on 2022/12/26.
//  Copyright © 2022 Tencent. All rights reserved.
//

import UIKit
import TUICore
import TUIRoomEngine

class PrePareView: UIView {
    
    weak var rootViewController: RoomPrePareViewController?
    
    let topViewContainer: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(named: "room_back")
        button.setImage(image, for: .normal)
        return button
    }()
    
    let avatarButton: UIButton = {
        let button = UIButton(type: .custom)
        return button
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    
    lazy var debugButton: UIButton = {
        let button = UIButton(type: .custom)
        let iconImg = UIImage(named: "debug.png")
        button.setImage(iconImg, for: .normal)
        return button
    }()
    
    let switchLanguageButton: UIButton = {
        let button = UIButton(type: .custom)
        let normalIcon = UIImage(named: "room_language")
        button.setImage(normalIcon, for: .normal)
        return button
    }()
    
    let signImageView: UIView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "room_tencent")
        return imageView
    }()
    
    let signLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = .videoConferencingText
        return label
    }()
    
    let joinRoomButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(.joinRoomText, for: .normal)
        button.layer.cornerRadius = 4
        button.backgroundColor = UIColor(0x146EFA)
        let normalIcon = UIImage(named: "room_enter")
        button.setImage(normalIcon, for: .normal)
        return button
    }()
    
    let createRoomButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(.createRoomText, for: .normal)
        button.layer.cornerRadius = 4
        button.backgroundColor = UIColor(0x146EFA)
        let normalIcon = UIImage(named: "room_create")
        button.setImage(normalIcon, for: .normal)
        return button
    }()
    
    let appVersionTipLabel: UILabel = {
        let tip = UILabel()
        tip.textAlignment = .center
        tip.font = UIFont.systemFont(ofSize: 14)
        tip.textColor = UIColor(red: 187, green:187, blue:187).withAlphaComponent(0.8)
        let version = (Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String) ?? "1.0.0"
        tip.text = "Tencent Cloud TUIRoomKit v\(version)"
        tip.adjustsFontSizeToFitWidth = true
        return tip
    }()
    
    private let signViewHeight: CGFloat = 36
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - view layout
    private var isViewReady: Bool = false
    override func didMoveToWindow() {
        super.didMoveToWindow()
        guard !isViewReady else { return }
        backgroundColor = .white
        constructViewHierarchy()
        activateConstraints()
        bindInteraction()
        isViewReady = true
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        avatarButton.roundedRect(rect: avatarButton.bounds,
                                 byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight],
                                 cornerRadii: CGSize(width: avatarButton.bounds.size.width, height: avatarButton.bounds.size.height))
        joinRoomButton.roundedRect(rect: joinRoomButton.bounds,
                                   byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight],
                                   cornerRadii: CGSize(width: 12, height: 12))
        createRoomButton.roundedRect(rect: createRoomButton.bounds,
                                     byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight],
                                     cornerRadii: CGSize(width: 12, height: 12))
    }
    
    func constructViewHierarchy() {
        addSubview(topViewContainer)
        topViewContainer.addSubview(backButton)
        topViewContainer.addSubview(avatarButton)
        topViewContainer.addSubview(userNameLabel)
        topViewContainer.addSubview(debugButton)
        topViewContainer.addSubview(switchLanguageButton)
        addSubview(signImageView)
        addSubview(signLabel)
        addSubview(joinRoomButton)
        addSubview(createRoomButton)
        addSubview(appVersionTipLabel)
    }
    
    func activateConstraints() {
        topViewContainer.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(32.scale375())
        }
        backButton.snp.makeConstraints { make in
            make.height.width.equalTo(32.scale375())
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        avatarButton.snp.makeConstraints { make in
            make.height.width.equalTo(32.scale375())
            make.leading.equalTo(backButton.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
        }
        userNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarButton.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
        }
        debugButton.snp.makeConstraints { make in
            make.trailing.equalTo(switchLanguageButton.snp.leading).offset(-5)
            make.width.height.equalTo(30)
        }
        switchLanguageButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.width.height.equalTo(30)
        }
        signImageView.snp.makeConstraints { make in
            make.width.equalTo(136)
            make.height.equalTo(signViewHeight)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(157.scale375())
        }
        signLabel.snp.makeConstraints { make in
            make.top.equalTo(signImageView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.height.equalTo(signViewHeight)
        }
        joinRoomButton.snp.makeConstraints { make in
            make.height.equalTo(60.scale375())
            make.width.equalTo(204.scale375())
            make.leading.equalTo(85.scale375())
            make.bottom.equalTo(createRoomButton.snp.top).offset(-20)
        }
        
        createRoomButton.snp.makeConstraints { make in
            make.height.equalTo(60.scale375())
            make.width.equalTo(204.scale375())
            make.leading.equalTo(85.scale375())
            make.bottom.equalToSuperview().offset(-103)
        }
        
        appVersionTipLabel.snp.makeConstraints { make in
            make.bottomMargin.equalToSuperview().offset(-20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
    }
    
    func bindInteraction() {
        setupViewState()
        backButton.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
        joinRoomButton.addTarget(self, action: #selector(joinRoomAction(sender:)), for: .touchUpInside)
        createRoomButton.addTarget(self, action: #selector(createRoomAction(sender:)), for: .touchUpInside)
        debugButton.addTarget(self, action: #selector(debugButtonClick), for: .touchUpInside)
        switchLanguageButton.addTarget(self, action: #selector(switchLanguageAction(sender:)), for: .touchUpInside)
    }
    
    func setupViewState() {
        let placeholderImage = UIImage(named: "room_default_avatar")
        avatarButton.sd_setImage(with: URL(string: TUILogin.getFaceUrl() ?? ""), for: .normal, placeholderImage: placeholderImage)
        userNameLabel.text = TUILogin.getNickName() ?? ""
        guard let image = getGradientImage(size: CGSize(width: UIScreen.main.bounds.width, height: signViewHeight)) else { return }
        signLabel.textColor = UIColor(patternImage: image)
    }
    
    @objc
    func backAction(sender: UIButton) {
        rootViewController?.backAction()
    }
    
    @objc
    func joinRoomAction(sender: UIButton) {
        rootViewController?.joinRoom()
    }
    
    @objc
    func createRoomAction(sender: UIButton) {
        rootViewController?.createRoom()
    }
    
    @objc
    func debugButtonClick() {
        rootViewController?.showDebugVC()
    }
    
    @objc
    func switchLanguageAction(sender: UIButton) {
        rootViewController?.switchLanguageAction()
        joinRoomButton.setTitle(.joinRoomText, for: .normal)
        createRoomButton.setTitle(.createRoomText, for: .normal)
        signLabel.text = .videoConferencingText
    }
    
    private func getGradientImage(size:CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else{ return nil }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        guard let gradientRef = CGGradient(colorsSpace: colorSpace, colors: [UIColor(0x00CED9).cgColor, UIColor(0x0C59F2).cgColor] 
                                           as CFArray, locations: nil) else { return nil }
        let startPoint = CGPoint(x: 0, y: 0)
        let endPoint = CGPoint(x: size.width, y: 0)
        context.drawLinearGradient(gradientRef, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(arrayLiteral: .drawsBeforeStartLocation,.drawsAfterEndLocation))
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return gradientImage
    }
    
    deinit {
        debugPrint("deinit \(self)")
    }
}

private extension String {
    static var joinRoomText: String {
        RoomDemoLocalize("Demo.TUIRoomKit.join.room")
    }
    static var createRoomText: String {
        RoomDemoLocalize("Demo.TUIRoomKit.create.room")
    }
    static var videoConferencingText: String {
        RoomDemoLocalize("Demo.TUIRoomKit.video.conferencing")
    }
}

