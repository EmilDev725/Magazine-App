//
//  TextStylerVC.swift
//  Magazine
//
//  Created by iOSpro on 24/2/18.
//  Copyright © 2018 iOSpro. All rights reserved.
//

import UIKit

class TextStylerVC: UIViewController {
    
    @IBOutlet weak var viewEditor: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewColor: UIScrollView!
    var colors = [String]()
    @IBOutlet weak var btnDownRed: UIButton!
    @IBOutlet weak var btnUpRed: UIButton!
    @IBOutlet weak var lbRed: UILabel!
    @IBOutlet weak var sliderRed: UISlider!
    @IBOutlet weak var btnDownGreen: UIButton!
    @IBOutlet weak var btnUpGreen: UIButton!
    @IBOutlet weak var lbGreen: UILabel!
    @IBOutlet weak var sliderGreen: UISlider!
    @IBOutlet weak var btnDownBlue: UIButton!
    @IBOutlet weak var btnUpBlue: UIButton!
    @IBOutlet weak var lbBlue: UILabel!
    @IBOutlet weak var sliderBlue: UISlider!
    @IBOutlet weak var btnDownAlpha: UIButton!
    @IBOutlet weak var btnUpAlpha: UIButton!
    @IBOutlet weak var lbAlpha: UILabel!
    @IBOutlet weak var sliderAlpha: UISlider!
    @IBOutlet weak var btnDownWidthStroke: UIButton!
    @IBOutlet weak var btnUpWidthStroke: UIButton!
    @IBOutlet weak var lbWidthStroke: UILabel!
    @IBOutlet weak var sliderWidthStroke: UISlider!
    @IBOutlet weak var viewStroke: UIView!
    @IBOutlet weak var btnDownWidthBackground: UIButton!
    @IBOutlet weak var btnUpWidthBackground: UIButton!
    @IBOutlet weak var lbWidthBackground: UILabel!
    @IBOutlet weak var sliderWidthBackground: UISlider!
    @IBOutlet weak var btnDownHeightBackground: UIButton!
    @IBOutlet weak var btnUpHeightBackground: UIButton!
    @IBOutlet weak var lbHeightBackground: UILabel!
    @IBOutlet weak var sliderHeightBackground: UISlider!
    @IBOutlet weak var btnDownCornerBackground: UIButton!
    @IBOutlet weak var btnUpCornerBackground: UIButton!
    @IBOutlet weak var lbCornerBackground: UILabel!
    @IBOutlet weak var sliderCornerBackground: UISlider!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var btnDownShadowAlpha: UIButton!
    @IBOutlet weak var btnUpShadowAlpha: UIButton!
    @IBOutlet weak var lbShadowAlpha: UILabel!
    @IBOutlet weak var sliderShadowAlpha: UISlider!
    @IBOutlet weak var btnDownShadowBlur: UIButton!
    @IBOutlet weak var btnUpShadowBlur: UIButton!
    @IBOutlet weak var lbShadowBlur: UILabel!
    @IBOutlet weak var sliderShadowBlur: UISlider!
    @IBOutlet weak var btnDownShadowX: UIButton!
    @IBOutlet weak var btnUpShadowX: UIButton!
    @IBOutlet weak var lbShadowX: UILabel!
    @IBOutlet weak var sliderShadowX: UISlider!
    @IBOutlet weak var btnDownShadowY: UIButton!
    @IBOutlet weak var btnUpShadowY: UIButton!
    @IBOutlet weak var lbShadowY: UILabel!
    @IBOutlet weak var sliderShadowY: UISlider!
    @IBOutlet weak var viewShadow: UIView!
    
    var frameText = CGRect.zero
    var userImage : UIImage?
    var style : UITextView?
    var strokeWidth : Float = 0
    var strokeColor : UIColor = UIColor.clear

