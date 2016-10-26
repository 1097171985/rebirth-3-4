//
//  HSReviseViewController.m
//  rebirth
//
//  Created by 侯帅 on 16/7/21.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSReviseViewController.h"
#import "HSXGPwdsecondViewController.h"
@interface HSReviseViewController ()

@end

@implementation HSReviseViewController
{
    UITextField *_phoneText;
}
- (void)viewDidLoad {
    [super viewDidLoad];
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
-(void)click_back:(UIButton *)sender{
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
    _phoneText = [[UITextField alloc] init];
    _phoneText.placeholder = @"  请输入手机号";
    
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
//    _passwordText = [[UITextField alloc] init];
//    _passwordText.placeholder = @"  请输入密码";
//    UIImageView *img1 =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password_icon@2x"]];
//    img1.frame =CGRectMake(0, 0, 15, 20);
//    
//    _passwordText.leftView =img1;
//    _passwordText.leftViewMode=UITextFieldViewModeAlways;
//    [self.view addSubview:_passwordText];
//    [_passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_phoneText);
//        make.right.mas_equalTo(_phoneText);
//        make.top.mas_equalTo(line).offset(1);
//        make.height.mas_equalTo(_phoneText);
//    }];
//    UIButton *mima = [UIButton buttonWithType:UIButtonTypeCustom];
//    mima.frame =CGRectMake(280, 5, 40, 40);
//    // [mima setBackgroundColor:[UIColor blackColor]];
//    [mima setImage:[UIImage imageNamed:@"password_see@2x"] forState:UIControlStateNormal];
//    [mima addTarget:self action:@selector(click_mima:) forControlEvents:UIControlEventTouchUpInside];
//    [_passwordText addSubview:mima];
//    
//    
//    
//    
//    UIView *line1 = [[UIView alloc] init];
//    line1.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:line1];
//    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(line);
//        make.right.mas_equalTo(line);
//        make.top.mas_equalTo(_passwordText).offset(40);
//        make.height.mas_equalTo(line);
//        
//    }];
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setBackgroundColor:[UIColor blackColor]];
    [loginBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(click_login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line);
        make.right.mas_equalTo(line);
        make.top.mas_equalTo(line).offset(40);
        make.height.mas_equalTo(_phoneText);
        
    }];
    loginBtn.layer.cornerRadius = 3;
    
    
}
-(void)click_login:(UIButton *)sender{
    if ([YkxHttptools isMobileNumber:_phoneText.text]==YES) {
        [self httprevisepwd];
    }else{
        [Common tipAlert:@"请输入正确的手机号"];
    }

}
-(void)httprevisepwd{
    /*
     104 忘记密码(获取验证码)
     URL：http://www.rempeach.com/rebirth/api/login/forgetPwd
     接口描述：忘记密码（获取验证码）
     请求方式：POST
     上传参数：
     phone
     round
     sign
     
     返回参数：state ：210 111 101 状态码（见附录）
     手机会收到短信验证码
      a b c d e f g h i j k l m n o p q r s t u v w x y z

*/
    NSString *phone =_phoneText.text;
    NSString *round = @"21145";
    NSArray *nameList = @[vn(phone),vn(round)];
    
    NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(phone),sv(round),nil];
    NSLog(@"%@",parameters1);
    [YkxHttptools post:XGphonefirst params:parameters1 success:^(id responseObj) {
        if ([[responseObj objectForKey:@"state"] isEqualToString:@"210"]) {
            [Common tipAlert:[responseObj objectForKey:@"message"]];
            HSXGPwdsecondViewController *hsxg = [[HSXGPwdsecondViewController alloc] init];
            hsxg.phone = _phoneText.text;
            [self.navigationController pushViewController:hsxg animated:YES];
        }else if ([[responseObj objectForKey:@"state"] isEqualToString:@"111"]){
            
        }else{
            
        }
    } failure:^(NSError *error) {
        
    }];
    
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
