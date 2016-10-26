//
//  OrderVC.m
//  rebirth
//
//  Created by boom on 16/7/20.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "OrderVC.h"

#import "OrderCell.h"
#import "TotalItinerVC.h"
#import "WJFDetailDiTuVC.h"
#import "HSPayViewController.h"
#import "WJFCalendarHomeVC.h"
#import "HSDelegateViewController.h"
#import "FavourableCouponsCell.h"
@interface OrderVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *orderTableView;

@property(nonatomic,strong)NSMutableArray *dataArr;

@property(nonatomic,strong)UIButton *orderBtu;

@property(nonatomic,strong)UILabel *totalMon;

@property(nonatomic,strong)UILabel *yixiangMonLabel;


@property(nonatomic,strong)NSString *delay_insurance;//逾期金额

@property(nonatomic,strong)NSString *peccancy_insurance;//违章金

@property(nonatomic,strong)NSMutableArray *coupon;//优惠券


@end

@implementation OrderVC

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    
}


-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    
    [self.leftBtu setImage:[UIImage imageNamed:@"back_arrow@2x"] forState:UIControlStateNormal];
    
    self.menuView.text = @"提交订单";
    
    [self  createTable];
    [self createOrderView];
    [self getData];
    
    //[self createBTU];
    
    
    
}

-(void)createOrderView{
    
    UIView *orderview = [[UIView alloc]init];
    
    //orderview.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:orderview];
    
    [orderview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo((56+96)/2+0.5);
        
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        
        
    }];
    
    UILabel *hexian  = [[UILabel alloc]init];
    hexian.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    [orderview addSubview:hexian];
    [hexian mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(0.5);
        make.top.equalTo(orderview.mas_top).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        
    }];
    
    
    UIView *orderview1 = [[UIView alloc]init];
    
    orderview1.backgroundColor = [UIColor whiteColor];
    
    [orderview addSubview:orderview1];
    
    [orderview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(56/2);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.top.equalTo(orderview.mas_top).offset(0.5);
        
        
    }];
    
    UILabel *hejiLabel = [[UILabel alloc]init];
    
    hejiLabel.text = @"合计:";
    hejiLabel.font = [UIFont systemFontOfSize:16];
    hejiLabel.textColor = [NSString colorWithHexString:@"#6d7278"];
    [orderview1 addSubview:hejiLabel];
    
    [hejiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(16);
        make.left.equalTo(orderview1.mas_left).offset(12);
        make.top.equalTo(orderview1.mas_top).offset(6);
        
        
    }];
    
    
    self.totalMon = [[UILabel alloc]init];
    
    self.totalMon.text = @"¥99998.00";
    self.totalMon.font = [UIFont systemFontOfSize:16];
    self.totalMon.textColor = [NSString colorWithHexString:@"#e6ca81"];
    [orderview1 addSubview:self.totalMon];
    
    [self.totalMon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(16);
        make.right.equalTo(orderview1.mas_right).offset(-12);
        make.top.equalTo(orderview1.mas_top).offset(6);
        
        
    }];
    
    
    UIView *orderview2 = [[UIView alloc]init];
    
    orderview2.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    
    [orderview addSubview:orderview2];
    
    [orderview2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(96/2);
        make.width.mas_equalTo(WIDTH-140);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.bottom.equalTo(orderview.mas_bottom).offset(0);
        
        
    }];
    
    
    UILabel *yixiangLabel = [[UILabel alloc]init];
    
    yixiangLabel.text = @"意向金:";
    yixiangLabel.font = [UIFont systemFontOfSize:16];
    yixiangLabel.textColor = [NSString colorWithHexString:@"#27292b"];
    [orderview2 addSubview:yixiangLabel];
    
    [yixiangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(orderview2.mas_left).offset(12);
        make.top.equalTo(orderview2.mas_top).offset(6);
        
        make.centerY.equalTo(orderview2.mas_centerY);
        
        
    }];
    
    
    self.yixiangMonLabel = [[UILabel alloc]init];
    
    self.yixiangMonLabel.text = @"¥999,80";
    self.yixiangMonLabel.font = [UIFont systemFontOfSize:16];
    self.yixiangMonLabel.textColor = [NSString colorWithHexString:@"#e6ca81"];
    [orderview2 addSubview:self.yixiangMonLabel];
    
    [self.yixiangMonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(yixiangLabel.mas_right).offset(13);
        
        make.top.equalTo(orderview2.mas_top).offset(6);
        
        make.centerY.equalTo(orderview2.mas_centerY);
        
        
    }];
    
    
    UIButton *jieshi = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [orderview2 addSubview:jieshi];
    
    [jieshi setTitleColor:[NSString colorWithHexString:@"#27292b"] forState:UIControlStateNormal];
    
    [jieshi setBackgroundColor:[NSString colorWithHexString:@"#f2f2f2"]];
    //jieshi.titleLabel.font = [UIFont systemFontOfSize:10];
    [jieshi setImage:[UIImage imageNamed:@"yixiangjin_help@2x"]  forState:UIControlStateNormal];
    
    [jieshi mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(orderview2.mas_centerY);
        
       // make.width.mas_equalTo(140);
        
        make.right.equalTo(orderview2.mas_right).with.offset(-12);
        
        
    }];

    
    [jieshi addTarget:self action:@selector(jieshiBtu:) forControlEvents:UIControlEventTouchUpInside];
    
    

    self.orderBtu = [UIButton buttonWithType:UIButtonTypeCustom];

    [orderview addSubview:self.orderBtu];
    
    //self.orderBtu.layer.cornerRadius = 3;
    
    [self.orderBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.orderBtu setBackgroundColor:[UIColor blackColor]];
    self.orderBtu.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.orderBtu setTitle:@"支付意向金" forState:UIControlStateNormal];
    
