//
//  HSVegetableViewController.m
//  rebirth
//
//  Created by 侯帅 on 16/7/19.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSVegetableViewController.h"
#import "HSXiangqingCell.h"
#import "HSXQTwoCell.h"
#import "HSXQRiqiCell.h"
#import "HSXQCaipuCell.h"
#import "HSCDXQMapCell.h"
#import "WJFCalendarHomeVC.h"
#import "WJFDetailDiTuVC.h"
#import "ServiceView.h"
#import "FirstViewController.h"
#import "HSLoginViewController.h"
#import "DingZhiVC.h"
#import "CardDingZhiDistance.h"
#import "XingChengGuanLiViewController.h"
@interface HSVegetableViewController ()<UITableViewDataSource,UITableViewDelegate,HSXQCaipuCellDelegate,MAMapViewDelegate,SDCycleScrollViewDelegate>
@property (nonatomic, strong)NSMutableArray *dataArray;//全部数组

@property(nonatomic,strong)NSMutableArray *chuanzhiDataArray;//传值数组

@property (nonatomic, strong)UITableView *htable;
@property (nonatomic, assign)BOOL isMore;

@property(nonatomic,strong)UIButton  *leftBtu;


@property(nonatomic,strong)UIButton  *rightBtu;

@property(nonatomic,strong)NSString *stypeDefine;

@property(nonatomic,strong)UILabel  *menuView;

@property(nonatomic,strong)UIView  *naviView;

@property(nonatomic,strong)NSString *type;

@property(nonatomic,strong)NSString *logoImage;

@property(nonatomic,strong)NSString  *price;

@property(nonatomic,strong)NSString  *vtitle;

@property(nonatomic,strong)NSString  *adv;

@property(nonatomic,strong)NSString  *defined;

@property(nonatomic,strong)NSString  *coordinate;

@property(nonatomic,strong)NSString  *address;

@property(nonatomic,strong)NSString  *time;

@property(nonatomic,strong)NSMutableArray *imageArr;

@property(nonatomic,strong)NSMutableDictionary  *caimenu;

@property(nonatomic,strong)UIButton  *ser;

@property(nonatomic,strong) ServiceView *service;

@property(nonatomic,strong)HSCDXQMapCell *mapCell;

@property(nonatomic, strong)NSString *gradelevel;




@end

@implementation HSVegetableViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.mapCell  = [[HSCDXQMapCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID4"];

    self.mapCell.mapView.delegate = self;
    
    [self.mapCell.mapView setVisibleMapRect:MAMapRectMake(220800, 1014700, 27200, 46600) animated:YES];
    

    UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backpreviousClick:)];
    rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGestureRecognizer];
    //self.time = @"2016/07/12";
    

    // Do any additional setup after loading the view.
    _isMore = 0;
    [self getDetailedData];
    [self createNav];
    [self creatTable];
    
    [self creatSelectBtu];

    
    
}

