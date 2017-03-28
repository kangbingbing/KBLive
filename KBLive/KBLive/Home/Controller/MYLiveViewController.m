//
//  MYLiveViewController.m
//  KBLive
//
//  Created by kangbing on 17/3/28.
//  Copyright © 2017年 kangbing. All rights reserved.
//

#import "MYLiveViewController.h"
#import "LFLiveSession.h"
#import "Masonry.h"

@interface MYLiveViewController ()<LFLiveSessionDelegate>

@property (nonatomic, strong) LFLiveSession *session;

@end

@implementation MYLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self prepareView];
}
- (LFLiveSession *)session {
    if (!_session) {
        _session = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfiguration]];
        _session.preView = self.view;
        _session.delegate = self;
    }
    return _session;
}

- (void)startLive {
    LFLiveStreamInfo *streamInfo = [LFLiveStreamInfo new];
    streamInfo.url = @"rtmp://192.168.1.115:1935/rtmplive/room";;
    [self.session startLive:streamInfo];
}

- (void)stopLive {
    [self.session stopLive];
}


- (void)liveSession:(nullable LFLiveSession *)session liveStateDidChange: (LFLiveState)state{

    dispatch_async(dispatch_get_main_queue(), ^{
        switch (state) {
            case LFLiveReady:
//                [weakSelf.controlView setLiveState:MPLiveStateLoading];
                break;
            case LFLivePending:
//                [weakSelf.controlView setLiveState:MPLiveStateLoading];
                break;
            case LFLiveStart:
//                [weakSelf.controlView setLiveState:MPLiveStatePlay];
                break;
            case LFLiveError:
                //            _stateLabel.text = @"连接错误";
                break;
            case LFLiveStop:
//                [weakSelf.controlView setLiveState:MPLiveStateStop];
                break;
            default:
                break;
        }
    });
    
}
- (void)liveSession:(nullable LFLiveSession *)session debugInfo:(nullable LFLiveDebug*)debugInfo{

    NSLog(@"debugInfo: %lf", debugInfo.dataFlow);
    
}
- (void)liveSession:(nullable LFLiveSession*)session errorCode:(LFLiveSocketErrorCode)errorCode{

    NSLog(@"errorCode: %ld", errorCode);
    
}

- (void)prepareView{
    
    
    UIButton *liveClickBtn = [[UIButton alloc]init];
    [self.view addSubview:liveClickBtn];
    liveClickBtn.backgroundColor = [UIColor blackColor];
    [liveClickBtn setTitle:@"我要直播" forState:UIControlStateNormal];
    [liveClickBtn setTitle:@"结束直播" forState:UIControlStateSelected];
    [liveClickBtn addTarget:self action:@selector(btnLiveClick:) forControlEvents:UIControlEventTouchUpInside];
    [liveClickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.view).offset(-15);
        make.left.equalTo(self.view).offset(15);
    }];

    


}

- (void)btnLiveClick:(UIButton *)btn{
    
//    btn.selected = !btn.selected;
    
    [self startLive];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
