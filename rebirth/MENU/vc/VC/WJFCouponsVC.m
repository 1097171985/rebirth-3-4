//
//  WJFCouponsVC.m
//  rebirth
//
//  Created by WJF on 16/9/28.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "WJFCouponsVC.h"
#import "CouponsCell.h"
#import "LastTableCell.h"
#import "HistoryCoupVC.h"
@interface WJFCouponsVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong)UITableView *couposTableView;

@property(nonatomic, strong)NSMutableArray *couposData;

@property(nonatomic, assign)int  page;

@property(nonatomic, assign)BOOL history;

@end


@implementation WJFCouponsVC

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    self.couposData = [NSMutableArray array];
    self.history = YES;
    self.view.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    self.page = 1;
    
    self.menuView.text = @"优惠劵";
    [self loadData:@"1"];
    [self loadCouposTableView];
    
}

-(void)loadData:(NSString *)page{
    
    NSLog(@"%d",self.page);
    NSDictionary *dict = @{@"id":[USER_DEFAULT objectForKey:@"id"],@"route":@"Coupon_couponList",@"version":@"1",@"page":page,@"type":@"0",@"token":[USER_DEFAULT objectForKey:@"token"]};
    
    NSDictionary *signDict = [self encryptDict:(NSMutableDictionary *)dict];
    [WJFCollection getWithURLString:@"http://www.rempeach.com/rebirth/api/AppApi/receive" parameters:signDict success:^(id responseObject) {
        
        NSLog(@"%@===%@",responseObject,responseObject[@"tip"]);
       
        
        if ([responseObject[@"state"] isEqualToString:@"200"]) {
            
            
            [self.couposData addObjectsFromArray:responseObject[@"data"][@"list"]];
            
            [self.couposTableView reloadData];
            [self.couposTableView.mj_footer endRefreshing];
            [self.couposTableView.mj_header endRefreshing];
        }else if ([responseObject[@"state"] isEqualToString:@"201"]){
            
            self.history  = NO;
            [self.couposTableView reloadData];
            [self.couposTableView.mj_footer endRefreshing];
            [self.couposTableView.mj_header endRefreshing];
            
            
        }else if ([responseObject[@"state"] isEqualToString:@"100"]){
            
            self.history  = NO;
            [self.couposTableView reloadData];
            [self.couposTableView.mj_footer endRefreshing];
            [self.couposTableView.mj_header endRefreshing];
        
        }
        
        
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
        
    }];
    
    
    
}

-(void)loadCouposTableView{
    
    self.couposTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
    
    self.couposTableView.delegate = self;
    
    self.couposTableView.dataSource = self;
    
    self.couposTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.couposTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        if (self.page == 0) {
            
            self.page = 1;
            
        }
        self.couposData = [NSMutableArray array];
        [weakSelf loadData:[NSString stringWithFormat:@"%d",self.page]];
        
        
    }];
    
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.page++;
        [weakSelf loadData:[NSString stringWithFormat:@"%d",self.page]];
        
    }];
    // 设置文字
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载中...,请稍后" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"已经加载完毕了" forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:17];
    
    // 设置颜色
    footer.stateLabel.textColor = [UIColor grayColor];
    
     self.couposTableView.mj_footer = footer;
    
    [self.view addSubview:self.couposTableView];
    
    
}


#pragma mark UITableView的协议

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_history == NO) {
        
   
    if (indexPath.row == self.couposData.count) {
        
        LastTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LastTableCell"];
        if (!cell) {
            
            cell = [[LastTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LastTableCell"];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.coupBtu addTarget:self action:@selector(coupBtu:) forControlEvents:UIControlEventTouchUpInside];

        return cell;
        
    }else{
       CouponsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CouponsCell"];
       if (!cell) {
        
          cell = [[CouponsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CouponsCell"];
        
       }
    
        cell.moneyLabel.text = self.couposData[indexPath.row][@"title"];
        cell.mudiLabel.text = self.couposData[indexPath.row][@"source_title"];
        NSArray *creatArr = [self.couposData[indexPath.row][@"created_date"] componentsSeparatedByString:@" "];
        
        NSString *creatStr = [creatArr[0] stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        NSArray *expireArr = [self.couposData[indexPath.row][@"expire_date"] componentsSeparatedByString:@" "];
        NSString *expireStr = [expireArr[0] stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        cell.youxiaoLabel.text = [NSString stringWithFormat:@"有效期：%@-%@",creatStr,expireStr];
       cell.zhangImage.hidden= YES;
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
       return cell;
    }}else{
        
        CouponsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CouponsCell"];
        if (!cell) {
            
            cell = [[CouponsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CouponsCell"];
            
        }
        
        cell.moneyLabel.text = self.couposData[indexPath.row][@"title"];
        cell.mudiLabel.text = self.couposData[indexPath.row][@"source_title"];
        NSArray *creatArr = [self.couposData[indexPath.row][@"created_date"] componentsSeparatedByString:@" "];
        
        NSString *creatStr = [creatArr[0] stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        NSArray *expireArr = [self.couposData[indexPath.row][@"expire_date"] componentsSeparatedByString:@" "];
        NSString *expireStr = [expireArr[0] stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        cell.youxiaoLabel.text = [NSString stringWithFormat:@"有效期：%@-%@",creatStr,expireStr];
        cell.zhangImage.hidden= YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return  nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == self.couposData.count) {
        
        return  60;
    }
       return (272/2+12)*HEIGHTRATIO;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_history == NO) {
        
        return self.couposData.count+1;
    }
    return self.couposData.count;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

-(void)coupBtu:(UIButton *)btu{
    
    //NSLog(@"33333");
    HistoryCoupVC  *vc = [[HistoryCoupVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