-(void)backpreviousClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)creatSelectBtu{
  
    UIView *content = [[UIView alloc] init];
    content.frame = CGRectMake(0, HEIGHT-50, kScreenWidth, 50);
    content.backgroundColor = [UIColor whiteColor];
   [self.view addSubview:content];
   UIButton *xuandingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
   xuandingBtn.frame = CGRectMake(kScreenWidth/3+kScreenWidth/3, 0, kScreenWidth/3, 50);
    [xuandingBtn setBackgroundColor:[UIColor blackColor]];
   [xuandingBtn setTitle:@"选定" forState:UIControlStateNormal];
   [xuandingBtn setTitleColor:[NSString colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    xuandingBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [xuandingBtn addTarget:self action:@selector(xuandingBin:) forControlEvents:UIControlEventTouchUpInside];
    
   [content addSubview:xuandingBtn];

}


#pragma mark 选定时间
-(void)xuandingBin:(UIButton *)btu{
    
     NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSString *userid = [user objectForKey:@"id"];
    if (!userid) {
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"您需要登录,请先登录" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSLog(@"确定");
            HSLoginViewController *vc = [[HSLoginViewController alloc]init];
            vc.source = @"ItineraryVC";
            
            [self.navigationController pushViewController:vc animated:YES];
            
            
            
        }];
        
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            NSLog(@"取消");
            
        }];
        
        [alert addAction:ok];//添加按钮
        [alert addAction:cancel];//添加按钮
        //以modal的形式
        [self presentViewController:alert animated:YES completion:^{ }];
        

        
    }else{
    
//       if ([self.caipu isEqualToString:@"caipu"]) {
//        
//          if (self.time.length > 0) {
//            
////        NSLog(@"%@",[user objectForKey:@"number"]);
//        
//          if (![[user objectForKey:@"number"] isEqualToString:@"0"]) {
//           
//            NSString *number = [user objectForKey:@"number"];
//              int  maxNum = 0;
//              if ([self.gradelevel isEqualToString:@"1"]) {
//                  
//                  maxNum = 1;
//                  
//              }else if([self.gradelevel isEqualToString:@"2"]){
//                  
//                  maxNum = 2;
//              }else if ([self.gradelevel isEqualToString:@"3"]){
//                  
//                  maxNum = 3;
//                  
//              }
//              
//            if ([number intValue]<3) {
//                
//                int  a = [number intValue];
//                a++;
//                
//                if ([self.stypeDefine isEqualToString:[user objectForKey:@"午餐"]]) {
//                    
//                    a--;
//                }
//                if ([self.stypeDefine isEqualToString:[user objectForKey:@"下午茶"]]) {
//                    
//                    a--;
//                    
//                }
//                if ([self.stypeDefine isEqualToString:[user objectForKey:@"晚餐"]]) {
//                    
//                    a--;
//                    //NSLog(@"晚餐");
//                }
//                
//                NSString *b = [NSString stringWithFormat:@"%d",a];
//                
//                [user setObject:b forKey:@"number"];
//                
//            }else{
//                
//                //NSLog(@"77777777777777777");
//            }
//              
//            if ([self.stypeDefine isEqualToString:@"午餐"]) {
//                
//                [user setObject:self.stypeDefine forKey:@"午餐"];
//                
//                NSDictionary *lunerDict = @{@"stype":@"luner",@"money":self.price,@"image":self.logoImage,@"title":self.vtitle,@"subTitle":self.adv,@"style":self.stypeDefine,@"qucheTime":self.time,@"address":self.address,@"item_id":self.item_id,@"info_id":self.info_id};
//                
//                [user setObject:lunerDict forKey:@"lunerDict"];
//                
//                [self riliThreeCarandFoodWithHotel:@"luner" withStareTime:self.time];
//                
//
//                
//            }
//              
//            if ([self.stypeDefine isEqualToString:@"下午茶"]) {
//                
//                [user setObject:self.stypeDefine forKey:@"下午茶"];
//                
//                NSDictionary *coffeDict = @{@"stype":@"coffe",@"money":self.price,@"image":self.logoImage,@"title":self.vtitle,@"subTitle":self.adv,@"style":self.stypeDefine,@"qucheTime":self.time,@"address":self.address,@"info_id":self.info_id};
//                
//                [user setObject:coffeDict forKey:@"coffeDict"];
//                
//                [self riliThreeCarandFoodWithHotel:@"coffe" withStareTime:self.time];
//                
//
//
//            }
//            
//            if ([self.stypeDefine isEqualToString:@"晚餐"]) {
//                
//                [user setObject:self.stypeDefine forKey:@"晚餐"];
//                
//                NSDictionary *dinnerDict = @{@"stype":@"dinner",@"money":self.price,@"image":self.logoImage,@"title":self.vtitle,@"subTitle":self.adv,@"style":self.stypeDefine,@"qucheTime":self.time,@"address":self.address,@"info_id":self.info_id};
//                [user setObject:dinnerDict forKey:@"dinnerDict"];
//                
//                [self riliThreeCarandFoodWithHotel:@"dinner" withStareTime:self.time];
//            }
//
//            
//        }else{
//            
//             [user setObject:@"1" forKey:@"number"];
//            
//            if ([self.stypeDefine isEqualToString:@"午餐"]) {
//                
//                [user setObject:self.stypeDefine forKey:@"午餐"];
//                
//                 NSDictionary *lunerDict = @{@"stype":@"luner",@"money":self.price,@"image":self.logoImage,@"title":self.vtitle,@"subTitle":self.adv,@"style":self.stypeDefine,@"qucheTime":self.time,@"address":self.address,@"item_id":self.item_id,@"info_id":self.info_id};
//                
//                [user setObject:lunerDict forKey:@"lunerDict"];
//                
//                [self riliThreeCarandFoodWithHotel:@"luner" withStareTime:self.time];
//                
//            }
//            
//            if ([self.stypeDefine isEqualToString:@"下午茶"]) {
//                
//                [user setObject:self.stypeDefine forKey:@"下午茶"];
//                
//                NSDictionary *coffeDict = @{@"stype":@"coffe",@"money":self.price,@"image":self.logoImage,@"title":self.vtitle,@"subTitle":self.adv,@"style":self.stypeDefine,@"qucheTime":self.time,@"address":self.address,@"item_id":self.item_id,@"info_id":self.info_id};
//                
//                [user setObject:coffeDict forKey:@"coffeDict"];
//                
//                [self riliThreeCarandFoodWithHotel:@"coffe" withStareTime:self.time];
//                
//                
//            }
//            
//            if ([self.stypeDefine isEqualToString:@"晚餐"]) {
//                
//                [user setObject:self.stypeDefine forKey:@"晚餐"];
//                
//                NSDictionary *dinnerDict = @{@"stype":@"dinner",@"money":self.price,@"image":self.logoImage,@"title":self.vtitle,@"subTitle":self.adv,@"style":self.stypeDefine,@"qucheTime":self.time,@"address":self.address,@"item_id":self.item_id,@"info_id":self.info_id};
//                
//                [user setObject:dinnerDict forKey:@"dinnerDict"];
//                
//                [self riliThreeCarandFoodWithHotel:@"dinner" withStareTime:self.time];
//                
//            }
//        }
//        
//              
//        NSDictionary *foodDict = @{@"luner":[user objectForKey:@"lunerDict"],@"coffer":[user objectForKey:@"coffeDict"],@"dinner":[user objectForKey:@"dinnerDict"]};
//        
//        [user setObject:foodDict forKey:@"foodDict"];
//        
//        if ([self.arrow isEqualToString:@"dingzhicai"]) {
//              [self startTime];
//             [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count -1] animated:YES];
//            
//        }else if ([self.arrow isEqualToString:@"home"]){
//            
//            CardDingZhiDistance *vc = [[CardDingZhiDistance alloc]init];
//            vc.hStype = @"food";
//            vc.grade = self.gradelevel;
//            //vc.grade  =
//            [self startTime];
//            [self.navigationController pushViewController:vc animated:YES];
//            
//            
//        }else{
//            
//             [self startTime];
//            
//             [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count -2] animated:YES];
//        }
//       
//     
//        }else{
//            
//            [LCProgressHUD showStatus:LCProgressHUDStatusInfo text:@"请您选择时间"];
//            
//        }
//    }

    
    NSMutableArray *foodArray = [NSMutableArray array];
    if ([user objectForKey:@"foodArray"]) {
        
        foodArray = [user objectForKey:@"foodArray"];
        
    }
        
    if ([self.caipu isEqualToString:@"caipu"]) {
        
        if (self.time.length > 0) {
        
          if ([self.gradelevel isEqualToString:@"1"]) {
              
              if (foodArray.count == 1) {
                  
                 // [LCProgressHUD showStatus:LCProgressHUDStatusInfo text:@"已选择，如重选请删除"];
                  [self pushAlertSelect];

              }else{
                  
                  [self gggggg:foodArray];

                  [self pushSave:foodArray];
              }
        
         }
            
        if ([self.gradelevel isEqualToString:@"2"]) {
            
            if (foodArray.count == 2) {
                
                //[LCProgressHUD showStatus:LCProgressHUDStatusInfo text:@"已选择，如重选请删除"];
                [self pushAlertSelect];
            }else{
                
                [self gggggg:foodArray];
                [self pushSave:foodArray];

            }
            
        }
         
        if ([self.gradelevel isEqualToString:@"3"]) {
            
            if (foodArray.count == 3) {
                
               // [LCProgressHUD showStatus:LCProgressHUDStatusInfo text:@"已选择，如重选请删除"];
                [self pushAlertSelect];

                
            }else{
                
                [self gggggg:foodArray];
                [self pushSave:foodArray];

            }

            
        }
            
            
      
        
      }else{
        
        [LCProgressHUD showStatus:LCProgressHUDStatusInfo text:@"请您选择时间"];
        
        }
    }

        
    if ([self.caipu isEqualToString:@"car"]) {
        
        if (self.time.length > 0) {
            
            if([[USER_DEFAULT objectForKey:@"car"] isEqualToString:@"car"]){
               
                [self pushAlertSelect];

                
            }else{
                
                [user setObject:@"car" forKey:@"car"];
                
                NSDictionary *carDict = @{@"stype":@"car",@"money":self.price,@"image":self.image_URL,@"title":self.vtitle,@"subTitle":self.adv,@"style":self.defined,@"qucheTime":self.time,@"address":self.address,@"item_id":self.item_id,@"info_id":self.info_id};
                
                [user setObject:carDict forKey:@"carNeirong"];
                
                if ([self.arrow isEqualToString:@"home"]){
                    
                    CardDingZhiDistance *vc = [[CardDingZhiDistance alloc]init];
                    vc.hStype = @"car";
                    vc.grade = self.gradelevel;
                    [self startTime];
                    [self riliThreeCarandFoodWithHotel:@"car" withStareTime:self.time];
                    [self.navigationController pushViewController:vc animated:YES];
                    
                    
                }else{
                    
                    
                    [self startTime];
                    [self riliThreeCarandFoodWithHotel:@"car" withStareTime:self.time];
                    [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count -2] animated:YES];
                    
                }


                
            }}else{
            
            [LCProgressHUD showStatus:LCProgressHUDStatusInfo text:@"请您选择时间"];
            
            
        }

    }
    
    if ([self.caipu isEqualToString:@"hotel"]) {
        
        if (self.time.length > 0) {
            
            if([[USER_DEFAULT objectForKey:@"hotel"] isEqualToString:@"hotel"]){
                
                [self pushAlertSelect];
                
                
            }else{
            
            
            [user setObject:@"hotel" forKey:@"hotel"];
            
            NSDictionary *hotelDict;
            if ([self.arrow isEqualToString:@"home"]) {
                
                hotelDict = @{@"stype":@"hotel",@"money":self.price,@"image":self.image_URL,@"title":self.vtitle,@"subTitle":self.adv,@"style":self.defined,@"qucheTime":self.time,@"address":self.address,@"item_id":self.item_id,@"info_id":self.info_id,@"FirstTitle":self.vtitle,@"FirstImage":self.image_URL,@"FirstSubTitle":self.adv};
                [user setObject:hotelDict forKey:@"hotelNeirong"];
                CardDingZhiDistance *vc = [[CardDingZhiDistance alloc]init];
                vc.hStype = @"hotel";
                [self startTime];
                vc.grade = self.gradelevel;
                
                [self riliThreeCarandFoodWithHotel:@"hotel" withStareTime:self.time];
                [self.navigationController pushViewController:vc animated:YES];
                


            }else if([self.arrow isEqualToString:@"dingzhihotel"]){
                
                
                hotelDict = @{@"stype":@"hotel",@"money":self.price,@"image":self.image_URL,@"title":self.vtitle,@"subTitle":self.adv,@"style":self.defined,@"qucheTime":self.time,@"address":self.address,@"item_id":self.item_id,@"info_id":self.info_id};
                [user setObject:hotelDict forKey:@"hotelNeirong"];
                [self startTime];
                [self riliThreeCarandFoodWithHotel:@"hotel" withStareTime:self.time];
                [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count -2] animated:YES];
            }else{
                
                
                hotelDict = @{@"stype":@"hotel",@"money":self.price,@"image":self.image_URL,@"title":self.vtitle,@"subTitle":self.adv,@"style":self.defined,@"qucheTime":self.time,@"address":self.address,@"item_id":self.item_id,@"info_id":self.info_id};
                [user setObject:hotelDict forKey:@"hotelNeirong"];
                [self startTime];
                
                [self riliThreeCarandFoodWithHotel:@"hotel" withStareTime:self.time];
                
                [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count -2] animated:YES];
            }
  
         }}else{
            
            [LCProgressHUD showStatus:LCProgressHUDStatusInfo text:@"请您选择时间"];
            
            
        }

     }
    }
  //  NSLog(@"%@",self.navigationController.viewControllers) ;
    
    
}



