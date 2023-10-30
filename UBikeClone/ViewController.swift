//
//  ViewController.swift
//  UBikeClone
//
//  Created by 羅群瀝 on 2023/10/28.
//

import UIKit

class ViewController: UIViewController{
    
    var searchArray = [YouBikeStation]()
    var allSarea = [String]()
    var searchSarea = [String]()
    var isSearching = false
    private let safeArea = UIView()
    
    private let UbikeLogo: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "Ubike")
        return imageView
    }()
    
    private let listBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "menu"), for: .normal)
        btn.tintColor = UIColor(named: "Ubike")
        return btn
    }()
    
    private let headerLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "站點資訊"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor(named: "Ubike")
        return label
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.leftView = .none
        searchBar.searchTextField.clearButtonMode = .never
        searchBar.placeholder = "搜尋站點"
        searchBar.backgroundImage = UIImage()
        return searchBar
    }()
    private let searchImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "search")
        imageView.image = image
        return imageView
    }()
    private let header: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "header")
        return image
    }()
    
    var searchResultList: UITableView?
    var ubikeList: UITableView?
    var didtapListBtn = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(screenTapped))
//        tapGestureRecognizer.cancelsTouchesInView = false
//          view.addGestureRecognizer(tapGestureRecognizer)
        configUbikeList()
        configSearcjResult()
        configSearchBar()
        addSubView()
        configHeader()
        listBtn.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        UBikeAPIManager.shared.getUBikeInfo { result in
            if let result = result{
             
                UBikeAPIManager.shared.youBikeStations = result
                self.searchArray = result
                var array = [String]()
                for n in result {
                    array.insert(n.sarea, at: 0)
                }
                self.allSarea = Array(Set(array))
                self.searchSarea = self.allSarea
                print(self.allSarea)
                    DispatchQueue.main.async {
                        self.ubikeList?.reloadData()
                        self.searchResultList?.reloadData()

                    }
            }else{
                print("fail")
            }
        }
    }
    @objc func screenTapped() {
        searchBar.resignFirstResponder()
        if searchBar.text == "" {
            searchArray = UBikeAPIManager.shared.youBikeStations
            ubikeList?.reloadData()
        }
    }
    
    @objc func showMenu(){
        let vc = menuList(model: 3)
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
    }
    
    @objc func configSearchBar(){
        searchBar.searchTextField.delegate = self
        searchBar.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        safeArea.frame = view.safeAreaLayoutGuide.layoutFrame
        UbikeLogo.frame = CGRect(x: 32, y: 7, width: 65, height: 65)
        listBtn.frame = CGRect(x: view.frame.width - 32 - 24, y: 24, width: 24, height: 24)
        headerLine.frame = CGRect(x: 0, y: UbikeLogo.frame.maxY, width: view.frame.width, height: 1)
        titleLabel.frame = CGRect(x: 32, y: 96, width: 82, height: 24)
        searchBar.frame = CGRect(x: 24, y: 136, width: view.frame.width - 48, height: 40)
        searchImage.frame = CGRect(x: view.frame.width - 40 - 18 , y: 136 + 11, width: 18, height: 18)
        header.frame = CGRect(x: 32, y: 200, width: view.frame.width - 64, height: 66)
        ubikeList?.frame = CGRect(x: 32 , y: header.frame.maxY - 1, width: view.frame.width - 64, height: 498 - 66 )
        searchResultList?.frame = CGRect(x: 32, y: searchBar.frame.maxY + 8, width: (ubikeList?.frame.width)!, height: 232)
    }
    
    func addSubView(){
        view.addSubview(safeArea)
        safeArea.addSubview(UbikeLogo)
        safeArea.addSubview(listBtn)
        safeArea.addSubview(headerLine)
        safeArea.addSubview(titleLabel)
        safeArea.addSubview(searchBar)
        safeArea.addSubview(searchImage)
        safeArea.addSubview(ubikeList!)
        safeArea.addSubview(header)
        safeArea.addSubview(searchResultList!)
    }
    
    func configHeader(){
        let label1 = UILabel()
        label1.text = "縣市"
        label1.textColor = .white
        label1.font = UIFont.boldSystemFont(ofSize: 16)
        let label2 = UILabel()
        label2.text = "區域"
        label2.textColor = .white
        label2.font = UIFont.boldSystemFont(ofSize: 16)
        let label3 = UILabel()
        label3.text = "站點名稱"
        label3.textColor = .white
        label3.font = UIFont.boldSystemFont(ofSize: 16)
        
        label1.frame = CGRect(x: 22, y: 21, width: 34, height: 24)
        label2.frame = CGRect(x: label1.frame.maxX + 38, y: 21, width: 34, height: 24)
        label3.frame = CGRect(x: label2.frame.maxX + 70, y: 21, width: 66, height: 24)
        
        header.addSubview(label1)
        header.addSubview(label2)
        header.addSubview(label3)
    }
    
    func configUbikeList(){
        ubikeList = UITableView()
        ubikeList?.delegate = self
        ubikeList?.dataSource = self
        ubikeList?.register(UbikeListCell.self, forCellReuseIdentifier: UbikeListCell.identifier)
        ubikeList?.separatorStyle = .none
        ubikeList?.layer.borderWidth = 1
    
        ubikeList?.layer.cornerRadius = 8
        ubikeList?.clipsToBounds = true
        ubikeList?.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        ubikeList?.layer.borderColor = UIColor.lightGray.cgColor
       
    }
    
    func configSearcjResult(){
        searchResultList = UITableView()
        searchResultList?.delegate = self
        searchResultList?.dataSource = self
        searchResultList?.register(searchResultCell.self, forCellReuseIdentifier: searchResultCell.identifier)
        ubikeList?.layer.cornerRadius = 8
        searchResultList?.separatorStyle = .none
        searchResultList?.backgroundColor = UIColor(named: "Ubikegray")
        searchResultList?.isHidden = true
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView{
        case ubikeList:
            return searchArray.count
        default:
            return searchSarea.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView{
        case ubikeList:
            return 72
        default:
            return 36
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView{
        case ubikeList:
            let cell = tableView.dequeueReusableCell(withIdentifier: UbikeListCell.identifier) as! UbikeListCell
            cell.label1.text = "台北市"
            cell.label2.text = searchArray[indexPath.row].sarea
            cell.label3.text = searchArray[indexPath.row].sna
            cell.backgroundColor = nil
            
            if indexPath.row%2 != 0 {
                cell.backgroundColor = UIColor(named: "Ubikegray")
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: searchResultCell.identifier) as! searchResultCell
            cell.label.text = searchSarea[indexPath.row]
            cell.backgroundColor = UIColor(named: "Ubikegray")
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if let cell = tableView.cellForRow(at: indexPath) as? searchResultCell {
            cell.label.textColor = UIColor(named: "Ubike")
           }
        if tableView == searchResultList {
            searchBar.text = searchSarea[indexPath.row]
            searchBar.searchTextField.textColor = UIColor(named: "Ubike")
            print(searchSarea[indexPath.row])
            
        }
    }
    
}


extension ViewController: UISearchBarDelegate{
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchSarea = allSarea
        searchResultList?.isHidden = false
        let array = searchSarea
        if searchBar.text != ""{
            searchSarea = array.filter{$0.contains(searchBar.text!)}
            
        }
        print(searchSarea)
        searchResultList?.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchArray = [YouBikeStation]()
        searchResultList?.isHidden = true

        for n in UBikeAPIManager.shared.youBikeStations {
            if searchBar.text == n.sarea{
                searchArray.insert(n, at: 0)
            }
        }
        searchBar.resignFirstResponder()
       
            DispatchQueue.main.async {
                //更新畫面程式
                self.ubikeList?.reloadData()
                self.searchResultList?.isHidden = true
            }
        

    }
    
   
}

extension ViewController: UITextFieldDelegate{

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
}

