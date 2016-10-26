//
//  HSPayViewController.m
//  rebirth
//
//  Created by 侯帅 on 16/7/25.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSPayViewController.h"
#import "Order.h"
#import "TotalItinerVC.h"
#import "APAuthV2Info.h"
#import "DataSigner.h"
#import "MZTimerLabel.h"
#import "UPPaymentControl.h"
#import "WXApi.h"
#import "DataMD5.h"
#import "GSPayVC.h"
@interface HSPayViewController ()
{
    NSString *PayId;
    NSString *body;
    NSString *out_trade_no;
    NSString *subject;
    NSString *total_fee;
    NSString *fenqiStr;
    UILabel *jine;
    BOOL isopen;
    BOOL isWX;
    BOOL isUP;
    BOOL  isGS;
}

@property(nonatomic,strong)UIView *total;

@property(nonatomic,strong)UIView  *GSStages;

@end

@implementation HSPayViewController{
    UIButton *alipayGou;
    UIButton *uppayGou;
    UIButton *WXGou;
    UIButton  *GSGou;
    NSString *type;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
     BOOL se =  [WXApi isWXAppInstalled];
    
    NSLog(@"%d",se);
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    isUP = YES;
    isWX = YES;
    isopen = YES;
    isGS = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatNavi];
    [self creatView];
    
    [self loadStages];

    
    // Do any additional setup after loading the view.
}

-(void)loadStages{
    
    UIButton *paybtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [paybtn setTitle:@"确认支付" forState:UIControlStateNormal];
    [paybtn setBackgroundColor:[NSString colorWithHexString:heitizi]];
    [paybtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:paybtn];
    [paybtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@40);
        make.bottom.equalTo(self.view);
    }];
    [paybtn addTarget:self action:@selector(click_payy:) forControlEvents:UIControlEventTouchUpInside];
    

    self.total = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-40)];
    self.total.hidden = YES;
    self.total.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    [self.view addSubview:self.total];
    
    
    self.GSStages = [[UIView alloc]init];
    
    self.GSStages.backgroundColor = [UIColor whiteColor];
    
    [self.total addSubview: self.GSStages];
    
    [ self.GSStages mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(paybtn.mas_top).with.offset(0);
        
        make.width.mas_equalTo(WIDTH);
        
        make.height.mas_equalTo(520/2);
        
        
    }];
    
    
    UILabel *selectStages = [[UILabel alloc]init];
    
    selectStages.text = @"选择分期期数";
    
    selectStages.textColor = [NSString colorWithHexString:@"27292b"];
    
    selectStages.font = [UIFont systemFontOfSize:16];
    selectStages.textAlignment = NSTextAlignmentCenter;
    [self.GSStages addSubview:selectStages];
    
    [selectStages mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo( self.GSStages.mas_top).with.offset(24);
        
        make.width.mas_equalTo(WIDTH);
        
    }];
    
    [selectStages sizeToFit];
    
    
    for (int i = 0; i < 4; i++) {
        if (i==0) {
            UIButton *view =[UIButton  buttonWithType:UIButtonTypeCustom];
            view.frame=CGRectMake(25,60, 150, 152/2);
            [view addTarget:self action:@selector(selectView:) forControlEvents:UIControlEventTouchUpInside];
            view.tag = 1000;
             view.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
            [ self.GSStages addSubview:view];
            view.layer.cornerRadius = 8;
            [self loadBtuView:view withStr:@"3" isSelectBool:NO];
           

            
        }else if (i==1){
            
            UIButton *view =[UIButton  buttonWithType:UIButtonTypeCustom];
            view.frame=CGRectMake(25+150+25,60, 150, 152/2);
            view.tag = 1001;
            [view addTarget:self action:@selector(selectView:) forControlEvents:UIControlEventTouchUpInside];
            view.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
            [ self.GSStages addSubview:view];
             view.layer.cornerRadius = 8;
            [self loadBtuView:view withStr:@"6" isSelectBool:NO];
            
        }else if (i==2){
             UIButton *view =[UIButton  buttonWithType:UIButtonTypeCustom];
            view.frame=CGRectMake(25,60+152/2+32/2, 150, 152/2);
            
            view.tag = 1002;
             [view addTarget:self action:@selector(selectView:) forControlEvents:UIControlEventTouchUpInside];
            view.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
            [ self.GSStages addSubview:view];
             view.layer.cornerRadius = 8;
            [self loadBtuView:view withStr:@"9" isSelectBool:NO];
            
        }else if (i==3){
             UIButton *view =[UIButton  buttonWithType:UIButtonTypeCustom];
             view.frame=CGRectMake(25+150+25,60+152/2+32/2, 150, 152/2);
            view.tag = 1003;
             [view addTarget:self action:@selector(selectView:) forControlEvents:UIControlEventTouchUpInside];
            view.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];            [ self.GSStages addSubview:view];
             view.layer.cornerRadius = 8;
             [self loadBtuView:view withStr:@"12" isSelectBool:NO];

            
        }

        
    }
    
    
}

