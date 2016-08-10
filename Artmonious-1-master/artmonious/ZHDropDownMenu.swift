
import UIKit

public protocol ZHDropDownMenuDelegate:class{
    func dropDownMenu(menu:ZHDropDownMenu!, didInput text:String!)
    func dropDownMenu(menu:ZHDropDownMenu!, didChoose index:Int)
}

@IBDesignable public class ZHDropDownMenu: UIView , UITableViewDataSource ,UITableViewDelegate,UITextFieldDelegate{
    
    public weak var delegate:ZHDropDownMenuDelegate?
    
    public var inputClosure: ((ZHDropDownMenu , text: String) ->Void )?
    
    public var chooseClosure: ((ZHDropDownMenu , index: Int) ->Void )?
    
    public var options:Array<String> = [] //
    
    @IBInspectable public var defaultValue:String? { //placeholder!!
        didSet {
            contentTextField.text = defaultValue
        }
    }
    
    @IBInspectable public var textColor:UIColor?{
        didSet {
            contentTextField.textColor = textColor
        }
    }
    
    public var font:UIFont?{
        didSet {
            contentTextField.font = font
        }
    }
    
    public var showBorder:Bool = true {
        didSet {
            if showBorder {
                layer.borderColor = UIColor.lightGrayColor().CGColor
                layer.borderWidth = 0.5
                layer.masksToBounds = true
                layer.cornerRadius = 2.5
            }else {
                layer.borderColor = UIColor.clearColor().CGColor
                layer.masksToBounds = false
                layer.cornerRadius = 0
                layer.borderWidth = 0
            }
        }
    }
    
    public lazy var rowHeight:CGFloat = {
        return self.frame.size.height
    }()
    
    public lazy var optionsList:UITableView = {
        let table = UITableView(frame: CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, 0), style: .Plain)
        table.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        table.dataSource = self
        table.delegate = self
        table.layer.borderColor = UIColor.lightGrayColor().CGColor
        table.layer.borderWidth = 0.5
        self.superview?.addSubview(table)
        return table
    }()
    
    @IBInspectable public var editable:Bool = true {
        didSet {
            contentTextField.enabled = editable
        }
    }
    
    @IBInspectable public var placeholder:String? {
        didSet {
            contentTextField.placeholder = placeholder
        }
    }
    
    @IBInspectable public var buttonImage:UIImage?{
        didSet {
            pullDownButton.setImage(buttonImage, forState: .Normal)
        }
    }
    
    var isShown:Bool = false
    
    private var contentTextField:UITextField!
    
    private var pullDownButton:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp() {
        contentTextField = UITextField(frame: CGRectZero)
        contentTextField.delegate = self
        addSubview(contentTextField)
        
        pullDownButton = UIButton(type: .Custom)
        pullDownButton.addTarget(self, action: #selector(ZHDropDownMenu.showOrHide), forControlEvents: .TouchUpInside)
        addSubview(pullDownButton)
        
        self.showBorder = true
        self.textColor = UIColor.darkGrayColor()
        self.font = UIFont.systemFontOfSize(16)
    }
    
    func showOrHide() {
        if isShown {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
//                self.pullDownButton.transform = CGAffineTransformMakeRotation(CGFloat(M_PI*2))
                self.optionsList.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height-0.5, self.frame.size.width, 0)
                }) { (finished) -> Void in
                    if finished{
                        self.pullDownButton.transform = CGAffineTransformMakeRotation(0.0)
                        self.isShown = false
                    }
            }
        } else {
            contentTextField.resignFirstResponder()
            optionsList.reloadData()
            UIView.animateWithDuration(0.3, animations: { () -> Void in
//                self.pullDownButton.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
                self.optionsList.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height-0.5, self.frame.size.width, CGFloat(self.options.count) * self.rowHeight)
                }) { (finished) -> Void in
                    if finished{
                        self.isShown = true
                    }
            }
        }
        
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        contentTextField.frame = CGRect(x: 15, y: 5, width: self.frame.size.width - 50, height: self.frame.size.height - 10)
        pullDownButton.frame = CGRect(x: self.frame.size.width - 35, y: 5, width: 30, height: 30)
    }
    
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text {
            self.delegate?.dropDownMenu(self, didInput: text)
            self.inputClosure?(self, text: text)
        }
        return true
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "")
               
        cell.textLabel?.text = options[indexPath.row]
        cell.textLabel?.font = font
        cell.textLabel?.textColor = textColor
        return cell
    }
    
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return rowHeight
    }
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        contentTextField.text = options[indexPath.row]
        self.delegate?.dropDownMenu(self, didChoose:indexPath.row)
        self.chooseClosure?(self, index: indexPath.row)
//        showOrHide()
    }

}
