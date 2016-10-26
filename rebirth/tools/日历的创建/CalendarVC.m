//
//  CalendarVC.m
//  一些常用的知识点
//
//  Created by boom on 16/7/14.
//  Copyright © 2016年 boom. All rights reserved.
//

#import "CalendarVC.h"

//UI
#import "WJFCalendarFlowLayout.h"
#import "WJFCalendarMonthHeaderView.h"
#import "WJFCalendarCell.h"
//MODEL
#import "CalendarDayModel.h"


#import "WJFPickView.h"



@interface CalendarVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    
    NSTimer* timer;//定时器
    
}
@property(nonatomic,strong)WJFPickView  *pick;

@property(nonatomic,strong)NSMutableArray  *hoursArr;

@property(nonatomic,strong)NSMutableArray *muntiesArr;

@property(nonatomic,strong)NSMutableString  *str;

@property(nonatomic,strong)NSMutableArray *userdateArray;


@end

@implementation CalendarVC

static NSString *MonthHeader = @"MonthHeaderView";

static NSString *DayCell = @"DayCell";


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [self initData];
        [self createSelectView];
        
        [self initView];
        
        [self gainHttpData];
        
      
    }
    return self;
}

-(void)createSelectView{
    
    UIView *selectView = [[UIView alloc]initWithFrame:CGRectMake(0, 65, WIDTH, 44)];
    
    selectView.backgroundColor = [UIColor whiteColor];

    
    [self.view addSubview:selectView];
    
    
    UILabel *textLable = [[UILabel alloc]init];
    
    textLable.text = @"可租日期";
    
    textLable.font = [UIFont systemFontOfSize:14];
    
    textLable.textColor = [NSString colorWithHexString:@"#333333"];
    
    
    [selectView addSubview:textLable];
    
    [textLable mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.equalTo(selectView.mas_left).with.offset(12);
        
        make.top.equalTo(selectView.mas_top).with.offset(0);
        
        make.bottom.equalTo(selectView.mas_bottom).with.offset(0);
    }];
    
    
    
    self.timeLable = [[UILabel alloc]init];
    
    
    NSDate * date = [NSDate date];
    NSTimeInterval sec = [date timeIntervalSinceNow];
    NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
    
    //设置时间输出格式：
    NSDateFormatter * df = [[NSDateFormatter alloc] init ];
    [df setDateFormat:@"yyyy/MM/dd HH:mm"];
    NSString * na = [df stringFromDate:currentDate];

    self.timeLable.text = na;
    
    self.timeLable.font = [UIFont systemFontOfSize:14];
    
    self.timeLable.textColor = [NSString colorWithHexString:@"#e4c675"];
    
    
    [selectView addSubview:self.timeLable];
    
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(selectView.mas_right).with.offset(-12);
        
        make.top.equalTo(selectView.mas_top).with.offset(0);
        
        make.bottom.equalTo(selectView.mas_bottom).with.offset(0);
    }];

    
}



#pragma mark

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)initView{
    
    
    WJFCalendarFlowLayout *layout = [WJFCalendarFlowLayout new];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 65+45, WIDTH, HEIGHT-65-45-49) collectionViewLayout:layout]; //初始化网格视图大小
    
    [self.collectionView registerClass:[WJFCalendarCell class] forCellWithReuseIdentifier:DayCell];//cell重用设置ID
    
    [self.collectionView registerClass:[WJFCalendarMonthHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MonthHeader];
    
    //    self.collectionView.bounces = NO;//将网格视图的下拉效果关闭
    
    self.collectionView.delegate = self;//实现网格视图的delegate
    
    self.collectionView.dataSource = self;//实现网格视图的dataSource
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
    
}



-(void)initData{
    
    self.calendarMonth = [[NSMutableArray alloc]init];//每个月份的数组
    
    self.hoursArr = [NSMutableArray array];
    
    self.muntiesArr = [NSMutableArray array];
    
    
    for (int i = 0; i < 24; i++) {
            
      [self.hoursArr addObject:[NSString stringWithFormat:@"%d",i]];
            
            
    }
    
    
    
    for (int i =0; i < 60; i++) {
        
         [self.muntiesArr addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
}



#pragma mark - CollectionView代理方法

//定义展示的Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    //NSLog(@"%lu",(unsigned long)self.calendarMonth.count);
    return self.calendarMonth.count;
}



//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSMutableArray *monthArray = [self.calendarMonth objectAtIndex:section];
   // NSLog(@"%lu",(unsigned long)self.calendarMonth.count);
    return monthArray.count;
}


//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WJFCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DayCell forIndexPath:indexPath];
    
    NSMutableArray *monthArray = [self.calendarMonth objectAtIndex:indexPath.section];
    
    CalendarDayModel *model = [monthArray objectAtIndex:indexPath.row];
    
