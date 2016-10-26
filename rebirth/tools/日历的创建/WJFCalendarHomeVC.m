//
//  WJFCalendarHomeVC.m
//  一些常用的知识点
//
//  Created by boom on 16/7/14.
//  Copyright © 2016年 boom. All rights reserved.
//

#import "WJFCalendarHomeVC.h"

@interface WJFCalendarHomeVC ()

{
    int daynumber;//天数
    int optiondaynumber;//选择日期数量
    //    NSMutableArray *optiondayarray;//存放选择好的日期对象数组
    
}

@property(nonatomic,strong)UIButton  *leftBtu;


@property(nonatomic,strong)UIButton  *rightBtu;


@property(nonatomic,strong)UILabel  *menuView;

@property(nonatomic,strong)UIView  *naviView;


@end



@implementation WJFCalendarHomeVC
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    
    [self createNavi];
    
    [self createSureBtu];
    // Do any additional setup after loading the view.
}



-(void)createNavi{
    
    
    self.naviView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH,NAV_BAR_HEIGHT)];
    
    self.naviView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.naviView];
    
    self.leftBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    //    self.leftBtu.backgroundColor = [UIColor redColor];
    
    
    [self.naviView addSubview:self.leftBtu];
    
    
    [self.leftBtu mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.naviView.mas_left).with.offset(15);
        
        make.top.equalTo(self.naviView.mas_top).with.offset(kStatusBarHeight);
        
        make.height.mas_equalTo(44);
        
        //make.width.mas_equalTo(22);
        
        
    }];
    
    
    
    
    [self.leftBtu addTarget:self action:@selector(rilibackClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.menuView = [[UILabel alloc]init];
    
    //self.menuView.backgroundColor = [UIColor yellowColor];
    
    [self.naviView addSubview:self.menuView];
    
    [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.top.equalTo(self.naviView.mas_top).with.offset(kStatusBarHeight);
        
        make.height.mas_equalTo(44);
        
        make.centerX.equalTo(self.naviView.mas_centerX);
        
        
    }];
    
    self.view.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    
    [self.leftBtu setTitle:@"返回"  forState:UIControlStateNormal];
    
    [self.leftBtu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    //    self.leftBtu.titleLabel.font = [UIFont systemFontOfSize:10];
    
    self.menuView.text = @"请选择时间";
    
    
  
    
    
    
}



-(void)rilibackClick:(UIButton *)btu{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setPlaneToDay:(int)day ToDateforString:(NSString *)todate
{
    daynumber = day;
    optiondaynumber = 1;//选择一个后返回数据对象
    super.calendarMonth = [self getMonthArrayOfDayNumber:daynumber ToDateforString:todate];
    [super.collectionView reloadData];//刷新
}

#pragma mark - 逻辑代码初始化

//获取时间段内的天数数组
- (NSMutableArray *)getMonthArrayOfDayNumber:(int)day ToDateforString:(NSString *)todate
{
    
    NSDate *date = [NSDate date];
    
    NSDate *selectdate  = [NSDate date];
    
    if (todate) {
        
        selectdate = [selectdate dateFromString:todate];
        
    }
    
    super.Logic = [[CalendarLogic alloc]init];
    
    return [super.Logic reloadCalendarView:date selectDate:selectdate  needDays:day];
    
}


#pragma mark - 设置标题

- (void)setCalendartitle:(NSString *)calendartitle
{
    
    [self.navigationItem setTitle:calendartitle];
    
}


#pragma mark 底下的确定按钮
-(void)createSureBtu{
    
    UIButton *sure = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [sure setTitle:@"确定" forState:UIControlStateNormal];
    
    [sure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    sure.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:sure];
    
    [sure mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).with.offset(0);
        
        make.right.equalTo(self.view).with.offset(0);
        
        make.bottom.equalTo(self.view).with.offset(0);
        
        make.height.mas_equalTo(49);
        
        
        
    }];
    
    [sure addTarget:self action:@selector(bottomSureBtu:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

-(void)bottomSureBtu:(UIButton *)btu{
    
    
    if (self.totalstr == nil) {
        
       [LCProgressHUD showStatus:LCProgressHUDStatusInfo text:@"请您选择预约时间"];
        
        
       // NSLog(@"2222222");
    }else{
        
       
        
         self.block(self.timeLable.text);
        [self.navigationController popViewControllerAnimated:YES];
        //NSLog(@"3333333333");
        
    }
    
    
}

@end
