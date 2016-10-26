//
//  DingZhiVC.m
//  rebirth
//
//  Created by boom on 16/7/19.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "DingZhiVC.h"

#import "MBDatePicker.h"
#import "DingzhiTableView.h"
#import "FoodTotalView.h"

#import "RestaurantVC.h"
#import "WJFCalendarHomeVC.h"
#import "DingZhiCell.h"

#import "OrderVC.h"

#import "GoodsOneModel.h"

#import "WJFHotelVC.h"


static int selectNumber = 1;

static int pageCarNumber = 1;

static int pageFoodNumber = 1;

static int pageHotelNumber = 1;

@interface DingZhiVC ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)UIView  *startView;

@property(nonatomic,strong)UIView *pickTotalView;


@property(nonatomic,strong)UIPickerView *pickView;

@property(nonatomic,strong)UIButton  *sureBtu;

@property(nonatomic,strong)NSMutableString  *dateString;

@property(nonatomic,strong)UILabel  *timeLabel;
@property(nonatomic,strong)UILabel  *picktimeLabel;


@property(nonatomic,strong)UIButton  *sureDingZhiBtu;

@property(nonatomic,strong)NSMutableArray  *cheDataArr;

@property(nonatomic,strong)NSMutableArray  *foodDataArr;

@property(nonatomic,strong)NSMutableArray  *hotelDataArr;

@property(nonatomic,strong)LXSegmentScrollView *scView;


@property(nonatomic,strong)NSMutableArray *food;

@property(nonatomic,strong)NSMutableArray *foodDetail;

@property (nonatomic, assign) CGFloat offsetY;
@end

@implementation DingZhiVC

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    // [self createStateView];
    
     [self createSegView];
    
     [self createsureDingZhiBtu];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    if ( [[user objectForKey:@"Rili"] count]) {
        
        NSArray *timeArr = [[user objectForKey:@"Rili"][0][@"startTime"] componentsSeparatedByString:@" "];
        
        _dateString  = [NSMutableString stringWithFormat:@"%@",timeArr[0]];
        
        [self okSureBtu];
        
    }
    
}


-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    
}

//重写父类左侧按钮返回的方法
-(void)backClick:(UIButton *)btu{
    
    //NSLog(@"111111111111111111111111111");
    if ([self.hStype isEqualToString:@"food"] || [self.hStype isEqualToString:@"car"] ||[self.hStype isEqualToString:@"hotel"]) {
        
        NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
        for (UIViewController *vc in marr) {
            if ([vc isKindOfClass:[HSVegetableViewController class]]) {
                [marr removeObject:vc];
                break;
            }
        }
         self.navigationController.viewControllers = marr;
        
         [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
         [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}


-(void)viewDidLoad{
    
    [super viewDidLoad];

    self.view.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    
    [self.leftBtu setImage:[UIImage imageNamed:@"back_arrow@2x"] forState:UIControlStateNormal];
    
    self.menuView.text = @"定制行程";
    
//    id  String        必选   5  用户ID
//    page string       必选   1  页数
//    category string   必选   3    1：车类；3：饭店类；8酒店类
//    begin_time string 必传   2016-07-22 11:12:12  筛选开始时间（缺省状态：default）
//    token   string    必传   820625d7c926d989da57d4f07ae27e8a  验证会话合法性
//    sign  string      必传   b22732211e51090f62ee944541d9abba   签名
  
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSMutableString *userid = [user objectForKey:@"id"];
    NSMutableString *token  = [user objectForKey:@"token"];
    // 2==faa0688d0c2d8f8c224fed0ecd95ab29
    //NSLog(@"%@",userid);
    if (!userid) {
        
        //NSLog(@"11111");
        int a = arc4random() % 99999;
        NSString *str = [NSString stringWithFormat:@"%05d", a];
        token =  (NSMutableString *)[self md5:str];
        userid = (NSMutableString *)@"10000";
        
    }else{
        
        
    }

    _cheDataArr = [NSMutableArray array];
    [self  getTotalDataCategory:@"1" nameID:userid pageNumber:@"1" tokenStr:token begin_time:@"default" backDataArr:_cheDataArr];

    _foodDataArr = [NSMutableArray array];
    
     [self  getTotalDataCategory:@"2" nameID:userid pageNumber:@"1" tokenStr:token begin_time:@"default" backDataArr:_foodDataArr];
    
    _hotelDataArr = [NSMutableArray array];
    
     [self  getTotalDataCategory:@"3" nameID:userid pageNumber:@"1" tokenStr:token begin_time:@"default" backDataArr:_hotelDataArr];

    
}

#pragma mark 完成事件按钮

-(void)createsureDingZhiBtu{
    
    
    self.sureDingZhiBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //self.sureDingZhiBtu.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.sureDingZhiBtu];
    
    self.sureDingZhiBtu.layer.cornerRadius = 3;
    
    [self.sureDingZhiBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.sureDingZhiBtu setBackgroundColor:[NSString colorWithHexString:@"#27292b"]];
    self.sureDingZhiBtu.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.sureDingZhiBtu setTitle:@"完成定制" forState:UIControlStateNormal];
    
    self.sureDingZhiBtu.layer.shadowOffset = CGSizeMake(-1, 1);
    self.sureDingZhiBtu.layer.shadowOpacity = 0.8;
    self.sureDingZhiBtu.layer.shadowColor = [UIColor blackColor].CGColor;
    
    [self.sureDingZhiBtu mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-20);
        
        make.left.equalTo(self.view.mas_left).with.offset(56/2);
        
        make.right.equalTo(self.view.mas_right).with.offset(-56/2);
        
        make.height.mas_equalTo(40);
        
    }];
    
    
    [self.sureDingZhiBtu addTarget:self action:@selector(sureDingZhiBtu:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    [self.view bringSubviewToFront:self.sureDingZhiBtu];
}

-(void)sureDingZhiBtu:(UIButton *)btu{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    if ([[user objectForKey:@"car"] isEqualToString:@"car"] &&(self.food.count >0 ||[[user objectForKey:@"hotel"] isEqualToString:@"hotel"] )) {
        
       // NSLog(@"定制");
        
        OrderVC *vc = [[OrderVC alloc]init];
        vc.grade = self.grade;
        [self.navigationController pushViewController:vc animated:YES];
       
    }else{
        
       // NSLog(@"bu定制");
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"您的定制不满足要求(定制需要2件以上的商品,并且车是必选)" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
          
             }];
        
        [alert addAction:ok];//添加按钮
        //以modal的形式
        [self presentViewController:alert animated:YES completion:^{ }];
        
    }
    
}


