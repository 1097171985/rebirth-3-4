//
//  HSXYViewController.m
//  rebirth
//
//  Created by 侯帅 on 16/10/10.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSXYViewController.h"

@interface HSXYViewController ()<UITextViewDelegate>

@end

@implementation HSXYViewController
{
    UITextView *XYTextView;
    UIButton *btn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [NSString  colorWithHexString:@"f2f2f2"];
    [self creatNavi];
    [self creatView];
    // Do any additional setup after loading the view.
    
}
-(void)http{
    /*405 意见反馈
     URL：http://www.rempeach.com/rebirth/api/user/feedback
     接口描述：意见反馈
     请求方式：POST
     上传参数：
     id
     idea
     category       1
     token
     sign
     
     
     返回参数：state ：210 111 101 121 状态码（见附录） */
    NSString *category = @"1";
    NSString *transformId=[USER_DEFAULT objectForKey:@"id"];
    NSString *idea=XYTextView.text;
    NSString *token=[USER_DEFAULT objectForKey:@"token"];
   
    
    
    NSArray *nameList = @[vn(category),@"id",vn(idea),vn(token)];
    NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(category),sv(transformId),sv(idea),sv(token),nil];
    NSLog(@"%@",parameters1);
    NSString *str = sv(transformId);
   // NSDictionary *dic = @{@"category":@"1",@"id":[USER_DEFAULT objectForKey:@"id"],@"idea":@"eref",@"token":[USER_DEFAULT objectForKey:@"token"],@"sign":@"4ceabddec1aa1a5943a0c48d1492f9a3",@"debug":@"true"};
    [YkxHttptools post:@"http://www.rempeach.com/rebirth/api/user/feedback" params:parameters1 success:^(id responseObj) {
        NSLog(@"%@",[responseObj objectForKey:@"tip"]);
        if ([[responseObj objectForKey:@"state"] isEqualToString:@"210"]) {
            [Common tipAlert:@"提交成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [Common tipAlert:[responseObj objectForKey:@"message"]];
        }
    } failure:^(NSError *error) {
        
    }];
    
    
}
//-(void)textViewDidEndEditing:(UITextView *)textView{
//    if (XYTextView.text.length>6) {
//        btn.enabled =YES;
//    }else{
//        btn.enabled=NO;
//    }
//}
-(void)creatNavi{
    UIView *navi = [[UIView alloc] init];
    navi.frame =CGRectMake(0, 0,kScreenWidth , NAV_BAR_HEIGHT);
    navi.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navi];
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(50, kStatusBarHeight, kScreenWidth-100, NAV_BAR_HEIGHT-kStatusBarHeight)];
    titleLbl.textColor = [NSString colorWithHexString:heitizi];
    titleLbl.text = @"心愿单";
    titleLbl.font = [UIFont systemFontOfSize:16];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    [navi addSubview:titleLbl];
    UIButton *backBtn=  [YkxHttptools initwithButton:[UIColor clearColor] Frame:CGRectMake(0, kStatusBarHeight, 50, NAV_BAR_HEIGHT-kStatusBarHeight) Image:[UIImage imageNamed:@"back_arrow@2x"] Title:nil Titlecolor:[NSString colorWithHexString:heitizi ] Titlefont:[UIFont systemFontOfSize:14] BaseView:navi];
    [backBtn addTarget:self action:@selector(click_back:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)click_back:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)creatView{
    UIView *contentView = [[UIView alloc] init];
    contentView.frame =CGRectMake(0, NAV_BAR_HEIGHT+12, kScreenWidth, 210);
    contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentView];
    XYTextView = [[UITextView alloc] init];


    XYTextView.frame =CGRectMake(12,12, kScreenWidth-24, contentView.frame.size.height-24);
    [contentView addSubview:XYTextView];
    XYTextView.textColor = [UIColor lightGrayColor];
    XYTextView.text = NSLocalizedString(@"告诉我们你的心愿", nil);
    XYTextView.selectedRange = NSMakeRange(0, 0);
    XYTextView.delegate = self;
    XYTextView.font = [UIFont systemFontOfSize:14];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(12, NAV_BAR_HEIGHT+12+contentView.frame.size.height+40, kScreenWidth-24, 96/2);
    
    btn.backgroundColor = [UIColor blackColor];
    [btn setTitleColor:[NSString colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    [btn setTitle:@"许愿" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(click_tijiao:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 8;
}
-(void)click_tijiao:(UIButton *)sender{
    NSLog(@"提交");
    if (XYTextView.text.length>6) {
         [self http];
    }else{
        [Common tipAlert:@"请输入大于10位的字数"];
    }
   
}
-(void)textViewDidChangeSelection:(UITextView *)textView{
    if (textView.textColor==[UIColor lightGrayColor])//如果是提示内容，光标放置开始位置
    {
        NSRange range;
        range.location = 0;
        range.length = 0;
        textView.selectedRange = range;
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if (![text isEqualToString:@""]&&textView.textColor==[UIColor lightGrayColor])//如果不是delete响应,当前是提示信息，修改其属性
    {
        textView.text=@"";//置空
        textView.textColor=[UIColor blackColor];
    }
    
    if ([text isEqualToString:@"\n"])//回车事件
    {
        if ([textView.text isEqualToString:@""])//如果直接回车，显示提示内容
        {
            textView.textColor=[UIColor lightGrayColor];
            textView.text=NSLocalizedString(@"告诉我们你的心愿", nil);
        }
        [textView resignFirstResponder];//隐藏键盘
        return NO;
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""])
    {
        textView.textColor=[UIColor lightGrayColor];
        textView.text=NSLocalizedString(@"InputReason", nil);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
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