-(void)loadBtuView:(UIButton *)view withStr:(NSString *)numStr isSelectBool:(BOOL)selectBool{
    
    UILabel *qishulabel  =[[UILabel alloc] init];
    qishulabel.frame =CGRectMake(0, 12, view.frame.size.width, 14);
    qishulabel.textAlignment  =NSTextAlignmentCenter;
    qishulabel.text = [NSString stringWithFormat:@"分%@期",numStr];
    qishulabel.font = [UIFont systemFontOfSize:14];
   
    [view addSubview:qishulabel];
    UILabel *shouxufeilabel = [[UILabel alloc] init];
    shouxufeilabel.frame =CGRectMake(0, 12+qishulabel.frame.size.height+8,  view.frame.size.width, 10);
    shouxufeilabel.textAlignment = NSTextAlignmentCenter;
    shouxufeilabel.font = [UIFont systemFontOfSize:10];
    shouxufeilabel.text = @"(含￥120.22手续费)";
    [view addSubview:shouxufeilabel];
    UILabel *qianshulabel = [[UILabel alloc] init];
    qianshulabel.frame =CGRectMake(0, 12+qishulabel.frame.size.height+8+shouxufeilabel.frame.size.height+8,  view.frame.size.width, 14);
    qianshulabel.text = @"￥1000.55期";
    qianshulabel.textAlignment = NSTextAlignmentCenter;
    qianshulabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:qianshulabel];
    
    if (selectBool == NO) {
        shouxufeilabel.textColor = [NSString colorWithHexString:@"abaeb0"];
        
        qishulabel.textColor = [NSString colorWithHexString:@"6d7278"];
        qianshulabel.textColor = [NSString colorWithHexString:@"6d7278"];

    }else{
        shouxufeilabel.textColor = [UIColor whiteColor];
        
        qishulabel.textColor = [UIColor whiteColor];
        qianshulabel.textColor = [UIColor whiteColor];

    }
   

}

-(void)selectView:(UIButton *)btu{
    NSLog(@"2222");
    if (btu.tag == 1000) {
        
        NSLog(@"3");
      fenqiStr = @"3";
      [self loadBtuBackColor:btu withStr:@"3"];
        
    }else if (btu.tag == 1001){
        
        NSLog(@"6");
        fenqiStr = @"6";
      [self loadBtuBackColor:btu withStr:@"6"];
    }else if (btu.tag == 1002){
        
        NSLog(@"9");
        fenqiStr = @"9";
      [self loadBtuBackColor:btu withStr:@"9"];
    }else if (btu.tag == 1003){
        
        NSLog(@"12");
        fenqiStr = @"12";
        [self loadBtuBackColor:btu withStr:@"12"];
    }
    
    
    
}

#define  FENQI @[@"3",@"6",@"9",@"12"]
-(void)loadBtuBackColor:(UIButton *)selectBtu withStr:(NSString *)numStr{
    
    for (int i = 1000; i < 1004;i++) {
        
        UIButton *btu = [self.view viewWithTag:i];
        
        btu.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
        for (UIView *view in btu.subviews) {
            
            [view removeFromSuperview];
        }

        [self loadBtuView:btu withStr:FENQI[i-1000] isSelectBool:NO];
    }
    selectBtu.backgroundColor = [NSString  colorWithHexString:@"c7000b"];
    
    for (UIView *view in selectBtu.subviews) {
        
        [view removeFromSuperview];
    }
    
    [self loadBtuView:selectBtu withStr:numStr isSelectBool:YES];

    
}
-(void)creatView{
    
    UIView *contentTime = [[UIView alloc] init];
    contentTime.frame =CGRectMake(0, NAV_BAR_HEIGHT, kScreenWidth, 20);
    contentTime.backgroundColor = [NSString colorWithHexString:heitizi];
    [self.view addSubview:contentTime];
    
    UIView *contentview = [[UIView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT+contentTime.frame.size.height, kScreenWidth, 112/2)];
    contentview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentview];

    UIView *contentview1 = [[UIView alloc] init];
    contentview1.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    [contentview addSubview:contentview1];
    [contentview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentview);
        make.top.equalTo(@44);
        make.height.equalTo(@12);
        
    }];
    
    
