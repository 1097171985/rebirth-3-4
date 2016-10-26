//
//  GSPayVC.m
//  rebirth
//
//  Created by WJF on 16/10/11.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "GSPayVC.h"

@interface GSPayVC ()

@end

@implementation GSPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webview = [[UIWebView alloc]initWithFrame:CGRectMake(0,64
                                                                    ,WIDTH,HEIGHT)];
    
    [self.view addSubview:webview];
    NSURL *url = [NSURL URLWithString: @"http://www.rempeach.com/rebirth/api/order/getDataOfPay"];
    NSString *body1 = [NSString stringWithFormat: @"id=%@&instalment_num=%@&oid=%@&pay_type=8&round=%@&sign=%@&token=%@",self.paraDict[@"id"],self.paraDict[@"instalment_num"],self.paraDict[@"oid"],self.paraDict[@"round"],self.paraDict[@"sign"],self.paraDict[@"token"]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: [body1 dataUsingEncoding: NSUTF8StringEncoding]];
    [webview loadRequest: request];
    

    // Do any additional setup after loading the view.
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