//    self.orderBtu.layer.shadowOffset = CGSizeMake(-1, 1);
//    self.orderBtu.layer.shadowOpacity = 0.8;
//    self.orderBtu.layer.shadowColor = [UIColor blackColor].CGColor;
    [self.orderBtu mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        
        make.width.mas_equalTo(140);
        
        make.right.equalTo(self.view.mas_right).with.offset(0);
        
        make.height.mas_equalTo(96/2);
        
    }];
    
    
    [self.orderBtu addTarget:self action:@selector(orderBtu:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark 介绍意向金
-(void)jieshiBtu:(UIButton *)btu{

    HSDelegateViewController *vc = [[HSDelegateViewController alloc]init];
    vc.location = @"6";
    [self.navigationController pushViewController:vc animated:YES];
    

}

-(void)orderBtu:(UIButton *)btu{
    
    NSLog(@"提交订单");
    NSMutableArray *order = [NSMutableArray array];
    
    NSLog(@"self.dataArr%@",self.dataArr);
    for (NSDictionary *dict in self.dataArr) {
       
        NSDictionary *oderdict = @{@"info_id":dict[@"info_id"],@"num":@"1",@"price":dict[@"money"],@"start_time":dict[@"qucheTime"]};
        
        [order addObject:oderdict];
        
    }
    
    NSString *jsonstr =   [self idObjectToJson:order];
    
    NSString * encodingString = [jsonstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSMutableString *userid = [user objectForKey:@"id"];
    NSMutableString *token  = [user objectForKey:@"token"];
    NSLog(@"%@",userid);
    
    NSDictionary *dict = @{@"route":@"Order_submitOrder",@"version":@"1",@"price_level":self.grade,@"id":userid,@"item_json":encodingString,@"token":token};
//    
    NSDictionary *paraDict = [self encryptDict:(NSMutableDictionary *)dict];
    
    [WJFCollection postWithUrlString:[NSString stringWithFormat:@"http://www.rempeach.com/rebirth/api/AppApi/receive"] Parameter:paraDict success:^(id responseObject) {
        
        NSLog(@"%@====%@",responseObject,responseObject[@"tip"]);
        if ([responseObject[@"state"] isEqualToString:@"200"]) {
            
            [user removeObjectForKey:@"startTime"];
            
            HSPayViewController *payVC = [[HSPayViewController alloc]init];
            payVC.dingjin  =  [NSString stringWithFormat:@"%@",responseObject[@"data"][@"dingjin"]];
            payVC.totalMoney = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"total"]];
            payVC.oid = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"oid"]];
            
            [self.navigationController pushViewController:payVC animated:YES];
            
            
            
            
            if (responseObject[@"data"][@"zm_flag"]) {
                
                NSLog(@"跳转到芝麻信用分");
                
            }else{
                
                if (responseObject[@"data"][@"card_flag"]) {
                    
                    NSLog(@"驾照未上传,跳转驾照页面");
                    
                }else{
                    
                    if (responseObject[@"data"][@"emergency_flag"]) {
                        
                        NSLog(@"紧急联系人是否设置,跳转紧急联系人页面");
                        
                    }else{
                        
                        
                        HSPayViewController *payVC = [[HSPayViewController alloc]init];
                        payVC.dingjin  =  [NSString stringWithFormat:@"%@",responseObject[@"data"][@"dingjin"]];
                        payVC.totalMoney = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"total"]];
                        payVC.oid = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"oid"]];
                    
                        [self.navigationController pushViewController:payVC animated:YES];
                        
                    }
                    
                }
                
                
              
            }
            
            
        }else if ([responseObject[@"state"] isEqualToString:@"210"]){
            
            
            
        }else if ([responseObject[@"state"] isEqualToString:@"101"]){
            
            
            
        }else if ([responseObject[@"state"] isEqualToString:@"111"]){
            
            
            
        }else if ([responseObject[@"state"] isEqualToString:@"121"]){
            
            [USER_DEFAULT removeObjectForKey:@"id"];
            
            [USER_DEFAULT removeObjectForKey:@"token"];
            
            [USER_DEFAULT removeObjectForKey:@"phone"];
            
            HSLoginViewController *vc = [[HSLoginViewController alloc]init];
            vc.source = @"ItineraryVC";
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        


        
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
    
    
    
}


