//
//  QuizForAlgoViewController.swift
//  AlgorithmStudy
//
//  Created by Junwoo Seo on 12/4/18.
//  Copyright © 2018 Junwoo Seo. All rights reserved.
//



import UIKit



class QuizForAlgoViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate{
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isInt == true || (textField.text?.isEmpty)!{

            textField.resignFirstResponder()
            
        }
        else{
            textField.becomeFirstResponder()
        }
    }
    @IBOutlet weak var SearchFirstBox: UIView!
    @IBOutlet weak var searchSecondBox: UIView!
    @IBOutlet weak var searchThridBox: UIView!
    @IBOutlet weak var searchforthbox: UIView!
    @IBOutlet weak var searchFifthBox: UIView!
    @IBOutlet weak var searchSixthBox: UIView!
    @IBOutlet weak var searchSeventhBox: UIView!
    @IBOutlet weak var searchEightBox: UIView!
    @IBOutlet weak var searchNinthBox: UIView!
    @IBOutlet weak var searchRootView: UIView!
    var searchEachNext = [Int:[UIView]]()
    var searchOrder = [UIView]()
    
    
    
    @IBOutlet weak var hashRootView: UIView!
    @IBOutlet weak var hashFirstbox: UIView!
    @IBOutlet weak var hashSecondBox: UIView!
    @IBOutlet weak var hashThridbox: UIView!
    @IBOutlet weak var hashForthbox: UIView!
    @IBOutlet weak var hashFifhbox: UIView!
    
    
    @IBOutlet weak var treeFirstBox: UIView!
    @IBOutlet weak var treeSecondBox: UIView!
    @IBOutlet weak var treeThirdBox: UIView!
    @IBOutlet weak var treeForthBox: UIView!
    @IBOutlet weak var treeFifthBox: UIView!
    @IBOutlet weak var treeSixthBox: UIView!
    @IBOutlet weak var treeSeventhBox: UIView!
    @IBOutlet weak var treeRootView: UIView!
    @IBOutlet weak var treeTextfield: UITextField!
    
    
    @IBOutlet weak var linkedFirstBox: UIView!
    @IBOutlet weak var LinkedSecondBox: UIView!
    @IBOutlet weak var linkedThirdBox: UIView!
    @IBOutlet weak var linkedForthBox: UIView!
    @IBOutlet weak var LinkedRootView: UIView!
    
    
    @IBOutlet weak var sortingFirstbox: UIView!
    @IBOutlet weak var sortingSecondBox: UIView!
    @IBOutlet weak var sortingThridBox: UIView!
    @IBOutlet weak var sortingForthBox: UIView!
    @IBOutlet weak var sortingFifthBox: UIView!
    @IBOutlet weak var sortingRootview: UIView!
    
    @objc func handleTap(_ sender:UITapGestureRecognizer) {
        if sender.view?.backgroundColor == originalColor{
            sender.view?.backgroundColor = UIColor.gray
        }
        else{
            sender.view?.backgroundColor = originalColor
        }
    }
    @objc func handleTapHash(_ sender: UIGestureRecognizer){
        if sender.view?.backgroundColor == originalColor{
            sender.view?.backgroundColor = UIColor.gray
        }
        else{
            sender.view?.backgroundColor = originalColor
        }
    }
    
    @IBAction func solveButton(_ sender: UIButton) {
        if currentIndexPath.section == 0{
            let candidate = ["Selection","Merge","Insertion","Bubble"]

//            print(randomGenerated)
//            print(candidate[randomGenerated])
            if randomGenerated == 0{
                selectionSort()

            }
            else if randomGenerated == 1{
                mergeSort()

            }
            else if randomGenerated == 2{
                insertionSort()

            }
            else if randomGenerated == 3{
                bubbleSort()
            }
        }
        
    }
    var treeAnswers = Int()
    var linkedAnswers = [Int]()
    var linkedRandomGenerated = Int()
    var originalColor = UIColor()
    var randomGenerated = Int()
    var animationView = [UIView]()
    @IBOutlet weak var scrollView: UIScrollView!
    var currentIndexPath = IndexPath()
    var numberOfProblems = Int()
    let algoModel = AlgorithmModel()
    let quizModel = QuizModel()
    var label = UILabel()
    var questionBox = UISegmentedControl()
    var problemOrigin = CGPoint()
    var problemSize = CGSize()
    var whatWereChoosed = [UISegmentedControl]()
    var answers = [String]()
    var originalPoint = [CGPoint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfProblems = 1
        scrollView.delegate = self
//        treeTextfield.delegate = self as UITextFieldDelegate
//        treeTextfield.keyboardType = .numberPad
        scrollView.isScrollEnabled = true
        let items = ["O(n)","O(n^2)","O(1)","O(nlog(n))"]
        questionBox = UISegmentedControl(items: items)
        problemOrigin = scrollView.frame.origin
        problemOrigin.x = scrollView.frame.width * 0.05
        problemOrigin.y = problemOrigin.y + 1.0
        problemSize = CGSize(width: scrollView.frame.width * 0.9, height: 50.0)
        sortingRootview.isHidden = true
        LinkedRootView.isHidden = true
        treeRootView.isHidden = true
        hashRootView.isHidden = true
        searchRootView.isHidden = true
        originalColor = linkedForthBox.backgroundColor!

        if currentIndexPath.section == 0{
            sortingProblems()
            sortingRootview.isHidden = false
            animationView = [sortingFirstbox,sortingSecondBox,sortingThridBox,sortingForthBox,sortingFifthBox]
            heightAdjustment()
            for box in animationView{
                originalPoint.append(box.frame.origin)
            }
        }
        else if currentIndexPath.section == 1{
            linkedRandomGenerated = Int(arc4random_uniform(4))
            let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            let tap3 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            let tap4 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            tap1.numberOfTapsRequired = 1
            tap2.numberOfTapsRequired = 1
            tap3.numberOfTapsRequired = 1
            tap4.numberOfTapsRequired = 1
            LinkedRootView.isHidden = false
//            originalColor = linkedForthBox.backgroundColor!
            animationView = [linkedFirstBox,LinkedSecondBox,linkedThirdBox,linkedForthBox]
            linkedFirstBox.addGestureRecognizer(tap1)
            linkedFirstBox.isUserInteractionEnabled = true
            
            LinkedSecondBox.addGestureRecognizer(tap2)
            LinkedSecondBox.isUserInteractionEnabled = true

            linkedThirdBox.addGestureRecognizer(tap3)
            linkedThirdBox.isUserInteractionEnabled = true

            linkedForthBox.addGestureRecognizer(tap4)
            linkedForthBox.isUserInteractionEnabled = true

//            print("hello \(animationView.count)")
            LinkedQuiz()

        }
        else if currentIndexPath.section == 2{
            linkedRandomGenerated = Int(arc4random_uniform(7))
            while linkedRandomGenerated == 3{
                linkedRandomGenerated = Int(arc4random_uniform(7))
            }
            treeRootView.isHidden = false
            animationView = [treeFirstBox,treeSecondBox,treeThirdBox,treeForthBox,treeFifthBox,treeSixthBox,treeSeventhBox]
            var tap10 = UITapGestureRecognizer()
            for box in animationView{
                tap10 = UITapGestureRecognizer(target: self, action: #selector(self.handleTapHash(_:)))
                box.addGestureRecognizer(tap10)
            }
            addDoneButtonOnKeyboard()
            TreeProblem()
            

        }
        else if currentIndexPath.section == 3{
            linkedRandomGenerated = Int(arc4random_uniform(100))
            hashRootView.isHidden = false
            let tap10 = UITapGestureRecognizer(target: self, action: #selector(self.handleTapHash(_:)))
            let tap21 = UITapGestureRecognizer(target: self, action: #selector(self.handleTapHash(_:)))
            let tap31 = UITapGestureRecognizer(target: self, action: #selector(self.handleTapHash(_:)))
            let tap41 = UITapGestureRecognizer(target: self, action: #selector(self.handleTapHash(_:)))
            let tap51 = UITapGestureRecognizer(target: self, action: #selector(self.handleTapHash(_:)))
            animationView = [hashFirstbox,hashSecondBox,hashThridbox,hashForthbox,hashFifhbox]

            tap10.numberOfTapsRequired = 1
            tap21.numberOfTapsRequired = 1
            tap31.numberOfTapsRequired = 1
            tap41.numberOfTapsRequired = 1
            tap51.numberOfTapsRequired = 1
            
            hashFirstbox.addGestureRecognizer(tap10)
            hashSecondBox.addGestureRecognizer(tap21)
            hashThridbox.addGestureRecognizer(tap31)
            hashForthbox.addGestureRecognizer(tap41)
            hashFifhbox.addGestureRecognizer(tap51)
            HashQuiz()
            
        }
        else if currentIndexPath.section == 4{
            linkedRandomGenerated = Int(arc4random_uniform(9))

            searchRootView.isHidden = false

            animationView = [SearchFirstBox,searchSecondBox,searchThridBox,searchforthbox,searchFifthBox,searchSixthBox,searchSeventhBox,searchEightBox,searchNinthBox]
            searchEachNext = [0:[searchSecondBox,searchforthbox],1:[searchFifthBox],2:[searchSecondBox],3:[searchSeventhBox],4:[searchforthbox,searchSixthBox],5:[searchThridBox],6:[searchEightBox],7:[searchNinthBox],8:[searchSixthBox]]
            for box in animationView{
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTapHash(_:)))

                box.addGestureRecognizer(tap)
            }
            searchQuiz()
        }

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    @objc func keyboardWillShow(notification:Notification){
        //        self.CustomizeTextField.becomeFirstResponder()
        let userInfo = notification.userInfo!
        let keyboardSize = userInfo[UIKeyboardFrameBeginUserInfoKey] as? CGRect
        //        let yPoint = editTextView.frame.origin.y + editTextView.frame.height
        //        let totalChangeHeight = UIScreen.main.bounds.height - yPoint
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y = -((keyboardSize?.height)!) - treeTextfield.frame.height
            
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
        }
        else{
        }
        
    }

    override func didReceiveMemoryWarning() {
        
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
