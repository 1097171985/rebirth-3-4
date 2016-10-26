//
//  DoingItinerVC.m
//  rebirth
//
//  Created by boom on 16/8/18.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "DoingItinerVC.h"
#import "HSLoginViewController.h"
#import "DoingItModel.h"
#import "WJFTimerCell.h"
#import "DaoHangVC.h"


#import "DownPayVC.h"
@interface DoingItinerVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView*  itineraryTable;
     CGFloat _leading;
}
@property(nonatomic,strong)NSMutableArray *doingArray;

//////////////////////////////////////////////////////
@property(nonatomic,strong)UIView *topLine;

@property(nonatomic,strong)UIView  *bottomLine;

@end

static int dongingPage = 1;

@implementation DoingItinerVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
   
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
        
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self gainHttpData2:@"1" withBool:nil];
    [self createTable];
    self.topLine = [[UIView alloc]init];
    
    self.bottomLine = [[UIView alloc]init];
    
    
    [self.view addSubview:self.topLine];
    
    [self.view addSubview:self.bottomLine];
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)createTable{
    
    itineraryTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH,HEIGHT-104) style:UITableViewStylePlain];
    itineraryTable.delegate=self;
    itineraryTable.dataSource=self;
    itineraryTable.separatorStyle = UITableViewCellSeparatorStyleNone;//下划线
    
    itineraryTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    itineraryTable.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    itineraryTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
         dongingPage--;
         if (dongingPage == 0) {
             
             dongingPage = 1;
             
         }
         [weakSelf gainHttpData2:[NSString stringWithFormat:@"%d",dongingPage] withBool:YES];
        
            
            
    }];
    
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
            dongingPage++;
            [weakSelf gainHttpData2:[NSString stringWithFormat:@"%d",dongingPage] withBool:NO];
            
        }];
    // 设置文字
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载中...,请稍后" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"已经加载完毕了" forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:17];
    
    // 设置颜色
    footer.stateLabel.textColor = [UIColor grayColor];
    
    itineraryTable.mj_footer = footer;
    
    [self.view addSubview:itineraryTable];
}



