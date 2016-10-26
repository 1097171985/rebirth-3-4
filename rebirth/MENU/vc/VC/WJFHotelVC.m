//
//  WJFHotelVC.m
//  rebirth
//
//  Created by boom on 16/7/23.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "WJFHotelVC.h"

#import "DingZhiCell.h"

#import "FoodModel.h"
#import "HSVegetableViewController.h"

@interface WJFHotelVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *hotelTableView;

@property(nonatomic,strong)NSMutableArray *dataARR;

@end

@implementation WJFHotelVC

static int page = 1;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    
    [self.leftBtu setImage:[UIImage imageNamed:@"back_arrow@2x"] forState:UIControlStateNormal];
    
    self.menuView.text =self.hotelName;
    
    [self  createTableView];
    
    
    _dataARR = [NSMutableArray array];
    [self getHttpDatapageNumber:@"1"];
    // Do any additional setup after loading the view.
}

-(void)createTableView{
    
    self.hotelTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
    
    self.hotelTableView.dataSource = self;
    
    self.hotelTableView.delegate = self;
    
    [self.view addSubview:self.hotelTableView];
    
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.hotelTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.dataARR = [NSMutableArray array];
        page = 1;
        [weakSelf getHttpDatapageNumber:@"1"];
    }];
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.hotelTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        page++;
        [weakSelf getHttpDatapageNumber:[NSString stringWithFormat:@"%d",page]];
    }];

    
}




#define mark uitableviewdelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DingZhiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DingZhiCell"];
    
    if (!cell) {
        
        cell = [[DingZhiCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"DingZhiCell"];
        
    }
    
    
    FoodModel *model = _dataARR[indexPath.row];
    cell.dingzhiLabel.text =model.title;
    
    cell.moneyLable.text = [NSString stringWithFormat:@"¥ %@",[self addSpaceFromSring:model.price]];
    cell.moneyLable.textColor = [NSString colorWithHexString:@"#e4c675"];
    [cell.dingzhiimageView sd_setImageWithURL:[NSURL URLWithString:model.head_img] placeholderImage:[UIImage imageNamed:@""]];
    
    cell.subDingZhiLable.text = model.adv;

    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([[USER_DEFAULT objectForKey:@"hotel"] isEqualToString:@"hotel"]) {
        
        return _dataARR.count+1;
    }
    
    return _dataARR.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 256/2;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HSVegetableViewController  *vc = [[HSVegetableViewController alloc]init];
    FoodModel *model = [[FoodModel alloc]init];
    vc.grade = self.grade;
    model = _dataARR[indexPath.row];
    vc.info_id =model.info_id;
    vc.item_id = model.item_id;
    vc.image_URL = self.image_url;
    vc.oneDict  = self.oneHotel;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:model.info_id forKey:@"info_id"];
    
    [user setObject:model.info_id forKey:@"item_id"];
    vc.caipu = @"hotel";
    [self.navigationController pushViewController:vc animated:YES];

    
    
}



-(void)getHttpDatapageNumber:(NSString *)pageStr{
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSMutableString *userid = [user objectForKey:@"id"];
    NSMutableString *token  = [user objectForKey:@"token"];
    NSDictionary *dict;
    NSDictionary *signDict;
//    NSString *urlStr ;
    NSString *pageNumber = pageStr;
    
    
    
    
    if (!userid) {
        
        //NSLog(@"11111");
        int a = arc4random() % 99999;
        NSString *str = [NSString stringWithFormat:@"%05d", a];
        token =  (NSMutableString *)[self md5:str];
        userid = (NSMutableString *)@"10000";
        
        dict = @{@"route":@"Item_showMenuList",@"version":@"1",@"price_level":self.grade,@"page":pageNumber,@"category":@"9",@"item_id":self.item_id};
        
        
    }else{
        
        dict = @{@"route":@"Item_showMenuList",@"version":@"1",@"price_level":self.grade,@"id":userid,@"page":pageNumber,@"category":@"9",@"token":token,@"item_id":self.item_id};

    }
    
      signDict = [self encryptDict:(NSMutableDictionary *)dict];
    
    [WJFCollection getWithURLString:@"http://www.rempeach.com/rebirth/api/AppApi/receive" parameters:signDict success:^(id responseObject) {
        
        //NSLog(@"?????%@",responseObject[@"tip"]);
        
        if ([responseObject[@"state"] isEqualToString:@"200"]) {
            
            for (NSDictionary *dict in responseObject[@"data"][@"list"]) {
                
                [self toModelCodeString:dict];
                
                FoodModel *model = [FoodModel tgWithDict:dict];
                
                [_dataARR addObject:model];
                
            }
            
            // NSLog(@"%lu",(unsigned long)dataArr.count);
            
            [self.hotelTableView reloadData];
            
            [self.hotelTableView.mj_footer endRefreshing];
            
            [self.hotelTableView.mj_header endRefreshing];
            
            
        }else if([responseObject[@"state"] isEqualToString:@"100"]){
            
            
            //拿到当前的下拉刷新控件，结束刷新状态
            [self.hotelTableView.mj_footer endRefreshing];
            // 拿到当前的上拉刷新控件，变为没有更多数据的状态
            [self.hotelTableView.mj_footer endRefreshingWithNoMoreData];
            
            
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
        
        
    }];
}



-(NSString *)toModelCodeString:(NSDictionary *)dic{
    
    NSMutableString *strCode = [NSMutableString string];
    
    for (NSString *strKey in dic.allKeys) {
        
        id value = dic[strKey];
        
        NSString *strFlag = @"strong";
        
        NSString *strType = @"NSObject *";
        
        if (value) {
            
            if ([value isKindOfClass:[NSString class]]) {
                
                strType = @"NSString *";
                
            }else{
                
                if ([value isKindOfClass:[NSNumber class]]) {
                    
                    strFlag = @"assign";
                    
                    NSNumber *number = value;
                    
                    if (strcmp(number.objCType, @encode(int))) {
                        
                        strType = @"NSInteger ";
                    }else{
                        
                        if (strcmp(number.objCType, @encode(BOOL))) {
                            
                            strType = @"BOOL ";
                        }else{
                            
                            if (strcmp(number.objCType, @encode(float))) {
                                
                                strType = @"float ";
                            }else{
                                if (strcmp(number.objCType, @encode(double))) {
                                    
                                    strType = @"double ";
                                }
                            }
                        }
                    }
                }
            }
        }
        
        [strCode appendFormat:@"@property(nonatomic,%@)%@%@;\n",strFlag,strType,strKey];
    }
    //NSLog(@"=====\n%@",strCode);
    return strCode;
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
        
       // NSLog(@"截取的值为：%@",qianstring);
        
        huostring = [str substringFromIndex:str.length-2];//去掉下标2之前的字符串
        
      //  NSLog(@"截取的值为：%@",huostring);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