//    UIView  *contentView4 = [[UIView  alloc]init];
//    contentView4.backgroundColor = [UIColor yellowColor];
//    [contentview addSubview:contentView4];
//    [contentView4 mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.right.equalTo(contentview);
//        make.top.equalTo(@44);
//        make.height.equalTo(@44);
//        
//        
//    }];
//    
//    
//    UILabel *hongbaoLabel = [[UILabel alloc]init];
//    hongbaoLabel.text = @"红包";
//    [contentView4 addSubview:hongbaoLabel];
//    [hongbaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.centerY.equalTo(contentView4.mas_centerY);
//        
//        make.left.equalTo(contentView4.mas_left).with.offset(12);
//        
//    }];
//    
//    
//    UILabel  *reduceLabel  = [[UILabel alloc]init];
//    reduceLabel.text = @"-¥1200";
//    [contentView4 addSubview:reduceLabel];
//    [reduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.centerY.equalTo(contentView4.mas_centerY);
//        
//        make.right.equalTo(contentView4.mas_right).with.offset(-12);
//    }];

    
    UIView *timerView = [[UIView alloc]init];
    [contentTime addSubview:timerView];
    
    UILabel *textLabel = [[UILabel alloc]init];
    textLabel.text = @"剩余支付时间:";
    textLabel.font = [UIFont systemFontOfSize:12];
    textLabel.textColor = [NSString colorWithHexString:@"#ffffff"];
    [timerView addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(timerView.mas_top).with.offset(0);
        make.bottom.equalTo(timerView.mas_bottom).with.offset(0);
        make.left.equalTo(timerView.mas_left).with.offset(0);
        
    }];


    
   MZTimerLabel *timerDown =[[MZTimerLabel alloc] initWithTimerType:MZTimerLabelTypeTimer];;
    [timerDown setCountDownTime:2400];
    timerDown.resetTimerAfterFinish = YES;
    timerDown.timeFormat = @"hh时mm分ss秒";
    timerDown.font = [UIFont systemFontOfSize:12];
    timerDown.timeLabel.textColor = [NSString colorWithHexString:@"#ffffff"];

     [timerDown start];
    [timerView addSubview:timerDown];
    [timerDown mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(timerView.mas_top).with.offset(0);
        make.bottom.equalTo(timerView.mas_bottom).with.offset(0);
        make.left.equalTo(textLabel.mas_right).with.offset(1);
        
    }];
    
    [timerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(contentTime.mas_top).with.offset(0);
        make.bottom.equalTo(contentTime.mas_bottom).with.offset(0);
        make.centerX.equalTo(contentTime.mas_centerX);
        
        make.width.mas_equalTo(200);
        
    }];
    
    UILabel *dingdan = [[UILabel alloc] init];
    dingdan.textColor = [NSString colorWithHexString:heitizi];
    dingdan.font = [UIFont systemFontOfSize:14];
    dingdan.textAlignment = NSTextAlignmentLeft;
    [contentview addSubview:dingdan];
    [dingdan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(12);
        make.right.equalTo(self.view).offset(-kScreenWidth/2);
        make.top.equalTo(contentview).offset(15);
        make.height.equalTo(@14);
        
    }];
    jine = [[UILabel alloc] init];
    jine.textAlignment = NSTextAlignmentRight;
    jine.textColor = [NSString colorWithHexString:@"#e4c675"];
    if ([self.status isEqualToString:@"0"]) {
        //付意向金
        jine.text = [NSString stringWithFormat:@"¥%@",[self addSpaceFromSring:self.dingjin]];
        dingdan.text = @"意向金金额";
        
    }else if ([self.status isEqualToString:@"3"]){
        //付全款
        jine.text = [NSString stringWithFormat:@"¥%@",[self addSpaceFromSring:self.totalMoney]];
        dingdan.text = @"订单金额";
        
        
    }else{
        
        //付意向金(从定制过来的)
        jine.text = [NSString stringWithFormat:@"¥%@",[self addSpaceFromSring:self.dingjin]];
        dingdan.text = @"意向金金额";
    }
   
    jine.font = [UIFont systemFontOfSize:16];
    [contentview addSubview:jine];
    [jine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kScreenWidth/2);
        make.right.equalTo(self.view).offset(-12);
        make.top.equalTo(contentview).offset(15);
        make.height.equalTo(@16);
    }];
    
    
    UIView *contentview2 = [[UIView alloc] init];
    contentview2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentview2];
    [contentview2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(contentview1.mas_bottom);
        make.height.equalTo(@32);
    }];
    UILabel *lbl = [[UILabel alloc] init];
    lbl.text = @"选择支付方式";
    lbl.textAlignment = NSTextAlignmentLeft;
    lbl.textColor = [NSString colorWithHexString:heitizi];
    lbl.font = [UIFont systemFontOfSize:12];
    [contentview2 addSubview:lbl];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(12);
        make.right.equalTo(self.view).offset(-12);
        make.top.equalTo(@11);
        make.height.equalTo(@12);
        
    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    line.frame =CGRectMake(0, 31.5, kScreenWidth, 0.5);
    [contentview2 addSubview:line];
    UIButton *alipayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [alipayBtn addTarget:self action:@selector(click_pay:) forControlEvents:UIControlEventTouchUpInside];
    alipayBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:alipayBtn];
    [alipayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(contentview2.mas_bottom);
        make.height.equalTo(@48);
    }];
    //图片格式32*32
    UIImageView *alipay = [[UIImageView alloc] init];
    alipay.image = [UIImage imageNamed:@"alipay_icon@2x"];
    [alipayBtn addSubview:alipay];
    [alipay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(12);
        make.width.height.equalTo(@32);
        make.top.equalTo(alipayBtn).offset(12);
    }];
    UILabel *alipayLbl = [[UILabel alloc] init];
    alipayLbl.text = @"支付宝支付";
    alipayLbl.textAlignment = NSTextAlignmentLeft;
    alipayLbl.textColor = [NSString colorWithHexString:heitizi];
    alipayLbl.font = [UIFont systemFontOfSize:14];
    [alipayBtn addSubview:alipayLbl];
    [alipayLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(alipay.mas_right).offset(12);
        make.height.equalTo(@14);
        make.top.equalTo(@20);
        make.right.equalTo(alipayBtn).offset(-kScreenWidth/2);
        
    }];
    alipayGou = [UIButton buttonWithType:UIButtonTypeCustom];
    [alipayGou setImage:[UIImage imageNamed:@"pay_0@2x"] forState:UIControlStateNormal];
    [alipayGou addTarget:self action:@selector(click_alipay:) forControlEvents:UIControlEventTouchUpInside];
    [alipayBtn addSubview:alipayGou];
    [alipayGou mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-12);
        make.top.equalTo(alipayBtn).offset(12);
        make.height.width.equalTo(@32);
    }];
    UIView *line1 = [[UIView alloc] init];
    line1.frame =CGRectMake(0, 47.5, kScreenWidth, 0.5);
    line1.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    [alipayBtn addSubview:line1];
    //银联  64*40
