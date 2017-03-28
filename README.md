## 一步一步带你实现 iOS 直播 Demo 

> 推流：LFLiveKit 播放：ijkplayer 服务器:nginx+rtmp+ffmpeg

---
直播现在估计已经到了下半场, 那么开发一款直播 APP 首先是播放, 前提是服务器只要提供拉流的 url, 下面就主要是通过ijkplayer, 来实现播放;
直播源, 也就是 url 是从映客抓的, 直接上代码

	- (void)loadData{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];
    [manager GET:@"http://116.211.167.106/api/live/aggregation?uid=23455&interest=1" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"error_msg"] isEqualToString:@"操作成功"]) {
            self.dataArray = [LiveModel mj_objectArrayWithKeyValuesArray:responseObject[@"lives"]];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    }
	

有了数据源, 实现 tableView 代理方法即可, 如下图:
![](https://ws1.sinaimg.cn/large/9e1008a3ly1fe2lsqqfc9g20ab0ife83.gif)

接下来就是比较重要的一步, 实现播放, 去下载[ijkplayer](https://github.com/Bilibili/ijkplayer)
![](https://ws1.sinaimg.cn/large/9e1008a3ly1fe2m98a6wxj20k705d0tc.jpg)
下载完成之后, cd到当前文件夹下, 执行命令``./init-ios.sh``然后会等很久,等下载完成之后
![](https://ws1.sinaimg.cn/large/9e1008a3ly1fe2mduk40gj20kd06l0u8.jpg)
![](https://ws1.sinaimg.cn/large/9e1008a3ly1fe2mksz50wj20kd0con04.jpg)
我们cd 到 ios 文件夹执行命令``./compile-ffmpeg.sh clean``
![](https://ws1.sinaimg.cn/large/9e1008a3ly1fe2mmwz5hpj20ka0c4dhh.jpg)
再执行``./compile-ffmpeg.sh all``
编译时间较长。
![](https://ws1.sinaimg.cn/large/9e1008a3ly1fe2mygt301j20kc0c30vs.jpg)完成之后打包IJKMediaFramework.framework框架
1. 首先打开工程IJKMediaPlayer.xcodeproj, 位置如下图: ![](https://ws1.sinaimg.cn/large/9e1008a3ly1fe2mti4jvcj20h50aowgq.jpg)
2. 打开之后,去修改 scheme -> run -> release![](https://ws1.sinaimg.cn/large/9e1008a3ly1fe2mw9a5izj20qx0a377e.jpg)
3. 模拟器下 command+b 编译下![](https://ws1.sinaimg.cn/large/9e1008a3ly1fe2n1j36sbj20pz09lta4.jpg)
4. 真机下 command+b 编译 ![](https://ws1.sinaimg.cn/large/9e1008a3ly1fe2n4q6u5lj20qj0ajjsu.jpg)
5. 然后展开 Product 文件夹 如图 Show In Finder![](https://ws1.sinaimg.cn/large/9e1008a3ly1fe2n4q6u5lj20qj0ajjsu.jpg)
6. lipo -create "真机路径" "模拟器路径" -output "合并后的文件路径"注意合并后问价的命名,如下图![](https://ws1.sinaimg.cn/large/9e1008a3ly1fe2nv082d5j20kh09r40v.jpg)
7. 将Release-iphoneos里面的IJKMediaFramework删掉;![](https://ws1.sinaimg.cn/large/9e1008a3ly1fe2o0q47drj20kx05uq4k.jpg)
8. 把刚生成的IJKMediaFramework拖到Release-iphoneos/IJKMediaFramework.framework/文件夹下![](https://ws1.sinaimg.cn/large/9e1008a3ly1fe2nzhpzvgj20h60ar75c.jpg)
9. 这样IJKMediaFramework.framework就是我们需要的了如图![](https://ws1.sinaimg.cn/large/9e1008a3ly1fe2o44vrvgj20ht06ygmc.jpg)
10. 将其添加到项目中并添加相关的库

```` 
Build Phases -> Link Binary with Libraries -> Add:
IJKMediaFramework.framework

AudioToolbox.framework

AVFoundation.framework

CoreGraphics.framework

CoreMedia.framework

CoreVideo.framework

libbz2.tbd

libz.tbd

MediaPlayer.framework

MobileCoreServices.framework

OpenGLES.framework

QuartzCore.framework

UIKit.framework

VideoToolbox.framework 
````

### 播放代码


	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didChangeNotification:) name:IJKMPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    
    [self loadingImgView];
    
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    // 硬解
	//    [options setPlayerOptionIntValue:1  forKey:@"videotoolbox"];
	//    // 帧速率(fps) （可以改，确认非标准桢率会导致音画不同步，所以只能设定为15或者29.97）
	//    [options setPlayerOptionIntValue:29.97 forKey:@"r"];
	//    // -vol——设置音量大小，256为标准音量。（要设置成两倍音量时则输入512，依此类推
	//    [options setPlayerOptionIntValue:512 forKey:@"vol"];
    // 去掉缓冲区
	//    [options setPlayerOptionIntValue:0 forKey:@"packet-buffering"];
    
    NSURL *url = [NSURL URLWithString:self.stream_addr];
    IJKFFMoviePlayerController *playerVc = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:options];
    [playerVc prepareToPlay];
    _playerVc = playerVc;
    playerVc.view.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:playerVc.view];
效果如图:![](https://ws1.sinaimg.cn/large/9e1008a3ly1fe2oj9ikvij20cr0lh137.jpg)



### IJKMediaFramework已上传百度云
IJKMediaFramework.framework [下载](https://pan.baidu.com/s/1hsJZFzm)  密码: vqwp