-(void)createStateView{
    
    self.startView = [[UIView alloc]initWithFrame:CGRectMake(8, NAV_BAR_HEIGHT+8, WIDTH-16, 58)];
    
    self.startView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.startView];
    
   
    
    UIView  *startTime = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    // startTime.backgroundColor = [UIColor redColor];
    
    [self.startView addSubview:startTime];
    
  
    
    
    UILabel *startLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    startLabel.font = [UIFont systemFontOfSize:12];
    
    startLabel.text = @"开始时间";
    
    [startTime addSubview:startLabel];
    
    [startLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(startTime.mas_left).with.offset(0);
        
        make.top.equalTo(startTime.mas_top).with.offset(0);
        
        make.bottom.equalTo(startTime.mas_bottom).with.offset(0);
        
        
    }];
    
    
    UIImageView *startImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    [startTime addSubview:startImage];
    
    startImage.image = [UIImage imageNamed:@"sifting_arrow@2x"];
    
    [startImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(startLabel.mas_right).with.offset(2);
        
        make.top.equalTo(startTime.mas_top).with.offset(3);
        
        make.bottom.equalTo(startTime.mas_bottom).with.offset(-3);
        
        //make.width.equalTo(startImage.mas_height);
        
    }];
    
    
    
    
    [startTime mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.startView.mas_centerX);
        
        make.top.equalTo(self.startView.mas_top).with.offset(12);
        
        
        make.width.mas_equalTo(64);
        
    }];

   
    
    self.timeLabel = [[UILabel alloc]init];
    
    [self.startView addSubview:self.timeLabel];
    
    self.timeLabel.text = @"请选择时间";
    
    self.timeLabel.font = [UIFont systemFontOfSize:16];
    
    self.timeLabel.textColor = [NSString colorWithHexString:@"#e4c675"];
    
//    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc]init];
//    [dateFormatter1 setDateFormat:@"yyyy/MM/dd"];
//    NSString *selectDate = [dateFormatter1 stringFromDate:[NSDate date]];
//    self.timeLabel.text = selectDate;
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.centerX.equalTo(self.startView.mas_centerX);
        
        make.top.equalTo(startTime.mas_bottom).with.offset(8);
        

        
    }];
    
    UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    
    [self.startView addGestureRecognizer:tap];

}


-(void)tapClick:(UITapGestureRecognizer *)tap{
    
    if (self.pickTotalView) {
        
        [self.pickTotalView removeFromSuperview];
        
        self.pickTotalView = nil;
    }
    
    [self show];
}


#pragma mark 时间筛选
-(void)okSureBtu{
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSMutableString *userid = [user objectForKey:@"id"];
    NSMutableString *token  = [user objectForKey:@"token"];
    // 2==faa0688d0c2d8f8c224fed0ecd95ab29
    NSLog(@"%@",userid);
    if (!userid) {
        
        //NSLog(@"11111");
        int a = arc4random() % 99999;
        NSString *str = [NSString stringWithFormat:@"%05d", a];
        token =  (NSMutableString *)[self md5:str];
        userid = (NSMutableString *)@"10000";
        
    }else{
        
        
    }
    
    self.timeLabel.text = _dateString;
    
    if ([_dateString isEqualToString:@"请选择时间"]) {
        
        _dateString = (NSMutableString *)@"default";
        
        self.timeLabel.text = @"请选择时间";
        
    }else{
        
       // NSLog(@"%@",_dateString);
        
        _dateString = (NSMutableString *)[_dateString stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
        
        //NSLog(@"%@",_dateString);
        
    }
    [self hide];
    
    _cheDataArr = [NSMutableArray array];
    
    [self  getTotalDataCategory:@"1" nameID:userid pageNumber:@"1" tokenStr:token begin_time:_dateString backDataArr:_cheDataArr];
    
    _foodDataArr = [NSMutableArray array];
    
    [self  getTotalDataCategory:@"2" nameID:userid pageNumber:@"1" tokenStr:token begin_time:_dateString backDataArr:_foodDataArr];
    
    _hotelDataArr = [NSMutableArray array];
    
    [self getTotalDataCategory:@"3" nameID:userid pageNumber:@"1" tokenStr:token begin_time:_dateString backDataArr:_hotelDataArr];
}


-(void)hide{
    
    [UIView animateWithDuration:0.3 delay:0.0 options:0 animations:^{
       
        [self.pickTotalView layoutIfNeeded];
    }completion:^(BOOL finished) {
        [self.pickTotalView removeFromSuperview];
    }];
}

-(void)show{
    
    self.pickTotalView =[[UIView alloc]initWithFrame:CGRectMake(0,131,WIDTH,376/2)];
    
    self.pickTotalView.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    
    [self.view addSubview:self.pickTotalView];
    
    self.pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(8, 0, WIDTH-16, 136)];
    self.pickView.delegate = self;
    self.pickView.dataSource = self;
    
    self.pickView.backgroundColor = [UIColor whiteColor];
    [self.pickTotalView addSubview:self.pickView];
    
    self.sureBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.sureBtu.backgroundColor = [UIColor blackColor];
    
    
    [self.pickTotalView addSubview:self.sureBtu];
    
    [self.sureBtu mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.pickTotalView.mas_left).with.offset(0);
        
        make.right.equalTo(self.pickTotalView.mas_right).with.offset(0);
        
        make.height.mas_equalTo(44);
        
        make.top.equalTo(self.pickView.mas_bottom).with.offset(8);
        
    }];
    
    
    [self.sureBtu setTitle:@"确定" forState:UIControlStateNormal];
    
    [self.sureBtu setTitleColor:[NSString colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    
    self.sureBtu.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [self.sureBtu addTarget:self action:@selector(okSureBtu) forControlEvents:UIControlEventTouchUpInside];
    

}
#pragma mark pickerView的代理方法
static int picknumber = 0;

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return 31;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    
    return 1;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)vie{
    
    self.picktimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateFormat:@"M月d日    EEE"];
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:(row-1) * 24 * 60 * 60];
    NSString *currentDateString = [formatter stringFromDate:date];
    if (row>1){
        self.picktimeLabel.text = currentDateString;
    }else if(row == 1){
        self.picktimeLabel.text = @"今天";
    }else{
        self.picktimeLabel.text = @"请选择时间";
    }
    self.picktimeLabel.textAlignment = NSTextAlignmentCenter;
    
    if (row == picknumber) {
        
           self.picktimeLabel.textColor = [NSString colorWithHexString:@"#e7cc86"];
        
    }else{
        
        
        
    }
    
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc]init];
    [dateFormatter1 setDateFormat:@"yyyy/MM/dd"];
    NSString *selectDate = [dateFormatter1 stringFromDate:date];
    // NSLog(@"选择的日期%@",selectDate);
   
    
    if ([self.picktimeLabel.text isEqualToString:@"请选择时间"]) {
        
        _dateString = (NSMutableString *)@"请选择时间";
        
    }else{
        
        _dateString = (NSMutableString*)selectDate;
        
    }
    
     return self.picktimeLabel;
    
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    
    return 56/2;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    
    picknumber = (int)row;
    
    [self.pickView  selectRow:picknumber inComponent:0 animated:YES];
    
    [self.pickView reloadComponent:0];
}


