//
//  ResturantViewController.swift
//  MyFinalPlusApp
//
//  Created by Faten Abdullh salem on 24/05/1443 AH.
//
import UIKit
import Firebase
class ResturantViewController: UIViewController {
    var posts = [Post]()
    var selectedFood:Post?
    var selectedPostImage:UIImage?
    @IBOutlet weak var postsTableView: UITableView! {
        didSet {
            postsTableView.delegate = self
            postsTableView.dataSource = self
            postsTableView.register(UINib(nibName: "DataTVCell", bundle: nil), forCellReuseIdentifier: "DataTVCell")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getPosts()
        // Do any additional setup after loading the view.
    }
    func getPosts() {
        let ref = Firestore.firestore()
        ref.collection("posts").order(by: "createdAt",descending: true).addSnapshotListener { snapshot, error in
            if let error = error {
                print("DB ERROR Posts",error.localizedDescription)
            }
            if let snapshot = snapshot {
                print("POST CANGES:",snapshot.documentChanges.count)
                snapshot.documentChanges.forEach { diff in
                    let postData = diff.document.data()
                    switch diff.type {
                 case .added :
                     
                     if let userId = postData["userId"] as? String {
                         ref.collection("users").document(userId).getDocument { userSnapshot, error in
                             if let error = error {
                                 print("ERROR user Data",error.localizedDescription)
                                 
                             }
                             if let userSnapshot = userSnapshot,
                                let userData = userSnapshot.data(){
                                 let user = User(dict:userData)
                                 let post = Post(dict:postData,id:diff.document.documentID,user:user)
                                 self.postsTableView.beginUpdates()
                                 if snapshot.documentChanges.count != 1 {
                                     self.posts.append(post)
                                   
                                     self.postsTableView.insertRows(at: [IndexPath(row:self.posts.count - 1,section: 0)],with: .automatic)
                                 }else {
                                     self.posts.insert(post,at:0)
                                   
                                     self.postsTableView.insertRows(at: [IndexPath(row: 0,section: 0)],with: .automatic)
                                 }
                               
                                 self.postsTableView.endUpdates()
                                 
                                 
                             }
                         }
                     }
                 case .modified:
                     let postId = diff.document.documentID
                     if let currentPost = self.posts.first(where: {$0.id == postId}),
                        let updateIndex = self.posts.firstIndex(where: {$0.id == postId}){
                         let newPost = Post(dict:postData, id: postId, user: currentPost.user)
                         self.posts[updateIndex] = newPost
                      
                             self.postsTableView.beginUpdates()
                             self.postsTableView.deleteRows(at: [IndexPath(row: updateIndex,section: 0)], with: .left)
                             self.postsTableView.insertRows(at: [IndexPath(row: updateIndex,section: 0)],with: .left)
                             self.postsTableView.endUpdates()
                         
                     }
                 case .removed:
                     let postId = diff.document.documentID
                     if let deleteIndex = self.posts.firstIndex(where: {$0.id == postId}){
                         self.posts.remove(at: deleteIndex)
                       
                             self.postsTableView.beginUpdates()
                             self.postsTableView.deleteRows(at: [IndexPath(row: deleteIndex,section: 0)], with: .automatic)
                             self.postsTableView.endUpdates()
                         
                     }
                 }
             }
         }
     }
 }
    @IBAction func Exit(_ sender: Any) {
        do {
    try Auth.auth().signOut()
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LandingNavigationController") as? UINavigationController {
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        } catch  {
            print("ERROR in signout",error.localizedDescription)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toPostVC" {
                let vc = segue.destination as! FoodViewController
                vc.selectedFood = selectedFood
                vc.selectedPostImage = selectedPostImage
            }else if identifier == "toDetailsVC" {
                let vc = segue.destination as! DetailsViewController
                vc.selectedFood = selectedFood
                vc.selectedPostImage = selectedPostImage
            }
        }
     
    }
}
extension ResturantViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DataTVCell
        return cell.configure(with: posts[indexPath.row])
    }
    
}
extension ResturantViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! DataTVCell
        selectedPostImage = cell.MealImageView.image
        selectedFood = posts[indexPath.row]
        if let currentUser = Auth.auth().currentUser,
           currentUser.uid == posts[indexPath.row].user.id{
          performSegue(withIdentifier: "toPostVC", sender: self)
        }else {
            performSegue(withIdentifier: "toDetailsVC", sender: self)
            
        }
    }
}


