//
//  QuestionsVC.swift
//  QuizAppHarsh
//
//  Created by My Mac Mini on 30/01/24.
//

import UIKit

class QuestionsVC: UIViewController {
    
    //MARK: -  @IBOutlet
    
    @IBOutlet weak var quesNumber: UILabel!
    
    @IBOutlet weak var collvQuestions: UICollectionView!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var btnPrevious: UIButton!
    
    
    
    //MARK: -  Properties
    private var viewModel = QueViewModel()
    
    var counterCorrectAnswer = 0
    var totalQuestions = 0
    var skipedQuestions = 0
    
    var activityView: UIActivityIndicatorView?
     
    //MARK: -  ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showActivityIndicator()
        
        configuration()
        
        btnSubmit.isHidden = true
        
       
    }
    
    
    //MARK: -  Buttons Actions
    @IBAction func btnPrevious(_ sender: Any) {
        collvQuestions.scrollToPreviousItem()
    }
    
    @IBAction func btnNext(_ sender: Any) {
        collvQuestions.scrollToNextItem()
    }
    
    @IBAction func btnSubmit (_ sender: Any) {
        //print("self.viewModel.arrQuestions",self.viewModel.arrQuestions)
        
        counterCorrectAnswer = 0
        for i in 0...viewModel.arrQuestions.count - 1{
            if self.viewModel.arrQuestions[i].userSelectedAnswer == self.viewModel.arrQuestions[i].correct{
                counterCorrectAnswer += 1
            }
        }
        
        skipedQuestions = 0
        for i in 0...viewModel.arrQuestions.count - 1 {
            
            if self.viewModel.arrQuestions[i].userSelectedAnswer == nil{
                skipedQuestions += 1
            }
        }
        
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: Constant.shared.VC_RESULT_VC) as! ResultVC
        nextVC.totalQuestions = self.viewModel.arrQuestions.count
        nextVC.skipedQuestions = skipedQuestions
        nextVC.counterCorrectAnswer = self.counterCorrectAnswer
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // This is calling here because we don't need anywhere else. Otherwise, it should be a global code with access from everywhere for reusability.
    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
    }
    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
        }
    }
    
}

//MARK: -  API Call Functions
extension QuestionsVC{
    
    // this is work like viewDidLoad
    func configuration(){
        
        collvQuestions.dataSource = self
        collvQuestions.delegate = self
         
        initViewModel()
        observeEvent()
    }
    
    func initViewModel(){
        viewModel.fetchQuestionsApi()
    }
    
    func observeEvent(){
        viewModel.eventHandler = { [weak self] event in
            guard let self else {return}
            
            switch event {
            case .loading:
                print("data loading")
                 
            case .stopLoading:
                print("loading finished")
                DispatchQueue.main.async {
                    self.hideActivityIndicator()
                }
            case .dataLoaded:
                print(viewModel.arrQuestions)
                DispatchQueue.main.async {
                    self.collvQuestions.reloadData()
                }
                
            case .network(let error):
                print(error ?? "Error at ObserEvnt")
                
            }
            
        }
    }
}



//MARK: -  UICollectionViewDelegate, UICollectionViewDataSource
extension QuestionsVC : UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.arrQuestions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //print("viewModel.arrQuestions",viewModel.arrQuestions)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.shared.CELL_QUESTION_CVC, for: indexPath) as? QuestionCVC else {return UICollectionViewCell()}
        
        cell.lblQues.text = viewModel.arrQuestions[indexPath.row].question
        cell.currentIndex = String(indexPath.row)
        self.quesNumber.text = "\(indexPath.row + 1) of \(Constant.shared.totalQuestionToBeAsked)"
        
        cell.queModel = viewModel.arrQuestions[indexPath.row]
        cell.configureArray()
        
        cell.strCorrectAns = viewModel.arrQuestions[indexPath.row].correct
        
        
        cell.userSelectedAns = { [weak self] (userAnswer) in
            self?.viewModel.arrQuestions[indexPath.row].userSelectedAnswer = userAnswer
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if let indexpath = self.collvQuestions.indexPathsForVisibleItems.last?.row{
            
            if indexpath >= (viewModel.arrQuestions.count - 1){
                btnNext.isHidden = true
                btnSubmit.isHidden = false
            }else{
                btnNext.isHidden = false
                btnSubmit.isHidden = true
            }
            
            if indexpath == 0{
                btnPrevious.isHidden = true
            }else{
                btnPrevious.isHidden = false
            }
        }
        
        
    }
    
}
extension UICollectionView {
    
    func scrollToNextItem() {
        let contentOffset = CGFloat(floor(self.contentOffset.x +
                                          self.bounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
        
    }
    
    func scrollToPreviousItem() {
        let contentOffset = CGFloat(floor(self.contentOffset.x - self.bounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
    }
    
    func moveToFrame(contentOffset : CGFloat) {
        self.setContentOffset(CGPoint(x: contentOffset, y: self.contentOffset.y), animated: true)
    }
}