- (NSString *)idObjectToJson:(id)object
{
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}



//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    
//    
//    CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
//    
//    if (translation.y>0) {
//        
//        [UIView animateWithDuration:0.3 animations:^{
//            
//            [self.view bringSubviewToFront:self.orderBtu];
//        }];
//        
//    }else if(translation.y<0){
//        
//        [UIView animateWithDuration:0.3 animations:^{
//            
//            [self.view sendSubviewToBack:self.orderBtu];
//            
//        }];
//        
//    }
//    
//}



#pragma mark 获取网络数据
-(void)getData{
    
    
    self.dataArr = [NSMutableArray array];
    
    NSUserDefaults  *user = [NSUserDefaults standardUserDefaults];
    
   // NSLog(@"%@",[user objectForKey:@"carNeirong"]);
    
    if (![[user objectForKey:@"carNeirong"] isKindOfClass:[NSString class]]) {
        
        [self.dataArr addObject:[user objectForKey:@"carNeirong"]];
    
    }
    
    if ( [user objectForKey:@"foodArray"]) {
        
        for (NSDictionary *dict in  [user objectForKey:@"foodArray"]) {
            
            [self.dataArr addObject:dict];
        }
        
    }
    
    if (![[user objectForKey:@"hotelNeirong"] isKindOfClass:[NSString class]]) {
        
         [self.dataArr addObject:[user objectForKey:@"hotelNeirong"]];
        
    }
    
    //NSLog(@"%lu",(unsigned long)self.dataArr.count);
    

    
    NSMutableArray *order = [NSMutableArray array];
    self.coupon = [NSMutableArray array];
    //NSLog(@"self.dataArr%@",self.dataArr);
    for (NSDictionary *dict in self.dataArr) {
        
        NSDictionary *oderdict = @{@"info_id":dict[@"info_id"],@"num":@"1",@"price":dict[@"money"],@"start_time":dict[@"qucheTime"]};
        
        [order addObject:oderdict];
        
    }
    
    NSString *jsonstr =   [self idObjectToJson:order];
    
    NSString * encodingString = [jsonstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableString *userid = [user objectForKey:@"id"];
    NSMutableString *token  = [user objectForKey:@"token"];

    NSDictionary *dict = @{@"route":@"Order_preSubmit",@"version":@"1",@"price_level":self.grade,@"id":userid,@"item_json":encodingString,@"token":token};
    
    NSDictionary *paraDict = [self encryptDict:(NSMutableDictionary *)dict];
    
    NSLog(@"%@",paraDict);
    
    [WJFCollection postWithUrlString:[NSString stringWithFormat:@"http://www.rempeach.com/rebirth/api/AppApi/receive"] Parameter:paraDict success:^(id responseObject) {
        
        NSLog(@"%@====%@",responseObject,responseObject[@"tip"]);
        if ([responseObject[@"state"] isEqualToString:@"200"]) {
           
            self.totalMon.text = [NSString stringWithFormat:@"¥%@",[self addSpaceFromSring:[NSString stringWithFormat:@"%@",responseObject[@"data"][@"real_price"]]]];
            
            self.yixiangMonLabel.text =[NSString stringWithFormat:@"%@",[self addSpaceFromSring:[NSString stringWithFormat:@"%@",responseObject[@"data"][@"dingjin"]]]];
            
            self.delay_insurance =[NSString stringWithFormat:@"%@",[self addSpaceFromSring:[NSString stringWithFormat:@"%@",responseObject[@"data"][@"delay_insurance"]]]];
            
            self.peccancy_insurance =[NSString stringWithFormat:@"%@",[self addSpaceFromSring:[NSString stringWithFormat:@"%@",responseObject[@"data"][@"peccancy_insurance"]]]];
            
            if (![responseObject[@"data"][@"coupon"] isEqualToString:@""]) {
                
                self.coupon = responseObject[@"data"][@"coupon"];
                
            }
            
            [self.orderTableView reloadData];
            
        }else if ([responseObject[@"state"] isEqualToString:@"210"]){
            
            
            
        }else if ([responseObject[@"state"] isEqualToString:@"101"]){
            
            
            
        }else if ([responseObject[@"state"] isEqualToString:@"111"]){
            
            
            
        }else if ([responseObject[@"state"] isEqualToString:@"121"]){
            
            [USER_DEFAULT removeObjectForKey:@"id"];
            
            [USER_DEFAULT removeObjectForKey:@"token"];
            
            [USER_DEFAULT removeObjectForKey:@"phone"];
            
            HSLoginViewController *vc = [[HSLoginViewController alloc]init];
            vc.source = @"ItineraryVC";
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

    
    
}


-(void)createTable{
    
    self.orderTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64+8, WIDTH,HEIGHT-72-(56+96)/2) style:UITableViewStylePlain];
    
    
    self.orderTableView.dataSource = self;
    
    self.orderTableView.delegate = self;
    
    [self.view addSubview:self.orderTableView];
    
    
}


#pragma mark uitablewViewdelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    if(indexPath.section != _dataArr.count){
        
     OrderCell * cell = [[OrderCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"OrderCell"];
        
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
     cell.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
   
    if (indexPath.section == 0) {
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        
        NSLog(@"%@",[user objectForKey:@"carNeirong"]);
        
        NSDictionary *car = [user objectForKey:@"carNeirong"];
        
        [cell.insuranceView.newsBtu mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(cell.mas_right).with.offset(0);
            
            make.top.equalTo(cell.mas_top).with.offset(12);
            make.width.mas_equalTo(0);
            make.height.mas_equalTo(12);
            
        }];

        cell.subOrderView.newsLeftLable.text = @"车辆";
        [cell.sub2OrderView.orderImageView sd_setImageWithURL:[NSURL URLWithString:car[@"image"]] placeholderImage:[UIImage imageNamed:@"default_img_zhengfang"]];
        
        cell.sub2OrderView.orderTextLable.text = car[@"title"];
        cell.sub2OrderView.orderSubTextLable.text = car[@"subTitle"];
        cell.sub2OrderView.chepaiLable.text = car[@"style"];
        
        cell.qucheTimeOrderView.timeLable.text = @"取车时间";
        
        cell.qucheTimeOrderView.orderTimeLable.text = car[@"qucheTime"];
        
        cell.qucheTimeOrderView.userInteractionEnabled = YES;
        cell.qucheTimeOrderView.tag = 888;
        UITapGestureRecognizer *quchetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(timeTap:)];
        
        [cell.qucheTimeOrderView addGestureRecognizer:quchetap];
        
        NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
        [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        [inputFormatter setDateFormat:@"yyyy/MM/dd hh:mm"];
        NSDate *inputDate = [inputFormatter dateFromString:car[@"qucheTime"]];
       NSLog(@"date= %@", inputDate);
        
        NSTimeInterval secondsPerDay = 24 * 60 * 60;
        NSDate *tomorrow;
        
        tomorrow = [inputDate dateByAddingTimeInterval: secondsPerDay];
        NSString * tomorrowString = [inputFormatter stringFromDate:tomorrow];
        NSLog(@"%@",tomorrowString);
        
        
        cell.hauancheTimeOrderView.timeLable.text = @"还车时间";
        cell.hauancheTimeOrderView.tag = 999;
        cell.hauancheTimeOrderView.orderTimeLable.text = tomorrowString;
        
        cell.addressView.newsLeftLable.text = @"取车地点";
        cell.addressView.newsLeftLable.textColor = [NSString colorWithHexString:@"#27292b"];
        cell.addressView.newsLeftLable.font = [UIFont systemFontOfSize:14];
        
        cell.addressView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addressTap:)];
        cell.addressView.tag  = 800;
        
        [cell.addressView addGestureRecognizer:tap];
        
        
        cell.addressView.newsRightLable.text = car[@"address"];
        cell.addressView.newsRightLable.textColor = [NSString colorWithHexString:@"#7a7e83"];
        cell.addressView.newsRightLable.font = [UIFont systemFontOfSize:12];
        
        cell.insuranceView.newsLeftLable.text = @"油费计算方式";
        [cell.insuranceTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.left.equalTo(cell.mas_left).with.offset(0);
            
            make.top.equalTo(cell.insuranceOneView.mas_bottom).with.offset(0);
            
            make.width.mas_equalTo(WIDTH);
            
            make.height.mas_equalTo(40);
            
            
        }];
        [cell.insuranceOneView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.left.equalTo(cell.mas_left).with.offset(0);
            
            make.top.equalTo(cell.postalView.mas_bottom).with.offset(0);
            
            make.width.mas_equalTo(WIDTH);
            
            make.height.mas_equalTo(40);
            
            
        }];
        
        [cell.insuranceThreeView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.left.equalTo(cell.mas_left).with.offset(0);
            
            make.top.equalTo(cell.insuranceTwoView.mas_bottom).with.offset(0);
            
            make.width.mas_equalTo(WIDTH);
            
            make.height.mas_equalTo(40);
            
            
        }];
        cell.insuranceView.newsLeftLable.textColor = [NSString colorWithHexString:@"#27292b"];
        cell.insuranceView.newsLeftLable.font = [UIFont systemFontOfSize:14];
        
        cell.insuranceView.newsRightLable.text = @"原油位还车";
        cell.insuranceView.newsRightLable.textColor = [NSString colorWithHexString:@"#7a7e83"];
        cell.insuranceView.newsRightLable.font = [UIFont systemFontOfSize:12];
        
        cell.postalView.newsLeftLable.text = @"不计免赔费用";
        cell.postalView.newsLeftLable.textColor = [NSString colorWithHexString:@"#27292b"];
        cell.postalView.newsLeftLable.font = [UIFont systemFontOfSize:14];
        
        cell.postalView.newsRightLable.text = @"平台赠送";
        cell.postalView.newsRightLable.textColor = [NSString colorWithHexString:@"#e6ca81"];
        cell.postalView.newsRightLable.font = [UIFont systemFontOfSize:12];
        
        cell.insuranceOneView.newsLeftLable.text = @"平台保障费";
        cell.insuranceOneView.newsLeftLable.textColor = [NSString colorWithHexString:@"#27292b"];
        cell.insuranceOneView.newsLeftLable.font = [UIFont systemFontOfSize:14];
        
        cell.insuranceOneView.newsRightLable.text = @"平台赠送";
        cell.insuranceOneView.newsRightLable.textColor = [NSString colorWithHexString:@"#e6ca81"];
        cell.insuranceOneView.newsRightLable.font = [UIFont systemFontOfSize:12];
        
        
        cell.insuranceTwoView.newsLeftLable.text = @"逾期还车担保金";
        cell.insuranceTwoView.newsLeftLable.textColor = [NSString colorWithHexString:@"#27292b"];
        cell.insuranceTwoView.newsLeftLable.font = [UIFont systemFontOfSize:14];
        ;
        
      //  NSLog(@"money===%f",[car[@"money"] floatValue]*0.5);
       // NSLog(@"money1==%.f",[car[@"money"] floatValue]*0.5);
        
        NSString *str = [NSString stringWithFormat:@"%f",[car[@"money"] floatValue]*0.5];
        
        NSArray *strArr = [str componentsSeparatedByString:@"."];
        
        //NSLog(@"money1==%f",[strArr[0] floatValue]);
        
        float carMoney;
        if ([car[@"money"] floatValue]*0.5 > [strArr[0] floatValue]) {
            
            carMoney = [strArr[0] floatValue]+1;
            
        }else{
            
            carMoney = [car[@"money"] floatValue]*0.5;

        }
        
        //NSLog(@"%f",carMoney);
        
        if (self.delay_insurance.length >0) {
            
             cell.insuranceTwoView.newsRightLable.text =[NSString stringWithFormat:@"¥%@",self.delay_insurance];
        }
       // NSLog(@"%@",[NSString stringWithFormat:@"%.f",carMoney]);
        cell.insuranceTwoView.newsRightLable.textColor = [NSString colorWithHexString:@"#e6ca81"];
        cell.insuranceTwoView.newsRightLable.font = [UIFont systemFontOfSize:12];
        
        cell.insuranceThreeView.newsLeftLable.text = @"违章担保金";
        cell.insuranceThreeView.newsLeftLable.textColor = [NSString colorWithHexString:@"#27292b"];
        cell.insuranceThreeView.newsLeftLable.font = [UIFont systemFontOfSize:14];
        
        cell.insuranceThreeView.newsRightLable.text = [NSString stringWithFormat:@"¥ 1500"];

        if (self.peccancy_insurance.length >0) {
           cell.insuranceThreeView.newsRightLable.text = [NSString stringWithFormat:@"¥ %@",self.peccancy_insurance];
            
      }
 
        cell.insuranceThreeView.newsRightLable.textColor = [NSString colorWithHexString:@"#e6ca81"];
        cell.insuranceThreeView.newsRightLable.font = [UIFont systemFontOfSize:12];
        

        
    }
    
    if (indexPath.section != 0 ) {
        
        [cell.qucheTimeOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(0);
            
            make.left.equalTo(cell.mas_left).with.offset(0);
            
            make.top.equalTo(cell.sub2OrderView.mas_bottom).with.offset(1);
            
            make.width.mas_equalTo(WIDTH/2);

            
        }];
        
      
        
        [cell.hauancheTimeOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(0);
            
            make.left.equalTo(cell.mas_left).with.offset(0);
            
            make.top.equalTo(cell.sub2OrderView.mas_bottom).with.offset(1);
            
            make.width.mas_equalTo(WIDTH/2);
            
            
        }];
        
        
        
        [cell.addressView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.left.equalTo(cell.mas_left).with.offset(0);
            
            make.top.equalTo(cell.qucheTimeOrderView.mas_bottom).with.offset(1);
            
            make.width.mas_equalTo(WIDTH);
            
            make.height.mas_equalTo(44);
            
            
        }];

        
        [cell.insuranceView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.left.equalTo(cell.mas_left).with.offset(0);
            make.top.equalTo(cell.addressView.mas_bottom).with.offset(1);
            
            make.width.mas_equalTo(WIDTH);
            
            make.height.mas_equalTo(44);
            
            
        }];
        
               
        [cell.postalView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(0);
            
            make.left.equalTo(cell.mas_left).with.offset(0);
            
            make.top.equalTo(cell.insuranceView.mas_bottom).with.offset(1);
            
            make.width.mas_equalTo(WIDTH/2);
            
            
        }];
        
        
        [cell.insuranceOneView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(0);
            
            make.left.equalTo(cell.mas_left).with.offset(0);
            make.top.equalTo(cell.postalView.mas_bottom).with.offset(1);
            
            make.width.mas_equalTo(WIDTH/2);
            
            
        }];
        
        [cell.insuranceTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(0);
            
            make.left.equalTo(cell.mas_left).with.offset(0);
            
            make.top.equalTo(cell.insuranceOneView.mas_bottom).with.offset(1);
            
            make.width.mas_equalTo(WIDTH/2);
            
            
        }];
        
        [cell.insuranceThreeView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(0);
            
            make.left.equalTo(cell.mas_left).with.offset(0);
            
            make.top.equalTo(cell.insuranceTwoView.mas_bottom).with.offset(1);
            
            make.width.mas_equalTo(WIDTH/2);
            
            
        }];
        
            NSDictionary  *dict  = _dataArr[indexPath.section];
        
            [cell.sub2OrderView.orderImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"image"]] placeholderImage:[UIImage imageNamed:@"default_img_zhengfang"]];
            
            cell.sub2OrderView.orderTextLable.text = dict[@"title"];
            
            cell.sub2OrderView.orderSubTextLable.text = dict[@"subTitle"];
            
           // cell.sub2OrderView.chepaiLable.text = dict[@"style"];
            
           // cell.qucheTimeOrderView.orderTimeLable.text = car[@"qucheTime"];
            
            cell.addressView.newsRightLable.text = dict[@"qucheTime"];
            cell.addressView.newsRightLable.textColor = [NSString colorWithHexString:@"#7a7e83"];
             cell.addressView.newsRightLable.font = [UIFont systemFontOfSize:12];
        
            cell.insuranceView.newsRightLable.text = dict[@"address"];
        
            cell.insuranceView.newsRightLable.textColor = [NSString colorWithHexString:@"#7a7e83"];
            cell.insuranceView.newsRightLable.font = [UIFont systemFontOfSize:12];

            cell.addressView.newsLeftLable.textColor = [NSString colorWithHexString:@"#27292b"];
            cell.addressView.newsLeftLable.font = [UIFont systemFontOfSize:14];
        
            cell.insuranceView.newsLeftLable.textColor = [NSString colorWithHexString:@"#27292b"];
            cell.insuranceView.newsLeftLable.font = [UIFont systemFontOfSize:14];
            cell.subOrderView.newsLeftLable.text = dict[@"style"];
        

        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];

        if (indexPath.section == self.dataArr.count-1 && ![[user objectForKey:@"hotelNeirong"] isKindOfClass:[NSString class]]) {
            
            
            cell.subOrderView.newsLeftLable.text = @"酒店";
            
            cell.addressView.newsLeftLable.text = @"入住时间";
            
            cell.insuranceView.newsLeftLable.text = @"入住地点";
            cell.addressView.newsLeftLable.textColor = [NSString colorWithHexString:@"#27292b"];
            cell.addressView.newsLeftLable.font = [UIFont systemFontOfSize:14];
            
            cell.insuranceView.newsLeftLable.textColor = [NSString colorWithHexString:@"#27292b"];
            cell.insuranceView.newsLeftLable.font = [UIFont systemFontOfSize:14];
        }else{
            
            cell.addressView.newsLeftLable.text = @"就餐时间";
            
            cell.insuranceView.newsLeftLable.text = @"就餐地点";

            cell.addressView.newsLeftLable.textColor = [NSString colorWithHexString:@"#27292b"];
            cell.addressView.newsLeftLable.font = [UIFont systemFontOfSize:14];
            cell.insuranceView.newsLeftLable.textColor = [NSString colorWithHexString:@"#27292b"];
            cell.insuranceView.newsLeftLable.font = [UIFont systemFontOfSize:14];
        }
        
        cell.insuranceView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addressTap:)];
        cell.insuranceView.tag  = 900;
        
        [cell.insuranceView addGestureRecognizer:tap];

        
        cell.addressView.userInteractionEnabled = YES;
        UITapGestureRecognizer *addressViewtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(timeTap:)];
        cell.addressView.tag  = 777;
        
        [cell.addressView addGestureRecognizer:addressViewtap];
    
        
     }
    
    [cell.addressView.newsBtu setImage:[UIImage imageNamed:@"order_arrow@2x"] forState:UIControlStateNormal];
    
    [cell.insuranceView.newsBtu setImage:[UIImage imageNamed:@"order_arrow@2x"] forState:UIControlStateNormal];
    

    return cell;
    
    }else{
        
        FavourableCouponsCell *cell = [[FavourableCouponsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FavourableCouponsCell"];
        
        if (self.coupon.count >0) {
            
            cell.favoCouLabel.text = [NSString stringWithFormat:@"-¥%f",[self.coupon[0][@"saleNum"] floatValue]];
        }else{
            
            cell.favoCouLabel.text = @"暂无红包可用";
            cell.favoCouLabel.textColor = [NSString colorWithHexString:@"85898d"];
        }
        
        return cell;
    }
    
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 12;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArr.count+1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return   920/2-24-3;
    }else if (indexPath.section == _dataArr.count){
        return 40;
    }
    return   221-8;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    
    view.backgroundColor = [NSString colorWithHexString:@"#f2f2f2"];
    
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    ItineraryVC *vc = [[ItineraryVC alloc]init];
//    
//    [self.navigationController pushViewController:vc animated:YES];
//    
}