#pragma mark  比较时间大小
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
#pragma mark createSegView

-(void)createSegView{
    
    self.foodDetail = [NSMutableArray array];
    if (self.scView) {
        
        [self.scView removeFromSuperview];
        
        self.scView = nil;
    }
    //iOS7新增属性
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    NSMutableArray *array=[NSMutableArray array];
    
    for (int i =0; i<3; i++) {
        
        
        DingzhiTableView  *tbale=[[DingzhiTableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-(self.startView.frame.origin.y+self.startView.frame.size.height+8)-44)];
         tbale.dingzhiView.delegate=self;
         tbale.dingzhiView.dataSource=self;
         tbale.tag = 200+i;
         tbale.dingzhiView.tag = 100 +i;
         tbale.dingzhiView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
         tbale.dingzhiView.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
        tbale.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
        
        // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
        if ([self.timeLabel.text isEqualToString:@"请选择时间"]) {
            
            _dateString = (NSMutableString *)@"default";
            
        }else{
            
            _dateString = (NSMutableString *)self.timeLabel.text;
        }
        
         __weak __typeof(self) weakSelf = self;
        tbale.dingzhiView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
           // NSLog(@"%ld",(long)tbale.dingzhiView.tag);
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            NSMutableString *userid = [user objectForKey:@"id"];
            NSMutableString *token  = [user objectForKey:@"token"];
            // 2==faa0688d0c2d8f8c224fed0ecd95ab29
           // NSLog(@"%@",userid);
            if (!userid) {
                
                //NSLog(@"11111");
                int a = arc4random() % 99999;
                NSString *str = [NSString stringWithFormat:@"%05d", a];
                token =  (NSMutableString *)[self md5:str];
                userid = (NSMutableString *)@"10000";
                
            }else{
                
                
            }
            if (tbale.dingzhiView.tag == 100) {
                
                
              _cheDataArr = [NSMutableArray array];
                [weakSelf getTotalDataCategory:@"1" nameID:userid pageNumber:@"1" tokenStr:token begin_time:_dateString backDataArr:_cheDataArr];
                pageCarNumber = 1;
                
            }else if(tbale.dingzhiView.tag == 101){
                _foodDataArr = [NSMutableArray array];
                
                [weakSelf getTotalDataCategory:@"2" nameID:userid pageNumber:@"1" tokenStr:token begin_time:_dateString backDataArr:_foodDataArr];
                pageFoodNumber = 1;
                
            }else if (tbale.dingzhiView.tag == 102){
                
                _hotelDataArr = [NSMutableArray array];
                pageHotelNumber = 1;
                
                [weakSelf getTotalDataCategory:@"3" nameID:userid pageNumber:@"1" tokenStr:token begin_time:_dateString backDataArr:_hotelDataArr];
                
            }
           
        }];
        
        // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
        tbale.dingzhiView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            NSMutableString *userid = [user objectForKey:@"id"];
            NSMutableString *token  = [user objectForKey:@"token"];
            // 2==faa0688d0c2d8f8c224fed0ecd95ab29
            NSLog(@"%@",userid);
            if (!userid) {
                
                //NSLog(@"11111");
                int a = arc4random() % 99999;
                NSString *str = [NSString stringWithFormat:@"%05d", a];
                token =  (NSMutableString *)[self md5:str];
                userid = (NSMutableString *)@"10000";
                
            }else{
                
                
            }
            if (tbale.dingzhiView.tag == 100) {
                
               // _cheDataArr = [NSMutableArray array];
                pageCarNumber++;
                [weakSelf getTotalDataCategory:@"1" nameID:userid pageNumber:[NSString stringWithFormat:@"%d",pageCarNumber] tokenStr:token begin_time:_dateString backDataArr:_cheDataArr];
                
            }else if(tbale.dingzhiView.tag == 101){
                //_foodDataArr = [NSMutableArray array];
                pageFoodNumber++;
                [weakSelf getTotalDataCategory:@"2" nameID:userid pageNumber:[NSString stringWithFormat:@"%d",pageFoodNumber] tokenStr:token begin_time:_dateString backDataArr:_foodDataArr];
                
            }else if (tbale.dingzhiView.tag == 102){
                // _hotelDataArr = [NSMutableArray array];
                pageHotelNumber++;
                [weakSelf getTotalDataCategory:@"3" nameID:userid pageNumber:[NSString stringWithFormat:@"%d",pageHotelNumber]tokenStr:token begin_time:_dateString backDataArr:_hotelDataArr];
                
            }

        }];
        // 马上进入刷新状态
        //[tbale.dingzhiView.mj_header beginRefreshing];
        
        if (i==0||i==2) {
                
                [tbale.selectedView1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    
                    make.width.mas_equalTo(WIDTH);
                    
                    make.top.equalTo(tbale.mas_top).with.offset(0);
                    
                    make.left.equalTo(tbale.mas_left).with.offset(0);
                    
                    make.height.mas_equalTo(0);
                }];
                
                [tbale.dingzhiView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    
                    make.width.mas_equalTo(WIDTH);
                    
                    make.top.equalTo(tbale.selectedView1.mas_bottom).with.offset(8);
                    
                    make.left.equalTo(tbale.mas_left).with.offset(0);
                    
                    make.bottom.equalTo(tbale.mas_bottom).with.offset(0);
                    
                    
                }];
            
            
           
            
        }else if (i==1) {
            
           
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            
            NSString *number =   [user objectForKey:@"number"];
            
            int a = [number intValue];
            

            if (a == 0) {
                [tbale.selectedView1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    
                    make.width.mas_equalTo(WIDTH);
                    
                    make.top.equalTo(tbale.mas_top).with.offset(0);
                    
                    make.left.equalTo(tbale.mas_left).with.offset(0);
                    
                    make.height.mas_equalTo(0);
                }];
                
                [tbale.dingzhiView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    
                    make.width.mas_equalTo(WIDTH);
                    
                    make.top.equalTo(tbale.selectedView1.mas_bottom).with.offset(8);
                    
                    make.left.equalTo(tbale.mas_left).with.offset(0);
                    
                    make.bottom.equalTo(tbale.mas_bottom).with.offset(0);
                    
                    
                }];
                
            }
            
            if (a != 0) {
                
                self.food = [NSMutableArray array];
                
               // NSLog(@"午餐%@",[user objectForKey:@"午餐"]);
                if (![[user objectForKey:@"午餐"] isEqualToString:@""]) {
                    
                    
                    NSDictionary *lunerDict = [user objectForKey:@"lunerDict"];
                    
                    [ self.food addObject:[user objectForKey:@"午餐"]];
                    
                    [self.foodDetail addObject:lunerDict];
                    
                }
                
                if (![[user objectForKey:@"下午茶"]isEqualToString:@""]) {
                    
                    NSDictionary *coffeDict = [user objectForKey:@"coffeDict"];
                    

                    [ self.food addObject:[user objectForKey:@"下午茶"]];
                    
                     [self.foodDetail addObject:coffeDict];
                }
                
                if (![[user objectForKey:@"晚餐"]isEqualToString:@""]) {
                    
                    
                    NSDictionary *dinnerDict = [user objectForKey:@"dinnerDict"];
                    
                    [self.foodDetail addObject:dinnerDict];
                    
                    [ self.food addObject:[user objectForKey:@"晚餐"]];
                    
                }

            for (int i = 0; i < a; i ++) {
                
                FoodTotalView *foodTotalView = [[FoodTotalView alloc]initWithFrame:CGRectMake(WIDTH/a*i,0, WIDTH/a,61)];
                
                foodTotalView.foodView.foodStyle.text =  self.food[i];
                
                NSArray *text = [self.foodDetail[i][@"qucheTime"] componentsSeparatedByString:@" "];
                
                foodTotalView.foodView.foodTime.text = text[1];
                
                foodTotalView.tag  = 700+i;
               
                [foodTotalView.deleteBtu addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
                
                
                foodTotalView.deleteBtu.tag = 600+i;
                
                foodTotalView.foodView.tag = 900+i;
                foodTotalView.foodView.userInteractionEnabled = YES;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chakan:)];
                
                [foodTotalView.foodView addGestureRecognizer:tap];
                
                [tbale.selectedView1 addSubview:foodTotalView];
                
//              NSLog(@"1111");
            }
            
            }
