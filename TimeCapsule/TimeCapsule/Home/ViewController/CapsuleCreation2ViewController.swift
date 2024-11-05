//
//  CapsuleCreation2ViewController.swift
//  TimeCapsule
//
//  Created by Dana Lim on 11/3/24.
//

import UIKit

class CapsuleCreation2ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = capsuleCreation2View
        capsuleCreation2View.tagDropDownTableView.delegate = self
        capsuleCreation2View.tagDropDownTableView.dataSource = self
        
        capsuleCreation2View.addTagButton.addTarget(self, action: #selector(showTagDropDown), for: .touchUpInside)
        capsuleCreation2View.addPictureButton.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
        capsuleCreation2View.cancelCreationButton.addTarget(self, action: #selector(cancelCreationButtonTap), for: .touchUpInside)
        capsuleCreation2View.doneCreationButton.addTarget(self, action: #selector(doneCreationButtonTap), for: .touchUpInside)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return capsuleCreation2View.tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = capsuleCreation2View.tags[indexPath.row]
        return cell
    }
    
    private lazy var capsuleCreation2View: CapsuleCreation2View = {
        let view = CapsuleCreation2View()
        
        return view
    }()

    
    @objc
    private func showTagDropDown(){
        capsuleCreation2View.tagDropDownTableView.isHidden.toggle() //드롭다운 메뉴 표시/숨김 전환
    }
    
    @objc
    private func cancelCreationButtonTap(){
        let viewController = CapsuleCreationViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc
    private func doneCreationButtonTap(){
        
    }
    
}

extension CapsuleCreation2ViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    //이미지 피커에서 이미지를 선택하지 않고 취소했을 때 호출되는 메소드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    //이미지 피커에서 이미지 선택했을때 호출되는 메서드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //편집된 이미지 선택한 경우
        if let editedImage = info[.editedImage] as? UIImage {
            addImageToStackView(image: editedImage) //스택뷰에 추가
        }
        //원본 이미지 선택한 경우
        else if let originalImage = info[.originalImage] as? UIImage {
            addImageToStackView(image: originalImage) //스택뷰에 추가
            }
            picker.dismiss(animated: true)
        }
    
    //이미지를 스택 뷰에 추가하는 메서드
    private func addImageToStackView(image:UIImage){
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true //크기에 맞게 이미지 자르기
        imageView.layer.cornerRadius = 20
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(120)
        }
        capsuleCreation2View.pictureStackView.addArrangedSubview(imageView)
    }
    
    //
    @objc
    func pickImage(_ sender:Any) {
        //imagepickercontroller 생성
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary //이미지 소스로 라이브러리
        picker.allowsEditing = true //이미지 편집 기능
        picker.delegate = self
        self.present(picker,animated:true, completion: nil) //image picker 컨트롤러 실행
    }
}

