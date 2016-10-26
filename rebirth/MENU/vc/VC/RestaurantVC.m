//
//  RestaurantVC.m
//  rebirth
//
//  Created by boom on 16/7/19.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "RestaurantVC.h"
#import "DingZhiCell.h"
#import "FoodModel.h"
#import "HSVegetableViewController.h"

@interface RestaurantVC ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)NSMutableArray *lunchArray;

@property(nonatomic,strong)NSMutableArray  *coffteArray;

@property(nonatomic,strong)NSMutableArray *dinnerArray;

@end

@implementation RestaurantVC

static int pageLunerNumner = 1;

static int pageCoffeNumber = 1;

static int pageDinnerNumer = 1;

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}


-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    
    
}


-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    
    
    [self.leftBtu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
//    self.leftBtu.titleLabel.font = [UIFont systemFontOfSize:10];
    
    self.menuView.text = self.name;
    
    [self createSeg];
    
    [self fasong];
    
}


-(void)fasong{
    
    
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
    
    _lunchArray = [NSMutableArray array];
    [self getTotalDataCategory:@"6" nameID:userid pageNumber:@"1" tokenStr:token item_id:self.item_id backDataArr:_lunchArray];
    
    _coffteArray = [NSMutableArray array];
    [self getTotalDataCategory:@"5" nameID:userid pageNumber:@"1" tokenStr:token item_id:self.item_id backDataArr:_coffteArray];
    
    _dinnerArray = [NSMutableArray array];
    [self getTotalDataCategory:@"7" nameID:userid pageNumber:@"1" tokenStr:token item_id:self.item_id backDataArr:_dinnerArray];
    
    
}
-(void)createSeg{
    
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    NSMutableArray *array=[NSMutableArray array];
    for (int i =0; i<3; i++) {
     
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH,HEIGHT-64-44) style:UITableViewStylePlain];
        tableView.tag = 300+i;
        tableView.delegate=self;
        tableView.dataSource=self;
        
     
        __weak __typeof(self) weakSelf = self;
        
        // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
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

            if (tableView.tag == 300) {
                
                _lunchArray = [NSMutableArray array];

                [weakSelf getTotalDataCategory:@"6" nameID:userid pageNumber:@"1" tokenStr:token item_id:self.item_id backDataArr:_lunchArray];
                pageLunerNumner = 1;
                
            }else if(tableView.tag == 301){
                
                _coffteArray = [NSMutableArray array];
                [weakSelf getTotalDataCategory:@"5" nameID:userid pageNumber:@"1" tokenStr:token item_id:self.item_id backDataArr:_coffteArray];
                pageCoffeNumber = 1;
                
            }else if (tableView.tag == 302)
          
              _dinnerArray = [NSMutableArray array];
              [weakSelf getTotalDataCategory:@"7" nameID:userid pageNumber:@"1" tokenStr:token item_id:self.item_id backDataArr:_dinnerArray];
              pageDinnerNumer = 1;
            
           }];
        

        // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
        tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
           
            
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
            
            if (tableView.tag == 300) {
                
               // _lunchArray = [NSMutableArray array];
                pageLunerNumner ++;
                [weakSelf getTotalDataCategory:@"6" nameID:userid pageNumber:[NSString stringWithFormat:@"%d",pageLunerNumner] tokenStr:token item_id:self.item_id backDataArr:_lunchArray];
                
            }else if(tableView.tag == 301){
                
               // _coffteArray = [NSMutableArray array];
                pageCoffeNumber ++;
                [weakSelf getTotalDataCategory:@"5" nameID:userid pageNumber:[NSString stringWithFormat:@"%d",pageCoffeNumber] tokenStr:token item_id:self.item_id backDataArr:_coffteArray];
            }else if (tableView.tag == 302)
                
               // _dinnerArray = [NSMutableArray array];
                pageDinnerNumer++;
              [weakSelf getTotalDataCategory:@"7" nameID:userid pageNumber:[NSString stringWithFormat:@"%d",pageDinnerNumer] tokenStr:token item_id:self.item_id backDataArr:_dinnerArray];
        }];
        [array addObject:tableView];
        
        
    
    
   }

    LXSegmentScrollView *scView=[[LXSegmentScrollView alloc] initWithFrame:CGRectMake(0,64, self.view.bounds.size.width, HEIGHT-64) titleArray:@[@"午餐",@"下午茶",@"晚餐"] contentViewArray:array];

    scView.segmentToolView.titleSelectColor = [NSString colorWithHexString:@"#27292b"];
    scView.segmentToolView.titleNomalColor = [NSString colorWithHexString:@"#6d7278"];
    [self.view addSubview:scView];
    
}


