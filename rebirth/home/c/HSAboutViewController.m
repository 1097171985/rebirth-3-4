//
//  HSAboutViewController.m
//  rebirth
//
//  Created by 侯帅 on 16/7/26.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSAboutViewController.h"
#import "HSServiceViewController.h"
#import "HSDelegateViewController.h"
#import "CCWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "HSWebViewController.h"
#import "WJFIdeaVC.h"
#import "HSLoginViewController.h"
#import "GradePrerogativeVC.h"
@interface HSAboutViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation HSAboutViewController
{
    NSMutableArray *_dataArr;
}
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
    _dataArr = [[NSMutableArray alloc] initWithObjects:@"服务条款",@"评价app",@"联系我们",@"意见反馈",@"等级特权",nil];
    // Do any additional setup after loading the view.
    [self creatTab];
}
-(void)creatNavi{
    UIView *navi = [[UIView alloc] init];
    navi.frame =CGRectMake(0, 0,kScreenWidth , NAV_BAR_HEIGHT);
    navi.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navi];
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(50, kStatusBarHeight, kScreenWidth-100, NAV_BAR_HEIGHT-kStatusBarHeight)];
    titleLbl.textColor = [NSString colorWithHexString:heitizi];
    titleLbl.text = @"关于UP";
    titleLbl.font = [UIFont systemFontOfSize:16];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    [navi addSubview:titleLbl];
    UIButton *backBtn=  [YkxHttptools initwithButton:[UIColor clearColor] Frame:CGRectMake(0, kStatusBarHeight, 50, NAV_BAR_HEIGHT-kStatusBarHeight) Image:[UIImage imageNamed:@"back_arrow@2x"] Title:nil Titlecolor:[NSString colorWithHexString:heitizi ] Titlefont:[UIFont systemFontOfSize:14] BaseView:navi];
    [backBtn addTarget:self action:@selector(click_back:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)click_back:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)creatTab{
    UITableView *htable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, kScreenWidth, kScreenHeight-NAV_BAR_HEIGHT) style:UITableViewStylePlain];
    htable.delegate = self;
    htable.dataSource = self;
    [self.view addSubview:htable];
    UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backpreviousClick:)];
    rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [htable addGestureRecognizer:rightSwipeGestureRecognizer];
    htable.scrollEnabled = NO;
     htable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
-(void)backpreviousClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _dataArr[indexPath.row];
    cell.textLabel.textColor = [NSString colorWithHexString:heitizi];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    UIView *line = [[UIView alloc] init];
    line.frame =CGRectMake(0, 40, kScreenWidth, 0.5);
    line.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    [cell addSubview:line];
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        [self.navigationController pushViewController:[[HSServiceViewController alloc] init] animated:YES];
    }else if(indexPath.row ==1){
        
        if (TARGET_IPHONE_SIMULATOR) {
            
            [LCProgressHUD showMessage:@"模拟器不可跳转APPStore"];
            
        }else{
        
        
        //http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=414478124&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1142429746&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"]];
//[[UIApplication sharedApplication]openURL:[NSURLURLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=APPID&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"]];
      //  [self.navigationController pushViewController:[[HSDelegateViewController alloc] init] animated:YES];
        }
    }else if (indexPath.row ==2){
       
        if (TARGET_IPHONE_SIMULATOR) {
            
            [LCProgressHUD showMessage:@"模拟器不支持打电话"];
            
        }else{
            
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"18969050270"];
            UIWebView * callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            [self.view addSubview:callWebview];
                  }
       
    }else if (indexPath.row ==3){
        if ([USER_DEFAULT objectForKey:@"id"]) {
            
            WJFIdeaVC *wj = [[WJFIdeaVC alloc] init];
            [self.navigationController pushViewController:wj animated:YES];
            
        }else{
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"您需要登录,请先登录" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                //                [UIView  beginAnimations:nil context:NULL];
                //                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                //                [UIView setAnimationDuration:0.75];
                NSLog(@"确定");
                HSLoginViewController *vc = [[HSLoginViewController alloc]init];
                vc.source = @"IdeaVC";
                
                [UIView transitionWithView: self.navigationController.view
                                  duration: 0.35f
                                   options: nil
                                animations: ^(void)
                 {
                     
                     CATransition *transition = [CATransition animation];
                     transition.type = kCATransitionPush;
                     transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                     transition.fillMode = kCAFillModeForwards;
                     transition.duration = 0.6;
                     transition.subtype = kCATransitionFromBottom;
                     [[self.navigationController.view layer] addAnimation:transition forKey:@"NavigationControllerAnimationKey"];
                     
                 }completion: ^(BOOL isFinished)
                 {
                     /* TODO: Whatever you want here */
                     [self.navigationController.view.layer removeAnimationForKey:@"NavigationControllerAnimationKey"];
                     
                 }];
                
                [self.navigationController pushViewController:vc animated:NO];
                
            }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                NSLog(@"取消");
                
            }];
            
            [alert addAction:ok];//添加按钮
            [alert addAction:cancel];//添加按钮
            //以modal的形式
            [self presentViewController:alert animated:YES completion:^{ }];
            
            
        }
    }else if (indexPath.row == 4){
        if ([USER_DEFAULT objectForKey:@"id"]) {
            
            GradePrerogativeVC *vc = [[GradePrerogativeVC alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];

            
        }else{
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"您需要登录,请先登录" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                

                NSLog(@"确定");
                HSLoginViewController *vc = [[HSLoginViewController alloc]init];
                vc.source = @"GradePrerogative";
                
                [UIView transitionWithView: self.navigationController.view
                                  duration: 0.35f
                                   options: nil
                                animations: ^(void)
                 {
                     
                     CATransition *transition = [CATransition animation];
                     transition.type = kCATransitionPush;
                     transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                     transition.fillMode = kCAFillModeForwards;
                     transition.duration = 0.6;
                     transition.subtype = kCATransitionFromBottom;
                     [[self.navigationController.view layer] addAnimation:transition forKey:@"NavigationControllerAnimationKey"];
                     
                 }completion: ^(BOOL isFinished)
                 {
                     /* TODO: Whatever you want here */
                     [self.navigationController.view.layer removeAnimationForKey:@"NavigationControllerAnimationKey"];
                     
                 }];
                
                [self.navigationController pushViewController:vc animated:NO];
                
            }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                NSLog(@"取消");
                
            }];
            
            [alert addAction:ok];//添加按钮
            [alert addAction:cancel];//添加按钮
            //以modal的形式
            [self presentViewController:alert animated:YES completion:^{ }];
            
           }}
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
