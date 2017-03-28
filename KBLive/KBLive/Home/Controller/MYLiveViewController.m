//
//  MYLiveViewController.m
//  KBLive
//
//  Created by kangbing on 17/3/28.
//  Copyright © 2017年 kangbing. All rights reserved.
//

#import "MYLiveViewController.h"
#import "LFLivePreview.h"

@interface MYLiveViewController ()


@end

@implementation MYLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(popToViewController) name:@"CloseBtnClick" object:nil];
    
    
    [self.view addSubview:[[LFLivePreview alloc] initWithFrame:self.view.bounds]];
    
    
}

- (void)popToViewController{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self];

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