-(void)pushAlertSelect{
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"您已选完此项，是否要重选" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"前往行程管理" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSLog(@"确定");
        XingChengGuanLiViewController  *vc = [[XingChengGuanLiViewController alloc]init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
    }];
    
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        NSLog(@"取消");
        
    }];
    
    [alert addAction:ok];//添加按钮
    [alert addAction:cancel];//添加按钮
    //以modal的形式
    [self presentViewController:alert animated:YES completion:^{ }];
    
    
    
    
}


-(void)pushSave:(NSMutableArray *)foodArray{
    
    
    [USER_DEFAULT setObject:foodArray forKey:@"foodArray"];
    
    if ([self.arrow isEqualToString:@"dingzhicai"]) {
        [self startTime];
        [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count -1] animated:YES];
        
    }else if ([self.arrow isEqualToString:@"home"]){
        
        CardDingZhiDistance *vc = [[CardDingZhiDistance alloc]init];
        vc.hStype = @"food";
        vc.grade = self.gradelevel;
        //vc.grade  =
        [self startTime];
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }else{
        
        [self startTime];
        
        [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count -2] animated:YES];
    }

}

-(void)gggggg:(NSMutableArray *)foodArray{
    
    
    if ([self.stypeDefine isEqualToString:@"午餐"]) {
        
        
        NSDictionary *lunerDict = @{@"stype":@"luner",@"money":self.price,@"image":self.logoImage,@"title":self.vtitle,@"subTitle":self.adv,@"style":self.stypeDefine,@"qucheTime":self.time,@"address":self.address,@"item_id":self.item_id,@"info_id":self.info_id};
//             [user setObject:coffeDict forKey:@"coffeDict"];
            [foodArray addObject:lunerDict];
            [self riliThreeCarandFoodWithHotel:@"luner" withStareTime:self.time];
        
        
        
        }
        
    if ([self.stypeDefine isEqualToString:@"下午茶"]) {
        
        
        NSDictionary *coffeDict = @{@"stype":@"coffe",@"money":self.price,@"image":self.logoImage,@"title":self.vtitle,@"subTitle":self.adv,@"style":self.stypeDefine,@"qucheTime":self.time,@"address":self.address,@"info_id":self.info_id};
        [foodArray addObject:coffeDict];

        [self riliThreeCarandFoodWithHotel:@"coffe" withStareTime:self.time];
        
        
        
        }
        
    if ([self.stypeDefine isEqualToString:@"晚餐"]) {
        
        
        NSDictionary *dinnerDict = @{@"stype":@"dinner",@"money":self.price,@"image":self.logoImage,@"title":self.vtitle,@"subTitle":self.adv,@"style":self.stypeDefine,@"qucheTime":self.time,@"address":self.address,@"info_id":self.info_id};
        [foodArray addObject:dinnerDict];
        [self riliThreeCarandFoodWithHotel:@"dinner" withStareTime:self.time];
    }

}