//    UIButton *upPayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    upPayBtn.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:upPayBtn];
//    [upPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.top.equalTo(alipayBtn.mas_bottom);
//        make.height.equalTo(@48);
//    }];
//    UIView *line2 = [[UIView alloc] init];
//    line2.frame =CGRectMake(0, 47.5, kScreenWidth, 0.5);
//    line2.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
//    [upPayBtn addSubview:line2];
//    UIImageView *upPayIMG = [[UIImageView alloc] init];
//    upPayIMG.image = [UIImage imageNamed:@"unionpay_icon@2x"];
//    [upPayBtn addSubview:upPayIMG];
//    [upPayIMG mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(12);
//        make.width.equalTo(@32);
//        make.height.equalTo(@20);
//        make.top.equalTo(upPayBtn).offset(15);
//    }];
//    UILabel *uppayLbl = [[UILabel alloc] init];
//    uppayLbl.text = @"银联支付";
//    uppayLbl.textAlignment = NSTextAlignmentLeft;
//    uppayLbl.textColor = [NSString colorWithHexString:heitizi];
//    uppayLbl.font = [UIFont systemFontOfSize:14];
//    [upPayBtn addSubview:uppayLbl];
//    [uppayLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(alipay.mas_right).offset(12);
//        make.height.equalTo(@14);
//        make.top.equalTo(@18);
//        make.right.equalTo(alipayBtn).offset(-kScreenWidth/2);
//        
//    }];
//
//    uppayGou = [UIButton buttonWithType:UIButtonTypeCustom];
//    [uppayGou setImage:[UIImage imageNamed:@"pay_0@2x"] forState:UIControlStateNormal];
//    [uppayGou addTarget:self action:@selector(click_UPPay:) forControlEvents:UIControlEventTouchUpInside];
//    [upPayBtn addSubview:uppayGou];
//    [uppayGou mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.view).offset(-12);
//        make.top.equalTo(upPayBtn).offset(12);
//        make.height.width.equalTo(@32);
//    }];