// NSLog(@"????????/%@",tbale.selectedView1.subviews);

        }
        
        [array addObject:tbale];
    }
    
    self.scView=[[LXSegmentScrollView alloc] initWithFrame:CGRectMake(0,64+8, self.view.bounds.size.width, HEIGHT-64-8) titleArray:@[@"开一俩豪车",@"品一餐珍馐",@"享一晚舒适"] contentViewArray:array];
    self.scView.segmentToolView.titleSelectColor = [NSString colorWithHexString:@"#27292b"];
    self.scView.segmentToolView.titleNomalColor = [NSString colorWithHexString:@"#6d7278"];
    if ([self.hStype isEqualToString:@"car"]) {
        selectNumber = 1;
    }else if ([self.hStype isEqualToString:@"food"]){
        selectNumber = 2;
        
    }else if ([self.hStype isEqualToString:@"hotel"]){
        
        selectNumber = 3;
        
    }else{
        
        selectNumber = selectNumber;
    }
    self.scView.segmentToolView.defaultIndex = selectNumber;

    [self.scView.bgScrollView setContentOffset:CGPointMake(WIDTH*(selectNumber-1), 0)];
    
    [self.view addSubview:self.scView];

    
}
#pragma mark 查看
-(void)chakan:(UITapGestureRecognizer *)sender{
    
    NSLog(@"查看");
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    HSVegetableViewController  *vc = [[HSVegetableViewController alloc]init];
    
  
    vc.info_id =self.foodDetail[sender.view.tag-900][@"info_id"];
    vc.item_id =self.foodDetail[sender.view.tag-900][@"item_id"];
    vc.image_URL = self.foodDetail[sender.view.tag-900][@"image"];
    vc.selectTime = self.foodDetail[sender.view.tag-900][@"qucheTime"];
    vc.caipu = @"caipu";
    vc.arrow = @"dingzhicai";
    [user setObject:self.foodDetail[sender.view.tag-900][@"info_id"] forKey:@"info_id"];
    
    [user setObject:self.foodDetail[sender.view.tag-900][@"item_id"] forKey:@"item_id"];
    selectNumber =2;
    [self.navigationController pushViewController:vc animated:YES];

    
    
}

#pragma mark 删

