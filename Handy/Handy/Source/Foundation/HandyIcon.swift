//
//  HandyIcon.swift
//  Handy
//
//  Created by 성현주 on 7/24/24.
//

import UIKit

public enum HandyIcon {
    public static var alertTriangleFilled: UIImage { .load(name: "ic_alertTriangle_filled") }
    public static var alertTriangleLine: UIImage { .load(name: "ic_alertTriangle_line") }
    public static var bookmarkFilled: UIImage { .load(name: "ic_bookmark_filled") }
    public static var bookmarkLine: UIImage { .load(name: "ic_bookmark_line") }
    public static var cancelFilled: UIImage { .load(name: "ic_cancel_filled") }
    public static var cancelLine: UIImage { .load(name: "ic_cancel_line") }
    public static var chatFilled: UIImage { .load(name: "ic_chat_filled") }
    public static var chatLine: UIImage { .load(name: "ic_chat_line") }
    public static var downloadFilled: UIImage { .load(name: "ic_download_filled") }
    public static var downloadLine: UIImage { .load(name: "ic_download_line") }
    public static var eyeFilled: UIImage { .load(name: "ic_eye_filled") }
    public static var eyeLine: UIImage { .load(name: "ic_eye_line") }
    public static var homeFilled: UIImage { .load(name: "ic_home_filled") }
    public static var homeLine: UIImage { .load(name: "ic_home_line") }
    public static var notificationFilled: UIImage { .load(name: "ic_notification_filled") }
    public static var notificationLine: UIImage { .load(name: "ic_notification_line") }
    public static var notificationOffFilled: UIImage { .load(name: "ic_notificationOff_filled") }
    public static var notificationOffLine: UIImage { .load(name: "ic_notificationOff_line") }
    public static var retryRefreshFilled: UIImage { .load(name: "ic_retryRefresh_filled") }
    public static var retryRefreshLine: UIImage { .load(name: "ic_retryRefresh_line") }
    public static var volumeFilled: UIImage { .load(name: "ic_volume_filled") }
    public static var volumeLine: UIImage { .load(name: "ic_volume_line") }
    public static var wifiFilled: UIImage { .load(name: "ic_wifi_filled") }
    public static var wifiLine: UIImage { .load(name: "ic_wifi_line") }
    public static var closeFilled: UIImage { .load(name: "ic_close_filled") }
    public static var closeLine: UIImage { .load(name: "ic_close_line") }
    public static var searchLine: UIImage { .load(name: "ic_search_line") }
    public static var arrowsChevronLeftFilled: UIImage { .load(name: "ic_ArrowsChevronLeft_filled") }
    public static var filterBarFilled: UIImage { .load(name: "ic_filterBar_filled") }


    public static var checkBoxFilled: UIImage { .load(name: "checkBoxFilled") }
    public static var checkBoxLine: UIImage { .load(name: "checkBoxLine") }
    public static var radioButtonLine: UIImage { .load(name: "radioButtonLine") }
    public static var radioButtonDisabled: UIImage { .load(name: "radioButtonDisabled") }
}

extension UIImage {
    fileprivate static func load(name: String) -> UIImage {
        guard let image = UIImage(named: name, in: nil, compatibleWith: nil) else {
            assert(false, "\(name) 이미지 로드 실패")
            return UIImage()
        }
        image.accessibilityIdentifier = name
        return image
    }
}
