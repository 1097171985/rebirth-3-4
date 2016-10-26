//
//  HistoryCoupVC.m
//  rebirth
//
//  Created by WJF on 16/9/29.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HistoryCoupVC.h"
#import "CouponsCell.h"
@interface HistoryCoupVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong)UITableView *couposTableView;

@property(nonatomic, strong)NSMutableArray *historyCouposArr;

@end

@implementation HistoryCoupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    [self loadData];
    self.menuView.text = @"历史优惠劵";
    [self loadCouposTableView];
    // Do any additional setup after loading the view.
}
-(void)loadData{
    
    self.historyCouposArr = [NSMutableArray array];
    NSDictionary *dict = @{@"id":[USER_DEFAULT objectForKey:@"id"],@"route":@"Coupon_couponList",@"version":@"1",@"page":@"1",@"type":@"1",@"token":[USER_DEFAULT objectForKey:@"token"]};
    
    NSDictionary *signDict = [self encryptDict:(NSMutableDictionary *)dict];
    [WJFCollection getWithURLString:@"http://www.rempeach.com/rebirth/api/AppApi/receive" parameters:signDict success:^(id responseObject) {
        
        NSLog(@"%@===%@",responseObject,responseObject[@"tip"]);
        if ([responseObject[@"state"] isEqualToString:@"200"]) {
            self.historyCouposArr = responseObject[@"data"][@"list"];
            
            [self.couposTableView reloadData];
            
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
    
    [self.view addSubview:self.couposTableView];
    
    
}


#pragma mark UITableView的协议

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        CouponsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CouponsCell"];
        if (!cell) {
            
            cell = [[CouponsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CouponsCell"];
            
        }
    
     cell.moneyLabel.text = self.historyCouposArr[indexPath.row][@"title"];
     cell.mudiLabel.text = self.historyCouposArr[indexPath.row][@"source_title"];
     NSArray *creatArr = [self.historyCouposArr[indexPath.row] [@"created_date"] componentsSeparatedByString:@" "];
    
     NSString *creatStr = [creatArr[0] stringByReplacingOccurrencesOfString:@"-" withString:@"."];
     NSArray *expireArr = [self.historyCouposArr[indexPath.row][@"expire_date"] componentsSeparatedByString:@" "];
     NSString *expireStr = [expireArr[0] stringByReplacingOccurrencesOfString:@"-" withString:@"."];
     cell.youxiaoLabel.text = [NSString stringWithFormat:@"有效期：%@-%@",creatStr,expireStr];
    if ([self.historyCouposArr[indexPath.row] [@"type"] isEqualToString:@"0"]) {
        //未使用
        cell.zhangImage.image = [UIImage imageNamed:@"past_due"];
    }else{
        //使用
        cell.zhangImage.image = [UIImage imageNamed:@"used"];

    }
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
      cell.textView1.backgroundColor = [NSString colorWithHexString:@"cdced0"];
      cell.moneyLabel.textColor = [NSString colorWithHexString:@"cdced0"];
      cell.mudiLabel.textColor = [NSString colorWithHexString:@"cdced0"];
     cell.youxiaoLabel.textColor = [NSString colorWithHexString:@"cdced0"];
      cell.juanImage.hidden = YES;
      return cell;
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return (272/2+12)*HEIGHTRATIO;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.historyCouposArr.count;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}


-(void)coupBtu:(UIButton *)btu{
    
    NSLog(@"33333");
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
