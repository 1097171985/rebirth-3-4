//
//  AllIternVC.m
//  rebirth
//
//  Created by boom on 16/8/18.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "AllIternVC.h"
#import "ItineraryCell.h"
#import "ItinerModel.h"
#import "HSPayViewController.h"
#import "JudgeViewVC.h"

@interface AllIternVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *itineraryTable;

@end

static int itpage = 1;

@implementation AllIternVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSMutableArray array];
    [self gainHttpData1:@"1"];
    
    [self createAllTternVC];
    // Do any additional setup after loading the view.
}

-(void)createAllTternVC{
    
    self.itineraryTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,WIDTH, HEIGHT-64-40) style:UITableViewStyleGrouped];
    self.itineraryTable.delegate=self;
    self.itineraryTable.dataSource=self;
    
    
    self.itineraryTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.itineraryTable.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.itineraryTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.dataArray = [NSMutableArray array];
        [weakSelf gainHttpData1:@"1"];
        itpage = 1;
        
    }];
    
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        itpage++;
        [weakSelf gainHttpData1:[NSString stringWithFormat:@"%d",itpage]];
    }];
    // 设置文字
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载中...,请稍后" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"已经加载完毕了" forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:17];
    
    // 设置颜色
    footer.stateLabel.textColor = [UIColor grayColor];
    
    self.itineraryTable.mj_footer = footer;
    
    [self.view addSubview:self.itineraryTable];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark 全部订单