//微信
    UIButton *WXBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [WXBtn addTarget:self action:@selector(click_pay:) forControlEvents:UIControlEventTouchUpInside];
    WXBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:WXBtn];
    [WXBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(alipayBtn.mas_bottom);
        make.height.equalTo(@48);
    }];
    //图片格式32*32
    UIImageView *WXpay = [[UIImageView alloc] init];
    WXpay.image = [UIImage imageNamed:@"wechatpay_icon@2x"];
    [WXBtn addSubview:WXpay];
    [WXpay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(12);
        make.width.height.equalTo(@32);
        make.top.equalTo(WXBtn).offset(12);
    }];
    UILabel *WXLbl = [[UILabel alloc] init];
    WXLbl.text = @"微信支付";
    WXLbl.textAlignment = NSTextAlignmentLeft;
    WXLbl.textColor = [NSString colorWithHexString:heitizi];
    WXLbl.font = [UIFont systemFontOfSize:14];
    [WXBtn addSubview:WXLbl];
    [WXLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(alipay.mas_right).offset(12);
        make.height.equalTo(@14);
        make.top.equalTo(@20);
        make.right.equalTo(WXBtn).offset(-kScreenWidth/2);
        
    }];
    
    WXGou = [UIButton buttonWithType:UIButtonTypeCustom];
    [WXGou setImage:[UIImage imageNamed:@"pay_0@2x"] forState:UIControlStateNormal];
    [WXGou addTarget:self action:@selector(click_WXPay:) forControlEvents:UIControlEventTouchUpInside];
    [WXBtn addSubview:WXGou];
    [WXGou mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-12);
        make.top.equalTo(WXBtn).offset(12);
        make.height.width.equalTo(@32);
    }];
    UIView *line12 = [[UIView alloc] init];
    line12.frame =CGRectMake(0, 47.5, kScreenWidth, 0.5);
    line12.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    [WXBtn addSubview:line12];
    
    
    
    //工商
//    UIButton *GSBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [GSBtn addTarget:self action:@selector(click_pay:) forControlEvents:UIControlEventTouchUpInside];
//    GSBtn.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:GSBtn];
//    [GSBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.top.equalTo(WXBtn.mas_bottom);
//        make.height.equalTo(@48);
//    }];
//    UIImageView *GSpay = [[UIImageView alloc] init];
//    GSpay.image = [UIImage imageNamed:@"icbcpay_icon@2x"];
//    [GSBtn addSubview:GSpay];
//    [GSpay mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(12);
//        make.width.height.equalTo(@32);
//        make.top.equalTo(GSBtn).offset(12);
//    }];
//    UILabel *GSLbl = [[UILabel alloc] init];
//    GSLbl.text = @"工商银行分期支付";
//    GSLbl.textAlignment = NSTextAlignmentLeft;
//    GSLbl.textColor = [NSString colorWithHexString:heitizi];
//    GSLbl.font = [UIFont systemFontOfSize:14];
//    [GSBtn addSubview:GSLbl];
//    [GSLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(alipay.mas_right).offset(12);
//        make.height.equalTo(@14);
//        make.top.equalTo(@20);
//        make.right.equalTo(GSBtn).offset(-kScreenWidth/2);
//        
//    }];
//    
//    GSGou = [UIButton buttonWithType:UIButtonTypeCustom];
//    [GSGou setImage:[UIImage imageNamed:@"pay_0@2x"] forState:UIControlStateNormal];
//    [GSGou addTarget:self action:@selector(click_GSPay:) forControlEvents:UIControlEventTouchUpInside];
//    [GSBtn addSubview:GSGou];
//    [GSGou mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.view).offset(-12);
//        make.top.equalTo(GSBtn).offset(12);
//        make.height.width.equalTo(@32);
//    }];
//    UIView *lineGS = [[UIView alloc] init];
//    lineGS.frame =CGRectMake(0, 47.5, kScreenWidth, 0.5);
//    lineGS.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
//    [GSBtn addSubview:lineGS];
//
   
    
}
-(void)click_alipay:(UIButton *)sender{
    NSLog(@"支付宝图标");
    if (isopen ==YES) {
        isopen = NO;
        isWX = YES;
        isUP = YES;
        isGS = YES;
         [alipayGou setImage:[UIImage imageNamed:@"pay_1@2x"] forState:UIControlStateNormal];
        [WXGou setImage:[UIImage imageNamed:@"pay_0@2x"] forState:UIControlStateNormal];
        [uppayGou setImage:[UIImage imageNamed:@"pay_0@2x"] forState:UIControlStateNormal];
        [GSGou setImage:[UIImage imageNamed:@"pay_0@2x"] forState:UIControlStateNormal];

        type = @"1";
        
    }else{
        isopen  =YES;
        [alipayGou setImage:[UIImage imageNamed:@"pay_0@2x"] forState:UIControlStateNormal];
    }
    
}
-(void)click_UPPay:(UIButton *)sender{
    NSLog(@"银联图标");
    if (isUP ==YES) {
        isUP = NO;
        isWX = YES;
        isopen = YES;
        isGS = YES;
        type = @"7";
        [uppayGou setImage:[UIImage imageNamed:@"pay_1@2x"] forState:UIControlStateNormal];
        [WXGou setImage:[UIImage imageNamed:@"pay_0@2x"] forState:UIControlStateNormal];
        [alipayGou setImage:[UIImage imageNamed:@"pay_0@2x"] forState:UIControlStateNormal];
        [GSGou setImage:[UIImage imageNamed:@"pay_0@2x"] forState:UIControlStateNormal];

    }else{
        isUP  =YES;
        [uppayGou setImage:[UIImage imageNamed:@"pay_0@2x"] forState:UIControlStateNormal];
    }

}
-(void)click_WXPay:(UIButton *)sender{
    NSLog(@"微信图标");
    if (isWX ==YES) {
        isWX = NO;
        isUP = YES;
        isopen = YES;
        isGS = YES;
        type = @"4";
        [WXGou setImage:[UIImage imageNamed:@"pay_1@2x"] forState:UIControlStateNormal];
        [alipayGou setImage:[UIImage imageNamed:@"pay_0@2x"] forState:UIControlStateNormal];
        [uppayGou setImage:[UIImage imageNamed:@"pay_0@2x"] forState:UIControlStateNormal];
        [GSGou setImage:[UIImage imageNamed:@"pay_0@2x"] forState:UIControlStateNormal];

    }else{
        isWX  =YES;
        [WXGou setImage:[UIImage imageNamed:@"pay_0@2x"] forState:UIControlStateNormal];
    }

}

