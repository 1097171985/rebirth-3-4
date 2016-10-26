//  WJFCalendarCell.M
//  一些常用的知识点
//
//  Created by boom on 16/7/14.
//  Copyright © 2016年 boom. All rights reserved.
//


#import "WJFCalendarCell.h"

@implementation WJFCalendarCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
    
    
//    self.contentView.layer.borderWidth = 1;
//    self.contentView.layer.borderColor = [UIColor clearColor].CGColor;
//    //选中时显示的图片
//    imgview = [[UIImageView alloc]initWithFrame:CGRectMake(5, 15, self.bounds.size.width-10, self.bounds.size.width-10)];
//    imgview.image = [UIImage imageNamed:@"shaxian_img"];
//    [self addSubview:imgview];
    
//    UILabel *total = [[UILabel alloc]initWithFrame:CGRectMake(0,0,self.bounds.size.width,self.bounds.size.width)];
//    
//    total.backgroundColor = [NSString colorWithHexString:@"#f2f3f5"];
//    
//    [self addSubview:total];
    
    //日期
    day_lab = [[UILabel alloc]initWithFrame:CGRectMake(0,3, self.bounds.size.width-3, self.bounds.size.width-8)];
    day_lab.backgroundColor = [NSString colorWithHexString:@"#f2f3f5"];
    day_lab.textAlignment = NSTextAlignmentCenter;
    day_lab.layer.borderWidth = 0.5;
    day_lab.layer.borderColor = [NSString colorWithHexString:@"#27292b"].CGColor;
    day_lab.textColor = [NSString colorWithHexString:@"#6d7278"];
    day_lab.font = [UIFont systemFontOfSize:16];
    [self addSubview:day_lab];
    
//    //农历
//    day_title = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-15, self.bounds.size.width, 13)];
//    day_title.textColor = [UIColor lightGrayColor];
//    day_title.font = [UIFont boldSystemFontOfSize:10];
//    day_title.textAlignment = NSTextAlignmentCenter;
//    [total addSubview:day_title];
    
    
}


- (void)setModel:(CalendarDayModel *)model
{
    
    
    switch (model.style) {
        case CellDayTypeEmpty://不显示
            [self hidden_YES];
            break;
            
        case CellDayTypePast://过去的日期
            [self hidden_NO];
            
            if (model.holiday) {
                day_lab.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
            }else{
                day_lab.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
            }
            day_lab.layer.borderWidth = 0;
            day_lab.backgroundColor = [NSString colorWithHexString:@"#f2f3f5"];
            day_lab.textColor = [NSString colorWithHexString:@"#6d7278"];
            //day_title.text = model.Chinese_calendar;
            imgview.hidden = YES;
            break;
            
        case CellDayTypeFutur://将来的日期
            
            [self hidden_NO];
            day_lab.layer.borderWidth = 0.5;
            day_lab.backgroundColor = [UIColor whiteColor];
            if (model.holiday) {
                day_lab.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
                day_lab.textColor = [NSString colorWithHexString:@"#27292b"];
            }else{
                day_lab.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
                day_lab.textColor = [NSString colorWithHexString:@"#27292b"];
            }
            imgview.hidden = YES;
            break;
            
        case CellDayTypeWeek://周末
            [self hidden_NO];
            day_lab.layer.borderWidth = 0.5;
            day_lab.backgroundColor = [UIColor whiteColor];
            if (model.holiday) {
                day_lab.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
                day_lab.textColor = [NSString colorWithHexString:@"#27292b"];
            }else{
                day_lab.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
                day_lab.textColor =[NSString colorWithHexString:@"#27292b"];
            }
            imgview.hidden = YES;
            break;
            
        case CellDayTypeClick://被点击的日期
            [self hidden_NO];
            day_lab.backgroundColor = [UIColor blackColor];
            day_lab.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
            day_lab.textColor = [UIColor whiteColor];
            day_title.text = model.Chinese_calendar;
            imgview.hidden = NO;
            
            break;
            
        default:
            break;
    }
    
    NSString *selectStr =(NSMutableString *)[NSString stringWithFormat:@"%lu-%02lu-%02lu 12:00:00",(unsigned long)model.year,(unsigned long)model.month,(unsigned long)model.day];
    
    
    BOOL select =  [self conetent:selectStr];
    
    BOOL oneTwoTHRE = [self bijiaoShijian:selectStr];
    
    //NSLog(@"1111");
    if (select == NO || oneTwoTHRE == NO) {
        
        day_lab.layer.borderWidth = 0;
        day_lab.backgroundColor = [NSString colorWithHexString:@"#f2f3f5"];
        day_lab.textColor = [NSString colorWithHexString:@"#6d7278"];
        
    }
}



- (void)hidden_YES{
    
    day_lab.hidden = YES;
    day_title.hidden = YES;
    imgview.hidden = YES;
    
}


- (void)hidden_NO{
    
    day_lab.hidden = NO;
    day_title.hidden = NO;
    
}

-(void)compentDataisHere:(CalendarDayModel *)model dateArray:(NSMutableArray *)userDateArray{
    
    
    self.userCellDateArray = [NSMutableArray array];
    
    [self.userCellDateArray addObjectsFromArray:userDateArray];
    
    
    [self setModel:model];
    
    
}
-(BOOL)conetent:(NSString *)dateStr{
    
    //NSLog(@"2222222222222222222222222");
    BOOL selectDateBool = YES;
    //过滤中间空格
    NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
    //[inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    for (NSDictionary *dateDict in self.userCellDateArray) {
        
        bool  startingBool = YES;
        bool  endingBool = YES;
        
        NSDate *seleDate = [inputFormatter dateFromString:dateStr];
        
        NSDate *startDate = [inputFormatter dateFromString:dateDict[@"busy_created"]];
        NSDate *endDate = [inputFormatter dateFromString:dateDict[@"busy_end"]];
        
      int startbool =  [self compareOneDay:seleDate withAnotherDay:startDate];
        
        //1是大于   -1 是小于 0 是等于
        if (startbool == 1) {
          //NSLog(@"11");
            startingBool  = YES;
            
        }else if (startbool == -1){
           // NSLog(@"12");
            startingBool = NO;
        }else{
          // NSLog(@"13");
            startingBool = NO;
            
        };
        
        int endbool =  [self compareOneDay:seleDate withAnotherDay:endDate];
        //1是大于   -1 是小于 0 是等于
        if (endbool == 1) {
           // NSLog(@"21");
            endingBool  = NO;
            
        }else if (endbool == -1){
           // NSLog(@"22");
            endingBool = YES;
        }else{
           //NSLog(@"23");
            endingBool = NO;
            
        };
        
        if (startingBool == YES && endingBool == YES) {
            
           // NSLog(@"选中的时间在这个区间内");
            selectDateBool = NO;
            
        }else{
            
            // NSLog(@"选中的时间不在这个区间内");
        }
        
    }
    
    return  selectDateBool;

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
