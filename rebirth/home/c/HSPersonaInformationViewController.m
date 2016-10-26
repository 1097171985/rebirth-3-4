//
//  HSPersonaInformationViewController.m
//  rebirth
//
//  Created by 侯帅 on 16/7/26.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSPersonaInformationViewController.h"

@interface HSPersonaInformationViewController ()

@end

@implementation HSPersonaInformationViewController
{
    UIImageView *touxiangIMG;
    NSString *namestr;
    UITextField *nametextfield;
    UITextField *jobtextfield;
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
    [self httpgerenxinxi];
    [self creatNavi];
    
    // Do any additional setup after loading the view.
}
-(void)creatNavi{
    UIView *navi = [[UIView alloc] init];
    navi.frame =CGRectMake(0, 0,kScreenWidth , NAV_BAR_HEIGHT);
    navi.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navi];
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(50, kStatusBarHeight, kScreenWidth-100, NAV_BAR_HEIGHT-kStatusBarHeight)];
    titleLbl.textColor = [NSString colorWithHexString:heitizi];
    titleLbl.text = @"我的资料";
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
    UIView *contentview = [[UIView alloc] init];
    contentview.frame = CGRectMake(0, NAV_BAR_HEIGHT, kScreenWidth, 380/2);
    contentview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentview];
    CGFloat width          = 90/2;
    touxiangIMG = [[UIImageView alloc]initWithFrame:CGRectMake(12, (90 - width) / 2, width, width)];
    //    [imageview setBackgroundColor:[UIColor redColor]];
    touxiangIMG.layer.cornerRadius = touxiangIMG.frame.size.width / 2;
    touxiangIMG.layer.masksToBounds = YES;
    [touxiangIMG setImage:[UIImage imageNamed:@"HeadIcon"]];
    [contentview addSubview:touxiangIMG];
    width                  = 15;
    UIImageView *arrow     = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/3+20, 40, 80, 80)];
    arrow.contentMode      = UIViewContentModeScaleAspectFit;
    [arrow setImage:[UIImage imageNamed:@"default_avatar@2x"]];
    [contentview addSubview:arrow];
    
    
    UIView *content = [[UIView alloc] init];
    content.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    [contentview addSubview:content];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(contentview).offset(178);
        make.height.equalTo(@12);
    }];
    //name
    UILabel *nameLbl = [[UILabel alloc] init];
    nameLbl.text = namestr;
    nameLbl.textAlignment = NSTextAlignmentCenter;
    nameLbl.textColor = [NSString colorWithHexString:@"e4c675"];
    nameLbl.font = [UIFont systemFontOfSize:14];
    [contentview addSubview:nameLbl];
    [nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(arrow.mas_bottom).offset(20);
        make.height.equalTo(@14);
    }];
    
    
    //第二部分
    UIButton *dingzhibtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dingzhibtn setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:dingzhibtn];
    [dingzhibtn addTarget:self action:@selector(click_dingzhi:) forControlEvents:UIControlEventTouchUpInside];
    [dingzhibtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(contentview.mas_bottom);
        make.height.equalTo(@40);
    }];
    UILabel *dingzhiLbl = [[UILabel alloc] init];
    dingzhiLbl.textColor = [NSString colorWithHexString:heitizi];
    dingzhiLbl.text = @"已定制XX套方案";
    dingzhiLbl.font = [UIFont systemFontOfSize:14];
    dingzhiLbl.textAlignment = NSTextAlignmentLeft;
    dingzhiLbl.backgroundColor = [UIColor clearColor];
    [dingzhibtn addSubview:dingzhiLbl];
    [dingzhiLbl mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.left.equalTo(dingzhibtn).offset(20);
        make.right.equalTo(dingzhibtn).offset(-kScreenWidth/2);
        make.top.equalTo(dingzhibtn).offset(15);
        make.height.equalTo(@14);
    }];
    //12*22
    UIImageView *img = [[UIImageView alloc] init];
    img.image = [UIImage imageNamed:@"order_arrow@2x"];
    [dingzhibtn addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(dingzhibtn).offset(-20);
        make.height.equalTo(@11);
        make.width.equalTo(@6);
        make.top.equalTo(@15);
    }];
    UIView *contentview1 = [[UIView alloc] init];
    contentview1.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    [self.view addSubview:contentview1];
    [contentview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(dingzhibtn.mas_bottom);
        make.height.equalTo(@12);
    }];
    UILabel *jialinglbl = [[UILabel alloc] init];
    jialinglbl.text = @"驾龄";
    jialinglbl.textAlignment = NSTextAlignmentLeft;
    jialinglbl.textColor = [NSString colorWithHexString:heitizi];
    [self.view addSubview:jialinglbl];
    [jialinglbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.width.equalTo(@50);
        make.top.equalTo(contentview1.mas_bottom);
        make.height.equalTo(@40);
    }];
    UITextField *jialingfild = [[UITextField alloc] init];
    //jialingfild.backgroundColor = [UIColor blackColor];
    [self.view addSubview:jialingfild];
    [jialingfild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(jialinglbl.mas_right);
        make.right.equalTo(self.view).offset(-kScreenWidth/2-2);
        make.top.equalTo(jialinglbl);
        make.height.equalTo(jialinglbl);
    }];

    
    
    UIView *shuxian = [[UIView alloc] init];
    shuxian.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    [self.view addSubview:shuxian];
    [shuxian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(jialingfild.mas_right);
        make.right.equalTo(self.view).offset(-kScreenWidth/2+3);
        make.height.equalTo(@40);
        make.top.equalTo(jialinglbl);
    }];
    UILabel *agelbl = [[UILabel alloc] init];
    agelbl.text = @"年龄";
    agelbl.textAlignment = NSTextAlignmentLeft;
    agelbl.textColor = [NSString colorWithHexString:heitizi];
    [self.view addSubview:agelbl];
    [agelbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shuxian.mas_right).offset(20);
        make.width.equalTo(@50);
        make.height.equalTo(@40);
        make.top.equalTo(jialinglbl);
    }];
    UITextField *agefild = [[UITextField alloc] init];
   // agefild.backgroundColor = [UIColor blackColor];
    [self.view addSubview:agefild];
    [agefild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(agelbl.mas_right);
        make.right.equalTo(self.view);
        make.top.equalTo(agelbl);
        make.height.equalTo(agelbl);
    }];
    UIView *contentview2 = [[UIView alloc] init];
    contentview2.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    [self.view addSubview:contentview2];
    [contentview2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(agelbl.mas_bottom);
        make.height.equalTo(@12);
    }];
    for (int i=0; i<3; i++) {
        UIView *lien = [[UIView alloc] init];
        lien.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
        [self.view addSubview:lien];
        [lien mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(contentview2.mas_bottom).offset(40+40*i);
            make.height.equalTo(@1);
            
        }];
    }
        UILabel *nicheng = [[UILabel alloc] init];
        nicheng.text = @"昵称";
        nicheng.textAlignment = NSTextAlignmentLeft;
        nicheng.textColor = [NSString colorWithHexString:heitizi];
        [self.view addSubview:nicheng];
        [nicheng mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(jialinglbl);
            make.right.equalTo(jialinglbl);
            make.top.equalTo(contentview2.mas_bottom);
            make.height.equalTo(@40);
        }];
        UILabel *zhiye = [[UILabel alloc] init];
        zhiye.text = @"职业";
        zhiye.textAlignment = NSTextAlignmentLeft;
        zhiye.textColor = [NSString colorWithHexString:heitizi];
        [self.view addSubview:zhiye];
        [zhiye mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(nicheng);
            make.top.equalTo(nicheng.mas_bottom).offset(1);
            make.height.equalTo(@40);
        }];
        UILabel *xingzuo = [[UILabel alloc] init];
        xingzuo.text = @"星座";
        xingzuo.textAlignment = NSTextAlignmentLeft;
        xingzuo.textColor = [NSString colorWithHexString:heitizi];
        [self.view addSubview:xingzuo];
        [xingzuo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(zhiye);
            make.top.equalTo(zhiye.mas_bottom).offset(1);
            
        }];
        UILabel *xingquaihao = [[UILabel alloc] init];
        xingquaihao.text = @"兴趣爱好";
        xingquaihao.textAlignment = NSTextAlignmentLeft;
        xingquaihao.textColor = [NSString colorWithHexString:heitizi];
        [self.view addSubview:xingquaihao];
        [xingquaihao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.height.equalTo(xingzuo);
            make.top.equalTo(xingzuo.mas_bottom).offset(1);
            make.width.equalTo(@100);
        }];

    nametextfield = [[UITextField alloc] init];
    nametextfield.placeholder = @"输入新的名字";
    [self.view addSubview:nametextfield];
    [nametextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(agelbl);
        make.right.equalTo(agefild);
        make.top.equalTo(jialingfild);
        make.height.equalTo(nicheng);
    }];
    
    
    
    
    
   }
