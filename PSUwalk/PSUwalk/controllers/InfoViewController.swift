//
//  InfoViewController.swift
//  PSUwalk
//
//  Created by Junwoo Seo on 10/22/18.
//  Copyright © 2018 Junwoo Seo. All rights reserved.
//

import UIKit
import MapKit


protocol InfoDelegate {
    func InfoDisplay(indexPath: IndexPath)
    func StoreImages(changedImageIndexPath: [IndexPath:UIImage], editedText: [String:String], changedHeight: [String:CGFloat])
}



class InfoViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate, UIScrollViewDelegate{
    
    
    var changedImageIndexPath = [IndexPath: UIImage]()
    
//    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var InsideScollView: UIView!
    
//    @IBOutlet weak var editTextView: UITextView!
    
    @IBAction func EditButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        delegate?.StoreImages(changedImageIndexPath: changedImageIndexPath, editedText: savedTextView, changedHeight: changedHeight)
    }
    
    @IBAction func PinButtonPressed(_ sender: Any) {
        delegate?.InfoDisplay(indexPath: indexPathForSelectedBuilding)
    }
    
    @IBAction func openCameraButtonPressed(_ sender: Any) {
        let alertView = UIAlertController(title: "Change Image", message: nil, preferredStyle: .actionSheet)
        
        let CameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true)
            }
            else{
                print("no camera")
            }
        }
        
        let LibaryAction = UIAlertAction(title: "PhotoLibrary", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true)
            }
            else{
                print("no photoLibrariy")
            }
            
        }
        
        alertView.addAction(CameraAction)
        alertView.addAction(LibaryAction)
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertView.addAction(actionCancel)
        self.present(alertView, animated: true, completion: nil)
    }
//    var editTextView : UITextView
    var editTextView = UITextView(frame: CGRect(x: 16.0, y: 504.0, width: UIScreen.main.bounds.width * 0.9, height: 100.0))
    var originalHeightOfTextView = CGFloat()
    var changedHeight : [String:CGFloat] = [:]
    var savedTextView : [String:String] = [:]
    var saveTextView = UITextView()
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noPhotoAble: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var coordinateLabel: UILabel!
    @IBOutlet weak var buildingImage: UIImageView!
    var indexPathForSelectedBuilding = IndexPath()
    var delegate : InfoDelegate?
    let mapModel = MapModel.sharedInstance
//    var currentBuildingCoordinate = CLLocationCoordinate2D()
//    var currentBuildingName = String()
//    var currentBuildingImageName = String()
    
    
    override func viewDidLoad() {
//        originalHeightOfTextView = (editTextView.font?.pointSize)!
        let buildingIndex = mapModel.getRowDetail(section: indexPathForSelectedBuilding.section, row: indexPathForSelectedBuilding.row)
        let buildingInfo = mapModel.Building[buildingIndex]
        self.editTextView.delegate = self
        titleLabel.text = String(buildingInfo.name)
        titleLabel.adjustsFontSizeToFitWidth = true
        yearLabel.text = String("Year Constructed: \(buildingInfo.year_constructed)")
        coordinateLabel.text = String("latitude: \(buildingInfo.latitude), longtidue: \(buildingInfo.longitude)")
        coordinateLabel.adjustsFontSizeToFitWidth = true
        self.definesPresentationContext = false
        
        editTextView.font = UIFont(name: "Courier", size: 20.0)
        editTextView.returnKeyType = .done
        editTextView.delegate = self
        editTextView.autocorrectionType = .no
//        editTextView.keyboardAppearance = .dark
//        print(InsideScollView.frame.size)
        editTextView.isScrollEnabled = false
        InsideScollView.addSubview(editTextView)
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true
//        scrollView.frame.size = InsideScollView.frame.size
//        scrollView.contentSize = InsideScollView.frame.size
        scrollView.addSubview(InsideScollView)


        view.addSubview(scrollView)

        if changedImageIndexPath[indexPathForSelectedBuilding] == nil{
            if buildingInfo.photo == ""{
                buildingImage.isHidden = true
            }
            else{
                noPhotoAble.isHidden = true
                let image = UIImage(named: buildingInfo.photo!)
                buildingImage.image = image
                
            }
        }
        else{
            noPhotoAble.isHidden = true
            buildingImage.image = changedImageIndexPath[indexPathForSelectedBuilding]
        }

        if savedTextView[titleLabel.text!] != nil{
            
            let limit = UIScreen.main.bounds.height
            let ypoint = editTextView.frame.origin.y + editTextView.frame.height
            let difference = ypoint - limit
            InsideScollView.frame.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + difference)
            editTextView.text = savedTextView[titleLabel.text!]
            var frame = editTextView.frame

            frame.size.height = editTextView.sizeThatFits(editTextView.bounds.size).height

            
            editTextView.frame = frame
            InsideScollView.addSubview(editTextView)
            scrollView.contentSize = InsideScollView.frame.size
            scrollView.addSubview(InsideScollView)
            self.view.addSubview(scrollView)
        }
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if changedHeight[titleLabel.text!] != nil{
            var frame = editTextView.frame

            frame.size.height = editTextView.sizeThatFits(editTextView.bounds.size).height

            editTextView.frame = frame
            editTextView.isUserInteractionEnabled = true
            InsideScollView.addSubview(editTextView)
            InsideScollView.frame.size = CGSize(width: scrollView.frame.width, height: changedHeight[titleLabel.text!]!)
            scrollView.contentSize = InsideScollView.frame.size
            scrollView.addSubview(InsideScollView)
            self.view.addSubview(scrollView)
        }
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.contentSize = InsideScollView.frame.size

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else{
            return
        }
        changedImageIndexPath[indexPathForSelectedBuilding] = image
        buildingImage.image = image
        if noPhotoAble.isHidden == false{
            buildingImage.isHidden = false
            noPhotoAble.isHidden = true
        }
        
    }
    
