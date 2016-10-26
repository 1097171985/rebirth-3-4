//
//  HSHelpViewController.m
//  rebirth
//
//  Created by 侯帅 on 16/7/19.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSHelpViewController.h"
#import "HSZCZNViewController.h"
#import "WanZhuanVC.h"
@interface HSHelpViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation HSHelpViewController
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
-(void)creatNavi{
    //底层view
    
    UIView *navi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,NAV_BAR_HEIGHT)];
    navi.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navi];
    
    UILabel *titlelbl = [[UILabel alloc] init];
    UIButton *returnbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnbtn.frame = CGRectMake(8, kStatusBarHeight+5, 56/2, 56/2);
    [returnbtn setImage:[UIImage imageNamed:@"back_arrow@2x"] forState:UIControlStateNormal];
    [returnbtn addTarget:self action:@selector(click_back:) forControlEvents:UIControlEventTouchUpInside];
    [navi addSubview:returnbtn];
    
    titlelbl.frame = CGRectMake(12+returnbtn.frame.size.width, kStatusBarHeight, kScreenWidth-12-returnbtn.frame.size.width-12-returnbtn.frame.size.width, NAV_BAR_HEIGHT-kStatusBarHeight);
    titlelbl.text = @"帮助";
    titlelbl.font = [UIFont systemFontOfSize:38/2];
    titlelbl.textAlignment = NSTextAlignmentCenter;
    [navi addSubview:titlelbl];
    
}
-(void)click_back:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor  = [NSString colorWithHexString:shitudise];
    [self creatNavi];
    [self creatTab];
    // Do any additional setup after loading the view.
}
-(void)creatTab{
    UITableView *Htable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT+12, kScreenWidth, kScreenHeight-NAV_BAR_HEIGHT) style:UITableViewStylePlain];
    Htable.delegate =self;
    Htable.dataSource = self;
    [self.view addSubview:Htable];
    Htable.scrollEnabled = NO;
    Htable.separatorStyle = UITableViewCellSeparatorStyleNone;
    UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backpreviousClick:)];
    rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [Htable addGestureRecognizer:rightSwipeGestureRecognizer];

    _dataArr = [[NSMutableArray alloc]initWithObjects:@"租车流程",@"新手须知",@"版本", nil];
    
}
-(void)backpreviousClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1
    ;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.row==2) {
        UILabel *lbl = [[UILabel alloc] init];
        lbl.frame =CGRectMake(kScreenWidth-50, 10, 50, 14);
        lbl.text = @"2.0.0";
        lbl.textAlignment = NSTextAlignmentLeft;
        lbl.textColor = [NSString colorWithHexString:@"7a7e83"];
        lbl.font = [UIFont systemFontOfSize:14];
        [cell addSubview:lbl];
        
        
        
    }else{
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _dataArr[indexPath.row];
    cell.textLabel.textColor = [NSString colorWithHexString:heitizi];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    UIView *line = [[UIView alloc] init];
    line.frame =CGRectMake(0, 40, kScreenWidth, 0.5);
    line.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    [cell addSubview:line];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row ==0) {
        WanZhuanVC *wan = [[WanZhuanVC alloc] init];
        [self.navigationController pushViewController:wan animated:YES];
        
    }else if (indexPath.row ==1){
        [self.navigationController pushViewController:[[HSZCZNViewController alloc] init] animated:YES];
        
    }else if (indexPath.row==2){
        
    }
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
