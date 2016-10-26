//
//  HSServiceViewController.m
//  rebirth
//
//  Created by 侯帅 on 16/7/26.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSServiceViewController.h"
#import "HSDelegateViewController.h"
#import "HSBXTKViewController.h"
#import "HSYSZCViewController.h"
#import "CCWebViewController.h"
@interface HSServiceViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation HSServiceViewController
{
    NSMutableArray *_dataArr;
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
    [self.navigationController setNavigationBarHidden:YES];
    [self creatNavi];
    
    _dataArr = [[NSMutableArray alloc] initWithObjects:@"平台规则",@"保险条款",@"隐私政策", nil];
    [self creatTab];
    // Do any additional setup after loading the view.
}
-(void)creatTab{
    UITableView *htable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, kScreenWidth, kScreenHeight-NAV_BAR_HEIGHT) style:UITableViewStylePlain];
    htable.delegate = self;
    htable.dataSource = self;
    [self.view addSubview:htable];
    
    
    UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backpreviousClick:)];
    rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGestureRecognizer];
    htable.scrollEnabled = NO;
    //线
    htable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
-(void)backpreviousClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _dataArr[indexPath.row];
    cell.textLabel.textColor = [NSString colorWithHexString:heitizi];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    UIView *line = [[UIView alloc] init];
    line.frame =CGRectMake(0, 40, kScreenWidth, 0.5);
    line.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    [cell addSubview:line];
    return cell;
}
-(void)creatNavi{
    UIView *navi = [[UIView alloc] init];
    navi.frame =CGRectMake(0, 0,kScreenWidth , NAV_BAR_HEIGHT);
    navi.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navi];
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(50, kStatusBarHeight, kScreenWidth-100, NAV_BAR_HEIGHT-kStatusBarHeight)];
    titleLbl.textColor = [NSString colorWithHexString:heitizi];
    titleLbl.text = @"关于UP！";
    titleLbl.font = [UIFont systemFontOfSize:16];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    [navi addSubview:titleLbl];
    UIButton *backBtn=  [YkxHttptools initwithButton:[UIColor clearColor] Frame:CGRectMake(0, kStatusBarHeight, 50, NAV_BAR_HEIGHT-kStatusBarHeight) Image:[UIImage imageNamed:@"back_arrow@2x"] Title:nil Titlecolor:[NSString colorWithHexString:heitizi ] Titlefont:[UIFont systemFontOfSize:14] BaseView:navi];
    [backBtn addTarget:self action:@selector(click_back:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
       
        [self.navigationController pushViewController:[[HSDelegateViewController alloc] init] animated:YES];
    }else if (indexPath.row ==1){
        [self.navigationController pushViewController:[[HSBXTKViewController alloc] init] animated:YES];
        
    }else if (indexPath.row ==2){
        [self.navigationController pushViewController:[[HSYSZCViewController alloc]  init] animated:YES];
    }
}
-(void)click_back:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
