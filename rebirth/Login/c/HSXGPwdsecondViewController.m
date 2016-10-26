//
//  HSXGPwdsecondViewController.m
//  rebirth
//
//  Created by 侯帅 on 16/7/27.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSXGPwdsecondViewController.h"
#import "HSXGPwdThirdViewController.h"
#define RED_COLOR [UIColor redColor]
#define WIDTH 200

@interface HSXGPwdsecondViewController ()<UITextFieldDelegate>
@property (nonatomic,assign)int x;
@property (nonatomic,assign)int y;
@property (nonatomic,assign)int z;
@end

@implementation HSXGPwdsecondViewController
{
    UIButton *loginBtn;
    UITextField *_yanzhengma;
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
    _yanzhengma = [[UITextField alloc] init];
    _yanzhengma.placeholder = @"请输入验证码";
    
    [_yanzhengma addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingChanged];
    //    UIImageView *img =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phone_icon@2x"]];
    //    img.frame =CGRectMake(0, 0, 15, 20);
    //
    //    _phoneField.leftView =img;
    //    _phoneField.leftViewMode=UITextFieldViewModeAlways;
    [self.view addSubview:_yanzhengma];
    [_yanzhengma mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(56/2);
        make.right.mas_equalTo(self.view).offset(-187);
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
        make.top.mas_equalTo(_yanzhengma).offset(40);
    }];
    loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setBackgroundColor:[NSString colorWithHexString:bukedianjibtn]];
    loginBtn.enabled = NO;
    [loginBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(click_login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line);
        make.right.mas_equalTo(line);
        make.top.mas_equalTo(line).offset(40);
        make.height.mas_equalTo(_yanzhengma);
        
    }];
    loginBtn.layer.cornerRadius = 3;
    
    //验证码
    _x = 0;
    _y = 60;
    _z = 0;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 3;
    [btn addTarget:self action:@selector(dianji) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn
     ];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_yanzhengma).offset(159);
        make.right.mas_equalTo(self.view).offset(-56/2);
        make.top.equalTo(_yanzhengma);
        make.height.equalTo(_yanzhengma);
        
    }];
    UILabel *huoqulbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 159, 40)];
    huoqulbl.tag =1;
    huoqulbl.text = @"获取验证码";
    huoqulbl.textColor= [NSString colorWithHexString:@"ffffff"];
    huoqulbl.font = [UIFont systemFontOfSize:18];
    huoqulbl.backgroundColor = [NSString colorWithHexString:heitizi];
    huoqulbl.layer.borderWidth = 1;
    huoqulbl.layer.borderColor = [NSString colorWithHexString:heitizi].CGColor;
    huoqulbl.layer.cornerRadius = 6;
    huoqulbl.layer.masksToBounds = YES;
    huoqulbl.textAlignment = NSTextAlignmentCenter;
    [btn addSubview:huoqulbl];
    UILabel * huise_Label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 159, 40)];
    huise_Label.tag = 2;
    huise_Label.textColor = [UIColor whiteColor];
    huise_Label.backgroundColor = [UIColor grayColor];
    huise_Label.layer.borderColor = [UIColor grayColor].CGColor;
    huise_Label.layer.borderWidth = 1;
    huise_Label.layer.cornerRadius = 10;
    huise_Label.layer.masksToBounds = YES;
    huise_Label.textAlignment = NSTextAlignmentCenter;
    huise_Label.font = [UIFont systemFontOfSize:18];
    huise_Label.alpha = 0.4;
    [btn addSubview:huise_Label];
    
    huise_Label.hidden = YES;
    
    
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (_yanzhengma.text.length>=4) {
        loginBtn.enabled = YES;
        [loginBtn setBackgroundColor:[UIColor blackColor]];
        [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }else{
        loginBtn.enabled =NO;
        loginBtn.backgroundColor =[NSString colorWithHexString:bukedianjibtn];
    }
    
    
    
}

- (void)dianji{
    UILabel * hongse = (UILabel *)[self.view viewWithTag:1];
    UILabel * huise = (UILabel *)[self.view viewWithTag:2];
    hongse.hidden = YES;
    huise.hidden = NO;
    UIButton * btn = (UIButton *)[self.view viewWithTag:3];
    btn.userInteractionEnabled = NO;
    
    if (btn.userInteractionEnabled == NO) {
        if (_z == 0) {
            [self xianshi];
            //[self httpReg];
        }else{
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(xianshi) userInfo:nil repeats:NO];
        }
    }
    
    
}
- (void)xianshi{
    _z = 1;
    UILabel * hongse = (UILabel *)[self.view viewWithTag:1];
    UILabel * huise = (UILabel *)[self.view viewWithTag:2];
    UIButton * btn = (UIButton *)[self.view viewWithTag:3];
    
    huise.text = [NSString stringWithFormat:@"%ds后重新获取",_y];
    _y -= 1;
    
    if (_y == -1) {
        btn.userInteractionEnabled = YES;
        _y = 60;
        hongse.hidden = NO;
        huise.hidden = YES;
        _z = 0;
        [self ok];
    }else{
        [self dianji];
    }
}
- (void)ok{
    NSLog(@"循环结束");
}

-(void)click_back:(UIButton *)sender{
    NSLog(@"back");
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)click_login:(UIButton *)sender{
    NSLog(@"next");
    [self http];
}

-(void)http{
    /*105 忘记密码(验证验证码)
     URL：http://www.rempeach.com/rebirth/api/login/checkYzm
     接口描述：忘记密码（验证验证码）
     请求方式：POST
     上传参数：
     phone
     code
     round
     sign
     
     返回参数：state ：200 111 101 状态码（见附录）
      a b c d e f g h i j k l m n o p q r s t u v w x y z
*/
    NSString *code = _yanzhengma.text;
    NSString *phone = _phone;
    NSString *round = @"21145";
    NSArray *nameList = @[vn(code),vn(phone),vn(round)];
    
    NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(code),sv(phone),sv(round),nil];
    NSLog(@"%@",parameters1);
    [YkxHttptools post:XGphonesecond params:parameters1 success:^(id responseObj) {
        if ([[responseObj objectForKey:@"state"] isEqualToString:@"200"]) {
            NSDictionary *dic = [responseObj objectForKey:@"data"];
            HSXGPwdThirdViewController *hsxg = [[HSXGPwdThirdViewController alloc] init];
            hsxg.reSetCode = [dic objectForKey:@"reSetCode"];
            hsxg.phone = self.phone;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
