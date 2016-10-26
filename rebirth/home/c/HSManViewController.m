//
//  HSManViewController.m
//  rebirth
//
//  Created by 侯帅 on 16/7/25.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSManViewController.h"
#import "HSFHMCell.h"
#import "SDImageCache.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
#import "CCWebViewController.h"
@interface HSManViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation HSManViewController
{
    UITableView *htable;
    NSMutableArray *dataXiaArr;
    CCWebViewController *ccweb;
    NSInteger pagee;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    dataXiaArr = [[NSMutableArray alloc] init];
    _hsmodel = [[HSHomexiaModel alloc] init];
    pagee =1;
    [self httpHomeXia];
    // Do any additional setup after loading the view.
   // [self creatNavi];
    [self creatTab];
    __weak typeof(self)weakSelf = self;
    __weak UITableView *table = htable;
    table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        pagee =1;
        [dataXiaArr removeAllObjects];
        [self httpHomeXia];
    }];
    table.mj_header.automaticallyChangeAlpha = YES;
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [footer setTitle:@"" forState:MJRefreshStateIdle];
        [footer setTitle:@"松开获取更多数据" forState:MJRefreshStateWillRefresh];
        [footer setTitle:@"获取中" forState:MJRefreshStateRefreshing];
        [footer setRefreshingTitleHidden:YES];
        pagee++;
        [self httpHomeXia];
        [table.mj_footer endRefreshing];
    }];
    table.mj_footer = footer;

    
    
}
-(void)backpreviousClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)creatTab{
    htable =[[UITableView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, kScreenWidth, kScreenHeight-NAV_BAR_HEIGHT) style:UITableViewStylePlain];
    htable.delegate =self;
    htable.dataSource = self;
    [self.view addSubview:htable];
    htable.separatorStyle = UITableViewCellSeparatorStyleNone;
    UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backpreviousClick:)];
    rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [htable addGestureRecognizer:rightSwipeGestureRecognizer];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataXiaArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[HSFHMCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }

HSFHMCell *celll = cell;
NSLog(@"%lu12121212",dataXiaArr.count);
if (dataXiaArr.count!=0) {
    
    NSDictionary *dic = dataXiaArr[indexPath.row];
    _hsmodel  = [HSHomexiaModel HSHomeXiaModel:dic];
    [celll setHsmodel:_hsmodel];
    // ******* 动画 效果 ***********
    // 定义 cell 的初始状态
//    celll.alpha = 0.0;
//    celll.layer.transform = CATransform3DMakeTranslation(0, 200, 0);;
//    
//    [UIView animateWithDuration:0.5 animations:^{
//        celll.alpha = 1.0;
//        celll.layer.transform = CATransform3DIdentity;
//    }];
    // ******* 动画 效果 ***********
}



    return cell;
}

