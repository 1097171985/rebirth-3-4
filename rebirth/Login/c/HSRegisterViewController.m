//
//  HSRegisterViewController.m
//  rebirth
//
//  Created by 侯帅 on 16/7/21.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSRegisterViewController.h"
#import "HSHQYanzhengmaViewController.h"
#import "HSRegisterDelegateViewController.h"
@interface HSRegisterViewController ()<UITextFieldDelegate>

@end

@implementation HSRegisterViewController
{
    UITextField *_phoneField;
    UIButton *loginBtn;
    BOOL isopen;
    UIButton *delegatebtn;
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
    isopen = YES;
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatView];
    UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backpreviousClick:)];
    rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGestureRecognizer];
    
}
-(void)backpreviousClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
    _phoneField = [[UITextField alloc] init];
    _phoneField.placeholder = @"                          请输入手机号";
    [_phoneField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingChanged];
    
//    UIImageView *img =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phone_icon@2x"]];
//    img.frame =CGRectMake(0, 0, 15, 20);
//    
//    _phoneField.leftView =img;
//    _phoneField.leftViewMode=UITextFieldViewModeAlways;
    [self.view addSubview:_phoneField];
    [_phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.top.mas_equalTo(_phoneField).offset(40);
    }];
       loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setBackgroundColor:[NSString colorWithHexString:bukedianjibtn]];
    [loginBtn setTitle:@"下一步" forState:UIControlStateNormal];
    loginBtn.enabled = NO;
    
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(click_login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line);
        make.right.mas_equalTo(line);
        make.top.mas_equalTo(line).offset(40);
        make.height.mas_equalTo(_phoneField);
        
    }];
    loginBtn.layer.cornerRadius = 3;
       
    
   delegatebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [delegatebtn setImage:[UIImage imageNamed:@"consent_agreement@2x"] forState:UIControlStateNormal];
    [self.view addSubview:delegatebtn];
    [delegatebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginBtn.mas_bottom).offset(16);
        make.height.equalTo(@10);
        make.width.equalTo(@10);
        make.left.equalTo(@100);
    }];
    [delegatebtn addTarget:self action:@selector(click_delegate:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *delegatelbl = [[UILabel alloc] init];
    delegatelbl.backgroundColor = [UIColor clearColor];
    delegatelbl.text = @"我已阅读并同意";
    delegatelbl.textColor = [NSString colorWithHexString:heitizi];
    delegatelbl.font = [UIFont systemFontOfSize:9];
    [self.view addSubview:delegatelbl];
    [delegatelbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(delegatebtn.mas_right).offset(3);
        make.top.equalTo(delegatebtn);
        make.height.equalTo(@10);
        make.width.equalTo(@70);
    }];
    UIButton *tiaokuanbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tiaokuanbtn setTitle:@"使用条款和隐私政策" forState:UIControlStateNormal];
    [tiaokuanbtn setTitleColor:[NSString colorWithHexString:@"#e8ce8c"] forState:UIControlStateNormal];
    tiaokuanbtn.titleLabel.font = [UIFont systemFontOfSize:9];
    tiaokuanbtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:tiaokuanbtn];
    [tiaokuanbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(delegatebtn.mas_right).offset(58);
        make.top.equalTo(delegatelbl);
        make.height.equalTo(delegatelbl);
        make.width.equalTo(@100);
    }];
    [tiaokuanbtn addTarget:self action:@selector(click_tiaokuan:) forControlEvents:UIControlEventTouchUpInside];
    
    
}
-(void)click_delegate:(UIButton *)sender{
    if (isopen==YES) {
        isopen=NO;
        [delegatebtn setImage:[UIImage imageNamed:@"consent_agreement_0@2x"] forState:UIControlStateNormal];
    }else{
        isopen =YES;
        [delegatebtn setImage:[UIImage imageNamed:@"consent_agreement@2x"] forState:UIControlStateNormal];
    }
}
-(void)click_tiaokuan:(UIButton *)sender{
    NSLog(@"条款");
    [self.navigationController pushViewController:[[HSRegisterDelegateViewController alloc] init] animated:YES];
    
    
    
    
}
-(void)click_login:(UIButton *)sender{
    NSLog(@"下一步");
    if ([YkxHttptools isMobileNumber:_phoneField.text]==YES) {
        [self httpReg];
    }else{
        [Common tipAlert:@"请输入正确的手机号"];
    }
    
}
-(void)click_back:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)httpReg{
   /* 101 验证手机号
    URL：http://www.rempeach.com/rebirth/api/login/regist_checkPhone
    接口描述：发送手机号进行用户验证以及发送验证码
    请求方式：POST
    上传参数：
    phone           13484011010           用户名 或者 手机号
    round           21145                 5位的随机数
    sign            d45ba53e937d84d0c0500f8dda61b12d       签名
    
    abcdefghigklmnopqrstuvwxyz
    返回参数：state ：210 111 101 状态码（见附录） 
    */
    NSString *phone = _phoneField.text;
    NSString *round = @"21145";
    NSArray *nameList = @[vn(phone),vn(round)];
    
    NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(phone),sv(round),nil];
    NSLog(@"%@",parameters1);
    [YkxHttptools post:regPhoneNum params:parameters1 success:^(id responseObj) {
        if ([[responseObj objectForKey:@"state"] isEqualToString:@"210"]) {
           // [Common tipAlert:[responseObj objectForKey:@"message"]];
            HSHQYanzhengmaViewController *hshq = [[HSHQYanzhengmaViewController alloc] init];
            hshq.phoneNum = _phoneField.text;
            [self.navigationController pushViewController:hshq animated:YES];
        }else if ([[responseObj objectForKey:@"state"] isEqualToString:@"111"]){
            [Common tipAlert:[responseObj objectForKey:@"message"]];
            NSLog(@"%@",[responseObj objectForKey:@"message"]);
        }else{
            
        }
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (_phoneField.text.length==11&&isopen==YES) {
        loginBtn.enabled = YES;
        [loginBtn setBackgroundColor:[UIColor blackColor]];
        [loginBtn setTitle:@"下一步" forState:UIControlStateNormal];
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
