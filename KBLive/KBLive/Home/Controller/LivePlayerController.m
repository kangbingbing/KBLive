//
//  LivePlayerController.m
//  KBLive
//
//  Created by kangbing on 17/3/7.
//  Copyright © 2017年 kangbing. All rights reserved.
//

#import "LivePlayerController.h"


@interface LivePlayerController ()

@property (nonatomic, strong) UIImageView *corverImg;

@property(nonatomic, strong) id <IJKMediaPlayback> playerVc;

@end

@implementation LivePlayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

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
    
    [self prepareBackBtn];
}

- (void)didChangeNotification:(NSNotification*)notification{

    self.corverImg.hidden = YES;

}

// 加载图
- (void)loadingImgView
{
    self.corverImg = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [_corverImg sd_setImageWithURL:[NSURL URLWithString:self.cover_url]];
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffectView.frame = _corverImg.bounds;
    [_corverImg addSubview:visualEffectView];
    [self.view addSubview:_corverImg];
    
}

- (void)prepareBackBtn{

    UIButton *backBtn = [[UIButton alloc]init];
    [self.view addSubview:backBtn];
    [backBtn setImage:[UIImage imageNamed:@"close_preview"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15);
        make.bottom.equalTo(self.view).offset(-15);
        make.height.width.equalTo(@50);
    }];
}

- (void)backBtnClick{

    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
//    [_playerVc pause];
//    [_playerVc stop];
    [_playerVc shutdown];
    _playerVc = nil;

    
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
