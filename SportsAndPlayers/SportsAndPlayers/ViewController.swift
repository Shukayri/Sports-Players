//
//  ViewController.swift
//  SportsAndPlayers
//
//  Created by administrator on 1/10/22.
//

import UIKit

import CoreData

class ViewController: UITableViewCell,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var sport: UILabel!
    @IBOutlet weak var addimg: UIButton!
    @IBOutlet weak var img: UIImageView!
    var imgp=UIImagePickerController()
    var sp=0
    let cr=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var own:SportTableViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if (img.image != nil){
            addimg.isHidden=true
        }

        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func addimage(_ sender: UIButton) {
        imgp.delegate = self
        imgp.allowsEditing=true
        imgp.sourceType = .photoLibrary
        own!.present(imgp, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       
        if let imgpick = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            img.image=imgpick
        }
        own?.splist[sp].img = img.image?.jpegData(compressionQuality: 1)
        addimg.isHidden=true
        
        if cr.hasChanges {
            do {
                try cr.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