    let TEXT = 0
    let STROKE = 1
    let BACKGROUND = 2
    let SHADOW = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView?.image = userImage
        colors = ["ffffff", "bfbfbf", "808080", "404040", "000000", "ff8080", "ff4040", "e01717", "990000", "570000", "ffcced", "ff7abd", "ff4099", "ff0080", "c80049", "ffffc0", "ffff8a", "ffff52", "9e9e00", "424200", "ffe0b8", "ffaa55", "ff8000", "ff4200", "8a3800", "472100", "e2aaff", "c752e6", "8514b8", "610575", "8aebff", "38d1f0", "0f94b3", "005277", "00334d", "76ffff", "38f0f0", "0fbfbf", "008f8f", "004242", "a3ffe0", "52e6c2", "00b394", "007552", "003d29", "aaffaa", "42e642", "1ab31a", "005200", "002600", "e6ff8a", "9ef229", "539e0f", "2e4700"]
        scrollViewColor.contentSize = CGSize(width: scrollViewColor.frame.size.height * CGFloat(colors.count), height: scrollViewColor.frame.size.height)
        for i in 0..<colors.count {
            let button = UIButton(frame: CGRect(x: i * 50, y: 0, width: 50, height: 50))
            button.addTarget(self, action: #selector(self.btnSelectColor), for: .touchUpInside)
            button.tag = i
            button.backgroundColor = UIColor(hexString: colors[i])
            scrollViewColor.addSubview(button)
        }
        let l: CALayer? = imageView?.layer
        l?.masksToBounds = true
        l?.cornerRadius = 10.0
        sliderAlpha.maximumTrackTintColor = UIColor.black
        sliderRed.maximumTrackTintColor = UIColor.black
        sliderGreen.maximumTrackTintColor = UIColor.black
        sliderBlue.maximumTrackTintColor = UIColor.black
        sliderWidthStroke.maximumTrackTintColor = UIColor.black
        sliderWidthBackground.maximumTrackTintColor = UIColor.black
        sliderHeightBackground.maximumTrackTintColor = UIColor.black
        sliderCornerBackground.maximumTrackTintColor = UIColor.black
        sliderShadowAlpha.maximumTrackTintColor = UIColor.black
        sliderShadowBlur.maximumTrackTintColor = UIColor.black
        sliderShadowX.maximumTrackTintColor = UIColor.black
        sliderShadowY.maximumTrackTintColor = UIColor.black
        
        text.text = style?.text
        if let aName = style?.font?.fontName {
            text.font = UIFont(name: aName, size: 50)
        }
        loadStyle()
//        var navbarTitleTextAttributes = [
//            NSAttributedStringKey.foregroundColor : UIColor.black
//        ]
//        UINavigationBar.appearance().titleTextAttributes = navbarTitleTextAttributes
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: viewBackground.frame.origin.y + viewBackground.frame.size.height)

    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.isNavigationBarHidden = false
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.isNavigationBarHidden = true
//    }
    
