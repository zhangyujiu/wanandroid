# wanandroid

最近公司准备使用flutter开发自己内部项目，自学了一周的flutter后使用了鸿洋大神开源的api开发了Wanandroid项目，感谢鸿洋大神的无私奉献，由于是练手项目，开发的比较简陋。

## 项目主要页面截图

<div align="center">
<img src="https://github.com/zhangyujiu/wanandroid/blob/master/Screenshot_1545373520.png" height="330" width="190" >

<img src="https://github.com/zhangyujiu/wanandroid/blob/master/Screenshot_1545373559.png" height="330" width="190" >

<img src="https://github.com/zhangyujiu/wanandroid/blob/master/Screenshot_1545373569.png" height="330" width="190" >

<img src="https://github.com/zhangyujiu/wanandroid/blob/master/Screenshot_1545373583.png" height="330" width="190" >

<img src="https://github.com/zhangyujiu/wanandroid/blob/master/Screenshot_1545373624.png" height="330" width="190" >

<img src="https://github.com/zhangyujiu/wanandroid/blob/master/Screenshot_1545373632.png" height="330" width="190" >

<img src="https://github.com/zhangyujiu/wanandroid/blob/master/Screenshot_1545373593.png" height="330" width="190" >

<img src="https://github.com/zhangyujiu/wanandroid/blob/master/Screenshot_1546844980.png" height="330" width="190" >

</div>

## 主要第三方开源库

- shared_preferences: ^0.4.3
- sqflite: ^0.12.2
- path_provider: ^0.4.0
- redux: ^3.0.0
- flutter_redux: ^0.5.2
- fluttertoast: 2.1.2
- flutter_swiper: ^1.1.4
- event_bus: ^1.0.1
- pull_to_refresh: ^1.1.6
- flutter_spinkit: ^2.0.1
- flutter_webview_plugin: ^0.3.0+2
- cached_network_image: ^0.5.1
- flutter_html: ^0.8.2

##  功能介绍
- 启动页：项目启动后倒计时进入主页
- 首页：banner+listview，使用flutter_swiper开源库实现banner功能
- 登录：操作相应的功能服务器返回需要登录的信息会自动跳转到登录的页面，并做了cooike持久化
- 知识体系：使用listview展示知识体系分类
- 导航：使用listview+使用listview实现二级联动
- 项目：使用FutureBuilder先加载出分类tab，再加载列表页面
- 搜索：使用sqflite实现历史记录保存
- 数据共享：使用redux实现数据共享
- 更多功能请Clone进行查看

## 自定义widget
- 自定义TitleBar
- 自定义跑马灯效果：当字符长度超过控件宽度，会自动横向混动播放文字
- 自定义页面加载状态：1.进入页面进入加载状态 2.加载成功显示成功页面 3.加载失败显示失败页面，点击按钮可重新加载

## 参考项目
-  [CarGuo](https://github.com/CarGuo/GSYGithubAppFlutter)
- [JsonChao](https://github.com/JsonChao/Awesome-WanAndroid)
### 项目地址

[项目地址](https://github.com/zhangyujiu/wanandroid)