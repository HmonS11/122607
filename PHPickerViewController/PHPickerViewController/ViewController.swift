//

//  ViewController.swift

//  PHPickerViewControllerEx

//

//  Created by wizard on 2022/10/21.

//



import UIKit

import PhotosUI



class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    var picker: PHPickerViewController?

    var camera = UIImagePickerController()

    override func viewDidLoad() {

        super.viewDidLoad()

        var config = PHPickerConfiguration()

        config.selectionLimit = 1

        config.filter = .images

        

        picker = PHPickerViewController(configuration: config)

        picker?.delegate = self

        
        camera.sourceType = .camera

        camera.delegate = self

        

    }



    @IBAction func actPicker(_ sender: Any) {

        let sheet = UIAlertController(title: "이미지선택", message: "어디서?", preferredStyle: .actionSheet)

        let actionCamera = UIAlertAction(title: "카메라", style: .default) { _ in

//            let camera = UIImagePickerController()

//            camera.sourceType = .camera

//            camera.delegate = self

            self.present(self.camera, animated: true)

        }

        sheet.addAction(actionCamera)

        

        let actionAlbum = UIAlertAction(title: "포토 라이브러리", style: .default) { _ in

//            var config = PHPickerConfiguration()

//            config.selectionLimit = 1

//            config.filter = .images

//

//            let picker = PHPickerViewController(configuration: config)

//            picker.delegate = self

            self.present(self.picker!, animated: true)

        }

        

        sheet.addAction(actionAlbum)

        let actionCancel = UIAlertAction(title: "취소", style: .cancel)

        sheet.addAction(actionCancel)

        present(sheet, animated: true)

    }

}



extension ViewController: PHPickerViewControllerDelegate {

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {

        picker.dismiss(animated: true)

        if let itemProvider = results.first?.itemProvider {

            if itemProvider.canLoadObject(ofClass: UIImage.self) {

                itemProvider.loadObject(ofClass: UIImage.self) { image, error in

                    if let img = image as? UIImage {

                        DispatchQueue.main.async {

                            self.imageView.image = img

                        }

                    }

                }

            }

        }

    }

}



extension ViewController: UIImagePickerControllerDelegate,

                            UINavigationControllerDelegate {

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {

        picker.dismiss(animated: true)

    }

    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        picker.dismiss(animated: true)

        

        guard let image = info[.originalImage] as? UIImage else { return }

        imageView.image = image

    }

    

}
