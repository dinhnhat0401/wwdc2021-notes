Yahoo JP LT
１・ヤフーフリマアプリ起動速度改善

改善点
・ローカル cache
・API ロード時間測定、bottle neck 明確
・リンク時間最適化 dynamic -> static framework にする：起動時間 1.2 秒ー＞１秒　ー> -0.2秒

ツール
・Xcode Organizer でMetrics 確認
・パフォーマンス測定：OS Signpost iOS 12 から使える

確認
・起動速度測定し、遅くなる場合なら、slack に送信
・CI ツールで、起動速度をMR(コミット？)ごとに計算しているらしい、chart に表示されている

２・iOS 12サポートをやめると使えるAPIおさらい
・配列の差分更新
uitableviewdiffabledatasource
・UICollectionView モダンレイアウト：UICollectionViewCompositionLayout
・Reactive programing: Combine Framework (Apple から提供された RxSwift w)
・SwiftUI: コンポーネント志向
SwiftUIReplicator(?)


WWDC 2021 — June 7 | Apple
iOS 15

FaceTime: Spatial audio, video call voice effect, voice wide spectrum
Movie/music share play. share play + air play 
iMessage improvement about display & react with images, sharing
Notification Summary: based on priority, time, user interaction with apps
New mode: do not disturb > focus(customizable) > normal 
Photo:
*  Built-in Hand writing recognition
* Apple music to use with slide creation
Use iphone as Key for car, home, ...
Weather UI Updates
Apple Maps: privacy focus -> >< Google, lol, more details, street recognition

Developer betas today. Public betas next month.
iPadOS 15

new widgets, app library
Multitasking: menu on top, split view between apps, app shelf
QuickNote: iPadOS, MacOS
Translate with image recognition
Swift Playground, Build app with iPad
Privacy:

* Mail privacy protection, hide ip address, location, hide if you open email
* Safari: prevent xss
* New App privacy report section control
* Siri: 600M devices/month, request without internet connection, on device request recognition
iCloud

* Add recovery contact
* Digital legacy: sharing information after you die
* iCloud+ Private relay
* Hide my email
* Homekit secure video
Health

* health API
    * CareKit
    * ResearchKit
* Mobility:
    * walking steadiness
    * Labs
        * Data: like LDL Cholesterol ?
    * Trends
* Sharing health condition like heart rate with doctors securely. Apple doesn't have access.
* Family: Health sharing between family members, need permission
WatchOS

* Breath: meiso?🙂, while sleeping
* Workout
* Photo app on WatchOS
Home

* HomePod
* HomeKit
macOS Monterey

* macOS Monterey
* Universal Control
* AirPlay: to mac
* Shortcuts
* Safari new tab design
* Web extension safari
Developer Technologies

* API
    * AR: Object capture to create 3D content from 2D image
* Swift
    * Concurrency: async, await, actor
* AppStore
    * In-App Events
* Xcode Cloud + TestFlight
    * CI/CD tool to build, test, delivery
