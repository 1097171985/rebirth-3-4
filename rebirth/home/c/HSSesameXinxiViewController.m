//
//  HSSesameXinxiViewController.m
//  rebirth
//
//  Created by 侯帅 on 16/9/11.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSSesameXinxiViewController.h"
#import <ZMCreditSDK/ALCreditService.h>
#import "HSSesameViewController.h"
@interface HSSesameXinxiViewController ()

@end

@implementation HSSesameXinxiViewController
{
    UITextField *namefield;
    UITextField *numfield;
    NSString *paramsStr;
    NSString *signStr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"芝麻信用授权";
    self.view.backgroundColor = [NSString colorWithHexString:@"f8f9f9"];
    [self creatView];
    // Do any additional setup after loading the view.
}
-(void)creatView{
    //180*207
    UIImageView *img = [[UIImageView alloc] init];
    img.image = [UIImage imageNamed:@"progress_bar@2x"];
    [self.view addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAV_BAR_HEIGHT);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(90*HEIGHTRATIO);
    }];
    UIView *contenview = [[UIView alloc] init];
    contenview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contenview];
    [contenview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(img.mas_bottom);
        make.height.equalTo(@80);
    }];
    UILabel *namelbl = [[UILabel alloc] init];
    namelbl.text = @"姓名";
    namelbl.textColor = [NSString colorWithHexString:heitizi];
    namelbl.textAlignment = NSTextAlignmentRight;
    namelbl.font =[UIFont systemFontOfSize:16];
    [contenview addSubview:namelbl];
    [namelbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.mas_equalTo(self.view).offset(-kScreenWidth+188/2);
        make.top.equalTo(contenview.mas_top).offset(13);
        make.height.equalTo(@16);
        
    }];
    namefield = [[UITextField alloc] init];
   // namefield.placeholder = @"22";
    [contenview addSubview:namefield];
    [namefield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(namelbl.mas_right).offset(5);
        make.right.equalTo(self.view);
        make.top.equalTo(img.mas_bottom);
        make.height.equalTo(@40);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [NSString colorWithHexString:@"f5f5f5"];
    [contenview addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(namefield.mas_bottom);
        make.height.equalTo(@0.5);
    }];
    UILabel *numlbl = [[UILabel alloc] init];
    numlbl.text = @"身份证号";
    numlbl.textAlignment = NSTextAlignmentRight;
    numlbl.textColor = [NSString colorWithHexString:heitizi];
    numlbl.font = [UIFont systemFontOfSize:16];
    [contenview addSubview:numlbl];
    [numlbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(namelbl);
        make.top.equalTo(line.mas_bottom).offset(13);
        make.height.equalTo(@16);
    }];
    numfield = [[UITextField alloc] init];
    [contenview addSubview:numfield];
    [numfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(namefield);
        make.right.equalTo(namefield);
        make.top.equalTo(line.mas_bottom);
        make.height.equalTo(@40);
    }];
    UILabel *tislbl = [[UILabel alloc] init];
    tislbl.text = @"以上信息用于确认您的身份";
    tislbl.textAlignment = NSTextAlignmentLeft;
    tislbl.textColor = [NSString colorWithHexString:@"#6d7278"];
    tislbl.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:tislbl];
    [tislbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.right.equalTo(self.view);
        make.top.equalTo(contenview.mas_bottom).offset(12);
        make.height.equalTo(@12);
    }];
    UIButton *shouquanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shouquanBtn setTitle:@"立即授权" forState:UIControlStateNormal];
    [shouquanBtn setTitleColor:[NSString colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    shouquanBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    shouquanBtn.backgroundColor = [NSString colorWithHexString:@"#00C68D"];
    [self.view addSubview:shouquanBtn];
    [shouquanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.right.equalTo(@-12);
        make.top.equalTo(tislbl.mas_bottom).offset(40);
        make.height.equalTo(@50);
    }];
    shouquanBtn.layer.cornerRadius = 3;
    [shouquanBtn addTarget:self action:@selector(click_shoquan:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)click_shoquan:(UIButton *)sender{
    NSLog(@"授权");
    [self httpzhima];
}
-(void)httpzhima{
  /*  411 获取芝麻信用分的参数加密及签名
    URL：http://www.rempeach.com/rebirth/api/user/encryptParamAndSign
    接口描述：获取芝麻信用分的参数加密及签名
    请求方式：POST
    上传参数：
   
    
 a b c d e f g h i g k l m n o p q r s t u v w x y z
    返回参数：state ：200 111 101 121 状态码（见附录）
   */
    
    NSString *certNo = numfield.text;
    NSString *transformId = [USER_DEFAULT objectForKey:@"id"];
    NSString *name = namefield.text;
    NSString *token = [USER_DEFAULT objectForKey:@"token"];
    NSArray *nameList = @[vn(certNo),@"id",vn(name),vn(token)];
    
    NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(certNo),sv(transformId),sv(name),sv(token),nil];
    NSLog(@"%@",parameters1);
    NSString *str = sv(transformId);
    

    [YkxHttptools post:@"http://www.rempeach.com/rebirth/api/user/encryptParamAndSign" params:parameters1 success:^(id responseObj) {
        
        if ([[responseObj objectForKey:@"state"] isEqualToString:@"111"]) {
            [Common tipAlert:@"请和驾照统一"];
        }else if ([[responseObj objectForKey:@"state"] isEqualToString:@"200"]){
            NSDictionary *dic = [responseObj objectForKey:@"data"];
            // 商户需要从服务端获取
          
            NSString* appId = @"1000779";
            
            [[ALCreditService sharedService] queryUserAuthReq:appId sign:[dic objectForKey:@"sign"] params:[dic objectForKey:@"param"] extParams:nil selector:@selector(result:) target:self];
        }
        
        NSLog(@"%@",[responseObj objectForKey:@"message"]);
    } failure:^(NSError *error) {
        
    }];

}
- (void)result:(NSMutableDictionary*)dic{
    NSLog(@"result ");
    NSLog(@"%@",dic);
   // NSString *op = [dic objectForKey:@"openId"];
 //   NSLog(@"%@",op);
    paramsStr = [dic objectForKey:@"params"];
    signStr = [dic objectForKey:@"sign"];
    NSString* system  = [[UIDevice currentDevice] systemVersion];
    if([system intValue]>=7){
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    }
    [self httpsesameNum];
    
}
-(void)httpsesameNum{
    /*412 发送open_id信息并且获取芝麻分
     URL：http://www.rempeach.com/rebirth/api/user/setOpenId
     接口描述：发送芝麻信用分返回信息并取回芝麻信用分
     请求方式：POST
     上传参数：
     
     
     特殊返回状态码
     100
     
     a b c d e f g h i g k l m n o p q r s t u v w x y z
     返回参数：state ：200 100 111 101 121 状态码（见附录）*/
    
    
    NSString *transformId = [USER_DEFAULT objectForKey:@"id"];
    NSString *params = paramsStr;
    NSString *params_sign = signStr;
    NSString *token = [USER_DEFAULT objectForKey:@"token"];
    NSArray *nameList = @[@"id",vn(params),vn(params_sign),vn(token)];
    
    NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(transformId),sv(params),sv(params_sign),sv(token),nil];
    NSLog(@"%@",parameters1);
    NSString *str = sv(transformId);
    [YkxHttptools post:@"http://www.rempeach.com/rebirth/api/user/setOpenId" params:parameters1 success:^(id responseObj) {
        NSLog(@"%@",[responseObj objectForKey:@"tip"]);
        if ([[responseObj objectForKey:@"state"] isEqualToString:@"200"]) {
            NSDictionary *dic = [responseObj objectForKey:@"data"];
            HSSesameViewController *hsse = [[HSSesameViewController alloc] init];
            hsse.num = [NSString stringWithFormat:@"%@",[dic objectForKey:@"score"]];
            hsse.bo = [NSString stringWithFormat:@"%@",[dic objectForKey:@"flag"]];
            [self.navigationController pushViewController:hsse animated:YES];
            
        }else if ([[responseObj objectForKey:@"state"]isEqualToString:@"100"]){
            [Common tipAlert:@"请重新授权"];
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
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
   // self.navigationController.navigationBarHidden = YES;
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
