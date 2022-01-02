//
//  ViewController.swift
//  kakao
//
//  Created by 신희준 on 2021/12/26.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser

class ViewController: UIViewController {
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    //폰(시뮬레이터)에 앱이 안깔려 있을때 웹 브라우저를 통해 로그인
    @IBAction func onKakaoLoginByWebTouched(_ sender: Any) {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                
                //do something
                _ = oauthToken
                // 어세스토큰
                _ = oauthToken?.accessToken
                
                //카카오 로그인을 통해 사용자 토큰을 발급 받은 후 사용자 관리 API 호출
                self.setUserInfo()
            }
        }
    }
    
    func setUserInfo() {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
                //do something
                _ = user
                self.infoLabel.text = user?.kakaoAccount?.profile?.nickname
                
                if let url = user?.kakaoAccount?.profile?.profileImageUrl,
                    let data = try? Data(contentsOf: url) {
                    self.profileImageView.image = UIImage(data: data)
                }
            }
        }
    }
}