-(void)click_GSPay:(UIButton *)sender{
    NSLog(@"工商图标");
    if (isGS ==YES) {
        isGS = NO;
        isUP = YES;
        isopen = YES;
        isWX = YES;
        type = @"8";
        self.total.hidden = NO;
        [GSGou setImage:[UIImage imageNamed:@"pay_1@2x"] forState:UIControlStateNormal];
        [alipayGou setImage:[UIImage imageNamed:@"pay_0@2x"] forState:UIControlStateNormal];
        [WXGou setImage:[UIImage imageNamed:@"pay_0@2x"] forState:UIControlStateNormal];
        [uppayGou setImage:[UIImage imageNamed:@"pay_0@2x"] forState:UIControlStateNormal];
    }else{
        isGS  =YES;
        [GSGou setImage:[UIImage imageNamed:@"pay_0@2x"] forState:UIControlStateNormal];
    }


}


-(void)click_pay:(UIButton *)sender{
    NSLog(@"pay");
}
-(void)creatNavi{
    UIView *navi = [[UIView alloc] init];
    navi.frame =CGRectMake(0, 0,kScreenWidth , NAV_BAR_HEIGHT);
    navi.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navi];
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(50, kStatusBarHeight, kScreenWidth-100, NAV_BAR_HEIGHT-kStatusBarHeight)];
    titleLbl.textColor = [NSString colorWithHexString:heitizi];
    
    if ([self.status isEqualToString:@"0"]) {
        //付意向金
         titleLbl.text = @"支付意向金";
        
    }else if ([self.status isEqualToString:@"3"]){
        //付全款
         titleLbl.text = @"支付全款";
    }else{
        //付意向金(从定制过来的)
        titleLbl.text = @"支付意向金";
    }
   
    titleLbl.font = [UIFont systemFontOfSize:16];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    [navi addSubview:titleLbl];
    UIButton *backBtn=  [YkxHttptools initwithButton:[UIColor clearColor] Frame:CGRectMake(0, kStatusBarHeight, 50, NAV_BAR_HEIGHT-kStatusBarHeight) Image:[UIImage imageNamed:@"back_arrow@2x"] Title:nil Titlecolor:[NSString colorWithHexString:heitizi ] Titlefont:[UIFont systemFontOfSize:14] BaseView:navi];
    [backBtn addTarget:self action:@selector(click_back:) forControlEvents:UIControlEventTouchUpInside];
    
    
}
-(void)click_payy:(UIButton *)sender{
    
   // isGS = NO;
    if (isopen ==NO||isUP ==NO||isWX ==NO ||isGS == NO) {
        [self httppay];
    }
    else{
        [Common tipAlert:@"请选择一种支付方式"];
    }
}