-(void)deleteClick:(UIButton *)btu{
    
//    NSLog(@"删除");
    
     self.foodDetail = [NSMutableArray array];
   // NSMutableArray *foodArray = [NSMutableArray array];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSString *number =   [user objectForKey:@"number"];
    
    int a = [number intValue];

    
//    <UIView: 0x7fa9bb81d1c0; frame = (0 0; 375 61); layer = <CALayer: 0x7fa9b97b8bb0>
    
    DingzhiTableView  *tbale = [self.view viewWithTag:201];
    
    tbale.selectedView1.backgroundColor = [UIColor whiteColor];
  //  NSLog(@"///////////////////////////////%ld",btu.tag-600);
    
    if ([self.food[btu.tag-600] isEqualToString:@"午餐"]) {
        
        [user setObject:@"" forKey:@"午餐"];
        [user setObject:@"" forKey:@"lunerDict"];
        NSMutableArray *rili = [NSMutableArray arrayWithArray:[user objectForKey:@"Rili"]];
        
        NSMutableArray *riliagin = [NSMutableArray arrayWithArray:[user objectForKey:@"Rili"]];
        for (NSDictionary *riliDict in rili) {
            
            if ([riliDict[@"souereType"] isEqualToString:@"luner"]) {
                
                
                [riliagin  removeObject:riliDict];
            }
        }
        
        [user setObject:riliagin forKey:@"Rili"];

        
    }
    if ([self.food[btu.tag-600] isEqualToString:@"下午茶"]) {
        
        [user setObject:@"" forKey:@"下午茶"];
        [user setObject:@"" forKey:@"coffeDict"];
        NSMutableArray *rili = [NSMutableArray arrayWithArray:[user objectForKey:@"Rili"]];
        
        NSMutableArray *riliagin = [NSMutableArray arrayWithArray:[user objectForKey:@"Rili"]];
        for (NSDictionary *riliDict in rili) {
            
            if ([riliDict[@"souereType"] isEqualToString:@"coffe"]) {
                
                
                [riliagin  removeObject:riliDict];
            }
        }
        
        [user setObject:riliagin forKey:@"Rili"];
    }
    if ([self.food[btu.tag-600] isEqualToString:@"晚餐"]) {
        
        [user setObject:@"" forKey:@"晚餐"];
         [user setObject:@"" forKey:@"dinnerDict"];
        NSMutableArray *rili = [NSMutableArray arrayWithArray:[user objectForKey:@"Rili"]];
        
        NSMutableArray *riliagin = [NSMutableArray arrayWithArray:[user objectForKey:@"Rili"]];
        for (NSDictionary *riliDict in rili) {
            
            if ([riliDict[@"souereType"] isEqualToString:@"dinner"]) {
                
                
                [riliagin  removeObject:riliDict];
            }
        }
        
        [user setObject:riliagin forKey:@"Rili"];

        
    }
    
    [self.food exchangeObjectAtIndex:self.food.count-1 withObjectAtIndex:btu.tag-600];
   
    [self.food removeObjectAtIndex:self.food.count-1];

    [tbale.selectedView1.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
//    NSLog(@"%d",a);
    
    a--;
    
    [user setObject:[NSString stringWithFormat:@"%d",a] forKey:@"number"];

    if (a == 0) {
        
        [tbale.selectedView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.width.mas_equalTo(WIDTH);
            
            make.top.equalTo(tbale.mas_top).with.offset(0);
            
            make.left.equalTo(tbale.mas_left).with.offset(0);
            
            make.height.mas_equalTo(0);
        }];
        
        [tbale.dingzhiView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.width.mas_equalTo(WIDTH);
            
            make.top.equalTo(tbale.selectedView1.mas_bottom).with.offset(8);
            
            make.left.equalTo(tbale.mas_left).with.offset(0);
            
            make.bottom.equalTo(tbale.mas_bottom).with.offset(0);
            
        }];

    }

       for (int i = 0; i < a; i ++) {
        
        FoodTotalView *foodTotalView = [[FoodTotalView alloc]initWithFrame:CGRectMake(WIDTH/a*i,0, WIDTH/a,61)];
           
           //NSLog(@"%@",_food);
           foodTotalView.foodView.foodStyle.text = _food[i];
           if ([_food[i] isEqualToString:@"午餐"]) {
               
               NSDictionary *dinnerDict = [user objectForKey:@"lunerDict"];
               
               [self.foodDetail addObject:dinnerDict];
               NSArray *text = [dinnerDict[@"qucheTime"] componentsSeparatedByString:@" "];
               
               foodTotalView.foodView.foodTime.text = text[1];
               

           }else if ([_food[i] isEqualToString:@"下午茶"]){
               
               NSDictionary *dinnerDict = [user objectForKey:@"coffeDict"];
                [self.foodDetail addObject:dinnerDict];
               NSArray *text = [dinnerDict[@"qucheTime"] componentsSeparatedByString:@" "];
               
               foodTotalView.foodView.foodTime.text = text[1];
           }else if ([_food[i] isEqualToString:@"晚餐"]){
               
               NSDictionary *dinnerDict = [user objectForKey:@"dinnerDict"];
                [self.foodDetail addObject:dinnerDict];
               NSArray *text = [dinnerDict[@"qucheTime"] componentsSeparatedByString:@" "];
               
               foodTotalView.foodView.foodTime.text = text[1];
           }
           
     //  foodTotalView.foodView.foodTime.text = _food[];
           
        [foodTotalView.deleteBtu addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
        foodTotalView.foodView.tag = 900+i;
        foodTotalView.foodView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chakan:)];
           
        [foodTotalView.foodView addGestureRecognizer:tap];
        foodTotalView.deleteBtu.tag = 600+i;
           
        [tbale.selectedView1 addSubview:foodTotalView];
    

    }
    
   // NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    

    
}



#pragma mark uitableviewdelgate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellid=@"cell";
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];