    func loadTextFontSize(_ style: UITextView, lable: UILabel) {
        lable.font = UIFont(name: (style.font?.fontName)!, size: (style.font?.pointSize)!)
        lable.text = style.text
        lable.sizeToFit()
        let labelRect: CGRect = lable.text!.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: lable.font], context: nil)
        var frame: CGRect = lable.frame
        frame.size.height = labelRect.size.height * 2
        frame.size.width = labelRect.size.width
        lable.frame = frame
        lable.textAlignment = style.textAlignment
        lable.superview?.layoutSubviews()
    }

    func loadText(_ style: UITextView, lable: UILabel) {
//        let labelRect: CGRect = lable.text!.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: lable.font], context: nil)
//        let h: Int = Int(labelRect.size.height)
        // Text
//        var textColor: UIColor? = UIColor(hexString: style.textColor)
//        if let aRed = textColor?.red, let aGreen = textColor?.green, let aBlue = textColor?.blue {
//            textColor = UIColor(red: aRed, green: aGreen, blue: aBlue, alpha: style.textAlpha)
//        }
        lable.textColor = style.textColor
        // Stroke
//        var strokeColor: UIColor? = UIColor(hexString: style.attributedText.attributes(at: 0, effectiveRange: 0)..strokeColor)
//        if let aRed = strokeColor?.red, let aGreen = strokeColor?.green, let aBlue = strokeColor?.blue {
//            strokeColor = UIColor(red: aRed, green: aGreen, blue: aBlue, alpha: style.strokeAlpha)
//        }
//        lable.strokeColor = strokeColor
//        lable.strokeSize = style.strokeWidth
        let attributes = [NSAttributedStringKey.strokeWidth: strokeWidth,
                          NSAttributedStringKey.strokeColor: strokeColor,
                          NSAttributedStringKey.foregroundColor: UIColor.red] as [NSAttributedStringKey : Any]
        lable.attributedText = NSAttributedString(string: style.text, attributes: attributes)
        //Background
//        lable.transform = CGAffineTransform(rotationAngle: ((.pi * 0) / 180))
//        let frame: CGRect = lable.frame
//        let center: CGPoint = lable.center
//        frame.size.width = labelRect.size.width + (h * 2 * style.backgroundWidth) + (labelRect.size.width * 0.3)
//        frame.size.height = labelRect.size.height + (h * 2 * style.backgroundHeight) + (labelRect.size.height * 0.3)
//        lable.frame = frame
//        lable.center = center
//        lable.layer.cornerRadius = CGFloat((style.backgroundCorner * h))
//        var backgroundColor: UIColor? = UIColor(hexString: style.backgroundColor)
//        if let aRed = backgroundColor?.red, let aGreen = backgroundColor?.green, let aBlue = backgroundColor?.blue {
//            backgroundColor = UIColor(red: aRed, green: aGreen, blue: aBlue, alpha: style.backgroundAlpha)
//        }
        lable.frame = style.frame
        lable.backgroundColor = style.backgroundColor
        // Shadow
//        var shadowColor: UIColor? = UIColor(hexString: style.shadowColor)
//        if let aRed = shadowColor?.red, let aGreen = shadowColor?.green, let aBlue = shadowColor?.blue {
//            shadowColor = UIColor(red: aRed, green: aGreen, blue: aBlue, alpha: style.shadowAlpha)
//        }
//        lable.shadowColor =
        lable.layer.shadowOpacity = style.layer.shadowOpacity
        lable.layer.shadowOffset = style.layer.shadowOffset
        lable.layer.shadowColor = style.layer.shadowColor
//        lable.shadowOffset = CGSize(width: CGFloat((h / 4 * style.shadowX)), height: CGFloat((h / 4 * style.shadowY)))
        lable.superview?.layoutSubviews()
    }
    
    func loadTextPosition(_ style: UITextView, lable: UILabel) {
        lable.center = CGPoint(x: style.frame.origin.x, y: style.frame.origin.y)
//        lable.transform = CGAffineTransform(rotationAngle: ((.pi * style.angle) / 180))
    }
    