-(void)createNav{
    
    self.naviView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH,NAV_BAR_HEIGHT)];
    
    self.naviView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.naviView];
    
    self.leftBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [self.naviView addSubview:self.leftBtu];
    
    
    [self.leftBtu mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.naviView.mas_left).with.offset(15);
        
        make.top.equalTo(self.naviView.mas_top).with.offset(kStatusBarHeight);
        
        make.height.mas_equalTo(44);
        
        //      make.width.mas_equalTo(22);
        
        make.centerY.equalTo(self.naviView.mas_centerY).with.offset(kStatusBarHeight/2);
        
        

    }];
    
    
    
    
    [self.leftBtu addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.menuView = [[UILabel alloc]init];
    
    //    self.menuView.backgroundColor = [UIColor yellowColor];
    
    [self.naviView addSubview:self.menuView];
    
    [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.top.equalTo(self.naviView.mas_top).with.offset(kStatusBarHeight);
        
        make.height.mas_equalTo(44);
        
        make.centerX.equalTo(self.naviView.mas_centerX);
        make.centerY.equalTo(self.naviView.mas_centerY).with.offset(kStatusBarHeight/2);
        
        

        
    }];
    
    [self.leftBtu setImage:[UIImage imageNamed:@"back_arrow@2x"] forState:UIControlStateNormal];
    
    self.menuView.text = @"定制行程";

    
    
}
-(void)creatTable{
    
    _htable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-49) style:UITableViewStylePlain];
    _htable.delegate =self;
    _htable.dataSource =self;
    [self.view addSubview:_htable];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = nil;
    cellID = [NSString stringWithFormat:@"cellID%ld",(long)indexPath.section];
   
    switch (indexPath.section) {
        case 0:
        {
            
            HSXiangqingCell*   xqcell = [[HSXiangqingCell alloc] initWithStyle:UITableViewCellStyleDefault WithArray:self.imageArr reuseIdentifier:cellID];
            xqcell.imageScrollView.delegate = self;
            xqcell.selectionStyle =UITableViewCellSelectionStyleNone;
            return xqcell;
        }
            break;
        case 1:{
             HSXQTwoCell *xqcell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!xqcell) {
                
                xqcell = [[HSXQTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
               
            }
            
            xqcell.selectionStyle =UITableViewCellSelectionStyleNone;

            xqcell.mealName.text = self.vtitle;
            
            xqcell.detailName.text = self.adv;
            
            
//            xqcell.money.text = [NSString stringWithFormat:@"¥ %@",[self addSpaceFromSring:self.price]];
//            
//            xqcell.money.textColor = [NSString colorWithHexString:@"#e4c675"];
            
            if ([self.caipu isEqualToString:@"car"]) {
                NSRange range={self.defined.length-5,3};
                NSString *newStr3=[self.defined substringWithRange:range];
                xqcell.styleName.text = [self.defined stringByReplacingOccurrencesOfString:newStr3 withString:@"xxx"];
            }else{
                
                xqcell.styleName.text = self.defined;
            }
            
            [xqcell.serviceBtu addTarget:self action:@selector(serviceBtu:) forControlEvents:UIControlEventTouchUpInside];
            
            return xqcell;
        }
        case 2:{
            
            HSXQRiqiCell *riqiCell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!riqiCell) {
                riqiCell = [[HSXQRiqiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            //HSXQRiqiCell *riqiCell = (HSXQRiqiCell *)cell;
             riqiCell.selectionStyle =UITableViewCellSelectionStyleNone;
            [riqiCell.xuanzeBtn addTarget:self action:@selector(xuanzeBtn:) forControlEvents:UIControlEventTouchUpInside];
            riqiCell.xuanzeBtn.tag = 900;

            if (self.selectTime) {
                
               [riqiCell.xuanzeBtn setTitle:self.selectTime forState:UIControlStateNormal];
               self.time = self.selectTime;
            }else{
                
        
              if ([self.caipu isEqualToString:@"caipu"]) {
                  riqiCell.riqilbl.text = @"用餐时间";
                 [riqiCell.xuanzeBtn setTitle:@"请选择用餐时间" forState:UIControlStateNormal];
                  
             }else if ([self.caipu isEqualToString:@"car"]){
                
                 riqiCell.riqilbl.text = @"取车时间";
                 [riqiCell.xuanzeBtn setTitle:@"请选择取车时间" forState:UIControlStateNormal];
                
             }else if ([self.caipu isEqualToString:@"hotel"]){
                
                 riqiCell.riqilbl.text = @"入住时间";
                 [riqiCell.xuanzeBtn setTitle:@"请选择入住时间" forState:UIControlStateNormal];
                
             }
            }
            riqiCell.selectionStyle =UITableViewCellSelectionStyleNone;
            
            return riqiCell;
        }
        case 3:{
          
             if ([self.caipu isEqualToString:@"caipu"]) {
                    
                 HSXQCaipuCell *myCell = [[HSXQCaipuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID WithArray:self.chuanzhiDataArray withCaipu:@"caipu" withArrayCount:(int)self.dataArray.count];
                    myCell.delegate = self;
                    myCell.myBt.tag = 800;
                    myCell.backgroundColor = [UIColor whiteColor];
                 
                 myCell.selectionStyle =UITableViewCellSelectionStyleNone;
            
                 if (self.dataArray.count < 6) {
                     
                     
                     
                 }else{
                    if (_isMore) {
                     
                        [myCell.myBt setTitle:@"收回" forState:UIControlStateNormal];
                   }else{
                         [myCell.myBt setTitle:@"查看更多" forState:UIControlStateNormal];
                     }
                 }
                  return myCell;
             }else{
                    
                 HSXQCaipuCell *   myCell = [[HSXQCaipuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID WithArray:self.dataArray withCaipu:@"" withArrayCount:0];
                  myCell.delegate = self;
                
                  myCell.backgroundColor = [UIColor whiteColor];
                  myCell.selectionStyle =UITableViewCellSelectionStyleNone;
                 

                 return myCell;
                }
        }
        case 4:{
         
            if ([self.caipu isEqualToString:@"caipu"]) {
                
                self.mapCell.biaotiLbl.text = @"用餐地点";
            }else if ([self.caipu isEqualToString:@"car"]){
                self.mapCell.biaotiLbl.text = @"取车地点";
                
            }else if ([self.caipu isEqualToString:@"hotel"]){
                
                self.mapCell.biaotiLbl.text = @"入住地点";
            }
        
           NSArray *coor =  [self.coordinate componentsSeparatedByString:@","];
            MAPointAnnotation *a1 = [[MAPointAnnotation alloc] init];
            a1.coordinate = CLLocationCoordinate2DMake([coor[0] floatValue], [coor[1] floatValue]);
            [self.mapCell.mapView addAnnotation:a1];
            
            NSMutableArray *arr = [NSMutableArray array];
            
            [arr addObject:a1];
            
            [self.mapCell.mapView showAnnotations:arr edgePadding:UIEdgeInsetsMake(5,5,5, 5) animated:YES];
            
            self.mapCell.mapView.showsCompass= NO;
            self.mapCell.mapView.showsScale= NO;
            self.mapCell.addressLable.text = [NSString stringWithFormat:@"  %@",self.address];
            self.mapCell.selectionStyle =UITableViewCellSelectionStyleNone;
            return self.mapCell;
            
        }
            
        default:
            return nil;
            break;
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    
    view.backgroundColor = [NSString colorWithHexString:@"#eeeeee"];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        
        return 0;
    }
    
    return 12;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 480/2;
            break;
        case 1:{
            
            CGSize labelSize  = {0,0};
            labelSize = [self.adv boundingRectWithSize:CGSizeMake(WIDTH/3.0*2+25, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
            
            if (labelSize.height > 20) {
                
                return 100;
            }
            return 180/2;
        }
        case 2:{
            return 45;
        }
        case 3:{
            if ([self.caipu isEqualToString:@"caipu"]) {
                
                if (self.dataArray.count < 6) {
                    
                    return self.chuanzhiDataArray.count*40+32;
                    
                }else{
                    return ((self.chuanzhiDataArray.count + 1) * 40)+32;
                }
            }
            
            return  0;
        }
        case 4:{
            return 298;
        }
        default:
            return 0;
            break;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //NSLog(@"%ld",(long)indexPath.section);
    NSUserDefaults *user  = [NSUserDefaults standardUserDefaults];
    
    if (indexPath.section == 2) {
        
        UIButton *btu = [self.view viewWithTag:900];
        WJFCalendarHomeVC  *vc = [[WJFCalendarHomeVC alloc]init];
        NSLog(@"%@",self.defined);
        [user setObject:self.defined forKey:@"rilidefined"];
        [vc setPlaneToDay:365 ToDateforString:nil];//
        
        vc.block = ^(NSString *str ){
            
            [btu setTitle:str forState:UIControlStateNormal];
            
            self.time = str;
            
        };
        [self.navigationController pushViewController:vc animated:YES];

        
    }else if (indexPath.section == 4){
        
        WJFDetailDiTuVC *vc = [[WJFDetailDiTuVC alloc]init];
        vc.address = self.address;
        vc.coordinate = self.coordinate;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}



- (void)moreBtDelegate
{
    
    self.chuanzhiDataArray = [NSMutableArray array];
    if (_isMore) {
        
        for (int i = 0 ; i<5; i++) {
           [self.chuanzhiDataArray addObject:self.dataArray[i]];
        }
        //[btu setTitle:@"收回" forState:UIControlStateNormal];
        _isMore = 0;
    }else
    {
        [self.chuanzhiDataArray addObjectsFromArray:self.dataArray];
        //[btu setTitle:@"加载更多" forState:UIControlStateNormal];
        _isMore = 1;
    }
    
    //一个section刷新
     NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:3];
    [_htable reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)backClick:(UIButton *)btu{
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 选择日期
-(void)xuanzeBtn:(UIButton *)btu{
    
    NSLog(@"选择日期");
    
    WJFCalendarHomeVC  *vc = [[WJFCalendarHomeVC alloc]init];
    
    [vc setPlaneToDay:365 ToDateforString:nil];//
    
    vc.block = ^(NSString *str ){
        
        [btu setTitle:str forState:UIControlStateNormal];
        
        self.time = str;
        
    };
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
    FirstViewController *firstVC = [[FirstViewController alloc] init];
    firstVC.selecteIndex = (int)index;
    firstVC.firstArray = self.imageArr;
    [self presentViewController:firstVC animated:YES completion:^{
        
        
        
   }];

}



#pragma mark 数据请求
-(void)getDetailedData{
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSMutableString *userid = [user objectForKey:@"id"];
    NSMutableString *token  = [user objectForKey:@"token"];
    // 2==faa0688d0c2d8f8c224fed0ecd95ab29
    
    NSDictionary *dict ;
    NSDictionary *signDict;
   
    NSString *url ;
    //NSLog(@"%@",userid);
    if (!userid) {
        
        //NSLog(@"11111");
        int a = arc4random() % 99999;
        NSString *str = [NSString stringWithFormat:@"%05d", a];
        token =  (NSMutableString *)[self md5:str];
        userid = (NSMutableString *)@"10000";
        dict = @{@"route":@"Item_showItemInfo",@"version":@"1",@"info_id":self.info_id};
        NSString *str1 =  [self createMd5Sign:(NSMutableDictionary *)dict];
        
        NSString  *str2 = [self md5:@"miaotaoKJ"];
        
        
        NSString *sign = [self md5:[NSString stringWithFormat:@"%@%@",str1,str2]];
        //url =[NSString stringWithFormat:@"%@/api/item/showItemInfo?info_id=%@&sign=%@",ROOTURL,self.info_id,sign];
        NSMutableDictionary *siDit = [NSMutableDictionary dictionaryWithDictionary:dict];
        
        [siDit setObject:sign forKey:@"sign"];
        
        signDict = siDit;
        
    }else{
        dict = @{@"route":@"Item_showItemInfo",@"version":@"1",@"id":userid,@"info_id":self.info_id,@"token":token};
        NSString *str1 =  [self createMd5Sign:(NSMutableDictionary *)dict];
        
        NSString  *str2 = [self md5:@"miaotaoKJ"];
        
        
        NSString *sign = [self md5:[NSString stringWithFormat:@"%@%@",str1,str2]];
        
        
        NSMutableDictionary *siDit = [NSMutableDictionary dictionaryWithDictionary:dict];
        
        [siDit setObject:sign forKey:@"sign"];
        
        signDict = siDit;
        
        url = [NSString stringWithFormat:@"%@/api/item/showItemInfo?id=%@&info_id=%@&token=%@&sign=%@",ROOTURL,userid,self.info_id,token,sign];
    }

    
    self.imageArr = [NSMutableArray array];
    
    self.dataArray = [NSMutableArray array];
    
   
    NSLog(@"%@",url);
    [WJFCollection getWithURLString:@"http://www.rempeach.com/rebirth/api/AppApi/receive" parameters:signDict success:^(id responseObject) {
        //NSLog(@"?????%@====%@",responseObject[@"tip"],responseObject);
        
        if ([responseObject[@"state"] isEqualToString:@"200"]) {
            
            self.price = responseObject[@"data"][@"price"];
            
            self.vtitle = responseObject[@"data"][@"title"];
            
            self.adv   = responseObject[@"data"][@"adv"];
            
            self.defined = responseObject[@"data"][@"defined"];
            
            self.coordinate = responseObject[@"data"][@"coordinate"];
            
            self.address = responseObject[@"data"][@"address"];
            
            self.item_id = responseObject[@"data"][@"item_id"];
            
            self.type = responseObject[@"data"][@"type"];//大类行
            
            self.image_URL = responseObject[@"data"][@"head_img"];
            
            self.logoImage = responseObject[@"data"][@"logo"];
            
            self.gradelevel =responseObject[@"data"][@"price_level"];

            [user setObject:responseObject[@"data"][@"info_id"] forKey:@"info_id"];
            
            [user setObject:responseObject[@"data"][@"item_id"] forKey:@"item_id"];
            

            
            if ([self.type isEqualToString:@"1"]) {
                //车
                self.caipu = @"car";
                
                self.stypeDefine = @"car";
                
            }else if ([self.type isEqualToString:@"5"]){
                //下午茶
                self.caipu = @"caipu";
                self.stypeDefine = @"下午茶";
                
            }else if ([self.type isEqualToString:@"6"]){
                //午餐
                self.caipu = @"caipu";
                self.stypeDefine = @"午餐";
                
            }else if ([self.type isEqualToString:@"7"]){
                //晚餐
                self.caipu = @"caipu";
                self.stypeDefine = @"晚餐";
                
            }else if ([self.type isEqualToString:@"9"]){
                //住
                self.caipu = @"hotel";
                self.stypeDefine = @"hotel";
                
            }
            
            if ([self.caipu isEqualToString:@"caipu"]) {
                
                //self.caimenu =  responseObject[@"data"][@"menu"];
                 //转换数据格式
                self.dataArray = [self arrayWithJsonString:responseObject[@"data"][@"menu"]];
                
               //NSLog(@"%@",self.dataArray);
              self.chuanzhiDataArray = [NSMutableArray array];
              if (self.dataArray.count < 6 ) {
                    
                    for (int i = 0; i < self.dataArray.count; i++) {
                        
                         [self.chuanzhiDataArray addObject:self.dataArray[i]];
                       }
                    
                    
            }else{
               
                 for (int i = 0 ; i<5; i++){
                   [self.chuanzhiDataArray addObject:self.dataArray[i]];
                 }
              }
            }
          
            for (NSDictionary *dict in responseObject[@"data"][@"banner_list"]) {
                
                [self.imageArr addObject:dict[@"bannerImage"]];
                
            }
            [_htable reloadData];
            
            
        }else if([responseObject[@"state"] isEqualToString:@"100"]){
            
            
            
        }else if([responseObject[@"state"] isEqualToString:@"111"]){
            
            
            
        }else if([responseObject[@"state"] isEqualToString:@"101"]){
            
            
            
        }else if([responseObject[@"state"] isEqualToString:@"121"]){
            
            [USER_DEFAULT removeObjectForKey:@"id"];
            
            [USER_DEFAULT removeObjectForKey:@"token"];
            
            [USER_DEFAULT removeObjectForKey:@"phone"];
            
            HSLoginViewController *vc = [[HSLoginViewController alloc]init];
            vc.source = @"ItineraryVC";
            [self.navigationController pushViewController:vc animated:YES];
        }
    }failure:^(NSError *error) {
        
        
    }];
}



#pragma mark wufu
-(void)serviceBtu:(UIButton *)btu{
    
    self.ser = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.ser setTitle:@"确定" forState:UIControlStateNormal];
    
    [self.ser setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.ser addTarget:self action:@selector(wancheng:) forControlEvents:UIControlEventTouchUpInside];
    
     self.ser.backgroundColor = [NSString colorWithHexString:@"#27292b"];
    
    [self.view addSubview: self.ser];
    
    [ self.ser mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).with.offset(0);
        
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        
        make.height.mas_equalTo(49);
    }];
    
    
    self.service = [[ServiceView alloc]init];
    
    [self.view addSubview:self.service];
    
    self.service.backgroundColor = [UIColor whiteColor];
    
    
    if ([self.caipu isEqualToString:@"car"]) {
        
        self.service.oneServiceView.tubiaoLabel.text = @"车辆限行";
        
        self.service.oneServiceView.tubiaoImage.image = [UIImage imageNamed:@"xian_icon@2x"];
        
        NSString *timeStr;

   
       if ([self.defined  hasSuffix:@"2"]||[self.defined  hasSuffix:@"8"]) {
        
          timeStr = @"周二";
        
        }else if ([self.defined  hasSuffix:@"3"]||[self.defined  hasSuffix:@"7"]){
        
           timeStr = @"周三";
        
        }else if ([self.defined  hasSuffix:@"4"]||[self.defined  hasSuffix:@"6"]){
        
            timeStr = @"周四";
        }else if ([self.defined  hasSuffix:@"5"]||[self.defined  hasSuffix:@"0"]){
        
            timeStr = @"周五";
        
        }else if ([self.defined  hasSuffix:@"1"]||[self.defined  hasSuffix:@"9"]){
        
             timeStr = @"周一";
         }
        
        self.service.oneServiceView.tubiaoSubLabel.text = [NSString stringWithFormat:@"限行时间是%@7:00-9:00,晚上16:30-18:30,限行区域杭州市区",timeStr];
        
        self.service.twoServiceView.tubiaoLabel.text = @"平台保障费";
        
        self.service.twoServiceView.tubiaoSubLabel.text = @"享有7*24小时道路救援;车辆专门客服(此项服务平台提供)";
        self.service.twoServiceView.tubiaoImage.image = [UIImage imageNamed:@"bao_icon@2x"];
        
        
        self.service.threeServiceView.tubiaoLabel.text = @"不计免赔费";
        
        self.service.threeServiceView.tubiaoSubLabel.text = @"出险后租客无需承担保险责任范围内的任何费用(保险除外责任及绝对免赔部分仍需租客承担)";
        
        self.service.threeServiceView.tubiaoImage.image = [UIImage imageNamed:@"mian_icon@2x"];
        
        [self.service mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.view.mas_left).with.offset(0);
            
            make.right.equalTo(self.view.mas_right).with.offset(0);
            
            make.bottom.equalTo( self.ser.mas_top).with.offset(0);
            
            make.height.mas_equalTo(300);
            //make.centerY.equalTo(self.view.mas_centerY);
        }];


        
    }else if ([self.caipu isEqualToString:@"caipu"]){
        
        self.service.oneServiceView.tubiaoLabel.text = @"就餐须知";
        
        self.service.oneServiceView.tubiaoImage.image = [UIImage imageNamed:@"xuzhi_icon@2x"];

        self.service.oneServiceView.tubiaoSubLabel.text = [NSString stringWithFormat:@"抵达餐厅时间请勿晚于预定时间后一个小时，否则餐厅可取消本单，并不退还任何费用。"];
        
        self.service.twoServiceView.tubiaoLabel.text = @"平台保障";
        
        self.service.twoServiceView.tubiaoSubLabel.text = @"就餐期间，因餐厅原因为您带来不便，若协商无果，请联系客服平台（0571-88888888），平台将介入处理。";
        self.service.twoServiceView.tubiaoImage.image = [UIImage imageNamed:@"bao_icon@2x"];
        
        
        self.service.threeServiceView.tubiaoLabel.text = @"温馨提示";
        
        self.service.threeServiceView.tubiaoSubLabel.text = @"本次就餐以套餐形式进行，如需添加其他菜品，请与餐厅联系，费用自理。";
        
        self.service.threeServiceView.tubiaoImage.image = [UIImage imageNamed:@"wenxin_icon@2x"];
        
        [self.service mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.view.mas_left).with.offset(0);
            
            make.right.equalTo(self.view.mas_right).with.offset(0);
            
            make.bottom.equalTo( self.ser.mas_top).with.offset(0);
            
            make.height.mas_equalTo(305);
            //make.centerY.equalTo(self.view.mas_centerY);
        }];

        
    }else if ([self.caipu isEqualToString:@"hotel"]){
        
        self.service.oneServiceView.tubiaoLabel.text = @"入住须知";
        
        self.service.oneServiceView.tubiaoImage.image = [UIImage imageNamed:@"xuzhi_icon@2x"];
        
        self.service.oneServiceView.tubiaoSubLabel.text = [NSString stringWithFormat:@"请遵循酒店规章制度。若因违反制度造成损失，平台对此概不负责。"];
        
        self.service.twoServiceView.tubiaoLabel.text = @"平台保障";
        
        self.service.twoServiceView.tubiaoSubLabel.text = @"入住期间，因酒店原因为您带来不便，若协商无果，请联系客服平台（0571-88888888），平台将介入处理。";
        self.service.twoServiceView.tubiaoImage.image = [UIImage imageNamed:@"bao_icon@2x"];
        
        
        self.service.threeServiceView.tubiaoLabel.text = @"温馨提示";
        
        self.service.threeServiceView.tubiaoSubLabel.text = @"请于规定时间办理入住，入住时请出示身份证并保管好您的随身物品。入住期间产生的其他费用请自理。";
        
        self.service.threeServiceView.tubiaoImage.image = [UIImage imageNamed:@"wenxin_icon@2x"];
        
        [self.service mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.view.mas_left).with.offset(0);
            
            make.right.equalTo(self.view.mas_right).with.offset(0);
            
            make.bottom.equalTo( self.ser.mas_top).with.offset(0);
            
            make.height.mas_equalTo(305);
            //make.centerY.equalTo(self.view.mas_centerY);
        }];
    }
    
}

