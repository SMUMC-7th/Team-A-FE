//
//  CapsuleCreation2ViewController.swift
//  TimeCapsule
//
//  Created by Dana Lim on 11/3/24.
//

import UIKit
import Alamofire

class CapsuleCreation2ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // 이미지 배열 추가
    private var images: [UIImage] = []
    private let capsuleService = CapsuleCreationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = capsuleCreation2View
        setupNavigationBar()
        
        capsuleCreation2View.tagDropDownTableView.delegate = self
        capsuleCreation2View.tagDropDownTableView.dataSource = self
        capsuleCreation2View.imageCollectionView.dataSource = self
        capsuleCreation2View.imageCollectionView.delegate = self
        capsuleCreation2View.imageCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "PictureCell")
        
        // 버튼 액션 설정
        setupNavigationBar(action: #selector(customBackButtonTapped))
        capsuleCreation2View.addTagButton.addTarget(self, action: #selector(showTagDropDown), for: .touchUpInside)
        capsuleCreation2View.addImageButton.addTarget(self, action: #selector(pickImage), for: .touchUpInside) // 이미지 추가 버튼
        capsuleCreation2View.cancelCreationButton.addTarget(self, action: #selector(cancelCreationButtonTap), for: .touchUpInside)
        capsuleCreation2View.doneCreationButton.addTarget(self, action: #selector(doneCreationButtonTap), for: .touchUpInside)
    }
    
    // 태그 설정 테이블 뷰 행 수 반환
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return K.String.tags.count
    }
    
    // 태그 설정 테이블 뷰 셀 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = K.String.tags[indexPath.row]
        return cell
    }
    
    // 테이블 뷰의 특정 행이 선택되었을 때 호출되는 메서드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTag = K.String.tags[indexPath.row]
        capsuleCreation2View.addTagButton.setTitle(selectedTag, for: .normal) // 선택된 태그로 변경
        capsuleCreation2View.tagDropDownTableView.isHidden = true // 드롭다운 숨기기
        capsuleCreation2View.isTagSelected = true //태그 선택됨
    }
    
    private lazy var capsuleCreation2View: CapsuleCreation2View = {
        let view = CapsuleCreation2View()
        return view
    }()
    
    // MARK: 이벤트 처리
    @objc
    private func showTagDropDown() {
        capsuleCreation2View.tagDropDownTableView.isHidden.toggle() // 드롭다운 메뉴 표시/숨김 전환
        if !capsuleCreation2View.tagDropDownTableView.isHidden {
            capsuleCreation2View.isTagSelected = false // 드롭다운이 열리면 태그 선택이 되지 않은 상태로 초기화
            }
    }
    
    // 취소 버튼 눌렀을 때 호출되는 메서드
    @objc
    private func cancelCreationButtonTap() {
        navigationController?.popViewController(animated: true)
    }
    
    // 완료 버튼 눌렀을 때 호출되는 메서드, POST 호출
    @objc
    private func doneCreationButtonTap() {
        if !validateRequestData() {
                return
        }
        print("완료 버튼이 눌렸습니다.")  // 콘솔에 출력 확인

        sendTimeCapsuleRequest()   // 데이터 형식에 맞춰서 서버로 전송
    }
    
    // MARK: Feature Functions
    //다 nil이 아닌지 확인
    private func validateRequestData() -> Bool {
        if let title = capsuleCreation2View.addCapsuleTitleTextField.text, title.isEmpty {
            showAlert(message: "제목을 입력해주세요.")
            return false
        }
        
        if let content = capsuleCreation2View.addTextTextField.text, content.isEmpty {
            showAlert(message: "내용을 입력해주세요.")
            return false
        }
        
        if !capsuleCreation2View.isTagSelected {
            showAlert(message: "태그를 선택해주세요.")
            return false
        }
        // 모든 속성이 nil이 아닐떄
        return true
    }
    
    //알림 뜨게 하는 메서드
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    // request로 들어갈거 형식 맞춰주고 네트워크 요청
    private func sendTimeCapsuleRequest(){
        //날짜 형식 바꾸기
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd" // 서버에서 기대하는 날짜 형식
            let formattedDate = dateFormatter.string(from: capsuleCreation2View.addDatePicker.date)
        //태그
        let selectedTag = capsuleCreation2View.addTagButton.title(for: .normal) ?? ""
        //요청 데이터 생성, 사용자가 입력한거 받아오기
        let requestData = TimeCapsuleRequest(
            title: capsuleCreation2View.addCapsuleTitleTextField.text ?? "",
            content: capsuleCreation2View.addTextTextField.text ?? "",
            deadline: formattedDate,
            tagName: selectedTag,
            imageList: []
        )
        
        guard let token = KeychainService.load(for: "RefreshToken") else { return }
        
        //네트워크 요청 - 생성한 데이터를 parameter로 타임캡슐 생성 요청을 보냄
        APIClient.postRequest(endpoint: "/timecapsules", parameters: requestData, token: token) { (result: Result<CapsuleResponse, AFError>) in
            switch result {
            //성공
            case .success(let response):
                if response.isSuccess {
                    print("타임캡슐 생성 성공: \(response)")
                    
                    //성공시에 homeview로 pop해서 이동
                    DispatchQueue.main.async {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                } else {
                    print("타임캡슐 생성 실패: \(response.message)")
                }
                //타임캡슐 생성하고 다음 할거 여기에 들어옴
            //실패
            case .failure(let error):
                print("Error Description: \(error.localizedDescription)")
                dump(error)
            }
        }
    }
    
    private func setupNavigationBar() {
        setupNavigationBarBackgroundColor()
        self.title = "캡슐 생성"
        
        // 추가적으로 네비게이션바 타이틀 색상, 글자크기 수정
    }
}

extension CapsuleCreation2ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // 이미지 피커에서 이미지를 선택하지 않고 취소했을 때 호출되는 메서드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    // 이미지 피커에서 이미지 선택했을 때 호출되는 메서드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        let image = UIImage()
        // 편집된 이미지 선택한 경우
        if let editedImage = info[.editedImage] as? UIImage {
            uploadImage(image:editedImage)
        }
        // 원본 이미지 선택한 경우
        else if let originalImage = info[.originalImage] as? UIImage {
            uploadImage(image: originalImage)
        }
        picker.dismiss(animated: true)
    }
    
    // 이미지를 컬렉션 뷰에 추가하는 메서드
    private func addImageToCollectionView(image: UIImage) {
        guard images.count < 4 else {
            print("최대 4개까지 가능합니다")
            return
        }
        images.append(image) // 이미지 배열에 추가
        capsuleCreation2View.imageCollectionView.reloadData() // 컬렉션 뷰 업데이트
    }
    
    // 서비스 호출해와서 이미지 업로드해주는 메서드
    private func uploadImage(image: UIImage) {
        guard let token = KeychainService.load(for: "RefreshToken") else { return }
        
        // UIImage -> JPEG 데이터로 변환
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("이미지 변환 실패")
            return
        }
        
        APIClient.postImageRequest(endpoint: "/timecapsules/images", imageData: imageData, token: token) { (result: Result<ImageUploadResponse, AFError>) in
            switch result {
            case .success(let response):
                // 이미지 업로드 성공 여부 확인
                if response.isSuccess {
                    print("이미지 업로드 성공 : \(response.result)")
                    DispatchQueue.main.async {
                        self.addImageToCollectionView(image: image) // 올바른 인스턴스를 전달
                    }
                } else {
                    // 업로드 실패 메시지 출력
                    print("이미지 업로드 실패: \(response.message), \(response.code)")
                }
                
            case .failure(let error):
                // 네트워크 또는 서버 오류 출력
                print("이미지 업로드 실패: \(error.localizedDescription)")
            }
        }
    }

    
    // 이미지 선택 메서드
    @objc
    func pickImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true)
    }
}

// MARK: imageCollectionview에 대한 처리
extension CapsuleCreation2ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(images.count+1,5) // +1 for the add button
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCell", for: indexPath)
        
        // 기존의 모든 뷰 제거
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }

        if indexPath.item == 0 {
            // 항상 첫 번째 셀에 addImageButton 추가
            let button = capsuleCreation2View.addImageButton
            button.frame = cell.contentView.bounds
            button.autoresizingMask = [.flexibleWidth, .flexibleHeight] // 셀 크기에 맞추기
            cell.contentView.addSubview(button)
        } else {
            // 나머지 셀에 이미지를 추가
            let imageView = UIImageView(image: images[indexPath.item - 1])
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.frame = cell.contentView.bounds
            imageView.layer.cornerRadius = 20
            cell.contentView.addSubview(imageView)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            // 첫 번째 셀이 addPictureButton이므로 이미지 추가 메서드 호출
            pickImage(self)
        }
    }
}