//    func color(fromHexString hexString: String) -> UIColor {
//        var rgbValue: UInt = 0
//        let scanner = Scanner(string: hexString)
//        scanner.scanHexInt32(rgbValue)
//        return UIColor(red: CGFloat((((rgbValue & 0xff0000) >> 16) / 255.0)), green: CGFloat((((rgbValue & 0xff00) >> 8) / 255.0)), blue: CGFloat(((rgbValue & 0xff) / 255.0)), alpha: 1.0)
//    }
    
    @objc func btnSelectColor(_ sender: UIButton) {
        setBarColor(UIColor(hexString: colors[sender.tag]))
    }
    
    func setBarColor(_ color: UIColor) {
        if (color.cgColor.components?.count)! > 3{
            sliderRed.value = Float(color.cgColor.components![0] * 255)
            sliderGreen.value = Float(color.cgColor.components![1] * 255)
            sliderBlue.value = Float(color.cgColor.components![2] * 255)
        }
        slideRedChanged(sliderRed)
        slideGreenChanged(sliderGreen)
        slideBlueChanged(sliderBlue)
    }
    
    func setBarAlpha(_ alpha: Float) {
        switch segment.selectedSegmentIndex {
        case TEXT, STROKE, BACKGROUND:
            sliderAlpha.value = alpha
            slideAlphaChanged(sliderAlpha)
            break
        case SHADOW:
            sliderShadowAlpha.value = alpha
            slideShadowAlphaChanged(sliderShadowAlpha)
            break
        default:
            break
        }
    }
    
    func setBackgroundWidth(_ width: Float, height: Float, corner: Float) {
        sliderWidthBackground.value = width
        sliderHeightBackground.value = height
        sliderCornerBackground.value = corner
        slideWidthBackgroundChanged(sliderWidthBackground)
        slideHeightBackgroundChanged(sliderHeightBackground)
        slideCornerBackgroundChanged(sliderCornerBackground)
    }
    
    func setBlur(_ blur: Float, x: Float, y: Float) {
        sliderShadowBlur.value = (style?.layer.shadowOpacity)!
        sliderShadowX.value = Float((style?.layer.shadowOffset.width)!)
        sliderShadowY.value = Float((style?.layer.shadowOffset.height)!)
        slideShadowBlurChanged(sliderShadowBlur)
        slideShadowXChanged(sliderShadowX)
        slideShadowYChanged(sliderShadowY)
    }
    
    func shadowChanged() {
        style?.layer.shadowOpacity = sliderShadowBlur.value
        style?.layer.shadowOffset.width = CGFloat(sliderShadowX.value)
        style?.layer.shadowOffset.height = CGFloat(sliderShadowY.value)
        loadText(style!, lable: text)
    }
    
    func backgroundChanged() {
        let point_x = style?.frame.origin.x
        let point_y = style?.frame.origin.y
        let width = style?.frame.size.width
        let height = style?.frame.size.height
        
        let diff_width = width! * CGFloat(sliderWidthBackground.value)
        let diff_height = height! * CGFloat(sliderHeightBackground.value)
        
        let frame = CGRect(x: point_x! - diff_width / 2, y: point_y! - diff_height / 2, width: width! + diff_width, height: height! + diff_height)
        
        style?.frame = frame
//        style.backgroundWidth = sliderWidthBackground.value
//        style.backgroundHeight = sliderHeightBackground.value
        style?.layer.cornerRadius = CGFloat(sliderCornerBackground.value)
//        style.backgroundCorner = sliderCornerBackground.value
        loadText(style!, lable: text)
    }
    
    func colorChanged() {
        switch segment.selectedSegmentIndex {
        case TEXT:
            style?.textColor = UIColor(red: CGFloat(sliderRed.value/255), green: CGFloat(sliderGreen.value/255), blue: CGFloat(sliderBlue.value/255), alpha: 1)
//            rgb(sliderRed.value, sliderGreen.value, sliderBlue.value).hexStringValue()
            break
        case STROKE:
            strokeColor = UIColor(red: CGFloat(sliderRed.value/255), green: CGFloat(sliderGreen.value/255), blue: CGFloat(sliderBlue.value/255), alpha: 1)
//            style.strokeColor = rgb(sliderRed.value, sliderGreen.value, sliderBlue.value).hexStringValue()
            strokeWidth = sliderWidthStroke.value
            break
        case BACKGROUND:
            style?.backgroundColor = UIColor(red: CGFloat(sliderRed.value/255), green: CGFloat(sliderGreen.value/255), blue: CGFloat(sliderBlue.value/255), alpha: 1)
//            style.backgroundColor = rgb(sliderRed.value, sliderGreen.value, sliderBlue.value).hexStringValue()
            break
        case SHADOW:
            style?.layer.shadowColor = UIColor(red: CGFloat(sliderRed.value/255), green: CGFloat(sliderGreen.value/255), blue: CGFloat(sliderBlue.value/255), alpha: 1).cgColor
//            style.shadowColor = rgb(sliderRed.value, sliderGreen.value, sliderBlue.value).hexStringValue()
            break
        default:
            break
        }
        loadText(style!, lable: text)
    }
    
    func alphaChanged() {
//        switch segment.selectedSegmentIndex {
//        case TEXT:
//            style.textAlpha = sliderAlpha.value
//        case STROKE:
//            style.strokeAlpha = sliderAlpha.value
//        case BACKGROUND:
//            style.backgroundAlpha = sliderAlpha.value
//        case SHADOW:
//            style.shadowAlpha = sliderShadowAlpha.value
//        default:
//            break
//        }
        loadText(style!, lable: text)
    }
    
    func loadStyle() {
        setBarColor(style!.textColor!)
//        setBarAlpha(style.textAlpha)
//        setWidthStroke(style.strokeWidth)
//        setBackgroundWidth(style.backgroundWidth, height: style.backgroundHeight, corner: style.backgroundCorner)
//        setBlur(style.shadowBlur, x: style.shadowX, y: style.shadowY)
    }

    @IBAction func segmentChange(_ segment: UISegmentedControl) {
        scrollView.setContentOffset(CGPoint(x: 0, y: -scrollView.contentInset.top), animated: false)
        viewStroke.isHidden = true
        viewBackground.isHidden = true
        viewShadow.isHidden = true
        switch segment.selectedSegmentIndex {
        case TEXT:
            setBarColor(style!.textColor!)
//            barColor = UIColor(hexString: style.textColor)
//            barAlpha = style.textAlpha
            break
        case STROKE:
            viewStroke.isHidden = false
            setBarColor(style!.textColor!)
//            barColor = UIColor(hexString: style.strokeColor)
//            if style.strokeAlpha == 0 && style.strokeWidth == 0 {
//                style.strokeAlpha = 0.5
//                style.strokeWidth = 3
//            }
//            barAlpha = style.strokeAlpha
//            widthStroke = style.strokeWidth
            break
        case BACKGROUND:
            viewBackground.isHidden = false
            setBarColor(style!.textColor!)
//            if style.backgroundAlpha == 0 {
//                style.backgroundAlpha = 0.2
//            }
//            barColor = UIColor(hexString: style.backgroundColor)
//            barAlpha = style.backgroundAlpha
//            setBackgroundWidth(style.backgroundWidth, height: style.backgroundHeight, corner: style.backgroundCorner)
            break
        case SHADOW:
            viewShadow.isHidden = false
            setBarColor(style!.textColor!)
//            if style.shadowAlpha == 0 && style.shadowBlur == 0 {
//                style.shadowAlpha = 0.5
//                style.shadowBlur = 0.36
//                style.shadowX = 0.2
//                style.shadowY = 0.2
//            }
//            barColor = UIColor(hexString: style.shadowColor)
//            barAlpha = style.shadowAlpha
//            setBlur(style.shadowBlur, x: style.shadowX, y: style.shadowY)
            break
        default:
            break
        }
    }
    
    // MARK: - Color sliders
    @IBAction func btnDownRedClicked(_ sender: Any) {
        sliderRed.value -= 1.0
        slideRedChanged(sliderRed)
    }
    
    @IBAction func btnUpRedClicked(_ sender: Any) {
        sliderRed.value += 1.0
        slideRedChanged(sliderRed)
    }
    
    @IBAction func slideRedChanged(_ slider: UISlider) {
        btnDownRed.isEnabled = sliderRed.value != 0
        btnUpRed.isEnabled = sliderRed.value != 255
        lbRed.text = "\(Int(sliderRed.value))"
        colorChanged()
    }
    
    @IBAction func btnDownGreenClicked(_ sender: Any) {
        sliderGreen.value -= 1.0
        slideGreenChanged(sliderGreen)
    }
    
    @IBAction func btnUpGreenClicked(_ sender: Any) {
        sliderGreen.value += 1.0
        slideGreenChanged(sliderGreen)
    }
    
    @IBAction func slideGreenChanged(_ slider: UISlider) {
        btnDownGreen.isEnabled = sliderGreen.value != 0
        btnUpGreen.isEnabled = sliderGreen.value != 255
        lbGreen.text = "\(Int(sliderGreen.value))"
        colorChanged()
    }
    
    @IBAction func btnDownBlueClicked(_ sender: Any) {
        sliderBlue.value -= 1.0
        slideBlueChanged(sliderBlue)
    }
    
    @IBAction func btnUpBlueClicked(_ sender: Any) {
        sliderBlue.value += 1.0
        slideBlueChanged(sliderBlue)
    }
    
    @IBAction func slideBlueChanged(_ slider: UISlider) {
        btnDownBlue.isEnabled = sliderBlue.value != 0
        btnUpBlue.isEnabled = sliderBlue.value != 255
        lbBlue.text = "\(Int(sliderBlue.value))"
        colorChanged()
    }
    
    @IBAction func btnDownAlphaClicked(_ sender: Any) {
        sliderAlpha.value -= 0.01
        slideAlphaChanged(sliderAlpha)
    }
    
    @IBAction func btnUpAlphaClicked(_ sender: Any) {
        sliderAlpha.value += 0.01
        slideAlphaChanged(sliderAlpha)
    }
    
    @IBAction func slideAlphaChanged(_ slider: UISlider) {
        btnDownAlpha.isEnabled = sliderAlpha.value != 0
        btnUpAlpha.isEnabled = sliderAlpha.value != 1
        lbAlpha.text = String(format: "%.2f", sliderAlpha.value)
        alphaChanged()
    }
    
    @IBAction func btnDownWidthTextClicked(_ sender: Any) {
        sliderWidthStroke.value -= 1.0
        slideWidthTextChanged(sliderWidthStroke)
    }
    
    @IBAction func btnUpWidthTextClicked(_ sender: Any) {
        sliderWidthStroke.value += 1.0
        slideWidthTextChanged(sliderWidthStroke)
    }
    
    @IBAction func slideWidthTextChanged(_ slider: UISlider) {
        btnDownWidthStroke.isEnabled = sliderWidthStroke.value != 0
        btnUpWidthStroke.isEnabled = sliderWidthStroke.value != 8
        lbWidthStroke.text = "\(Int(sliderWidthStroke.value))"
        colorChanged()
    }
    
    @IBAction func btnDownWidthBackgroundClicked(_ sender: Any) {
        sliderWidthBackground.value -= 0.01
        slideWidthBackgroundChanged(sliderWidthBackground)
    }
    
    @IBAction func btnUpWidthBackgroundClicked(_ sender: Any) {
        sliderWidthBackground.value += 0.01
        slideWidthBackgroundChanged(sliderWidthBackground)
    }
    
    @IBAction func slideWidthBackgroundChanged(_ slider: UISlider) {
        btnDownWidthBackground.isEnabled = sliderWidthBackground.value != 0
        btnUpWidthBackground.isEnabled = sliderWidthBackground.value != 3
        lbWidthBackground.text = String(format: "%.2f", sliderWidthBackground.value)
        backgroundChanged()
    }
    
    @IBAction func btnDownHeightBackgroundClicked(_ sender: Any) {
        sliderHeightBackground.value -= 0.01
        slideHeightBackgroundChanged(sliderHeightBackground)
    }
    
    @IBAction func btnUpHeightBackgroundClicked(_ sender: Any) {
        sliderHeightBackground.value += 0.01
        slideHeightBackgroundChanged(sliderHeightBackground)
    }

    @IBAction func slideHeightBackgroundChanged(_ slider: UISlider) {
        btnDownHeightBackground.isEnabled = sliderHeightBackground.value != 0
        btnUpHeightBackground.isEnabled = sliderHeightBackground.value != 2
        lbHeightBackground.text = String(format: "%.2f", sliderHeightBackground.value)
        backgroundChanged()
    }
    
    @IBAction func btnDownCornerBackgroundClicked(_ sender: Any) {
        sliderCornerBackground.value -= 0.01
        slideCornerBackgroundChanged(sliderCornerBackground)
    }
    
    @IBAction func btnUpCornerBackgroundClicked(_ sender: Any) {
        sliderCornerBackground.value += 0.01
        slideCornerBackgroundChanged(sliderCornerBackground)
    }
    
    @IBAction func slideCornerBackgroundChanged(_ slider: UISlider) {
        btnDownCornerBackground.isEnabled = sliderCornerBackground.value != 0
        btnUpCornerBackground.isEnabled = sliderCornerBackground.value != 0.5
        lbCornerBackground.text = String(format: "%.2f", sliderCornerBackground.value)
        backgroundChanged()
    }
    
    @IBAction func btnDownShadowAlphaClicked(_ sender: Any) {
        sliderShadowAlpha.value -= 0.01
        slideShadowAlphaChanged(sliderShadowAlpha)
    }
    
    @IBAction func btnUpShadowAlphaClicked(_ sender: Any) {
        sliderShadowAlpha.value += 0.01
        slideShadowAlphaChanged(sliderShadowAlpha)
    }
    
    @IBAction func slideShadowAlphaChanged(_ slider: UISlider) {
        btnDownShadowAlpha.isEnabled = sliderShadowAlpha.value != 0
        btnUpShadowAlpha.isEnabled = sliderShadowAlpha.value != 1
        lbShadowAlpha.text = String(format: "%.2f", sliderShadowAlpha.value)
        alphaChanged()
    }
    
    @IBAction func btnDownShadowBlurClicked(_ sender: Any) {
        sliderShadowBlur.value -= 0.01
        slideShadowBlurChanged(sliderShadowBlur)
    }
    
    @IBAction func btnUpShadowBlurClicked(_ sender: Any) {
        sliderShadowBlur.value += 0.01
        slideShadowBlurChanged(sliderShadowBlur)
    }
    
    @IBAction func slideShadowBlurChanged(_ slider: UISlider) {
        btnDownShadowBlur.isEnabled = sliderShadowBlur.value != 0
        btnUpShadowBlur.isEnabled = sliderShadowBlur.value != 1
        lbShadowBlur.text = String(format: "%.2f", sliderShadowBlur.value)
        shadowChanged()
    }
    
    @IBAction func btnDownShadowXClicked(_ sender: Any) {
        sliderShadowX.value -= 0.01
        slideShadowXChanged(sliderShadowX)
    }
    
    @IBAction func btnUpShadowXClicked(_ sender: Any) {
        sliderShadowX.value += 0.01
        slideShadowXChanged(sliderShadowX)
    }
    
    @IBAction func slideShadowXChanged(_ slider: UISlider) {
        btnDownShadowX.isEnabled = sliderShadowX.value != 0
        btnUpShadowX.isEnabled = sliderShadowX.value != 1
        lbShadowX.text = String(format: "%.2f", sliderShadowX.value)
        shadowChanged()
    }
    
    @IBAction func btnDownShadowYClicked(_ sender: Any) {
        sliderShadowY.value -= 0.01
        slideShadowYChanged(sliderShadowY)
    }
    
    @IBAction func btnUpShadowYClicked(_ sender: Any) {
        sliderShadowY.value += 0.01
        slideShadowYChanged(sliderShadowY)
    }
    
    @IBAction func slideShadowYChanged(_ slider: UISlider) {
        btnDownShadowY.isEnabled = sliderShadowY.value != 0
        btnUpShadowY.isEnabled = sliderShadowY.value != 1
        lbShadowY.text = String(format: "%.2f", sliderShadowY.value)
        shadowChanged()
    }
    
    @IBAction func btnDoneClicked(_ sender: Any) {
        dismiss(animated: true) {() -> Void in }
    }
    
    @IBAction func btnCancelClicked(_ sender: Any) {
        dismiss(animated: true) {() -> Void in }
    }
}