-(void)wancheng:(UIButton *)btu{
    
    
    [self.ser removeFromSuperview];
    
    self.ser = nil;
    
    
    [self.service removeFromSuperview];
    
    
    self.service = nil;
    
    
    
    
}


-(NSString*) createMd5Sign:(NSMutableDictionary*)dict
{
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        
        [contentString appendFormat:@"%@%@", categoryId, [dict objectForKey:categoryId]];
        
    }
    return contentString;
}


//md5加密
-(NSString *) md5:(NSString *)str
{
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}





-(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    
    NSComparisonResult result = [oneDay compare:anotherDay];
    
    if (result == NSOrderedDescending) {
        //NSLog(@"oneDay比 anotherDay时间晚");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"oneDay比 anotherDay时间早");
        return -1;
    }
    //NSLog(@"两者时间是同一个时间");
    return 0;
    
}





#pragma mark ditu
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
        {
            static NSString *reuseIndetifier = @"annotationReuseIndetifier";
            MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
            if (annotationView == nil)
            {
                annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                              reuseIdentifier:reuseIndetifier];
            }
            annotationView.image = [UIImage imageNamed:@"map_address"];
            //设置中心点偏移，使得标注底部中间点成为经纬度对应点
            annotationView.centerOffset = CGPointMake(0, -18);
            return annotationView;
        }
        return nil;
    
}

- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"accessory view :%@", view);
}

- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view didChangeDragState:(MAAnnotationViewDragState)newState fromOldState:(MAAnnotationViewDragState)oldState
{
    NSLog(@"old :%ld - new :%ld", (long)oldState, (long)newState);
}

- (void)mapView:(MAMapView *)mapView didAnnotationViewCalloutTapped:(MAAnnotationView *)view
{
    NSLog(@"callout view :%@", view);
}




#pragma mark 插入字符串
-(NSMutableString *)addSpaceFromSring:(NSString *)str{
    
    
    // string = [string substringToIndex:7];//去掉下标7之后的字符串
    
    NSString *qianstring;
    NSString *huostring;
    
    if (str.length > 2) {
        
        qianstring = [str substringToIndex:str.length-2];//去掉下标7之后的字符串
        
       // NSLog(@"截取的值为：%@",qianstring);
        
        huostring = [str substringFromIndex:str.length-2];//去掉下标2之前的字符串
        
        //NSLog(@"截取的值为：%@",huostring);
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


- (NSMutableArray *)arrayWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSMutableArray *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}


#pragma mark 三大类进入日历的顺序
-(void)riliThreeCarandFoodWithHotel:(NSString *)souereType withStareTime:(NSString *)startTime{
 
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *dict = @{@"souereType":souereType,@"startTime":startTime};
    
    if ([user objectForKey:@"Rili"]) {
        
        NSMutableArray *rili = [NSMutableArray arrayWithArray:[user objectForKey:@"Rili"]];
        NSMutableArray *riliagin = [NSMutableArray arrayWithArray:[user objectForKey:@"Rili"]];
        for (NSDictionary *befordict in rili) {
            
            if ([befordict[@"souereType"] isEqualToString:dict[@"souereType"]]) {
                [riliagin removeObject:befordict];
            }
            
        }
        
        [riliagin addObject:dict];
        
        NSArray *array2 = [riliagin sortedArrayUsingComparator:
                           ^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
                               NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                               [formatter setDateFormat:@"yyyy/MM/dd hh:mm"];

                               NSDate *date1 = [formatter dateFromString:obj1[@"startTime"]];
                               NSDate *date2 = [formatter dateFromString:obj2[@"startTime"]];
                               NSComparisonResult result = [date1 compare:date2];
                               return result;
                            
                           }];
        
        [user setObject:array2 forKey:@"Rili"];
        
    }else{
        
        NSArray *rili = @[dict];
        [user setObject:rili forKey:@"Rili"];
        
    }
    
}










#pragma mark 最早时间保存
-(void)startTime{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if ([user objectForKey:@"startTime"]) {
        
#pragma Mark 以前的最早时间
        NSArray *timeOneArr = [[user objectForKey:@"startTime"] componentsSeparatedByString:@" "];
        NSString *timeOneStr = [NSMutableString stringWithFormat:@"%@",timeOneArr[0]];
#pragma mark 当前选中时间
        NSArray  *timeTwoArr = [self.time componentsSeparatedByString:@" "];
        NSString *timeTwoStr = [NSMutableString stringWithFormat:@"%@",timeTwoArr[0]];
        
        NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
        //[inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        [inputFormatter setDateFormat:@"yyyy/MM/dd"];
        
        NSDate *timeOneDate = [inputFormatter dateFromString:timeOneStr];
        
        NSDate *timeTwoDate = [inputFormatter dateFromString:timeTwoStr];
        
        int startbool =  [self compareOneDay:timeOneDate withAnotherDay:timeTwoDate];
        if(startbool == 1){
            
            [user setObject:self.time forKey:@"startTime"];
            
        }else if (startbool == -1){
            
            
            
            
        }else{
            
            
        }
        
        
    }else{
        
        [user setObject:self.time forKey:@"startTime"];
        
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