#define mark uitableviewdelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        
        DoingItModel *model = self.doingArray[indexPath.row];
        
        WJFTimerCell *cell = [[WJFTimerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WJFTimerCell" withBeginTime:model.begin];
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;//选中的效果
        cell.timeLabel.text = model.begin;
        
        [cell.neirongImage sd_setImageWithURL:[NSURL URLWithString:model.head_img] placeholderImage:nil];
        cell.title.text = model.title;
        cell.subTitle.text = model.address;
        if ([model.type isEqualToString:@"1"]) {
            cell.mudi.text = @"取车";
            cell.tubiao.image = [UIImage imageNamed:@"trip_car_doing@2x"];
            
        }else if ([model.type isEqualToString:@"5"]){
            
            cell.mudi.text = @"下午茶";
            cell.tubiao.image = [UIImage imageNamed:@"trip_tea_doing@2x"];
            
        }else if ([model.type isEqualToString:@"6"]){
            
            cell.mudi.text = @"午餐";
            cell.tubiao.image = [UIImage imageNamed:@"trip_lunch_doing@2x"];
            
        }else if ([model.type isEqualToString:@"7"]){
            
            cell.mudi.text = @"晚餐";
            cell.tubiao.image = [UIImage imageNamed:@"trip_dinner_doing@2x"];
        }else if ([model.type isEqualToString:@"9"]){
            
            cell.mudi.text = @"酒店";
            cell.tubiao.image = [UIImage imageNamed:@"trip_accommodation_doing@2x"];
        }
   
        [cell.goButton setTitle:@"带我去" forState:UIControlStateNormal];
         cell.goButton.tag = 999+indexPath.row;
        [cell.goButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
        cell.goButton.backgroundColor = [UIColor blackColor];
    
       [cell.goButton addTarget:self action:@selector(gotoTheAddress:) forControlEvents:UIControlEventTouchUpInside];
    
        return  cell;
   
    
}


-(void)gotoTheAddress:(UIButton *)btu{
    
    
    DaoHangVC *vc = [[DaoHangVC alloc]init];
    
    DoingItModel *model = self.doingArray[btu.tag-999];
    vc.coordinate = model.coordinate;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.doingArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 140;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
  
        DaoHangVC *vc = [[DaoHangVC alloc]init];
        
        DoingItModel *model = self.doingArray[indexPath.row];
        vc.coordinate = model.coordinate;

//     DownPayVC *vc =[[DownPayVC alloc]init];
       [self.navigationController pushViewController:vc animated:YES];
    
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WJFTimerCell *timeCell = (WJFTimerCell *)cell;
        
    self.topLine.backgroundColor = [UIColor grayColor];
        
    self.bottomLine.backgroundColor =  [UIColor grayColor];
        
    _leading = [timeCell convertPoint:timeCell.shuxian.frame.origin fromView:self.view].x;
        
    [self scrollViewDidScroll:tableView];
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    NSLog(@"%@",scrollView);
    if (scrollView.contentOffset.y<0) {
        
      
        self.topLine.frame = CGRectMake(_leading,scrollView.contentOffset.y,1,fabs(scrollView.contentOffset.y));
        NSLog(@"%f",fabs(scrollView.contentOffset.y));
    }
   
        
    CGFloat yOffset = scrollView.frame.size.height - scrollView.contentSize.height+scrollView.contentOffset.y;
        
    self.bottomLine.frame = CGRectMake(_leading, self.view.frame.size.height-yOffset,1,self.view.frame.size.height);
        
  
    NSLog(@"%@",scrollView);
    
}



#pragma mark doning
-(void)gainHttpData2:(NSString *)page  withBool:(BOOL)upDown{
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSMutableString *userid = [user objectForKey:@"id"];
    NSMutableString *token  = [user objectForKey:@"token"];
    // 2==faa0688d0c2d8f8c224fed0ecd95ab29
    NSLog(@"%@",userid);

    NSDictionary *dict = @{@"id":userid,@"page":page,@"type":@"doing",@"token":token};
    
    NSString *str1 =  [self createMd5Sign:(NSMutableDictionary *)dict];
    
    NSString  *str2 = [self md5:@"miaotaoKJ"];
    
    NSString *sign = [self md5:[NSString stringWithFormat:@"%@%@",str1,str2]];
    
    NSLog(@"////////////%@",[NSString stringWithFormat:@"%@/api/order/getOrder?id=%@&type=doing&token=%@&sign=%@&page=%@",ROOTURL,userid,token,sign,page]);
    
    [WJFCollection getWithURLString:[NSString stringWithFormat:@"%@/api/order/getOrder?id=%@&type=doing&token=%@&sign=%@&page=%@",ROOTURL,userid,token,sign,page] parameters:nil success:^(id responseObject) {
        
        NSLog(@"%@===%@",responseObject,responseObject[@"tip"]);
        if ([responseObject[@"state"] isEqualToString:@"200"]) {
            
            self.doingArray = [NSMutableArray array];
            for (NSDictionary *dict in responseObject[@"data"][@"list"]) {
                
                DoingItModel  *model = [DoingItModel tgWithDict:dict];
                
                [self.doingArray addObject:model];
                
            }
            
            if (upDown == YES) {
                if ([page isEqualToString:@"1"]) {
                    
                    [itineraryTable reloadData];
                    
                    
                }else{
                    [UIView transitionWithView: itineraryTable
                                                  duration: 0.35f
                                                   options: nil
                                                animations: ^(void)
                                 {
                
                                     CATransition *transition = [CATransition animation];
                                     transition.type = kCATransitionPush;
                                     transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                                     transition.fillMode = kCAFillModeForwards;
                                     transition.duration = 0.5;
                                     transition.subtype = kCATransitionFromBottom;
                                     [[itineraryTable layer] addAnimation:transition forKey:@"UITableViewReloadDataAnimationKey"];
                                     [itineraryTable reloadData];
                                 }completion: ^(BOOL isFinished)
                                 {
                                     /* TODO: Whatever you want here */
                                 }];
                }
                
            }else if (upDown == NO){
                
                [UIView transitionWithView: itineraryTable
                                  duration: 0.35f
                                   options: nil
                                animations: ^(void)
                 {
                     
                     CATransition *transition = [CATransition animation];
                     transition.type = kCATransitionPush;
                     transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                     transition.fillMode = kCAFillModeForwards;
                     transition.duration = 0.5;
                     transition.subtype = kCATransitionFromTop;
                     [[itineraryTable layer] addAnimation:transition forKey:@"UITableViewReloadDataAnimationKey"];
                     [itineraryTable reloadData];
                 }completion: ^(BOOL isFinished)
                 {
                     /* TODO: Whatever you want here */
                 }];
                
                
            }else{
                
                [itineraryTable reloadData];
                
            }
            
            [itineraryTable.mj_footer endRefreshing];
            [itineraryTable.mj_header endRefreshing];
            
            
            
            
        }else if ([responseObject[@"state"] isEqualToString:@"100"]){
            if (dongingPage == 1) {
                
                NetworkWrongView *netview = [[NetworkWrongView alloc]initWithFrame:CGRectMake(0,64+44,itineraryTable.frame.size.width,
        itineraryTable.frame.size.height)];
                
                netview.tupImage.image = [UIImage imageNamed:@"no_trip@2x"];
                
                netview.zhuTitle.text = @"您还没有相关行程";
                
                netview.zhuTitle.textColor = [NSString colorWithHexString:@"#27292b"];
                
                netview.zhuTitle.font = [UIFont systemFontOfSize:14];
                
                itineraryTable.backgroundView = netview;
                itineraryTable.separatorStyle = UITableViewCellSeparatorStyleNone;
            }else if (dongingPage >=1){
                
                [itineraryTable.mj_footer endRefreshing];
                // 拿到当前的上拉刷新控件，变为没有更多数据的状态
                [itineraryTable.mj_footer endRefreshingWithNoMoreData];
                
            }
            
            
            
        }else if ([responseObject[@"state"] isEqualToString:@"111"]){
            
            
        }else if ([responseObject[@"state"] isEqualToString:@"201"]){
            
            
        }else if ([responseObject[@"state"] isEqualToString:@"101"]){
            
            NSLog(@"%@",responseObject[@"tip"]);
            
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
        NetworkWrongView *netview = [[NetworkWrongView alloc]initWithFrame:CGRectMake(0,64+44,itineraryTable.frame.size.width,
                                                                                      itineraryTable.frame.size.height)];
        
        netview.tupImage.image = [UIImage imageNamed:@"sorry@2x"];
        
        netview.zhuTitle.text = @"数据加载失败";
        
        netview.zhuTitle.textColor = [NSString colorWithHexString:@"#27292b"];
        
        netview.zhuTitle.font = [UIFont systemFontOfSize:14];
        
        
        netview.subTitle.text = @"请检查你的手机是否联网";
        
        netview.subTitle.textColor = [NSString colorWithHexString:@"#6d7278"];
        
        netview.subTitle.font = [UIFont systemFontOfSize:14];
        
        
        [netview.sureBtu setTitle:@"重新加载" forState:UIControlStateNormal];
        
        netview.sureBtu.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [netview.sureBtu setTitleColor:[NSString colorWithHexString:@"27292b"] forState:UIControlStateNormal];
        [netview.sureBtu setBackgroundColor:[UIColor whiteColor]];
        
        netview.sureBtu.layer.masksToBounds = YES;
        
        netview.sureBtu.layer.cornerRadius =  2;
        netview.sureBtu.layer.borderWidth = 0.5;
        
        netview.sureBtu.layer.borderColor = [NSString colorWithHexString:@"#27292b"].CGColor;
        
        
        [netview.sureBtu addTarget:self action:@selector(jiazai:) forControlEvents:UIControlEventTouchUpInside];
        itineraryTable.backgroundView = netview;
        itineraryTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
    }];
    
    
}
#pragma mark 重新加载数据
-(void)jiazai:(UIButton *)btu{
    
    [self gainHttpData2:@"1" withBool:nil];
    
    
    
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
    
    
    NSString *str1  =   [self createMd5Sign:dict];
    
    NSString  *str2 = [self md5:@"miaotaoKJ"];
    
    
    NSString *sign  = [self md5:[NSString stringWithFormat:@"%@%@",str1,str2]];
    
    NSMutableDictionary  *total = [[NSMutableDictionary alloc]init];
    
    [total addEntriesFromDictionary:dict];
    
    [total setObject:sign forKey:@"sign"];
    
    return (NSDictionary *)total;
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