//    cell.model = model;
    [cell compentDataisHere:model dateArray:self.userdateArray];
//    NSLog(@"%lu",(unsigned long)self.calendarMonth.count);
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        NSMutableArray *month_Array = [self.calendarMonth objectAtIndex:indexPath.section];
        CalendarDayModel *model = [month_Array objectAtIndex:15];
        
        WJFCalendarMonthHeaderView *monthHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MonthHeader forIndexPath:indexPath];
        monthHeader.masterLabel.text = [NSString stringWithFormat:@"%d年 %d月",model.year,model.month];//@"日期";
        monthHeader.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
        reusableview = monthHeader;
    }
    return reusableview;
    
}

static bool selectDateBool = YES;

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableArray *month_Array = [self.calendarMonth objectAtIndex:indexPath.section];
//    NSLog(@"%lu",(unsigned long)self.calendarMonth.count);
    CalendarDayModel *model = [month_Array objectAtIndex:indexPath.row];
    
   // NSLog(@"model%@",model);
    
    _str = [NSMutableString string];
    
    _str = (NSMutableString *)[NSString stringWithFormat:@"%lu/%02lu/%02lu",(unsigned long)model.year,(unsigned long)model.month,(unsigned long)model.day];
    
    NSString *selectStr =(NSMutableString *)[NSString stringWithFormat:@"%lu-%02lu-%02lu 12:00:00",(unsigned long)model.year,(unsigned long)model.month,(unsigned long)model.day];
    
    NSLog(@"%@",self.userdateArray);
    
    //过滤中间空格
    NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
    //  [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    for (NSDictionary *dateDict in self.userdateArray) {
        
        bool  startingBool = YES;
        bool  endingBool = YES;
        
        NSDate *seleDate = [inputFormatter dateFromString:selectStr];

        NSDate *startDate = [inputFormatter dateFromString:dateDict[@"busy_created"]];
        NSDate *endDate = [inputFormatter dateFromString:dateDict[@"busy_end"]];
        
       // NSLog(@"date= %@====%@==%@", startDate,endDate,seleDate);
        int startbool =  [self compareOneDay:seleDate withAnotherDay:startDate];
        
        //1是大于   -1 是小于 0 是等于
        if (startbool == 1) {
            //NSLog(@"11");
            startingBool  = YES;
            
        }else if (startbool == -1){
            // NSLog(@"12");
            startingBool = NO;
        }else{
             //NSLog(@"13");
            startingBool = NO;
            
        };
        
        int endbool =  [self compareOneDay:seleDate withAnotherDay:endDate];
        //1是大于   -1 是小于 0 是等于
        if (endbool == 1) {
           //  NSLog(@"21");
            endingBool  = NO;
            
        }else if (endbool == -1){
            // NSLog(@"22");
            endingBool = YES;
        }else{
           // NSLog(@"23");
            endingBool = NO;
            
        };
        if (startingBool == YES && endingBool == YES) {
             NSLog(@"选中的时间在这个区间内");
             selectDateBool = NO;
            
        }else{
            
            //selectDateBool = YES;
             NSLog(@"选中的时间不在这个区间内");
        }
    }
    
    BOOL  oneTwoThree = [self bijiaoShijian:selectStr];
    
    if ((model.style == CellDayTypeFutur || model.style == CellDayTypeWeek ||model.style == CellDayTypeClick )&& selectDateBool == YES && oneTwoThree ==  YES) {
        
        [self.Logic selectLogic:model];
        
        if (self.calendarblock) {
            
            self.calendarblock(model);//传递数组给上级
            
            timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
        }
        [self.collectionView reloadData];
        
        for (NSDictionary *dict in self.userdateArray) {
            
            NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
            //  [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
            [inputFormatter setDateFormat:@"yyyy/MM/dd"];
            
            NSDate *seleDate = [inputFormatter dateFromString:_str];
            
            NSArray *endArr = [dict[@"busy_end"] componentsSeparatedByString:@" "];
            
            NSString *d5 = [endArr[0] stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
            
            NSDate *endingDate = [inputFormatter dateFromString:d5];
            
           // NSLog(@"%@====%@",seleDate,endingDate);
            
            int bijiaobool =  [self compareOneDay:seleDate withAnotherDay:endingDate];
            
            if (bijiaobool == 0) {
                
                self.hoursArr = [NSMutableArray array];
                for (int i = 12; i < 24; i++) {
                    
                 [self.hoursArr addObject:[NSString stringWithFormat:@"%d",i]];
                    
                }
                
            }else{
        
            }
        }
    
        self.pick = [[WJFPickView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        
        NSDate * date = [NSDate date];
        NSTimeInterval sec = [date timeIntervalSinceNow];
        NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
        
        //设置时间输出格式：
        NSDateFormatter * df = [[NSDateFormatter alloc] init ];
        [df setDateFormat:@"yyyy/MM/dd HH:mm"];
        NSString * naTime = [df stringFromDate:currentDate];

        self.pick.selectTimeLable.text =naTime;
        
        [self.pick.cancalBtu addTarget:self action:@selector(cancalBtu:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.pick.sureBtu  addTarget:self action:@selector(sureBtu:) forControlEvents:UIControlEventTouchUpInside];
        
        self.pick.timePickView.dataSource = self;
        
        self.pick.timePickView.delegate = self;
        
       // NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        
        
        [self.pick.timePickView selectRow:9 inComponent:0 animated:YES];
               
        
       
        
        //点击背景是否影藏
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        [self.pick addGestureRecognizer:tap];

        [self.view addSubview:self.pick];
        
    }
    
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}




//定时器方法
- (void)onTimer{
    
    [timer invalidate];//定时器无效
    
    timer = nil;
    
    [self.navigationController popViewControllerAnimated:YES];
}




-(void)cancalBtu:(UIButton *)btu{
    
     NSLog(@"取消");
    [self.pick removeFromSuperview];
    
     self.pick = nil;
    
}

-(void)sureBtu:(UIButton *)btu{
    
    [self.pick removeFromSuperview];
    
    self.pick = nil;
    
    
    //过滤中间空格
    NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
//  [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    
    NSDate *inputDate = [inputFormatter dateFromString:_totalstr];
    //NSLog(@"date= %@====%@", inputDate,[NSDate date]);
 
    
    int intbool =  [self compareOneDay:[NSDate date] withAnotherDay:inputDate];
    
    NSLog(@"%d",intbool);
    
    if (intbool == 1) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"时间不能小于当前时间" preferredStyle:UIAlertControllerStyleAlert];
        
         UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
      
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else{
        
        NSLog(@"%@",_totalstr);
        if (_totalstr == nil) {
        
            //设置时间输出格式：
            NSDateFormatter * df = [[NSDateFormatter alloc] init ];
            [df setDateFormat:@"yyyy/MM/dd HH:mm"];
            NSMutableString *totalStr = [NSMutableString stringWithFormat:@"%@ 09:00",_str];
            
            NSDate *inputDate = [inputFormatter dateFromString:totalStr];
            
           int compare =  [self compareOneDay:[NSDate date] withAnotherDay:inputDate];
            if (compare == 1) {
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"时间不能小于当前时间" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                
                [alertController addAction:cancelAction];
                [self presentViewController:alertController animated:YES completion:nil];

            }else{
                
                   _totalstr = [NSMutableString stringWithFormat:@"%@ 09:00",_str];
                   self.timeLable.text = _totalstr;
            }
            
         
            
        }else{
            self.timeLable.text = _totalstr;
        
        }
        
    }

    
    NSLog(@"确定");
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

#pragma mark uipikViewDelegate
//  一共有多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 2;
}
//  第component列一共有多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    
    if (component == 0) {
        return _hoursArr.count;
    }else{
        
        return _muntiesArr.count;
    }
    return 10;
    
}

//  第component列的宽度是多少
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    return WIDTH/2;
}
//  第component列的行高是多少
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 56/2;
    
}