-(void)httppay{
    /*
     501获取付款前信息
     URL：http://www.rempeach.com/rebirth/api/order/getDataOfPay
     接口描述：根据选择的支付方式获取付款前相关信息已完成付款
     请求方式：POST
     上传参数：
     id                 1
     oid                8101328469772636    订单ID
     pay_type           1
     round
     token
     sign
     a b c d e f g h i g k l m n o p q r s t u v w x y z
     返回参数：state ：210 111 101 121 状态码（见附录）
     
     */
    NSString *transformId = [USER_DEFAULT objectForKey:@"id"];
    NSString *oid = self.oid;
    NSString *pay_type = type;
    NSString *round = @"12345";
    NSString *instalment_num = fenqiStr;
    NSString *token = [USER_DEFAULT objectForKey:@"token"];
    NSArray *nameList;
    NSDictionary *parameters1;
   // type = @"8";
    if ([type isEqualToString:@"8"]) {
        
        nameList = @[@"id",vn(instalment_num),vn(oid),vn(pay_type),vn(round),vn(token)]; ;
        parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(transformId),sv(instalment_num),sv(oid),sv(pay_type),sv(round),sv(token),nil];

    }else{
        nameList = @[@"id",vn(oid),vn(pay_type),vn(round),vn(token)];
        parameters1  = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(transformId),sv(oid),sv(pay_type),sv(round),sv(token),nil];
    }
    
   
    NSLog(@"%@",parameters1);
//    NSString *str = sv(transformId);
    
    //   NSLog(@"%@",id);
    
    if ([pay_type isEqualToString:@"8"]) {
        
        
        GSPayVC *vc = [[GSPayVC alloc]init];
        vc.paraDict = parameters1;
        [self.navigationController pushViewController:vc animated:YES];
              
    }else{
    
    [YkxHttptools post:huoquzhifuxinxi params:parameters1 success:^(id responseObj) {
        
        NSLog(@"%@",responseObj);
        if ([[responseObj objectForKey:@"state"] isEqualToString:@"200"]) {
            if ([pay_type isEqualToString:@"7"]) {
                NSDictionary *dic = [responseObj objectForKey:@"data"];
                NSString *tn = [NSString stringWithFormat:@"%@",[dic objectForKey:@"pay_transaction_id"]];
             //   NSString *tn = [dic objectForKey:@"pay_transaction_id"];
                if (tn!=nil&&tn.length>0) {
                    UPPaymentControl *uppay = [UPPaymentControl defaultControl];
                    [uppay startPay:tn fromScheme:@"rebirth" mode:@"01" viewController:self];
                    
                }
               
                
            }else if ([pay_type isEqualToString:@"4"]){
                NSDictionary *dic = [responseObj objectForKey:@"data"];
                NSString *appid = [dic objectForKey:@"appid"];
                NSString *partnerid = [dic objectForKey:@"partnerid"];
                NSString *prepayid = [dic objectForKey:@"prepayid"];
                //调起微信
                PayReq *req = [[PayReq alloc] init];
                req.partnerId = partnerid;
                req.prepayId = prepayid;
                req.package = @"Sign=WXPay";
                req.nonceStr = [self generateTradeNO1];//随机串
                //将当前事件转化成时间戳
                NSDate *datenow = [NSDate date];
                NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
                UInt32 timeStamp =[timeSp intValue];
                req.timeStamp= timeStamp;
                DataMD5 *md5 = [[DataMD5 alloc]init];
                
                req.sign = [md5 createMD5SingForPay:appid partnerid:req.partnerId prepayid:req.prepayId package:req.package noncestr:req.nonceStr timestamp:req.timeStamp];
                [WXApi sendReq:req];
            }else if ([pay_type isEqualToString:@"8"]){
                
                NSLog(@"%@",responseObj);
            }
            else{
                NSDictionary *dic = [responseObj objectForKey:@"data"];
                body = [dic objectForKey:@"body"];
                out_trade_no = [dic objectForKey:@"out_trade_no"];
                subject = [dic objectForKey:@"subject"];
                total_fee = [dic objectForKey:@"total_fee"];
                [self generateData];
                
            }
           
            
        }else if ([[responseObj objectForKey:@"state"] isEqualToString:@"101"]){
            
            NSLog(@"%@",[responseObj objectForKey:@"tip"]);
        }else if ([[responseObj objectForKey:@"state"] isEqualToString:@"111"]){
            NSLog(@"%@123212",[responseObj objectForKey:@"message"]);
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    }
    
    
    
    
}

//产生随机字符串
- (NSString *)generateTradeNO1
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRST";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

#pragma mark -
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if (self.total.hidden == NO) {
        
        if (touch.view == self.total & touch.view != self.GSStages) {
        
            self.total.hidden = YES;
            isGS = YES;
            [GSGou setImage:[UIImage imageNamed:@"pay_0@2x"] forState:UIControlStateNormal];
            
            
            
        }
        
    }
   
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
}

#pragma mark   ==============产生订单信息==============

- (void)generateData

{
    /*
     *点击获取prodcut实例并初始化订单信息
     */
    //    Product *product = [self.productList objectAtIndex:indexPath.row];
    
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088421352706891";
    NSString *seller = @"9016828@qq.com";
    //    NSString *privateKey = @"kdzcrrx3ajyphwgy50u6ihs5b8sfom5y";
    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAPNg45cLzWjjdx55ZqZdFU9s9poSioQiSkDCyhNdyLoOCWRl+F5mYVeH+gca77o1U+oaCAc6OON0BvxwsjFu0b5sA0VSxN1Q/pYObmOMBCy0Yqord957hUMTGTt5vpfDtuENx7VEMb9afFsto8YnTp6tyW4HOkogTp0TTgX1kYWJAgMBAAECgYEAuibejTaSy2pIPz/eGttRpGmUiS4rUnujzbrvszZlhKGd33P7L8EhLUEtJWgd+pA1efalM1n+D0M84LMWKKc5tu2oYoYpyx2FfiL6VgX/JONaf4HB7MQeSgULvWQAxHlyD09d4EIR91oH4CHO2Tdy/YNLIH5LupPaxssdUml3oj0CQQD9DKtLNipQ3zXMFD4Mco9uTeqonR9xbLuL9lu5HxG3p/cl4rUo4V1Sb80CTpoUv4qfhA6yYfQy581ZLhcpK/PjAkEA9jdaTmvBaTEDJ9lvHUscx0Q2qXOBR6knleWSeBZTc2A1Z+1BWrdzaSHqzqkhrutzCOkS+/tMjEEANBm0Y/KUowJBALxtz6u81LvNyoCB3kZklBt+F6ug/IX4gptRQrHRyd6pS2dBrsaXMmetaso5/5BNpQrtSghY2n+Bjq7GnGaDHSMCQAuPW8EU1BbhQzmqvsnMTgSZEkvwbWB087PY/ICA49gl6zv+6rOcq2GDQygCzt8MlPEVKFwGV3i6UI0hq9OJfysCQD2yy6TOrpMV8FghXbyfGUOvQtICjlXhjM3aF9JrC3KRkrJjmdRvLcPo8JGOm3h8ut7rt8REtqRHt1afm7ejMXQ=";
    
    
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO =out_trade_no; //订单ID（由商家自行制定）
    PayId = order.tradeNO;
    order.productName = subject; //商品标题
    order.productDescription = body; //商品描述
    // NSString *pricezccount = [NSString stringWithFormat:@"%.2f",[_price floatValue]*[_manyDayStr floatValue]];
    //            NSString *pricezccount = total_fee; //0.0000001
    
    //  order.amount = pricezccount; //商品价格
    order.amount = [NSString stringWithFormat:@"%@",[jine.text stringByReplacingOccurrencesOfString:@"¥" withString:@""]];
    order.notifyURL =  @"www.rempeach.com/rebirth/api/api/alipay"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    // NSString *appScheme = @"TetsuyaStudentsApp";
    NSString *appScheme = @"ribirth";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEnc
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            
            NSLog(@"OrderReslut = %@",resultDic);
            
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                
               
                if ([self.typeBack isEqualToString:@"ItinerVC"]) {
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }else{
                    
                    TotalItinerVC *itie = [[TotalItinerVC alloc] init];
                    itie.typeBack = @"Pay";
                    [self.navigationController pushViewController:itie animated:YES];
                }
               
                
            }else{
                NSLog(@"支付失败resultStatus");
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message: @"支付失败" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
                
            }
        }];
        
        
        
        
    }
    
}

