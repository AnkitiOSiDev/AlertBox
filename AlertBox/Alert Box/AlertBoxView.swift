//
//  AlertBoxView.swift
//  AlertBox
//
//  Created by Ankit on 18/08/18.
//  Copyright © 2018 Ankit. All rights reserved.
//

import UIKit

typealias AlertActionCompletionHandler = () -> Void

enum AlertActionType{
    case normal
    case cancel
}

class AlertBoxView: UIView {
    //MARK:- Outlets
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnRight: UIButton!
    @IBOutlet weak var btnLeft: UIButton!
    
    //animation values
    var imgLogo: UIImage?
    var animateDuration: TimeInterval = 1.0
    var scaleX: CGFloat = 0.3
    var scaleY: CGFloat = 1.5
    var rotateRadian:CGFloat = 1.5 // 1 rad = 57 degrees
    var springWithDamping: CGFloat = 0.7
    var delay: TimeInterval = 0
    
    //alert UI specification
    var backgroundTransparency:CGFloat = 0.40
    var cornerRadius:CGFloat = 10
    
    //inital values
    private var title: String = ""
    private var message: String = ""
    private var leftAction: AlertAction?
    private var rightAction: AlertAction?
    
    //MARK:- init and draw
    override  init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    override func draw(_ rect: CGRect) {
        alertView.alpha = 0
        alertView.layer.cornerRadius = cornerRadius
        alertView.clipsToBounds = true
        startAnimation()
    }
    
    //MARK: - Configuration of alert
    
    class func create() -> AlertBoxView {
        let alertVC = Bundle.main.loadNibNamed("AlertBoxView", owner: nil, options: nil)?[0]
        return alertVC as! AlertBoxView
    }
    
    func config(title: String, message: String, isSingleButton:Bool) -> AlertBoxView {
        DispatchQueue.main.async(execute: {
                self.btnLeft.isHidden = isSingleButton
        });
        self.title = title
        self.message = message
        return self
    }
    
    func show(into view: UIView){
        self.backgroundColor = UIColor.black.withAlphaComponent(backgroundTransparency)
        view.addSubview(self)
        setupUI()
    }
    
    func hide(){
        perform(#selector(self.removeFromSuperview), with: self, afterDelay: delay + 0.105)
        startAnimation()
    }
    
    func setupUI(){
        setupButton()
        setupLabel()
    }
    
    func setupLabel(){
        self.lblTitle.text = title
        self.lblMessage.text = message
    }
    
    private func setupButton(){
        if let posAction = self.rightAction{
            self.btnRight.setTitle(posAction.title, for: .normal)
        }
        if let negAction = self.leftAction{
            self.btnLeft.isHidden = false
            self.btnLeft.setTitle(negAction.title, for: .normal)
        }
    }
    
    //MARK:- Animation
    private func startAnimation(){
        alertView.alpha = 1
        UIView.animate(withDuration: animateDuration, delay: delay, usingSpringWithDamping: springWithDamping, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            self.alertView.transform = .identity
        }, completion: nil)
    }

    func addAction(_ action: AlertAction){
        switch action.type{
        case .normal:
            rightAction = action
        case .cancel:
            leftAction = action
        }
    }
    
    //MARK: - Action implementation
    @IBAction func btnRightDidClicked(_ sender: Any) {
        self.hide()
        if let rightHandler = self.rightAction?.handler{
            rightHandler()
        }
    }
    
    @IBAction func btnLeftDidClicked(_ sender: Any) {
       self.hide()
        if let leftHandler = self.leftAction?.handler{
            leftHandler()
        }
    }
}

struct AlertAction{
    let title: String
    let type: AlertActionType
    let handler: AlertActionCompletionHandler?
    
    init(title: String, type: AlertActionType, handler: AlertActionCompletionHandler?){
        self.title = title
        self.type = type
        self.handler = handler
    }
}
