//
//  ListViewController.swift
//  UBikeClone
//
//  Created by 羅群瀝 on 2023/10/29.
//

import UIKit

class menuList: UIViewController {
    
    init (model: Int){
        super.init(nibName: nil, bundle: nil)
        self.comeFrom = model
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var comeFrom: Int?
    
    private let safeArea = UIView()
    
    private let UbikeLogo: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "Ubike")
        return imageView
    }()
    
    private let listBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "xmark"), for: .normal)
        btn.tintColor = UIColor(named: "Ubike")
        return btn
    }()
    
    private let headerLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    private let btnBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Ubike")
        return view
    }()
    
    private let instructions: UIButton = {
        let btn = UIButton()
        btn.setTitle("使用說明", for: .normal)

        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)

//        btn.font = UIFont.boldSystemFont(ofSize: 18)
        return btn
    }()
    private let charge: UIButton = {
        let btn = UIButton()
        btn.setTitle("收費方式", for: .normal)

        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)

//        btn.text = "收費方式"
//        btn.font = UIFont.boldSystemFont(ofSize: 18)
//        btn.textColor = .white
        return btn
    }()
    private let stopInfo: UIButton = {
        let btn = UIButton()
        btn.setTitle("站點資訊", for: .normal)

        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//        btn.text = "站點資訊"
//        btn.font = UIFont.boldSystemFont(ofSize: 18)
//        btn.textColor = .white
        return btn
    }()
    private let news: UIButton = {
        let btn = UIButton()
        btn.setTitle("最新消息", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)

//        btn.text = "最新消息"
//        btn.font = UIFont.boldSystemFont(ofSize: 18)
//        btn.textColor = .white
        return btn
    }()
    private let events: UIButton = {
        let btn = UIButton()
        btn.setTitle("活動專區", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)

//        btn.text = "活動專區"
//        btn.font = UIFont.boldSystemFont(ofSize: 18)
//        btn.textColor = .white
        return btn
    }()
    private let loginBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("登入", for: .normal)
        btn.setTitleColor(UIColor(named: "Ubike"), for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 20
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubview()
        if self.comeFrom == 3{
            stopInfo.setTitleColor(UIColor(named: "s"), for: .normal)
            
        }
        listBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
        stopInfo.addTarget(self, action: #selector(toStopInfoVC), for: .touchUpInside)
    }
    
    @objc func back(){
        dismiss(animated: false)
    }
    
    @objc func toStopInfoVC(){
        
        if self.comeFrom == 3 {
            dismiss(animated: false)
        }
        let vc = ViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }

 
    override func viewDidLayoutSubviews() {
        safeArea.frame = view.safeAreaLayoutGuide.layoutFrame
        UbikeLogo.frame = CGRect(x: 32, y: 7, width: 65, height: 65)
        listBtn.frame = CGRect(x: view.frame.width - 32 - 24, y: 24, width: 24, height: 24)
        headerLine.frame = CGRect(x: 0, y: UbikeLogo.frame.maxY, width: view.frame.width, height: 1)
        btnBackground.frame = CGRect(x: 0, y: headerLine.frame.maxY, width: view.frame.width, height: view.frame.height - UbikeLogo.frame.maxY)
        instructions.frame = CGRect(x: 32, y: headerLine.frame.maxY + 32, width: 82, height: 24)
        charge.frame = CGRect(x: 32, y: instructions.frame.maxY + 32, width: 82, height: 24)
        stopInfo.frame = CGRect(x: 32, y: charge.frame.maxY + 32, width: 82, height: 24)
        news.frame = CGRect(x: 32, y: stopInfo.frame.maxY + 32, width: 82, height: 24)
        events.frame = CGRect(x: 32, y: news.frame.maxY + 32, width: 82, height: 24)
        loginBtn.frame = CGRect(x: 32, y: events.frame.maxY + 244, width: 81, height: 40)
       
    }
    
    func addSubview() {
        view.addSubview(safeArea)
        safeArea.addSubview(UbikeLogo)
        safeArea.addSubview(listBtn)
        safeArea.addSubview(headerLine)
        safeArea.addSubview(btnBackground)
        safeArea.addSubview(instructions)
        safeArea.addSubview(charge)
        safeArea.addSubview(stopInfo)
        safeArea.addSubview(news)
        safeArea.addSubview(events)
        safeArea.addSubview(loginBtn)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
