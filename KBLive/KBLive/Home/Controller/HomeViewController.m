//
//  HomeViewController.m
//  KBLive
//
//  Created by kangbing on 17/3/7.
//  Copyright © 2017年 kangbing. All rights reserved.
//

#import "HomeViewController.h"
#import "LivePlayerController.h"
#import <AFNetworking/AFNetworking.h>
#import "MJExtension.h"
#import "LiveModel.h"
#import "PersonCell.h"
#import "Masonry.h"
#import "MYLiveViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"我要直播" style:UIBarButtonItemStylePlain target:self action:@selector(liveBtnClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self prepareTableView];
    
    [self loadData];
}

- (void)prepareTableView{

    UITableView *tableView = [[UITableView alloc]init];
    self.tableView = tableView;
    tableView.frame = self.view.bounds;
    tableView.rowHeight = ([UIScreen mainScreen].bounds.size.width * 618/480)+1;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"personCell";
    
    PersonCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[PersonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.liveModel = self.dataArray[indexPath.row];

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LiveModel *model = self.dataArray[indexPath.row];
    LivePlayerController *liveVC = [[LivePlayerController alloc]init];
    liveVC.stream_addr = model.stream_addr;
    liveVC.cover_url = model.creator.portrait;
    [self.navigationController pushViewController:liveVC animated:YES];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5);
    [UIView animateWithDuration:1 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}

#pragma mark 我要直播 Click
- (void)liveBtnClick{

    MYLiveViewController *liveVC = [[MYLiveViewController alloc]init];
    [self.navigationController presentViewController:liveVC animated:YES completion:nil];
    NSLog(@"我要直播");
}

// 导航栏隐藏
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    UIPanGestureRecognizer* pan = scrollView.panGestureRecognizer;
    // 拖拽的速度 >0 向下拖动 <0 向上拖动
    CGFloat velocity = [pan velocityInView:scrollView].y;
    if (velocity < -5) {
        //向上拖动
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }else if (velocity > 5) {
        //向下拖动
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }else if(velocity==0){
        //停止拖拽
    }
}


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

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