//  第component列第row行显示什么文字
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    
    if(component == 0){
        
        return [NSString stringWithFormat:@"%@时",_hoursArr[row]];
        
    }else{
        
        return [NSString stringWithFormat:@"%@分",_muntiesArr[row]];
    }
    
}


//选中了pickerView的第component列第row行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
      //NSString *str = [NSString stringWithFormat:];
     NSString *str1 = [NSString stringWithFormat:@"%02d:%02d",[ self.hoursArr[[pickerView selectedRowInComponent:0]] intValue],[self.muntiesArr[[pickerView selectedRowInComponent:1]] intValue]];
    
   // NSLog(@"%@ %@",_str,str1);
    _totalstr = [NSMutableString stringWithFormat:@"%@ %@",_str,str1];
    
    self.pick.selectTimeLable.text = _totalstr;

}


-(void)hide{
    
    [self.pick removeFromSuperview];
    
}

#pragma mark 数据请求
-(void)gainHttpData{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSMutableString *userid = [user objectForKey:@"id"];
    NSMutableString *token  = [user objectForKey:@"token"];
    // 2==faa0688d0c2d8f8c224fed0ecd95ab29
    self.info_id = [user objectForKey:@"info_id"];
    
    self.item_id =[user objectForKey:@"item_id"];
    
    self.userdateArray = [NSMutableArray array];
    
//    名称    类型    是否必传   实例值   参数描述
//    id   String     必         1     用户ID
//    info_id String  必选      120    详情ID
//    item_id  string  必选     1     商品ID
//    token   string  必传    820625d7c926d989da57d4f07ae27e8a   验证会话合法性
//    sign  string  必传    b22732211e51090f62ee944541d9abba   签名

    int a = arc4random() % 99999;
    NSDictionary *dict ;
    
    NSString *url ;
    
    if (!userid) {
        
        //NSLog(@"11111");
        int a = arc4random() % 99999;
        NSString *str = [NSString stringWithFormat:@"%05d", a];
        token =  (NSMutableString *)[self md5:str];
        userid = (NSMutableString *)@"10000";
        dict = @{@"info_id":self.info_id,@"item_id":self.item_id};
        
        NSString *str1 =  [self createMd5Sign:(NSMutableDictionary *)dict];
        
        NSString  *str2 = [self md5:@"miaotaoKJ"];
        
        
        NSString *sign = [self md5:[NSString stringWithFormat:@"%@%@",str1,str2]];
        url =[NSString stringWithFormat:@"%@/api/item/getBusyList?info_id=%@&item_id=%@&sign=%@",ROOTURL,self.info_id,self.item_id,sign];
    }else{
        dict = @{@"id":userid,@"info_id":self.info_id,@"token":token,@"item_id":self.item_id};
        NSString *str1 =  [self createMd5Sign:(NSDictionary *)dict];
        
        NSString  *str2 = [self md5:@"miaotaoKJ"];
        
        
        NSString *sign = [self md5:[NSString stringWithFormat:@"%@%@",str1,str2]];
        
        url = [NSString stringWithFormat:@"%@/api/item/getBusyList?id=%@&info_id=%@&item_id=%@&token=%@&sign=%@",ROOTURL,userid,self.info_id,self.item_id,token,sign];
    }
     //NSLog(@"%@",url);
    
    
    [WJFCollection getWithURLString:url parameters:nil success:^(id responseObject) {
        
        //NSLog(@"%@",responseObject);
        if ([responseObject[@"state"] isEqualToString:@"200"]) {
            
            [self.userdateArray addObjectsFromArray:responseObject[@"data"][@"list"]];
           // NSLog(@"%@",self.userdateArray);
            [self.collectionView reloadData];
            
        }else if ([responseObject[@"state"] isEqualToString:@"201"]) {
            
           // NSLog(@"无暂用记录");
            
        }else if ([responseObject[@"state"] isEqualToString:@"111"]) {
            
        }else if ([responseObject[@"state"] isEqualToString:@"101"]) {
            
        }else if ([responseObject[@"state"] isEqualToString:@"121"]) {
            
        }
        
      } failure:^(NSError *error) {
          
         // NSLog(@"%@",error);
          
      }];
    
    
}


