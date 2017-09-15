# CustomAlertViewHUDDemo
Swift 自定义弹出窗，想怎么弹，就怎么弹。

![](https://img.shields.io/badge/platform-iOS-red.svg) 
![](https://img.shields.io/badge/language-Swift--C-orange.svg) 
![](https://img.shields.io/badge/download-295K-brightgreen.svg)
![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg) 

关于弹窗这个小问题，面对产品🐶们一次又一次的定制化需求，你是否有过弹出一个💩的想法，现在你就可以这么做。

| 名称 |1.列表页 |2.弹出页示例 |3.弹出页示例 |
| ------------- | ------------- | ------------- | ------------- |
| 截图 | ![](http://og1yl0w9z.bkt.clouddn.com/17-7-6/49394070.jpg) | ![](http://og1yl0w9z.bkt.clouddn.com/17-7-6/43197086.jpg) | ![](http://og1yl0w9z.bkt.clouddn.com/17-7-6/14637275.jpg) |
| 描述 | 通过 storyboard 搭建基本框架 | 正常的弹出示例 | 嘿嘿嘿的弹出示例 |


## Advantage 框架的优势
* 1.文件少，代码简洁
* 2.不依赖任何其他第三方库
* 3.完全自定义的实现方式
* 4.具备较高自定义性


## Requirements 要求
* iOS 7+
* Xcode 8+


## Usage 使用方法
### 呃，正常弹出
```
let vc = TestAlertViewController()
self.present(vc, animated: true)
```
### HUD 的相关设置
```
func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController)
        -> UIPresentationController? {
            return HUDPresentationController(presentedViewController: presented, presenting: presenting)
}
```

使用简单、效率高效、进程安全~~~如果你有更好的建议,希望不吝赐教!


## License 许可证
CustomAlertViewHUDDemo 使用 MIT 许可证，详情见 LICENSE 文件。


## Contact 联系方式:
* WeChat : WhatsXie
* Email : ReverseScale@iCloud.com
* Blog : https://reversescale.github.io
