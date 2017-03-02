# PlayerContainerViewController

[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
             )](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-ObjC-brightgreen.svg?style=flat)](https://developer.apple.com/Objective-C)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](http://mit-license.org)

> 主流视频App 视频页面切换效果实现DEMO
>参照腾讯、爱奇艺、搜狐视频、头条等视频展示效果

##截图
![screen](https://github.com/MrLu/ChirdVCRotateDemo/tree/master/screen/screen.gif)

##使用:
###示例代码
``` 
//大小屏切换
self.playerContainerVC = [[PlayerContainerViewController alloc] initWithView:self.movieView viewController:self];
self.playerContainerVC.view.backgroundColor = [UIColor blackColor];
[self addChildViewController:self.playerContainerVC]; //增加子容器
[self.movieView addSubview:self.playerContainerVC.view];
```

```
//大小屏切换 迷你屏切换 参考demo
```

###原理
1、 大小屏切换利用present VC 实现横屏逻辑
2、 利用UIDevice 主动设置设备方向

### by
* 问题建议 to mail
* mail：haozi370198370@gmail.com