//    override func setEditing(_ editing: Bool, animated: Bool) {
//        super.setEditing(editing, animated: animated)
//        if !editing {
//            editTextView.resignFirstResponder()
//        }
//    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        savedTextView[titleLabel.text!] = editTextView.text
        var frame = editTextView.frame
 
        frame.size.height = editTextView.sizeThatFits(editTextView.bounds.size).height

        
        editTextView.frame = frame
        editTextView.isUserInteractionEnabled = true
        
        
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
//        let originalHeight = InsideScollView.frame.height
        let fixedWidth = editTextView.frame.size.width
        editTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = editTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = editTextView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        editTextView.frame = newFrame
        let yPoint = editTextView.frame.origin.y + editTextView.frame.height
        let limit = scrollView.frame.height
        let difference = yPoint - limit
        if (yPoint > limit){
            InsideScollView.frame.size = CGSize(width: InsideScollView.frame.width, height: UIScreen.main.bounds.height + difference)
            scrollView.contentSize = InsideScollView.frame.size
            InsideScollView.addSubview(editTextView)
            scrollView.addSubview(InsideScollView)
            changedHeight[titleLabel.text!] = (UIScreen.main.bounds.height + difference)
        }
        savedTextView[titleLabel.text!] = editTextView.text
        
//        editTextView.frame = newFrame
        
//        var newViewFrame = InsideScollView.frame
//        newViewFrame.size = CGSize(width: InsideScollView.frame.width, height: originalHeight + editTextView.frame.height)
//        InsideScollView.frame = newViewFrame
    }
    
    
    
    
    @objc func keyboardWillShow(notification:Notification){

        let userInfo = notification.userInfo!
        let keyboardSize = userInfo[UIKeyboardFrameBeginUserInfoKey] as? CGRect
//        let yPoint = editTextView.frame.origin.y + editTextView.frame.height
//        let totalChangeHeight = UIScreen.main.bounds.height - yPoint
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y = -((keyboardSize?.height)!)
//            print(self.view.frame.origin.y)
            
        }
        else{
        }
    }
    @objc func keyboardWillHide(notification:Notification){
//        editTextView.contentInset = UIEdgeInsets.zero
//        let userInfo = notification.userInfo!
//        let keyboardSize = userInfo[UIKeyboardFrameBeginUserInfoKey] as? CGRect
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y = 0
//                +(keyboardSize?.height)!
//            scrollView.contentSize = InsideScollView.frame.size
            editTextView.resignFirstResponder()

        }
        else{
        }
    
    }

    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
//        editTextView.becomeFirstResponder()
        return true
    }
    
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        editTextView.keyboardAppearance = .default
//    }
    

    
//    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
//        editTextView.becomeFirstResponder()
//        if editTextView.isFirstResponder{
//            print("first")
//        }
//        return true
//    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n"){
            textView.resignFirstResponder()
        }
        return true
    }
    

//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        switch segue.identifier {
//        case "editText":
//            let navController = segue.destination as! CategoryTableViewController
//            
//            
//        default:
//            assert(false, "Unhandled Segue")
//        }
//    }

}
