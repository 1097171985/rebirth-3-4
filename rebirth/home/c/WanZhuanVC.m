//
//  WanZhuanVC.m
//  rebirth
//
//  Created by boom on 16/8/10.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "WanZhuanVC.h"

@interface WanZhuanVC ()<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *wanZhuanWebView;

@end

@implementation WanZhuanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backpreviousClick:)];
    rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGestureRecognizer];
    self.view.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    
    [self.leftBtu setImage:[UIImage imageNamed:@"back_arrow@2x"] forState:UIControlStateNormal];
    
    self.menuView.text = @"玩转UP！";
    
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0, 64,WIDTH,1)];
    label.textColor = [NSString colorWithHexString:@"#bbbbbb"];
    
    [self.view addSubview:label];
    [self createWeb];
    // Do any additional setup after loading the view.
}

-(void)backpreviousClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createWeb{
    
//    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"index_list" ofType:@"html"];
//    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//    
//    
//    self.wanZhuanWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0,65, WIDTH, HEIGHT)];
//    
//    self.wanZhuanWebView.delegate = self;
//    [self.view addSubview:self.wanZhuanWebView];
//    
//    [self.wanZhuanWebView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, kScreenWidth, kScreenHeight-NAV_BAR_HEIGHT)];
    [self.view addSubview:webView];
//    NSString *path = [[NSBundle mainBundle] bundlePath];
//    NSURL *baseURL = [NSURL fileURLWithPath:path];
//    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"index_list"
//                                                          ofType:@"html"];
//    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
//                                                    encoding:NSUTF8StringEncoding
//                                                       error:nil];
//    [webView loadHTMLString:htmlCont baseURL:baseURL];
    NSURL *url = [NSURL URLWithString:@"http://www.rempeach.com/rempeach/indexs/up/index_list.html"];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];

    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{

    
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