-(void)gainHttpData1:(NSString *)page{
    
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
    //
    NSDictionary *dict = @{@"id":userid,@"page":page,@"type":@"all",@"token":token};
    
    NSString *str1 =  [self createMd5Sign:(NSMutableDictionary *)dict];
    
    //    NSLog(@"%@",str1);
    
    NSString  *str2 = [self md5:@"miaotaoKJ"];
    
    NSString *sign = [self md5:[NSString stringWithFormat:@"%@%@",str1,str2]];
    
    NSLog(@"%@",[NSString stringWithFormat:@"%@/api/order/getOrder?id=%@&page=%@&type=all&token=%@&sign=%@",ROOTURL,userid,page,token,sign]);
    [WJFCollection getWithURLString:[NSString stringWithFormat:@"%@/api/order/getOrder?id=%@&page=%@&type=all&token=%@&sign=%@",ROOTURL,userid,page,token,sign] parameters:nil success:^(id responseObject) {
        
        NSLog(@"alll====%@",responseObject);
        if ([responseObject[@"state"] isEqualToString:@"200"]) {
            
            for (NSDictionary *dict in responseObject[@"data"][@"order_list"]) {
                
                ItinerModel  *model = [ItinerModel tgWithDict:dict];
                
                [self.dataArray addObject:model];
                
                
            }
            
            
            [self.itineraryTable.mj_header endRefreshing];
            [self.itineraryTable.mj_footer endRefreshing];
            [self.itineraryTable reloadData];
            
            
        }else if ([responseObject[@"state"] isEqualToString:@"100"]){
            
            if (itpage == 1) {
                NetworkWrongView *netview = [[NetworkWrongView alloc]initWithFrame:CGRectMake(0, 0,self.itineraryTable.frame.size.width,
                                                                                              self.itineraryTable.frame.size.height)];
                
                netview.tupImage.image = [UIImage imageNamed:@"no_order@2x"];
                netview.zhuTitle.text = @"您还没有相关订单";
                
                netview.zhuTitle.textColor = [NSString colorWithHexString:@"#27292b"];
                
                netview.zhuTitle.font = [UIFont systemFontOfSize:14];
                self.itineraryTable.backgroundView = netview;
                self.itineraryTable.separatorStyle = UITableViewCellSeparatorStyleNone;
                
                
                
            }else if (itpage >=1){
                
                [self.itineraryTable.mj_footer endRefreshing];
                // 拿到当前的上拉刷新控件，变为没有更多数据的状态
                [self.itineraryTable.mj_footer endRefreshingWithNoMoreData];
                
            }
            
            
        }else if ([responseObject[@"state"] isEqualToString:@"111"]){
            
            
        }else if ([responseObject[@"state"] isEqualToString:@"201"]){
            
            
        }else if ([responseObject[@"state"] isEqualToString:@"101"]){
            
            
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
        NetworkWrongView *netview = [[NetworkWrongView alloc]initWithFrame:CGRectMake(0,64+44,_itineraryTable.frame.size.width,
                                                                                      _itineraryTable.frame.size.height)];
        
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
        _itineraryTable.backgroundView = netview;
        _itineraryTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }];
    
}
#pragma mark 重新加载数据
-(void)jiazai:(UIButton *)btu{
    
    [self gainHttpData1:@"1"];
    
}



#pragma mark 加密

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


-(NSDictionary *)encryptDict:(NSMutableDictionary *)dict{
    
    
    NSString  *str1  =   [self createMd5Sign:dict];
    
    NSString  *str2  = [self md5:@"miaotaoKJ"];
    
    NSString *sign  = [self md5:[NSString stringWithFormat:@"%@%@",str1,str2]];
    
    NSMutableDictionary  *total = [[NSMutableDictionary alloc]init];
    
    [total addEntriesFromDictionary:dict];
    
    [total setObject:sign forKey:@"sign"];
    
    return (NSDictionary *)total;
}


#define mark uitableviewdelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ItineraryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AllItineraryCell"];
    
    if (!cell) {
        
        cell = [[ItineraryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AllItineraryCell"];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ItinerModel  *model = self.dataArray[indexPath.section];
    
    
    NSMutableAttributedString *str;
    
    NSString *textStr;
    if ([model.status isEqualToString:@"0"]) {
        
        cell.timeFirstView.newsRightLable.text = @"待付意向金";
        
        str  = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"实付款:  ¥%@",[self addSpaceFromSring:model.dingjin]]];
        textStr = [NSString stringWithFormat:@"实付款:¥%@",[self addSpaceFromSring:model.dingjin]];
        [cell.leftBtu setTitle:@"取消订单" forState:UIControlStateNormal];
        [cell.rightBtu setTitle:@"支付" forState:UIControlStateNormal];
        
    }else if ([model.status isEqualToString:@"1"]){
        cell.timeFirstView.newsRightLable.text = @"审核中";
        [cell.rightBtu mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(cell.mas_right).with.offset(-12);
            
            make.width.mas_equalTo(0);
            
            make.height.mas_equalTo(0);
            
        }];
        str  = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"实付款:  ¥%@",[self addSpaceFromSring:model.dingjin]]];
        textStr = [NSString stringWithFormat:@"实付款:¥%@",[self addSpaceFromSring:model.dingjin]];
        [cell.leftBtu setTitle:@"等待审核" forState:UIControlStateNormal];
        cell.leftBtu.userInteractionEnabled = NO;
        
    }else if ([model.status isEqualToString:@"2"]){
        cell.timeFirstView.newsRightLable.text = @"审核失败";
        [cell.rightBtu mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(cell.rightBtu.mas_left).with.offset(-12);
            
            make.width.mas_equalTo(0);
            
            make.height.mas_equalTo(0);
            
        }];
        [cell.leftBtu setTitle:@"正在退款" forState:UIControlStateNormal];
        
        str  = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"实付款:  ¥%@",[self addSpaceFromSring:model.dingjin]]];
        textStr = [NSString stringWithFormat:@"实付款:¥%@",[self addSpaceFromSring:model.dingjin]];
        [cell.leftBtu setTitleColor:[NSString colorWithHexString:@"#a9b086"] forState:UIControlStateNormal];
        cell.leftBtu.userInteractionEnabled = NO;
        
    }else if ([model.status isEqualToString:@"3"]){
        cell.timeFirstView.newsRightLable.text = @"待付款";
        str  = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"实付款:  ¥%@",[self addSpaceFromSring:model.real_price]]];
        textStr = [NSString stringWithFormat:@"实付款:¥%@",[self addSpaceFromSring:model.real_price]];
        [cell.leftBtu setTitle:@"取消订单" forState:UIControlStateNormal];
        [cell.rightBtu setTitle:@"支付" forState:UIControlStateNormal];
        
    }else if ([model.status isEqualToString:@"9"]){
        
        cell.timeFirstView.newsRightLable.text = @"已完成";
        str  = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"实付款:  ¥%@",[self addSpaceFromSring:model.real_price]]];
        textStr = [NSString stringWithFormat:@"实付款:¥%@",[self addSpaceFromSring:model.real_price]];
        [cell.leftBtu setTitle:@"删除订单" forState:UIControlStateNormal];
        
        [cell.rightBtu setTitle:@"评价" forState:UIControlStateNormal];
        //            [cell.rightBtu mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        //                make.right.equalTo(cell.rightBtu.mas_left).with.offset(-12);
        //
        //                make.width.mas_equalTo(0);
        //
        //                make.height.mas_equalTo(0);
        //
        //            }];
        
        // [cell.rightBtu setTitle:@"评价" forState:UIControlStateNormal];
        
        
    }else if ([model.status isEqualToString:@"10"]){
        
        cell.timeFirstView.newsRightLable.text = @"已完成";
        str  = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"实付款:  ¥%@",[self addSpaceFromSring:model.real_price]]];
        textStr = [NSString stringWithFormat:@"实付款:¥%@",[self addSpaceFromSring:model.real_price]];
        [cell.leftBtu setTitle:@"删除订单" forState:UIControlStateNormal];
        
        //[cell.rightBtu setTitle:@"评价订单" forState:UIControlStateNormal];
        [cell.rightBtu mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(cell.rightBtu.mas_left).with.offset(-12);
            
            make.width.mas_equalTo(0);
            
            make.height.mas_equalTo(0);
            
        }];
        
        
        
    }
    
    cell.timeFirstView.newsLeftLable.text = model.date;
    [cell getImageScrView:model.list];
    cell.leftBtu.tag = 600+indexPath.section;
    cell.rightBtu.tag = 700+indexPath.section;
    [cell.leftBtu addTarget:self action:@selector(deleteBtu:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.rightBtu addTarget:self action:@selector(payBtu:) forControlEvents:UIControlEventTouchUpInside];
    
    NSRange range;
    range = [textStr rangeOfString:@"¥"];
    if (range.location != NSNotFound) {
        NSLog(@"found at location = %d, length = %lu",range.location,(unsigned long)range.length);
    }else{
        NSLog(@"Not Found");
    }
    
    [str addAttribute:NSForegroundColorAttributeName value:[NSString colorWithHexString:@"#27292b"] range:NSMakeRange(0,range.location)];
    [str addAttribute:NSForegroundColorAttributeName value:[NSString colorWithHexString:@"e4c675"] range:NSMakeRange(range.location,str.length-range.location)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, range.location)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(range.location,textStr.length-range.location)];
    cell.moneyLable.attributedText = str;
    //cell.moneyLable.text =[NSString stringWithFormat:@"实付款:¥%@",model.dingjin];
    
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return self.dataArray.count;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 192;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 12;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView *view = [[UIView alloc]init];
    
    view.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    
    return view;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


