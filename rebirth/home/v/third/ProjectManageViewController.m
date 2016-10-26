//
//  ProjectManageViewController.m
//  Shuangdaojia_Merchant
//
//  Created by 小浪子 on 16/7/14.
//  Copyright © 2016年 Daochan. All rights reserved.
//

#import "ProjectManageViewController.h"
#import "RootViewController.h"
#import "HSManViewController.h"
@interface ProjectManageViewController ()

@property(nonatomic, strong)RootViewController *goodsListViewController;//朋友圈
@property(nonatomic, strong)HSManViewController *projectListViewController;//资讯
@property(nonatomic, strong) UIView *navi;//资讯



@end

@implementation ProjectManageViewController

- (void)viewDidLoad {
    [self initializeNav];
    self.navView = _navi;

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createSegment];
    
    
}

//创建两个控制器
- (void)createSegment{
    self.projectListViewController = [[HSManViewController alloc]init];
    
    self.goodsListViewController = [[RootViewController alloc]init];
    [self setViewControllers:@[self.projectListViewController,
                               self.goodsListViewController] sectionTitles:@[@"对味资讯", @"对味社交"] height:SCREEN_HEIGHT-40-64];
    
    

}
//点击顶部出发的方法
- (void)segmentedValueChangedAction:(HMSegmentedControl *)segCtrl
{
    [super segmentedValueChangedAction:segCtrl];
    NSLog(@"索引%ld",self.selectedIndex);

}
- (void)initializeNav{
    
//    self.title = @"项目管理";
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"新建" style:UIBarButtonItemStylePlain target:self action:@selector(newAction)];
    _navi = [[UIView alloc] init];
    _navi.frame =CGRectMake(0, 0,kScreenWidth , NAV_BAR_HEIGHT);
    _navi.backgroundColor = [UIColor redColor];
    [self.view addSubview:_navi];
    UIButton *backBtn=  [YkxHttptools initwithButton:[UIColor clearColor] Frame:CGRectMake(0, kStatusBarHeight, 50, NAV_BAR_HEIGHT-kStatusBarHeight) Image:[UIImage imageNamed:@"back_arrow@2x"] Title:nil Titlecolor:[NSString colorWithHexString:heitizi ] Titlefont:[UIFont systemFontOfSize:14] BaseView:_navi];
    [backBtn addTarget:self action:@selector(click_back:) forControlEvents:UIControlEventTouchUpInside];


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