#pragma mark MD5
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

#pragma mark   时间头疼

-(BOOL)bijiaoShijian:(NSString *)dateStr{
    
    NSDateFormatter *inputFormatter1= [[NSDateFormatter alloc] init];
    //[inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSArray *rili = [user objectForKey:@"Rili"];
    if (rili.count > 0) {
        
        //第一个选定进来 ,第二个刚进来
        BOOL totalBOOL = YES;
        
        NSDictionary *dict = [user objectForKey:@"Rili"][0];
        
        NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
        //[inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        [inputFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSArray *dictArr = [dict[@"startTime"] componentsSeparatedByString:@" "];
        
        NSDate *oneDate = [inputFormatter dateFromString:dictArr[0]];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        NSDateComponents *comps = nil;
        
        comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:oneDate];
        
        NSDateComponents *futeradcomps = [[NSDateComponents alloc] init];
        
        [futeradcomps setYear:0];
        
        [futeradcomps setMonth:0];
        
        [futeradcomps setDay:1];
        NSDate *futedate = [calendar dateByAddingComponents:futeradcomps toDate:oneDate options:0];
        
        NSString *futerDateStr = [inputFormatter stringFromDate:futedate];
        NSLog(@"---后两天 =%@===%@=====%@",futedate,oneDate,dictArr[0]);
        NSString *bijdateStr  = [[dateStr componentsSeparatedByString:@" "][0] stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
        
        if ([bijdateStr isEqualToString:dictArr[0]]||[bijdateStr isEqualToString:[futerDateStr stringByReplacingOccurrencesOfString:@"-" withString:@"/"]]) {
            
            totalBOOL = YES;
            
        }else{
            
            totalBOOL = NO;
        }
        
        NSLog(@"%@=====%@=====%@",bijdateStr,dictArr[0],[futerDateStr stringByReplacingOccurrencesOfString:@"-" withString:@"/"]);
        
        return totalBOOL;
    
    }else{
        
        return  YES;
        
    }
}


@end