//    DingZhiCell *cell =[tableView dequeueReusableCellWithIdentifier:cellid];
//    if (!cell) {
       DingZhiCell* cell=[[DingZhiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
//    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (tableView.tag == 100) {
        
        if ([[user objectForKey:@"car"] isEqualToString:@"car"]) {
        
            if (indexPath.row== 0) {
                
                cell.layer.borderWidth = 1;
                
                cell.layer.borderColor = [NSString colorWithHexString:@"#6d7278"].CGColor;
                
                cell.delectBtu.hidden = NO;
                
                cell.delectBtu.tag = 300;
                
                [cell.delectBtu setBackgroundImage:[UIImage imageNamed:@"item_-choose@2x"] forState:UIControlStateNormal];
                
                 NSDictionary *dict = [user objectForKey:@"carNeirong"];
                
                [cell.dingzhiimageView sd_setImageWithURL:[NSURL URLWithString:dict[@"image"]] placeholderImage:nil];
                
                cell.dingzhiLabel.text = dict[@"title"];
                
                cell.subDingZhiLable.text = dict[@"subTitle"];
                
                
//                cell.moneyLable.text  = [NSString stringWithFormat:@"¥ %@",[self addSpaceFromSring:dict[@"money"]]];
//                
//                cell.moneyLable.textColor = [NSString colorWithHexString:@"#e4c675"];
                [cell.delectBtu addTarget:self action:@selector(delectBtu:) forControlEvents:UIControlEventTouchUpInside];
                
                
            }else{
                
                
                
                GoodsOneModel *model = _cheDataArr[indexPath.row-1];
                
                [cell.dingzhiimageView sd_setImageWithURL:[NSURL URLWithString:model.img_url] placeholderImage:nil];
                
                cell.dingzhiLabel.text = model.title;
                
                cell.subDingZhiLable.text = model.info;
                
//                cell.moneyLable.text  = [NSString stringWithFormat:@"¥ %@",[self addSpaceFromSring:model.price]];
//                cell.moneyLable.textColor = [NSString colorWithHexString:@"#e4c675"];
            }
        
        }else{
            
            GoodsOneModel *model = _cheDataArr[indexPath.row];
            
            [cell.dingzhiimageView sd_setImageWithURL:[NSURL URLWithString:model.img_url] placeholderImage:nil];
            
            cell.dingzhiLabel.text = model.title;
            
            cell.subDingZhiLable.text = model.info;
            
//            cell.moneyLable.text  = [NSString stringWithFormat:@"¥ %@",[self addSpaceFromSring:model.price]];
//            cell.moneyLable.textColor = [NSString colorWithHexString:@"#e4c675"];

        }

    }else if (tableView.tag == 101){
        
        GoodsOneModel *model = _foodDataArr[indexPath.row];
        
        [cell.dingzhiimageView sd_setImageWithURL:[NSURL URLWithString:model.img_url] placeholderImage:nil];
        
        cell.dingzhiLabel.text = model.title;
        
        cell.subDingZhiLable.text = model.info;
        
         cell.moneyLable.hidden = YES;
        
        
        
     }else if (tableView.tag == 102){
        
         if ([[user objectForKey:@"hotel"] isEqualToString:@"hotel"]) {
             
             if (indexPath.row== 0) {
                 
                // cell.backgroundColor = [UIColor redColor];
                 
                 cell.layer.borderWidth = 0.5;
                 
                 cell.delectBtu.hidden = NO;
                 
                 cell.delectBtu.tag = 400;
                 
                 [cell.delectBtu setBackgroundImage:[UIImage imageNamed:@"item_-choose@2x"] forState:UIControlStateNormal];
                 
                 NSDictionary *dict = [user objectForKey:@"hotelNeirong"];
                 
                 [cell.dingzhiimageView sd_setImageWithURL:[NSURL URLWithString:dict[@"FirstImage"]] placeholderImage:nil];
                 
                 cell.dingzhiLabel.text = dict[@"FirstTitle"];
                 
                 cell.subDingZhiLable.text = dict[@"FirstSubTitle"];
                 cell.moneyLable.hidden = YES;
                 
                 [cell.delectBtu addTarget:self action:@selector(delectBtu:) forControlEvents:UIControlEventTouchUpInside];
             
             }else{
                 
                 GoodsOneModel *model = _hotelDataArr[indexPath.row-1];
                 
                 [cell.dingzhiimageView sd_setImageWithURL:[NSURL URLWithString:model.img_url] placeholderImage:nil];
                 
                 cell.dingzhiLabel.text = model.title;
                 cell.subDingZhiLable.text = model.info;
                 cell.moneyLable.hidden = YES;
             }
         
         }else{
             
             GoodsOneModel *model = _hotelDataArr[indexPath.row];
             
             [cell.dingzhiimageView sd_setImageWithURL:[NSURL URLWithString:model.img_url] placeholderImage:nil];
             cell.moneyLable.hidden = YES;
             cell.dingzhiLabel.text = model.title;
             cell.subDingZhiLable.text = model.info;
             
         }

    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
     NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if (tableView.tag == 100) {
        
       
        if ([[user objectForKey:@"car"] isEqualToString:@"car"]) {
        
            return _cheDataArr.count+1;
        }
        return _cheDataArr.count;
        
    }else if (tableView.tag == 101){
        
        return _foodDataArr.count;
        
    }else if (tableView.tag == 102){
        
        if ([[user objectForKey:@"hotel"] isEqualToString:@"hotel"]) {
            
            return _hotelDataArr.count+1;
        }

        return  _hotelDataArr.count;
    }
    return 5;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 264/2;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
   
    if (tableView.tag == 101) {
        
        RestaurantVC *vc = [[RestaurantVC alloc]init];
        vc.grade = self.grade;
        GoodsOneModel *model = _foodDataArr[indexPath.row];
        
        vc.item_id =model.item_id;
        vc.name  = model.title;
        selectNumber = 2;
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
        
    }else if (tableView.tag == 100){
        
        
        if ([[user objectForKey:@"car"] isEqualToString:@"car"]) {
            
            if (indexPath.row== 0) {
                
              NSDictionary *dict =  [user objectForKey:@"carNeirong"];
              HSVegetableViewController  *vc = [[HSVegetableViewController alloc]init];
               vc.grade = self.grade;
               vc.info_id =dict[@"info_id"];
               vc.item_id =dict[@"item_id"];
               vc.image_URL = dict[@"image"];
               vc.selectTime = dict[@"qucheTime"];
               vc.caipu = @"car";
               
                [user setObject:dict[@"info_id"] forKey:@"info_id"];
                
                [user setObject:dict[@"item_id"] forKey:@"item_id"];
               selectNumber =1;
              [self.navigationController pushViewController:vc animated:YES];
                
                
            }else{
                
                GoodsOneModel *model = _cheDataArr[indexPath.row-1];
                
                HSVegetableViewController  *vc = [[HSVegetableViewController alloc]init];
                vc.grade = self.grade;
                vc.info_id = model.info_id;
                vc.item_id = model.item_id;
                vc.caipu = @"car";
                vc.image_URL = model.img_url;
                
                [user setObject:model.info_id forKey:@"info_id"];
                
                [user setObject:model.info_id forKey:@"item_id"];
                selectNumber =1;
                [self.navigationController pushViewController:vc animated:YES];
                
                
                
            }
            
        }else{
            
            GoodsOneModel *model = _cheDataArr[indexPath.row];
            HSVegetableViewController  *vc = [[HSVegetableViewController alloc]init];
            vc.grade = self.grade;
            vc.info_id =model.info_id;
            vc.item_id = model.item_id;
            vc.image_URL = model.img_url;
            vc.caipu = @"car";
            [user setObject:model.info_id forKey:@"info_id"];
            
            [user setObject:model.info_id forKey:@"item_id"];

            selectNumber =1;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
        

    }else{
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        if ([[user objectForKey:@"hotel"] isEqualToString:@"hotel"]) {
            
            if (indexPath.row== 0) {
                
                NSDictionary *dict =  [user objectForKey:@"hotelNeirong"];
                HSVegetableViewController  *vc = [[HSVegetableViewController alloc]init];
                vc.grade = self.grade;
                vc.info_id = dict[@"info_id"];
                vc.item_id = dict[@"item_id"];
                vc.caipu = @"hotel";
                vc.image_URL = dict[@"image"];
                vc.selectTime = dict[@"qucheTime"];
                vc.arrow = @"dingzhihotel";
                vc.oneDict = @{@"title":dict[@"FirstTitle"],@"img_url":dict[@"FirstImage"],@"info":dict[@"FirstSubTitle"]};
                [user setObject:dict[@"info_id"] forKey:@"info_id"];
                
                [user setObject:dict[@"item_id"] forKey:@"item_id"];
               
                selectNumber =3;
                [self.navigationController pushViewController:vc animated:YES];
                
            }else{
                
                GoodsOneModel *model = _hotelDataArr[indexPath.row-1];
                
                WJFHotelVC  *vc = [[WJFHotelVC alloc]init];
                vc.grade = self.grade;
                vc.item_id = model.item_id;
                vc.image_url = model.img_url;
                vc.hotelName = model.title;
                vc.oneHotel = @{@"title":model.title,@"img_url":model.img_url,@"info":model.info};
                selectNumber =3;
                
                [self.navigationController pushViewController:vc animated:YES];
            
            }
            
        }else{
            
            GoodsOneModel *model = _hotelDataArr[indexPath.row];
            
            WJFHotelVC  *vc = [[WJFHotelVC alloc]init];
            vc.grade = self.grade;
            vc.item_id    = model.item_id;
            vc.image_url  = model.img_url;
            vc.hotelName  = model.title;
            vc.oneHotel = @{@"title":model.title,@"img_url":model.img_url,@"info":model.info};
            selectNumber =3;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
    }
    
    
}

#pragma mark 滚动......
static float  lastoffset =0;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGPoint translation = scrollView.contentOffset;
    
    CGFloat yOffset = translation.y - lastoffset;
    
    
    NSLog(@"yOffset  %f",yOffset);
    
    if (yOffset > 0) {
        
        if (self.sureDingZhiBtu.frame.origin.y >= HEIGHT) {
            
           self.sureDingZhiBtu.frame = CGRectMake(56/2,HEIGHT, WIDTH-56, 40);
            
        }else{
            
            if (scrollView.tracking) {
                
            self.sureDingZhiBtu.frame = CGRectMake(56/2,self.sureDingZhiBtu.frame.origin.y+fabs(yOffset), WIDTH-56, 40);
            
                
            }
            
        }
        
    }else{
    
        if (self.sureDingZhiBtu.frame.origin.y <= HEIGHT-60) {
            self.sureDingZhiBtu.frame = CGRectMake(56/2,HEIGHT-60, WIDTH-56, 40);
        }else{
            if (scrollView.tracking) {
                
                [self.view bringSubviewToFront:self.sureDingZhiBtu];
                self.sureDingZhiBtu.frame = CGRectMake(56/2,self.sureDingZhiBtu.frame.origin.y-fabs(yOffset), WIDTH-56, 40);
            }
            
        }
    }
    NSLog(@"self.sureDingZhiBtu.frame.origin.y %f ===%f",self.sureDingZhiBtu.frame.origin.y,HEIGHT);
    lastoffset = translation.y;
    
}


#pragma mark 取消事件
-(void)delectBtu:(UIButton *)btu{
    

    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    if (btu.tag == 300) {
        
        
        DingzhiTableView  *tbale = [self.view viewWithTag:200];
        
        [user setObject:@"" forKey:@"car"];
        
        [user setObject:@"" forKey:@"carNeirong"];
        
        
        NSMutableArray *rili = [NSMutableArray arrayWithArray:[user objectForKey:@"Rili"]];
        
        NSMutableArray *riliagin = [NSMutableArray arrayWithArray:[user objectForKey:@"Rili"]];
        for (NSDictionary *riliDict in rili) {
            
            if ([riliDict[@"souereType"] isEqualToString:@"car"]) {
                
                
                [riliagin  removeObject:riliDict];
            }
        }
        
        [user setObject:riliagin forKey:@"Rili"];
        
        
        [tbale.dingzhiView reloadData];
        
       
        
    }else if (btu.tag == 400){
        
        
        DingzhiTableView  *tbale = [self.view viewWithTag:202];
        
        [user setObject:@"" forKey:@"hotel"];
        
        [user setObject:@"" forKey:@"hotelNeirong"];
        
        
        NSMutableArray *rili = [NSMutableArray arrayWithArray:[user objectForKey:@"Rili"]];
        
        NSMutableArray *riliagin = [NSMutableArray arrayWithArray:[user objectForKey:@"Rili"]];
        for (NSDictionary *riliDict in rili) {
            
            if ([riliDict[@"souereType"] isEqualToString:@"hotel"]) {
                
                
                [riliagin  removeObject:riliDict];
            }
        }
        
        [user setObject:riliagin forKey:@"Rili"];
        
        [tbale.dingzhiView reloadData];
        
        
    }
    
   
}



-(void)getTotalDataCategory:(NSString *)category  nameID:(NSString *)nameID  pageNumber:(NSString *)pageNumber  tokenStr:(NSString *)token  begin_time:(NSString *)beginTime backDataArr:(NSMutableArray *)dataArr{
    
    NSDictionary *dict;
    NSDictionary *signDict;
    
    if ([nameID isEqualToString:@"10000"]) {
        
        dict = @{@"route":@"Item_showItem",@"version":@"1",@"page":pageNumber,@"category":category,@"price_level":self.grade,@"begin_time":@"default"};
        
        signDict = [self encryptDict:(NSMutableDictionary *)dict];
    
    }else{
        
         dict = @{@"route":@"Item_showItem",@"version":@"1",@"id":nameID,@"page":pageNumber,@"category":category,@"token":token,@"begin_time":@"default",@"price_level":self.grade};

        signDict = [self encryptDict:(NSMutableDictionary *)dict];
        
    }
   
    [WJFCollection getWithURLString:@"http://www.rempeach.com/rebirth/api/AppApi/receive" parameters:signDict success:^(id responseObject) {
        
      //  NSLog(@"?????%@",responseObject[@"tip"]);
        if ([responseObject[@"state"] isEqualToString:@"200"]) {
            
            for (NSDictionary *dict in responseObject[@"data"][@"list"]) {
                
                
                GoodsOneModel *model = [GoodsOneModel tgWithDict:dict];
    
                
                [dataArr addObject:model];
                
                
            }
            
//            NSLog(@"%lu",(unsigned long)dataArr.count);
            
            if ([category isEqualToString:@"1"]) {
                UITableView  *tbale = [self.view viewWithTag:100];
                
                 [tbale reloadData];

                 //拿到当前的下拉刷新控件，结束刷新状态
                 [tbale.mj_header endRefreshing];
                 [tbale.mj_footer endRefreshing];
                
            }else if([category isEqualToString:@"2"]){
                
                UITableView  *tbale = [self.view viewWithTag:101];
                
                [tbale reloadData];
                //拿到当前的下拉刷新控件，结束刷新状态
                [tbale.mj_header endRefreshing];
                 [tbale.mj_footer endRefreshing];
                
            }else if([category isEqualToString:@"3"]){
                
                
                UITableView  *tbale = [self.view viewWithTag:102];
                
                [tbale reloadData];
                //拿到当前的下拉刷新控件，结束刷新状态
                [tbale.mj_header endRefreshing];
                [tbale.mj_footer endRefreshing];

                
            }
            
            
            
        }else if([responseObject[@"state"] isEqualToString:@"100"]){
            
            //NSLog(@"没有更多了");
            if ([category isEqualToString:@"1"]) {
                UITableView  *tbale = [self.view viewWithTag:100];
                
               // [LCProgressHUD showStatus:LCProgressHUDStatusInfo text:@"已经加载到最后一页了"];
                //拿到当前的下拉刷新控件，结束刷新状态
                [tbale.mj_footer endRefreshing];
                // 拿到当前的上拉刷新控件，变为没有更多数据的状态
                [tbale.mj_footer endRefreshingWithNoMoreData];
                
            }else if([category isEqualToString:@"2"]){
                
                UITableView  *tbale = [self.view viewWithTag:101];
                
                 //[LCProgressHUD showStatus:LCProgressHUDStatusInfo text:@"已经加载到最后一页了"];
                //拿到当前的下拉刷新控件，结束刷新状态
                [tbale.mj_footer endRefreshing];
                // 拿到当前的上拉刷新控件，变为没有更多数据的状态
                [tbale.mj_footer endRefreshingWithNoMoreData];

            }else if([category isEqualToString:@"3"]){
                
                
                UITableView  *tbale = [self.view viewWithTag:102];
                //[LCProgressHUD showStatus:LCProgressHUDStatusInfo text:@"已经加载到最后一页了"];
               
                [tbale.mj_footer endRefreshing];
                // 拿到当前的上拉刷新控件，变为没有更多数据的状态
                [tbale.mj_footer endRefreshingWithNoMoreData];

                
            }

           
            
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
        
    } failure:^(NSError *error) {
        
    
        if ([category isEqualToString:@"1"]) {
            UITableView  *tbale = [self.view viewWithTag:100];
            
            NetworkWrongView *netview = [[NetworkWrongView alloc]initWithFrame:CGRectMake(0,64+44,tbale.frame.size.width,
                                                                                          tbale.frame.size.height)];
            
            netview.tupImage.image = [UIImage imageNamed:@"sorry@2x"];
            
            netview.zhuTitle.text = @"数据加载失败";
            
            netview.zhuTitle.textColor = [NSString colorWithHexString:@"#27292b"];
            
            netview.zhuTitle.font = [UIFont systemFontOfSize:14];
            
            
            netview.subTitle.text = @"请检查你的手机是否联网";
            
            netview.subTitle.textColor = [NSString colorWithHexString:@"#6d7278"];
            
            netview.subTitle.font = [UIFont systemFontOfSize:14];
            
            
            [netview.sureBtu setTitle:@"重新加载" forState:UIControlStateNormal];
            
            [netview.sureBtu setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            
            netview.sureBtu.titleLabel.font = [UIFont systemFontOfSize:12];
            
            [netview.sureBtu setTitleColor:[NSString colorWithHexString:@"27292b"] forState:UIControlStateNormal];
            [netview.sureBtu setBackgroundColor:[UIColor whiteColor]];
            
            netview.sureBtu.layer.masksToBounds = YES;
            
            netview.sureBtu.layer.cornerRadius =  2;
            netview.sureBtu.layer.borderWidth = 0.5;
            
            netview.sureBtu.layer.borderColor = [NSString colorWithHexString:@"#27292b"].CGColor;
            
            
            [netview.sureBtu addTarget:self action:@selector(jiazai:) forControlEvents:UIControlEventTouchUpInside];
            tbale.backgroundView = netview;
            tbale.separatorStyle = UITableViewCellSeparatorStyleNone;
            
            [tbale.mj_footer removeFromSuperview];
             self.sureDingZhiBtu.hidden = YES;
            
            
        }else if([category isEqualToString:@"2"]){
            
            UITableView  *tbale = [self.view viewWithTag:101];
            NetworkWrongView *netview = [[NetworkWrongView alloc]initWithFrame:CGRectMake(0,64+44,tbale.frame.size.width,
                                                                                          tbale.frame.size.height)];
            
            netview.tupImage.image = [UIImage imageNamed:@"sorry@2x"];
            
            netview.zhuTitle.text = @"数据加载失败";
            
            netview.zhuTitle.textColor = [NSString colorWithHexString:@"#27292b"];
            
            netview.zhuTitle.font = [UIFont systemFontOfSize:14];
            
            
            netview.subTitle.text = @"请检查你的手机是否联网";
            
            netview.subTitle.textColor = [NSString colorWithHexString:@"#6d7278"];
            
            netview.subTitle.font = [UIFont systemFontOfSize:14];
            
            [netview.sureBtu setTitle:@"重新加载" forState:UIControlStateNormal];
            
            [netview.sureBtu setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            
            netview.sureBtu.titleLabel.font = [UIFont systemFontOfSize:12];
            
            [netview.sureBtu setTitleColor:[NSString colorWithHexString:@"27292b"] forState:UIControlStateNormal];
            [netview.sureBtu setBackgroundColor:[UIColor whiteColor]];
            
            netview.sureBtu.layer.masksToBounds = YES;
            
            netview.sureBtu.layer.cornerRadius =  2;
            netview.sureBtu.layer.borderWidth = 0.5;
            
            netview.sureBtu.layer.borderColor = [NSString colorWithHexString:@"#27292b"].CGColor;
            
            
            [netview.sureBtu addTarget:self action:@selector(jiazai:) forControlEvents:UIControlEventTouchUpInside];
            tbale.backgroundView = netview;
            tbale.separatorStyle = UITableViewCellSeparatorStyleNone;
            
             [tbale.mj_footer removeFromSuperview];
             self.sureDingZhiBtu.hidden = YES;
            
        }else if([category isEqualToString:@"3"]){
            
            
            UITableView  *tbale = [self.view viewWithTag:102];
            NetworkWrongView *netview = [[NetworkWrongView alloc]initWithFrame:CGRectMake(0,64+44,tbale.frame.size.width,
                                                                                          tbale.frame.size.height)];
            
            netview.tupImage.image = [UIImage imageNamed:@"sorry@2x"];
            
            netview.zhuTitle.text = @"数据加载失败";
            
            netview.zhuTitle.textColor = [NSString colorWithHexString:@"#27292b"];
            
            netview.zhuTitle.font = [UIFont systemFontOfSize:14];
            
            
            netview.subTitle.text = @"请检查你的手机是否联网";
            
            netview.subTitle.textColor = [NSString colorWithHexString:@"#6d7278"];
            
            netview.subTitle.font = [UIFont systemFontOfSize:14];
            
            
            [netview.sureBtu setTitle:@"重新加载" forState:UIControlStateNormal];
            
            [netview.sureBtu setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            
            netview.sureBtu.titleLabel.font = [UIFont systemFontOfSize:12];
            
            [netview.sureBtu setTitleColor:[NSString colorWithHexString:@"27292b"] forState:UIControlStateNormal];
            [netview.sureBtu setBackgroundColor:[UIColor whiteColor]];
            
            netview.sureBtu.layer.masksToBounds = YES;
            
            netview.sureBtu.layer.cornerRadius =  2;
            netview.sureBtu.layer.borderWidth = 0.5;
            
            netview.sureBtu.layer.borderColor = [NSString colorWithHexString:@"#27292b"].CGColor;
            
            
            [netview.sureBtu addTarget:self action:@selector(jiazai:) forControlEvents:UIControlEventTouchUpInside];
            tbale.backgroundView = netview;
            tbale.separatorStyle = UITableViewCellSeparatorStyleNone;
            [tbale.mj_footer removeFromSuperview];
            
            self.sureDingZhiBtu.hidden = YES;
        }
        
    }];
}

#pragma mark 重新加载
-(void)jiazai:(UIButton *)btu{
    
    
    
    
    
    
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
        
       // NSLog(@"截取的值为：%@",huostring);
        NSMutableString *mst = [[NSMutableString alloc] init];
        
        [mst setString:qianstring];
        
        for (int i = (int)qianstring.length-3; i >0; i = i-3) {
            
            
            [mst insertString:@"," atIndex:i]; //插入空格
            
        }
        
       // NSLog(@"%f",[huostring floatValue]);
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