#pragma mark   ==============产生随机订单号==============


- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}





-(void)click_back:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 插入字符串
-(NSMutableString *)addSpaceFromSring:(NSString *)str{
    
    
    // string = [string substringToIndex:7];//去掉下标7之后的字符串
    
    NSString *qianstring;
    NSString *huostring;
    
    if (str.length > 2) {
        
        qianstring = [str substringToIndex:str.length-2];//去掉下标7之后的字符串
        
        NSLog(@"截取的值为：%@",qianstring);
        
        huostring = [str substringFromIndex:str.length-2];//去掉下标2之前的字符串
        
        NSLog(@"截取的值为：%@",huostring);
        NSMutableString *mst = [[NSMutableString alloc] init];
        
        [mst setString:qianstring];
        
        for (int i = (int)qianstring.length-3; i >0; i = i-3) {
            
            
            [mst insertString:@"," atIndex:i]; //插入空格
            
        }
        
        NSLog(@"%f",[huostring floatValue]);
        if ([huostring floatValue] == 0) {
            
            return mst;
            
        }
        
        return (NSMutableString *)[NSString stringWithFormat:@"%@.%@",mst,huostring];
        
    }else{
        
        if (str.length ==1) {
            
            return (NSMutableString *)[NSString stringWithFormat:@"0.0%@",str];
        }
        
        return (NSMutableString *)[NSString stringWithFormat:@"0.%@",str];
        
        
    }
    
}



@end
