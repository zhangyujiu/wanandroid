# wanandroid

最近公司准备使用Flutter开发自己内部项目，自学了一周的flutter后使用了鸿洋大神开源的api开发了Flutter版Wanandroid项目，感谢鸿洋大神的无私奉献，由于是练手写的项目，开发的比较简陋，界面比较难看。

## 项目主要页面截图

<div align="center">

<img src="https://github.com/zhangyujiu/wanandroid/blob/master/snapshot/Screenshot_2019-07-21-12-11-04-770.png" height="330" width="190" >

<img src="https://github.com/zhangyujiu/wanandroid/blob/master/snapshot/Screenshot_2019-07-21-12-11-27-386.png" height="330" width="190" >

<img src="https://github.com/zhangyujiu/wanandroid/blob/master/snapshot/Screenshot_2019-07-21-12-11-37-574.png" height="330" width="190" >

<img src="https://github.com/zhangyujiu/wanandroid/blob/master/snapshot/Screenshot_2019-07-21-12-11-43-286.png" height="330" width="190" >

<img src="https://github.com/zhangyujiu/wanandroid/blob/master/snapshot/Screenshot_2019-07-21-12-11-52-801.png" height="330" width="190" >

<img src="https://github.com/zhangyujiu/wanandroid/blob/master/snapshot/Screenshot_2019-07-21-12-12-14-237.png" height="330" width="190" >

<img src="https://github.com/zhangyujiu/wanandroid/blob/master/snapshot/Screenshot_2019-07-21-12-12-47-389.png" height="330" width="190" >

<img src="https://github.com/zhangyujiu/wanandroid/blob/master/snapshot/Screenshot_2019-07-21-12-13-04-857.png" height="330" width="190" >

<img src="https://github.com/zhangyujiu/wanandroid/blob/master/snapshot/Screenshot_2019-07-21-12-13-13-260.png" height="330" width="190" >

<img src="https://github.com/zhangyujiu/wanandroid/blob/master/snapshot/Screenshot_2019-07-21-12-13-46-977.png" height="330" width="190" >

<img src="https://github.com/zhangyujiu/wanandroid/blob/master/snapshot/Screenshot_2019-07-21-12-14-08-961.png" height="330" width="190" >

<img src="https://github.com/zhangyujiu/wanandroid/blob/master/snapshot/Screenshot_2019-07-21-12-14-12-756.png" height="330" width="190" >

<img src="https://github.com/zhangyujiu/wanandroid/blob/master/snapshot/Screenshot_2019-07-21-12-14-24-070.png" height="330" width="190" >

</div>

## 主要第三方开源库

- shared_preferences
- dio
- sqflite
- path_provider
- flutter_redux
- fluttertoast
- flutter_swiper
- event_bus
- flutter_easyrefresh
- flutter_spinkit
- flutter_webview_plugin
- cached_network_image
- flutter_html
- fish_redux
- flare_flutter
- flutter_ui:  git:    url: "https://github.com/zhangyujiu/flutter_ui.git"

##  功能介绍
- 启动页：项目启动后倒计时进入主页
- 首页：banner+listview，使用flutter_swiper开源库实现banner功能
- 登录：操作相应的功能服务器返回需要登录的信息会自动跳转到登录的页面，并做了cooike持久化
- 知识体系：使用listview展示知识体系分类
- 导航：使用listview+使用listview实现二级联动
- 项目：使用FutureBuilder先加载出分类tab，再加载列表页面
- 搜索：使用sqflite实现历史记录保存
- Todo：使用阿里的fish-redux，特点：集中，分治，复用，隔离
- 数据共享：使用redux实现数据共享
- 更多功能请Clone进行查看

## 自定义widget
- 自定义TitleBar
- 自定义跑马灯效果：当字符长度超过控件宽度，会自动横向混动播放文字
- 自定义页面加载状态：1.进入页面进入加载状态 2.加载成功显示成功页面 3.加载失败显示失败页面，点击按钮可重新加载
- 侧滑删除

## 参考项目
- [CarGuo](https://github.com/CarGuo/GSYGithubAppFlutter)
- [JsonChao](https://github.com/JsonChao/Awesome-WanAndroid)
### 项目地址

[项目地址](https://github.com/zhangyujiu/wanandroid)