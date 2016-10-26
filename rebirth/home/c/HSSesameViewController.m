//
//  HSSesameViewController.m
//  rebirth
//
//  Created by 侯帅 on 16/7/19.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSSesameViewController.h"


@interface HSSesameViewController ()

@end

@implementation HSSesameViewController
{
    UILabel *_numlbl;
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
    [self httpgetScore];
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
    titleLbl.text = @"授权芝麻分";
    titleLbl.font = [UIFont systemFontOfSize:16];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    [navi addSubview:titleLbl];
    UIButton *backBtn=  [YkxHttptools initwithButton:[UIColor clearColor] Frame:CGRectMake(0, kStatusBarHeight, 50, NAV_BAR_HEIGHT-kStatusBarHeight) Image:[UIImage imageNamed:@"back_arrow@2x"] Title:nil Titlecolor:[NSString colorWithHexString:heitizi ] Titlefont:[UIFont systemFontOfSize:14] BaseView:navi];
    [backBtn addTarget:self action:@selector(back_btn:) forControlEvents:UIControlEventTouchUpInside];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    [navi addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(NAV_BAR_HEIGHT-1);
        make.height.equalTo(@0.5);
    }];
}

-(void)creatView{
    //返回
    
       UIImageView *fenshuIMG = [[UIImageView alloc] init];
        if ([self.bo isEqualToString:@"0"]) {
        fenshuIMG.image = [UIImage imageNamed:@"xinyongfen_fail_bg@2x"];
    }else{
     
        fenshuIMG.image = [UIImage imageNamed:@"xinyongfen_success_bg@2x"];
    }
    fenshuIMG.frame =CGRectMake(103*WIDTHRATIO, (NAV_BAR_HEIGHT+56)*HEIGHTRATIO, 168*WIDTHRATIO, 168*WIDTHRATIO);
    
    [self.view addSubview:fenshuIMG];
//    [fenshuIMG mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.view).offset(103);
//        make.right.mas_equalTo(self.view).offset(-103);
//        make.top.mas_equalTo(self.view).offset(NAV_BAR_HEIGHT+56);
//        make.height.width.mas_equalTo(168);
//        
//    }];
    _numlbl = [[UILabel alloc] init];
    _numlbl.frame =CGRectMake(0, 67*HEIGHTRATIO, 168*WIDTHRATIO, 44);
    _numlbl.text = self.num;
    _numlbl.textColor = [NSString colorWithHexString:@"#ffffff"];
    _numlbl.textAlignment = NSTextAlignmentCenter;
   //  _numlbl.font = [UIFont systemFontOfSize:44];
    _numlbl.font = [UIFont boldSystemFontOfSize:44];
    [fenshuIMG addSubview:_numlbl];
   ;
        //提示
    
    UILabel *tishilbl = [[UILabel alloc] init];
     UILabel *tishilbl1 = [[UILabel alloc] init];
    if ([self.bo isEqualToString:@"0"]) {
         tishilbl.text = [NSString stringWithFormat:@"您的芝麻信用分低于650"];
        tishilbl1.text = @"暂时不能享受特权";
    }else{
        tishilbl.text = @"授权成功，开启您的行程";
    }

   
    tishilbl.textAlignment = NSTextAlignmentCenter;
    tishilbl.textColor = [NSString colorWithHexString:heitizi];
    tishilbl.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:tishilbl];
    [tishilbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(fenshuIMG.mas_bottom).offset(44);
        make.height.mas_equalTo(16);
    }];
    
   
    tishilbl1.textColor = [NSString colorWithHexString:heitizi];
    tishilbl1.textAlignment = NSTextAlignmentCenter;
    
    tishilbl1.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:tishilbl1];
    [tishilbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(tishilbl).offset(16+5);
        make.height.mas_equalTo(16);
    }];
    //下部按钮
    UIButton *RootBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [RootBtn setBackgroundColor:[UIColor whiteColor]];

    
    
    
    [RootBtn.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    
    [RootBtn.layer setCornerRadius:8];
    
    [RootBtn.layer setBorderWidth:1];//设置边界的宽度
    
    
    
    //设置按钮的边界颜色
    
//    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
//    
//    CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){1,0,0,1});
    
    [RootBtn.layer setBorderColor:[NSString colorWithHexString:@"27292b"].CGColor];
    
    [RootBtn setTitle:@"返回首页" forState:UIControlStateNormal];
    [RootBtn setTitleColor:[NSString colorWithHexString:heitizi] forState:UIControlStateNormal];
    [self.view addSubview:RootBtn];
    [RootBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(64);
        make.right.mas_equalTo(self.view).offset(-64);
        make.bottom.mas_equalTo(self.view).offset(-80);
        make.height.mas_equalTo(48);
        
    }];
    RootBtn.layer.cornerRadius = 6;
    [RootBtn addTarget:self action:@selector(back_RootBtn:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *tislbl = [[UILabel alloc] init];
    tislbl.text = @"平台将根据您的芝麻信用分数额为您匹配适合的服务，信";
    tislbl.textAlignment = NSTextAlignmentCenter;
    tislbl.textColor = [NSString colorWithHexString:@"#6d7278"];
    tislbl.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:tislbl];
    [tislbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(RootBtn.mas_top).offset(-54);
        make.height.equalTo(@10);
    }];
    UILabel *tislbl1 = [[UILabel alloc] init];
    tislbl1.textColor = [NSString colorWithHexString:@"#6d7278"];
    tislbl1.text = @"用分提高至下一级别可享受更多优质服务。";
    tislbl1.textAlignment = NSTextAlignmentCenter;
    tislbl1.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:tislbl1];
    [tislbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(RootBtn.mas_top).offset(-40);
        make.height.equalTo(@10);
    }];
    
}
-(void)back_RootBtn:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)back_btn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)httpgetScore{
   /* 413 获取芝麻分
    URL：http://www.rempeach.com/rebirth/api/user/getScore
    接口描述：在授权后获取刷新芝麻信用分
    请求方式：GET
    上传参数：
    id
    round
    token
    sign
    
    特殊返回状态码
    
    
    返回参数：state ：200 100 111 101 121 状态码（见附录）
    a b c d e f g h i g k l m n o p q r s t u v w x y z
*/
   
    NSString *transformId = [USER_DEFAULT objectForKey:@"id"];
    NSString *round = @"47563";
    NSString *token = [USER_DEFAULT objectForKey:@"token"];
    NSArray *nameList = @[@"id",vn(round),vn(token)];
    
    NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(transformId),sv(round),sv(token),nil];
    NSLog(@"%@",parameters1);
    NSString *str = sv(transformId);
    [YkxHttptools get:@"http://www.rempeach.com/rebirth/api/user/getScore" params:parameters1 success:^(id responseObj) {
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableContainers error:nil];//转换数据格式

      //  finishStr = [YkxHttptools repTabStr:finishStr];
       // NSDictionary *paramDic = [[[SBJsonParser alloc]init] objectWithString:finishStr];
        NSLog(@"%@",content);
        if ([[content objectForKey:@"state"] isEqualToString:@"200"]) {
            NSDictionary *dic = [content objectForKey:@"data"];
            
            self.num = [NSString stringWithFormat:@"%@",[dic objectForKey:@"score"]];
            self.bo = [NSString stringWithFormat:@"%@",[dic objectForKey:@"flag"]];
             [self creatView];
            
        }
        NSLog(@"!!!!!!!!!!!!!!%@",[content objectForKey:@"tip"]);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
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