#pragma mark  右侧按钮
-(void)payBtu:(UIButton *)btu{
    
    if([btu.titleLabel.text isEqualToString:@"评价"]){
        
        JudgeViewVC *vc = [[JudgeViewVC alloc]init];
        ItinerModel  *model = self.dataArray[btu.tag-700];
        vc.oid =model.oid;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }else{
        NSLog(@"支付");
        [self pay:btu];
    }
    
    
    
}

#pragma mark 去支付
-(void)pay:(UIButton *)btu{
    
    
    HSPayViewController *pay = [[HSPayViewController alloc]init];
    ItinerModel  *model = self.dataArray[btu.tag-700];
    
    if ([model.status isEqualToString:@"3"]) {
        
        pay.oid = model.repay_id;
    }else{
        pay.oid =    model.oid;
    }
    pay.status = model.status;
    pay.dingjin = model.dingjin;
    pay.totalMoney =model.real_price;
    pay.typeBack = @"ItinerVC";
    [self.navigationController pushViewController:pay animated:YES];
    
}


#pragma mark 左侧按钮
-(void)deleteBtu:(UIButton *)btu{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"您确认取消订单吗?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self deleteDingdan:btu];
        
    }];
    
    [alert addAction:ok];//添加按钮
    
    UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
        
    }];
    
    [alert addAction:quxiao];//添加按钮
    
    //以modal的形式
    [self presentViewController:alert animated:YES completion:^{ }];
    
    NSLog(@"删除订单");
    
    
    
}

#pragma mark 删除订单
-(void)deleteDingdan:(UIButton *)btu{
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSMutableString *userid = [user objectForKey:@"id"];
    NSMutableString *token  = [user objectForKey:@"token"];
    
    ItinerModel  *model = self.dataArray[btu.tag-600];
    NSString *iod =    model.oid;
    
    NSDictionary *dict = @{@"id":userid,@"oid":iod,@"token":token};
    
    NSString *str1 =  [self createMd5Sign:(NSMutableDictionary *)dict];
    
    NSString  *str2 = [self md5:@"miaotaoKJ"];
    
    NSString *sign = [self md5:[NSString stringWithFormat:@"%@%@",str1,str2]];
    
    NSDictionary *para = @{@"id":userid,@"oid":iod,@"token":token,@"sign":sign};
    
    [WJFCollection postWithUrlString:[NSString stringWithFormat:@"%@/api/order/deleteOrder",ROOTURL] Parameter:para success:^(id responseObject) {
        
        //NSLog(@"%@",responseObject);
        if ([responseObject[@"state"] isEqualToString:@"200"]) {
            
            
            [self.dataArray removeObjectAtIndex:btu.tag-600];
            
            [self.itineraryTable reloadData];
            
            
        }else if ([responseObject[@"state"] isEqualToString:@"100"]){
            
            
        }else if ([responseObject[@"state"] isEqualToString:@"101"]){
            
            
        }else if ([responseObject[@"state"] isEqualToString:@"121"]){
            
            
        }else if ([responseObject[@"state"] isEqualToString:@"111"]){
            
            
        }else if ([responseObject[@"state"] isEqualToString:@"210"]){
            
            
            [self.dataArray removeObjectAtIndex:btu.tag-600];
            
            [self.itineraryTable reloadData];
            
            // NSLog(@"%@",responseObject[@"message"]);
            
        }
        
        
    } failure:^(NSError *error) {
        
        
    }];
    
    
    
}

#pragma mark 插入字符串
-(NSMutableString *)addSpaceFromSring:(NSString *)str{
    
    
    // string = [string substringToIndex:7];//去掉下标7之后的字符串
    
    NSString *qianstring;
    NSString *huostring;
    
    if (str.length > 2) {
        
        qianstring = [str substringToIndex:str.length-2];//去掉下标7之后的字符串
        
        //NSLog(@"截取的值为：%@",qianstring);
        
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

#pragma mark 比较时间
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