-(void)creatNavi{
    UIView *navi = [[UIView alloc] init];
    navi.frame =CGRectMake(0, 0,kScreenWidth , NAV_BAR_HEIGHT);
    navi.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navi];
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(50, kStatusBarHeight, kScreenWidth-100, NAV_BAR_HEIGHT-kStatusBarHeight)];
    titleLbl.textColor = [NSString colorWithHexString:heitizi];
    titleLbl.text = @"对味";
    titleLbl.font = [UIFont systemFontOfSize:16];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    [navi addSubview:titleLbl];
    UIButton *backBtn=  [YkxHttptools initwithButton:[UIColor clearColor] Frame:CGRectMake(0, kStatusBarHeight, 50, NAV_BAR_HEIGHT-kStatusBarHeight) Image:[UIImage imageNamed:@"back_arrow@2x"] Title:nil Titlecolor:[NSString colorWithHexString:heitizi ] Titlefont:[UIFont systemFontOfSize:14] BaseView:navi];
    [backBtn addTarget:self action:@selector(click_back:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)click_back:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)httpHomeXia{
    /*202 对味获取列表
     URL：http://www.rempeach.com/rebirth/api/index/getIndexList
     接口描述：下半部分新闻列表（每次15条数据）
     请求方式：GET
     上传参数：
     id *
     page
     token  *
     sign
     a b c d e f g h i g k l m n o p q r s t u v w x y z
     返回参数：state ：200 111 101 121 状态码（见附录）
     */
   
    
    NSString *idd = [USER_DEFAULT objectForKey:@"id"];
    NSString *page =[NSString stringWithFormat:@"%ld",pagee];
    NSString *token = [USER_DEFAULT objectForKey:@"token"];
   
    if (token.length<6) {
        NSArray *nameList = @[vn(page)];
        NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(page),nil];
       
        NSLog(@"%@",parameters1);
        [YkxHttptools get:@"http://www.rempeach.com/rebirth/api/index/getNewsList" params:parameters1 success:^(id responseObj) {
            NSString *finishStr = [[NSString alloc]initWithData:responseObj encoding:NSUTF8StringEncoding];
            finishStr = [YkxHttptools repTabStr:finishStr];
            NSDictionary *paramDic = [[[SBJsonParser alloc]init] objectWithString:finishStr];
            NSLog(@"%@",paramDic);
            if ([[paramDic objectForKey:@"state"] isEqualToString:@"200"]) {
                NSDictionary   *brr = [paramDic objectForKey:@"data"];
                NSLog(@"-----------------%@---------------",brr);
                NSArray *arr = [brr objectForKey:@"list"];
                [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [dataXiaArr addObject:obj];
                }];
                NSDictionary *dic = arr[0];
                [htable.mj_header endRefreshing];
                
                //  _homexiamodel = [HSHomexiaModel HSHomeXiaModel:dic];
                [htable reloadData];
                
                
            }else if ([[paramDic objectForKey:@"state"] isEqualToString:@"111"]){
                [htable.mj_header endRefreshing];
                
            }else if ([[paramDic objectForKey:@"state"] isEqualToString:@"101"]){
                [htable.mj_header endRefreshing];
                
            }else if([[paramDic objectForKey:@"state"] isEqualToString:@"100"])
            {[htable.mj_footer endRefreshingWithNoMoreData];
                [htable.mj_header endRefreshing];
                
            }else{
                
            }
        } failure:^(NSError *error) {
            [htable.mj_footer endRefreshing];
            [htable.mj_header endRefreshing];
        }];
    }else{
        NSArray *nameList = @[@"id",vn(page),vn(token)];
        NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(idd),sv(page),sv(token),nil];
        NSString *str = sv(idd);
        NSLog(@"%@",parameters1);
        [YkxHttptools get:@"http://www.rempeach.com/rebirth/api/index/getNewsList" params:parameters1 success:^(id responseObj) {
            NSString *finishStr = [[NSString alloc]initWithData:responseObj encoding:NSUTF8StringEncoding];
            finishStr = [YkxHttptools repTabStr:finishStr];
            NSDictionary *paramDic = [[[SBJsonParser alloc]init] objectWithString:finishStr];
            NSLog(@"%@",paramDic);
            if ([[paramDic objectForKey:@"state"] isEqualToString:@"200"]) {
                NSDictionary   *brr = [paramDic objectForKey:@"data"];
                NSLog(@"-----------------%@---------------",brr);
                NSArray *arr = [brr objectForKey:@"list"];
                [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [dataXiaArr addObject:obj];
                }];
                NSDictionary *dic = arr[0];
                
                [htable.mj_header endRefreshing];
                [htable.mj_footer endRefreshing];
                //  _homexiamodel = [HSHomexiaModel HSHomeXiaModel:dic];
                [htable reloadData];
                
                
            }else if ([[paramDic objectForKey:@"state"] isEqualToString:@"111"]){
                [htable.mj_header endRefreshing];
                
            }else if ([[paramDic objectForKey:@"state"] isEqualToString:@"101"]){
                [htable.mj_header endRefreshing];
                
            }else{
                [htable.mj_header endRefreshing];
                
            }
        } failure:^(NSError *error) {
            [htable.mj_header endRefreshing];
            [htable.mj_footer endRefreshing];
        }];
    }
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 182*HEIGHTRATIO;
}
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    
//    CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
//    
//
//    HSFHMCell *celll = [htable dequeueReusableCellWithIdentifier:@"cellID"];
//    if (translation.y>0) {
//       
////        celll.alpha = 0.0;
////        celll.layer.transform = CATransform3DMakeTranslation(0, 200, 0);;
////        
////        [UIView animateWithDuration:0.5 animations:^{
////            celll.alpha = 1.0;
////            celll.layer.transform = CATransform3DIdentity;
////        }];
//
//        
//        
//            }else if(translation.y<0){
//        
//       
//                celll.alpha = 0.0;
//                celll.layer.transform = CATransform3DMakeTranslation(0, 200, 0);;
//                
//                [UIView animateWithDuration:0.5 animations:^{
//                    celll.alpha = 1.0;
//                    celll.layer.transform = CATransform3DIdentity;
//                }];
//                
//
//        
//        
//    }
//    
//}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    static float lastOff =0;
    if (tableView.contentOffset.y > lastOff) {
        
        cell.alpha = 0.0;
        cell.layer.transform = CATransform3DMakeTranslation(0, 200, 0);;
        
        [UIView animateWithDuration:0.5 animations:^{
            cell.alpha = 1.0;
            cell.layer.transform = CATransform3DIdentity;
        }];
        
    } else{
        
        
        
    }
    
    lastOff = tableView.contentOffset.y;
    
    NSLog(@"%ld",(long)lastOff);
   

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = dataXiaArr[indexPath.row];
    
    [CCWebViewController showWithContro:self withUrlStr:[dic objectForKey:@"url"] withTitle:@"对味"];
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