//去掉UItableview headerview黏性
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.orderTableView)
    {
        CGFloat sectionHeaderHeight = 12;
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}
#pragma mark 手势

-(void)addressTap:(UITapGestureRecognizer *)sender{
    
    NSLog(@"%@",sender.view);
    
    OrderSubView1 *view = (OrderSubView1*)sender.view;
    
    NSLog(@"%@",view.newsRightLable.text);
    WJFDetailDiTuVC *vc = [[WJFDetailDiTuVC alloc]init];
    vc.address = view.newsRightLable.text;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)timeTap:(UITapGestureRecognizer *)sender{
    
    if (sender.view.tag == 777) {
        WJFCalendarHomeVC *vc = [[WJFCalendarHomeVC alloc]init];
        OrderSubView1 *view = (OrderSubView1*)sender.view;
        [vc setPlaneToDay:365 ToDateforString:nil];//
        
        vc.block = ^(NSString *str ){
            
            view.newsRightLable.text = str;
            
        };
        
        [self.navigationController pushViewController:vc animated:YES];
    }else if(sender.view.tag == 888){
        
        
        WJFCalendarHomeVC *vc = [[WJFCalendarHomeVC alloc]init];
        OrderView3 *view = (OrderView3*)sender.view;
        [vc setPlaneToDay:365 ToDateforString:nil];//
        
        vc.block = ^(NSString *str ){
            
            view.orderTimeLable.text = str;
            
            NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
            [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
            [inputFormatter setDateFormat:@"yyyy/MM/dd hh:mm"];
            NSDate *inputDate = [inputFormatter dateFromString:str];
            NSLog(@"date= %@", inputDate);
            
            NSTimeInterval secondsPerDay = 24 * 60 * 60;
            NSDate *tomorrow;
            
            tomorrow = [inputDate dateByAddingTimeInterval: secondsPerDay];
            NSString * tomorrowString = [inputFormatter stringFromDate:tomorrow];
            NSLog(@"%@",tomorrowString);
            
            OrderView3 *huancheview = [self.view viewWithTag:999];
            huancheview.orderTimeLable.text = tomorrowString;

            
        };
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
   

    
}

#pragma mark 插入字符串
-(NSMutableString *)addSpaceFromSring:(NSString *)str{
    
    
    // string = [string substringToIndex:7];//去掉下标7之后的字符串
    
    NSString *qianstring;
    NSString *huostring;
    
    if (str.length > 2) {
        
        qianstring = [str substringToIndex:str.length-2];//去掉下标7之后的字符串
        
      //  NSLog(@"截取的值为：%@",qianstring);
        
        huostring = [str substringFromIndex:str.length-2];//去掉下标2之前的字符串
        
       // NSLog(@"截取的值为：%@",huostring);
        NSMutableString *mst = [[NSMutableString alloc] init];
        
        [mst setString:qianstring];
        
        for (int i = (int)qianstring.length-3; i >0; i = i-3) {
            
            
            [mst insertString:@"," atIndex:i]; //插入空格
            
        }
        
        //NSLog(@"%f",[huostring floatValue]);
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
