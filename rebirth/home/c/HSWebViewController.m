//
//  HSWebViewController.m
//  rebirth
//
//  Created by 侯帅 on 16/8/16.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSWebViewController.h"
#import "android.h"
#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self;
@interface HSWebViewController ()<UIWebViewDelegate>

@end

@implementation HSWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *web = [[UIWebView alloc] init];
    web.frame =CGRectMake(0, NAV_BAR_HEIGHT, kScreenWidth, kScreenHeight);
    [self.view addSubview:web];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.rempeach.com/rebirth/Admin/Feedback/feedback.html?id=%@",[USER_DEFAULT objectForKey:@"id"]]];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [web loadRequest:request];
    UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backpreviousClick:)];
    rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [web addGestureRecognizer:rightSwipeGestureRecognizer];
    // Do any additional setup after loading the view.
}
-(void)backpreviousClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"开始加载");
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"%@",title);

    
    
   
    
    
    //网页加载完成调用此方法
    
    //首先创建JSContext 对象（此处通过当前webView的键获取到jscontext）
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //第二种情况，js是通过对象调用的，我们假设js里面有一个对象 testobject 在调用方法
    //首先创建我们新建类的对象，将他赋值给js的对象
    WS(ws);
    android *testJO=[android new];
    context[@"android"]=testJO;
    
    testJO.htmlBack = ^(NSString *str){
        if ([str isEqualToString:@"pickSource"]) {
            [self.navigationController popViewControllerAnimated:YES];
            
        }else {
            
            
            
            
        }
        
        
    };
    
    
    
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
