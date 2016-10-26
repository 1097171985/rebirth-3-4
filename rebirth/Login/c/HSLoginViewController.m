//
//  HSLoginViewController.m
//  rebirth
//
//  Created by 侯帅 on 16/7/20.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSLoginViewController.h"
#import "HSRegisterViewController.h"
#import "HSReviseViewController.h"
#import "HomeViewController.h"
#import "WJFIdeaVC.h"
#import "HSBindingViewController.h"
#import "GradePrerogativeVC.h"
#import "HSSementViewController.h"
@interface HSLoginViewController ()<UITextFieldDelegate>

@end

@implementation HSLoginViewController
{
    UITextField *_phoneText;
    UITextField *_passwordText;
    UIButton *loginBtn;
    BOOL *isLook;
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
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    isLook =YES;
    [self creatView];
    
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
    //210*120
    UIImageView *rebirthIMG = [[UIImageView alloc] init];
    rebirthIMG.image = [UIImage imageNamed:@"logo_gold@2x"];
    [self.view addSubview:rebirthIMG];
    [rebirthIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(135*WIDTHRATIO);
        make.right.equalTo(self.view).offset(-135*WIDTHRATIO);
        make.top.mas_equalTo(self.view).offset(100);
        make.height.mas_equalTo(60*HEIGHTRATIO);
        
    }];
    _phoneText = [[UITextField alloc] init];
    _phoneText.placeholder = @"请输入手机号";
    //居中
    _phoneText.textAlignment = NSTextAlignmentCenter;
    _phoneText.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    UIImageView *img =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phone_icon@2x"]];
    img.frame =CGRectMake(0, 0, 15, 20);

    _phoneText.leftView =img;
    _phoneText.leftViewMode=UITextFieldViewModeAlways;
    [self.view addSubview:_phoneText];
    [_phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.top.mas_equalTo(_phoneText).offset(40);
    }];
    _passwordText = [[UITextField alloc] init];
    _passwordText.placeholder = @"请输入密码";
    _passwordText.textAlignment = NSTextAlignmentCenter;
    [_passwordText setSecureTextEntry:YES];
    UIImageView *img1 =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password_icon@2x"]];
    img1.frame =CGRectMake(0, 0, 15, 20);
    
    _passwordText.leftView =img1;
    _passwordText.leftViewMode=UITextFieldViewModeAlways;
    _passwordText.enabled =YES;
    [self.view addSubview:_passwordText];
    [_passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_phoneText);
        make.right.mas_equalTo(_phoneText);
        make.top.mas_equalTo(line).offset(1);
        make.height.mas_equalTo(_phoneText);
    }];
    UIButton *mima = [UIButton buttonWithType:UIButtonTypeCustom];
    mima.frame =CGRectMake(280, 5, 40, 40);
   // [mima setBackgroundColor:[UIColor blackColor]];
    [mima setImage:[UIImage imageNamed:@"password_see@2x"] forState:UIControlStateNormal];
    [mima addTarget:self action:@selector(click_mima:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mima];
    [mima mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@40);
        make.height.equalTo(@40);
        make.top.equalTo(_passwordText);
        make.right.equalTo(_passwordText);
        
    }];
    [_phoneText addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingChanged];
    [_passwordText addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingChanged];
    
    
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line);
        make.right.mas_equalTo(line);
        make.top.mas_equalTo(_passwordText).offset(40);
        make.height.mas_equalTo(line);
        
    }];
    loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setBackgroundColor:[NSString colorWithHexString:bukedianjibtn]];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.enabled = NO;
    [loginBtn addTarget:self action:@selector(click_login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line1);
        make.right.mas_equalTo(line1);
        make.top.mas_equalTo(line1).offset(40);
        make.height.mas_equalTo(_passwordText);
        
    }];
    loginBtn.layer.cornerRadius = 3;
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setBackgroundColor:[UIColor clearColor]];
    [registerBtn setTitleColor:[NSString colorWithHexString:@"#e4c675"] forState:UIControlStateNormal];
    [registerBtn setTitle:@"立刻注册" forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [registerBtn addTarget:self action:@selector(click_reg:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(56/2);
        make.width.mas_equalTo(60);
        make.top.mas_equalTo(loginBtn).offset(80);
        make.height.mas_equalTo(16);
        
    }];
    
    UIButton *forget = [UIButton buttonWithType:UIButtonTypeCustom];
    [forget setBackgroundColor:[UIColor clearColor]];
    [forget setTitleColor:[NSString colorWithHexString:heitizi] forState:UIControlStateNormal];
    [forget setTitle:@"忘记密码" forState:UIControlStateNormal];
    forget.titleLabel.font = [UIFont systemFontOfSize:14];
    [forget addTarget:self action:@selector(click_forget:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forget];
    [forget mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).offset(-56/2);
        make.width.mas_equalTo(60);
        make.top.mas_equalTo(loginBtn).offset(80);
        make.height.mas_equalTo(16);
        
    }];

    
    
}
-(void)click_reg:(UIButton *)sender{
    NSLog(@"注册");
    HSRegisterViewController *hsr = [[HSRegisterViewController alloc] init];
    [self.navigationController pushViewController:hsr animated:YES];
}
-(void)click_mima:(UIButton *)sender{
    NSLog(@"查看密码");
    
    if (isLook ) {
        [_passwordText setSecureTextEntry:NO];
        isLook = NO;
    }else{
         [_passwordText setSecureTextEntry:YES];
        isLook = YES;
    }
   
}
-(void)click_back:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
  //  [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)click_login:(UIButton *)sender{
    NSLog(@"登录");
    
    if ([YkxHttptools isMobileNumber:_phoneText.text]==YES) {
        [self httplogin];
    }else{
        [Common tipAlert:@"请输入正确的手机号"];
    }
    
}
-(void)click_forget:(UIButton *)sender{
    NSLog(@"忘记密码");
    HSReviseViewController *hsrevise = [[HSReviseViewController alloc] init];
    [self.navigationController pushViewController:hsrevise animated:YES];
}
-(void)httplogin{
    /*100 登陆验证
     URL：http://www.rempeach.com/rebirth/api/login/login
     接口描述：登录请求
     请求方式：POST
     上传参数：user_name   13484011011   用户名 或者 手机号
             pwd          123123       密码 （不需要加密）
             round        21145        5位的随机数
             sign         d45ba53e937d84d0c0500f8dda61b12d        签名
     
     
     
     返回参数：state ：200 111 101 状态码（见附录）
     
     
*/
    NSString *pwd = _passwordText.text;
    NSString *round = @"21145";
    NSString *user_name =_phoneText.text;
   
    
    NSArray *nameList = @[vn(pwd),vn(round),vn(user_name)];
    
    NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(pwd),sv(round),sv(user_name),nil];
    NSLog(@"%@",parameters1);
