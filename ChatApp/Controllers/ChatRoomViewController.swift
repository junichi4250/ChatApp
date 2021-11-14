//
//  ChatRoomViewController.swift
//  ChatApp
//
//  Created by kato junichi on 2021/11/08.
//

import UIKit

class ChatRoomViewController: UIViewController {
    
    private let cellId = "cellId"
    private var messages = [String]()
    
    private lazy var chatInputAccessaryView: ChatInputAccessaryView = {
        let view = ChatInputAccessaryView()
        view.frame = .init(x: 0, y: 0, width: view.frame.width , height: 100)
        view.delegate = self
        return view
    }()

    @IBOutlet var chatRoomTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        chatRoomTableView.delegate = self
        chatRoomTableView.dataSource = self
        chatRoomTableView.register(UINib(nibName: "ChatRoomTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        chatRoomTableView.backgroundColor = .rgb(red: 118, green: 140, blue: 180)
        // Do any additional setup after loading the view.
    }
    
    override var inputAccessoryView: UIView? {
        get {
            return chatInputAccessaryView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
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

extension ChatRoomViewController: ChatInputAccessaryViewDelegate {
    func tappedSendButton(text: String) {
        messages.append(text)
        chatInputAccessaryView.removeText()
        chatRoomTableView.reloadData()
    }
    
    
}

extension ChatRoomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatRoomTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatRoomTableViewCell
        cell.messageText = messages[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        chatRoomTableView.estimatedRowHeight = 20
        return UITableView.automaticDimension
    }
    
    
}
