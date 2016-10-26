//
//  HSSettingPasswordViewController.m
//  rebirth
//
//  Created by 侯帅 on 16/7/21.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSSettingPasswordViewController.h"
#import "HomeViewController.h"

@interface HSSettingPasswordViewController ()<UITextFieldDelegate>

@end

@implementation HSSettingPasswordViewController
{
    UITextField *_password;
    UITextField *_querenPassword;
    UIButton *loginBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatView];
    // Do any additional setup after loading the view.
}
-(void)creatView{
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"bind_back_arrow@2x"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(click_back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(28);
        make.top.mas_equalTo(self.view).offset(40);
        make.height.mas_equalTo(32);
        make.width.mas_equalTo(32);
    }];
    UIImageView *rebirthIMG = [[UIImageView alloc] init];
    rebirthIMG.image = [UIImage imageNamed:@"logo_gold@2x"];
    [self.view addSubview:rebirthIMG];
    [rebirthIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(135*WIDTHRATIO);
        make.right.equalTo(self.view).offset(-135*WIDTHRATIO);
        make.top.mas_equalTo(self.view).offset(100);
        make.height.mas_equalTo(60*HEIGHTRATIO);
    }];
    _password = [[UITextField alloc] init];
    _password.placeholder = @"  请设置密码";
     [_password setSecureTextEntry:YES];
    [_password addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingChanged];

    [self.view addSubview:_password];
    [_password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(56/2);
        make.right.mas_equalTo(self.view).offset(-56/2);
        make.top.mas_equalTo(rebirthIMG).offset(100);
        make.height.mas_equalTo(40);
        
    }];
    UIView*line = [[UIView alloc] init];
    line.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(56/2);
        make.right.mas_equalTo(self.view).offset(-56/2);
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(_password).offset(40);
    }];
    _querenPassword = [[UITextField alloc] init];
    _querenPassword.placeholder = @"  请确认密码";
     [_querenPassword setSecureTextEntry:YES];
    [_querenPassword addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingChanged];
//    UIImageView *img1 =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password_icon@2x"]];
//    img1.frame =CGRectMake(0, 0, 15, 20);
//    
//    _querenPassword.leftView =img1;
//    _querenPassword.leftViewMode=UITextFieldViewModeAlways;
    [self.view addSubview:_querenPassword];
    [_querenPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_password);
        make.right.mas_equalTo(_password);
        make.top.mas_equalTo(line).offset(1);
        make.height.mas_equalTo(_password);
    }];
    
    
    
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line);
        make.right.mas_equalTo(line);
        make.top.mas_equalTo(_querenPassword).offset(40);
        make.height.mas_equalTo(line);
        
    }];
    loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setBackgroundColor:[NSString colorWithHexString:bukedianjibtn]];
    [loginBtn setTitle:@"注册" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(click_login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line1);
        make.right.mas_equalTo(line1);
        make.top.mas_equalTo(line1).offset(40);
        make.height.mas_equalTo(_password);
        
    }];
    loginBtn.layer.cornerRadius = 3;
       
    
    
}
-(void)click_back:(UIButton *)sender{
    NSLog(@"back");
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)click_next:(UIButton *)sender{
    NSLog(@"next");
}
-(void)click_login:(UIButton *)sender{
    NSLog(@"login");
    if ([_querenPassword.text isEqualToString:_password.text]) {
        [self httpRegs];
    }else{
        [Common tipAlert:@"两次密码不一致"];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)httpRegs{
    /*103 注册请求
     URL：www.rempeach.com/rebirth/api/login/regist
     接口描述：注册
     请求方式：POST
     上传参数：
     phone          15847517316
     registCode     894w8r94g1e6a96g4ag1ae6gss4
     pwd            123123
     other_id       (选填)    第三方ID
     otherType      0        注册方式 0：默认注册 1：其他方式（待定）
     round          21145
     sign           2d19e812b4cc7b29c80bdbad1a7028a0
      a b c d e f g h i g k l m n o p q r s t u v w x y z
     返回参数：state ：200 111 101 状态码（见附录）
*/
    
    NSString *otherType = @"0";
    NSString *phone = self.phoneNum;
    NSString *pwd = _querenPassword.text;
    NSString *registCode = self.registCode;
    NSString *round = @"21145";
    NSArray *nameList = @[vn(otherType),vn(phone),vn(pwd),vn(registCode),vn(round)];
    
    NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(otherType),sv(phone),sv(pwd),sv(registCode),sv(round),nil];
    NSLog(@"%@",parameters1);
    [YkxHttptools post:regzhanghao params:parameters1 success:^(id responseObj) {
        if ([[responseObj objectForKey:@"state"] isEqualToString:@"200"]) {
            NSDictionary *dic = [responseObj objectForKey:@"data"];
           
            NSString *idd = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
            [USER_DEFAULT setObject:idd forKey:@"id"];
            [USER_DEFAULT setObject:[dic objectForKey:@"token"] forKey:@"token"];
            [USER_DEFAULT setObject:self.phoneNum forKey:@"phone"];
        
            [self.navigationController pushViewController:[[HomeViewController alloc] init] animated:YES];
            [LCProgressHUD showSuccess:@"注册成功"];
        }else if ([[responseObj objectForKey:@"state"] isEqualToString:@"111"]){
            NSLog(@"%@",[responseObj objectForKey:@"tip"]);
            NSLog(@"%@",[responseObj objectForKey:@"message"]);
        }else{
            NSLog(@"%@",[responseObj objectForKey:@"tip"]);
        }
    } failure:^(NSError *error) {
        
    }];
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (_password.text.length>=6&&_querenPassword.text.length>=6) {
        loginBtn.enabled = YES;
        [loginBtn setBackgroundColor:[UIColor blackColor]];
        [loginBtn setTitle:@"注册" forState:UIControlStateNormal];
        [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }else{
        loginBtn.enabled =NO;
        loginBtn.backgroundColor =[NSString colorWithHexString:bukedianjibtn];
    }
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}

@end