//    NSDictionary *parDic =@{@"user_name":@"15847517316",@"pwd":@"123123",@"round":@"21145",@"sign":@"3b5e8b15dc9a404a347112bd2e0df6",@"debug":@"true"};
    
    
    [YkxHttptools post:loginHttp params:parameters1 success:^(id responseObj) {
        NSLog(@"%@",[responseObj objectForKey:@"tip"]);
        if ([[responseObj objectForKey:@"state"] isEqualToString:@"200"]) {
            NSDictionary *dic = [responseObj objectForKey:@"data"];
            NSString *idd = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
            [USER_DEFAULT setObject:idd forKey:@"id"];
            
            NSLog(@"%@==%@",[dic objectForKey:@"id"],[dic objectForKey:@"token"]);
            [USER_DEFAULT setObject:[dic objectForKey:@"token"] forKey:@"token"];
            [USER_DEFAULT setObject:_phoneText.text forKey:@"phone"];
            if([self.source isEqualToString:@"ItineraryVC"]){
                                     /* TODO: Whatever you want here */
                
                [self.navigationController popViewControllerAnimated:YES];

            
            }else if ([self.source isEqualToString:@"BindingView"]){
                
             
                HSBindingViewController *vc = [[HSBindingViewController alloc]init];
                vc.stype = @"login";
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }else if ([self.source isEqualToString:@"IdeaVC"]){
                
                WJFIdeaVC *vc = [[WJFIdeaVC alloc]init];
                vc.stype = @"login";
                [self.navigationController pushViewController:vc animated:YES];
                
            }else if ([self.source isEqualToString:@"TieZhi"]){
                
                HSSementViewController *vc = [[HSSementViewController alloc]init];
                vc.stype = @"login";
                [self.navigationController pushViewController:vc animated:YES];

                
            }else if ([self.source isEqualToString:@"GradePrerogative"]){
                
                GradePrerogativeVC *vc = [[GradePrerogativeVC alloc]init];
                vc.stype = @"login";
                [self.navigationController pushViewController:vc animated:YES];
                
            }else{
                
               
                [self.navigationController pushViewController:[[HomeViewController alloc] init] animated:YES];
            }
         
            [LCProgressHUD showSuccess:@"登录成功"];
        }else if ([[responseObj objectForKey:@"state"] isEqualToString:@"111"]){
             NSLog(@"%@11111",[responseObj objectForKey:@"tip"]);
             NSLog(@"%@2222",[responseObj objectForKey:@"message"]);
             [Common tipAlert:[responseObj objectForKey:@"message"]];
        }else{
            NSLog(@"%@",[responseObj objectForKey:@"tip"]);
        }
        
    } failure:^(NSError *error) {
        NSLog(@"111");
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (_passwordText.text.length>=6&&_phoneText.text.length==11) {
        loginBtn.enabled = YES;
        [loginBtn setBackgroundColor:[UIColor blackColor]];
        [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
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

@end