-(void)httpPostmessage{
    /*111 修改用户信息
     URL：http://www.rempeach.com/rebirth/api/user/edit_userInfo
     接口描述：修改用户信息
     请求方式：POST
     上传参数：
     id      1
     nick     2
     age        2
     dri_age     2
     job         
     zodiac
     hobby
     token
     sign
     
     返回参数：state ：200 111 101 121 状态码（见附录） 
*/
    
    
    
}
-(void)click_dingzhi:(UIButton *)sender{
    NSLog(@"定制");
}
-(void)httpgerenxinxi{
    /*112 获取用户信息
     URL：http://www.rempeach.com/rebirth/api/user/get_userInfo
     接口描述：获取用户信息
     请求方式：GET
     上传参数：
     id
     round
     token
     sign
     
     返回参数：state ：200 111 101 121 状态码（见附录）
*/
    
    NSString *transformId = [USER_DEFAULT objectForKey:@"id"];
    NSString *round = @"12345";
    NSString *token = [USER_DEFAULT objectForKey:@"token"];
    NSArray *nameList = @[@"id",vn(round),vn(token)];
    
    NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(transformId),sv(round),sv(token),nil];
    NSLog(@"%@",parameters1);
    NSString *str = sv(transformId);
    [YkxHttptools get:huoquxinxi params:parameters1 success:^(id responseObj) {
        NSString *finishStr = [[NSString alloc]initWithData:responseObj encoding:NSUTF8StringEncoding];
        finishStr = [YkxHttptools repTabStr:finishStr];
        NSDictionary *paramDic = [[[SBJsonParser alloc]init] objectWithString:finishStr];
        NSLog(@"%@11111111111111",paramDic);
        if ([[paramDic objectForKey:@"state"] isEqualToString:@"200"]) {
            NSDictionary *dic = [paramDic objectForKey:@"data"];
            namestr = [dic objectForKey:@"nick"];
            [self creatView];
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
