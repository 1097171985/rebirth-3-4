//
//  HSZCZNViewController.m
//  rebirth
//
//  Created by 侯帅 on 16/8/9.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSZCZNViewController.h"

@interface HSZCZNViewController ()

@end

@implementation HSZCZNViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self creatNavi];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, kScreenWidth, kScreenHeight-NAV_BAR_HEIGHT)];
    [self.view addSubview:webView];
    
    UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backpreviousClick:)];
    rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [webView addGestureRecognizer:rightSwipeGestureRecognizer];
//    NSString *path = [[NSBundle mainBundle] bundlePath];
//    NSURL *baseURL = [NSURL fileURLWithPath:path];
//    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"rental_guide"
//                                                          ofType:@"html"];
//    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
//                                                    encoding:NSUTF8StringEncoding
//                                                       error:nil];
//    [webView loadHTMLString:htmlCont baseURL:baseURL];
    NSURL *url = [NSURL URLWithString:@"http://www.rempeach.com/rempeach/indexs/rental_guide.html"];
    //http://www.rempeach.com/rempeach/indexs/rental_guide.html
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    // Do any additional setup after loading the view.
}
-(void)backpreviousClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)creatNavi{
    UIView *navi = [[UIView alloc] init];
    navi.frame =CGRectMake(0, 0,kScreenWidth , NAV_BAR_HEIGHT);
    navi.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navi];
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(50, kStatusBarHeight, kScreenWidth-100, NAV_BAR_HEIGHT-kStatusBarHeight)];
    titleLbl.textColor = [NSString colorWithHexString:heitizi];
    titleLbl.text = @"租车指南";
    titleLbl.font = [UIFont systemFontOfSize:16];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    [navi addSubview:titleLbl];
    UIButton *backBtn=  [YkxHttptools initwithButton:[UIColor clearColor] Frame:CGRectMake(0, kStatusBarHeight, 50, NAV_BAR_HEIGHT-kStatusBarHeight) Image:[UIImage imageNamed:@"back_arrow@2x"] Title:nil Titlecolor:[NSString colorWithHexString:heitizi ] Titlefont:[UIFont systemFontOfSize:14] BaseView:navi];
    [backBtn addTarget:self action:@selector(click_back:) forControlEvents:UIControlEventTouchUpInside];
    UIView *line = [[UIView alloc]init];
    line.frame =CGRectMake(0, NAV_BAR_HEIGHT-0.5, kScreenWidth, 0.5);
    line.backgroundColor = [NSString colorWithHexString:@"#b4b4b4"];
    [navi addSubview:line];
    
}

-(void)click_back:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
