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

IJKMediaFramework.framework [下载](https://pan.baidu.com/s/1hr6mlBA)  密码: eatk