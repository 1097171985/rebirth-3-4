//
//  DownPayVC.m
//  rebirth
//
//  Created by boom on 16/8/26.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "DownPayVC.h"
#import "TotalItinerVC.h"

#define MENUTEXT @[@"意向金支付成功",@"全款支付成功"]

#define ZHUTEXT @[@"意向金支付完成,已提交订单至平台审核",@"全款支付完成,已开始行程时间轴"]

#define SUBTEXT @[@"审核通过后,支付全款即可原路退回意向金",@"您可以去行程时间轴查看进行中"]

@interface DownPayVC ()

@end

@implementation DownPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.leftBtu setImage:[UIImage imageNamed:@"back_arrow@2x"] forState:UIControlStateNormal];
    
    self.menuView.text = @"意向金支付";
    
    [self createPayDown];
    
     self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
}



-(void)createPayDown{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, WIDTH, 1)];
    label.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    [self.view addSubview:label];
    
    UIImageView *downpay = [[UIImageView alloc]initWithFrame:CGRectMake(286/2, 144/2+NAV_BAR_HEIGHT, 90, 90)];
    
    downpay.image = [UIImage imageNamed:@"椭圆-1@2x"];
    
    [self.view addSubview:downpay];
    
    [downpay mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(90);
        
        make.top.equalTo(label.mas_bottom).with.offset(200/2);
        
        make.width.mas_equalTo(90);
        
        make.left.equalTo(self.view.mas_left).with.offset(WIDTH/2-45);
        
    }];

    
    UILabel *zhulabel = [[UILabel alloc]init];
    
    zhulabel.text = @"意向金支付完成,已提交订单至平台审核";
    
    zhulabel.textAlignment = NSTextAlignmentCenter;
    
    zhulabel.font = [UIFont systemFontOfSize:16];
    
    [self.view addSubview:zhulabel];
    
    [zhulabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(16);
        
        make.top.equalTo(downpay.mas_bottom).with.offset(45);
        
        make.left.equalTo(self.view.mas_left).with.offset(0);
        
        make.right.equalTo(self.view.mas_right).with.offset(0);
        
    }];
    
    
    UILabel *shulabel = [[UILabel alloc]init];
    
    [self.view addSubview:shulabel];
    
    shulabel.text = @"审核通过后,支付全款即可原路退回意向金";
    shulabel.textColor = [UIColor grayColor];
    shulabel.textAlignment = NSTextAlignmentCenter;
    shulabel.font = [UIFont systemFontOfSize:12];
    [shulabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(12);
        
        make.top.equalTo(zhulabel.mas_bottom).with.offset(16);
        
        make.left.equalTo(self.view.mas_left).with.offset(0);
        
        make.right.equalTo(self.view.mas_right).with.offset(0);
        
    }];

    UIButton *dingdan = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.view addSubview:dingdan];
    
    [dingdan setBackgroundColor:[UIColor blackColor]];
    
    [dingdan setTitle:@"查看订单" forState:UIControlStateNormal];
    
    dingdan.layer.masksToBounds = YES;
    
    dingdan.layer.cornerRadius = 3;
    
    [dingdan setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [dingdan mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(44);
        
        make.width.mas_equalTo(120);
        
        make.top.equalTo(shulabel.mas_bottom).with.offset(20);
        
        make.left.equalTo(self.view.mas_left).with.offset(WIDTH/2-60);
        
    }];
    
    [dingdan addTarget:self action:@selector(dingdan:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)dingdan:(UIButton *)btu{

    TotalItinerVC *vc = [[TotalItinerVC alloc]init];
    vc.typeBack = @"Pay";
    [self.navigationController pushViewController:vc animated:YES];

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