#pragma mark uitableviewdelgate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellid=@"DingZhiCell";
   DingZhiCell *cell =[tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell=[[DingZhiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    if (tableView.tag == 300) {
        
        FoodModel *model = _lunchArray[indexPath.row];
        cell.dingzhiLabel.text =model.title;
        
        cell.moneyLable.text = [NSString stringWithFormat:@"¥ %@",[self addSpaceFromSring:model.price]];
        cell.moneyLable.textColor = [NSString colorWithHexString:@"#e4c675"];
        [cell.dingzhiimageView sd_setImageWithURL:[NSURL URLWithString:model.head_img] placeholderImage:[UIImage imageNamed:@""]];
        
        cell.subDingZhiLable.text =model.adv;
        
    }else if (tableView.tag == 301){
        
        
        FoodModel *model = _coffteArray[indexPath.row];
        cell.dingzhiLabel.text =model.title;
        
         cell.moneyLable.text = [NSString stringWithFormat:@"¥ %@",[self addSpaceFromSring:model.price]];
        cell.moneyLable.textColor = [NSString colorWithHexString:@"#e4c675"];
        [cell.dingzhiimageView sd_setImageWithURL:[NSURL URLWithString:model.head_img] placeholderImage:[UIImage imageNamed:@""]];
        
        cell.subDingZhiLable.text = model.adv;
        
    }else if (tableView.tag == 302){
        
        FoodModel *model = _dinnerArray[indexPath.row];
        cell.dingzhiLabel.text =model.title;
        cell.moneyLable.text = [NSString stringWithFormat:@"¥ %@",[self addSpaceFromSring:model.price]];
        cell.moneyLable.textColor = [NSString colorWithHexString:@"#e4c675"];
        [cell.dingzhiimageView sd_setImageWithURL:[NSURL URLWithString:model.head_img] placeholderImage:[UIImage imageNamed:@""]];
        
        cell.subDingZhiLable.text =model.adv;
    }
    
    
    
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView.tag == 300) {
        
        return _lunchArray.count;
    
    }else if (tableView.tag == 301){
        
        return _coffteArray.count;
        
    }else if (tableView.tag == 302){
        
        return _dinnerArray.count;
    }
    return 5;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 256/2;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
        
    HSVegetableViewController  *vc = [[HSVegetableViewController alloc]init];
    FoodModel *model = [[FoodModel alloc]init];
    if (tableView.tag == 300) {
        
         model = _lunchArray[indexPath.row];
        
      }else if (tableView.tag == 301){
        
        model = _coffteArray[indexPath.row];
          
      }else if (tableView.tag == 302){
        
         model = _dinnerArray[indexPath.row];
      }

     vc.info_id =model.info_id;
     vc.item_id = model.item_id;
     vc.grade = self.grade;
    
     NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
     [user setObject:model.info_id forKey:@"info_id"];
     [user setObject:model.info_id forKey:@"item_id"];
     vc.caipu = @"caipu";
     [self.navigationController pushViewController:vc animated:YES];
        
  
    
    
}


-(void)getTotalDataCategory:(NSString *)category  nameID:(NSString *)nameID  pageNumber:(NSString *)pageNumber  tokenStr:(NSString *)token  item_id:(NSString *)item_id backDataArr:(NSMutableArray *)dataArr{
    
    NSDictionary *dict ;
    NSDictionary *signDict;
   
    if ([nameID isEqualToString:@"10000"]) {
        
        dict = @{@"route":@"Item_showMenuList",@"version":@"1",@"price_level":self.grade,@"page":pageNumber,@"category":category,@"item_id":item_id};
       
        
    }else{
        
        dict = @{@"route":@"Item_showMenuList",@"version":@"1",@"price_level":self.grade,@"id":nameID,@"page":pageNumber,@"category":category,@"token":token,@"item_id":item_id};
        
    }
    signDict = [self encryptDict:(NSMutableDictionary *)dict];
   
    [WJFCollection getWithURLString:@"http://www.rempeach.com/rebirth/api/AppApi/receive" parameters:signDict success:^(id responseObject) {
        
        NSLog(@"?????%@",responseObject[@"tip"]);
        if ([responseObject[@"state"] isEqualToString:@"200"]) {
            
            for (NSDictionary *dict in responseObject[@"data"][@"list"]) {
                
                [self toModelCodeString:dict];
                
                FoodModel *model = [FoodModel tgWithDict:dict];
                
                [dataArr addObject:model];
                
            }
            
//          NSLog(@"%lu",(unsigned long)dataArr.count);
            
            if ([category isEqualToString:@"6"]) {
                UITableView  *tbale = [self.view viewWithTag:300];
                
                [tbale reloadData];
                
                // 拿到当前的下拉刷新控件，结束刷新状态
                [tbale.mj_header endRefreshing];
                [tbale.mj_footer endRefreshing];
                
                
            }else if([category isEqualToString:@"5"]){
                
                UITableView  *tbale = [self.view viewWithTag:301];
                
                [tbale reloadData];
                // 拿到当前的下拉刷新控件，结束刷新状态
                [tbale.mj_header endRefreshing];
                [tbale.mj_footer endRefreshing];
                
            }else if([category isEqualToString:@"7"]){
                
                UITableView  *tbale = [self.view viewWithTag:302];
                
                [tbale reloadData];
                // 拿到当前的下拉刷新控件，结束刷新状态
                [tbale.mj_header endRefreshing];
                [tbale.mj_footer endRefreshing];
            }
            
            
            
        }else if([responseObject[@"state"] isEqualToString:@"100"]){
            
            //NSLog(@"没有gengd");
            if ([category isEqualToString:@"6"]) {
                UITableView  *tbale = [self.view viewWithTag:300];
                
                //拿到当前的下拉刷新控件，结束刷新状态
                [tbale.mj_footer endRefreshing];
                // 拿到当前的上拉刷新控件，变为没有更多数据的状态
                [tbale.mj_footer endRefreshingWithNoMoreData];
                
                
            }else if([category isEqualToString:@"5"]){
                
                UITableView  *tbale = [self.view viewWithTag:301];
                
                //拿到当前的下拉刷新控件，结束刷新状态
                [tbale.mj_footer endRefreshing];
                // 拿到当前的上拉刷新控件，变为没有更多数据的状态
                [tbale.mj_footer endRefreshingWithNoMoreData];
                
            }else if([category isEqualToString:@"7"]){
                
                UITableView  *tbale = [self.view viewWithTag:302];
                
                //拿到当前的下拉刷新控件，结束刷新状态
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
