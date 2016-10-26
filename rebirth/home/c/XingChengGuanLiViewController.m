//
//  XingChengGuanLiViewController.m
//  rebirth
//
//  Created by 侯帅 on 16/10/20.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "XingChengGuanLiViewController.h"
#import "XingChengGuanLiCell.h"
@interface XingChengGuanLiViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong)NSMutableArray *data;
@end

@implementation XingChengGuanLiViewController
{
    UITableView *htable;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    
    [self loadData];
  //  self.view.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    [self creatNavi];
    [self creatTable];
    // Do any additional setup after loading the view.
}

-(void)loadData{
    self.data = [NSMutableArray array];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if ([[user objectForKey:@"car"] isEqualToString:@"car"]) {
    
        NSDictionary *carDict = [user objectForKey:@"carNeirong"];
       
        [self.data addObject:carDict];

    
    }
    
    
    if ( [user objectForKey:@"foodArray"]) {
        
        for (NSDictionary *dict in  [user objectForKey:@"foodArray"]) {
            
            [self.data addObject:dict];
        }
        
    }
    
    if ([[user objectForKey:@"hotel"] isEqualToString:@"hotel"]) {
        
        NSDictionary *hotelDict = [user objectForKey:@"hotelNeirong"];

        [self.data addObject:hotelDict];
    }
    
}

-(void)creatTable{
    htable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, kScreenWidth, kScreenHeight-NAV_BAR_HEIGHT) style:UITableViewStylePlain];
    htable.delegate = self;
    htable.dataSource = self;
    [self.view addSubview:htable];
    htable.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
      htable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
-(void)creatNavi{
    UIView *navi = [[UIView alloc] init];
    navi.frame =CGRectMake(0, 0,kScreenWidth , NAV_BAR_HEIGHT);
    navi.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navi];
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(50, kStatusBarHeight, kScreenWidth-100, NAV_BAR_HEIGHT-kStatusBarHeight)];
    titleLbl.textColor = [NSString colorWithHexString:heitizi];
    titleLbl.text = @"行程管理";
    titleLbl.font = [UIFont systemFontOfSize:16];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    [navi addSubview:titleLbl];
    UIView *line = [[UIView alloc] init];
    line.frame =CGRectMake(0, NAV_BAR_HEIGHT-1, kScreenWidth, 0.5);
    line.backgroundColor = [NSString colorWithHexString:@"e5e5e5"];
    [navi addSubview:line];
    UIButton *backBtn=  [YkxHttptools initwithButton:[UIColor clearColor] Frame:CGRectMake(0, kStatusBarHeight, 50, NAV_BAR_HEIGHT-kStatusBarHeight) Image:[UIImage imageNamed:@"back_arrow@2x"] Title:nil Titlecolor:[NSString colorWithHexString:heitizi ] Titlefont:[UIFont systemFontOfSize:14] BaseView:navi];
    [backBtn addTarget:self action:@selector(click_back:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellid";
    XingChengGuanLiCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
       cell = [[XingChengGuanLiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    NSDictionary *dict = self.data[indexPath.row];
    cell.namelabel.text = dict[@"title"];
    
    cell.weizhiLabel.text = dict[@"address"];
    
    cell.timelabel.text = dict[@"qucheTime"];
    [cell.leftIMG sd_setImageWithURL:[NSURL URLWithString:dict[@"image"]] placeholderImage:[UIImage imageNamed:@"default_img_zhengfang"]] ;
    
    [cell.deleteBtn addTarget:self action:@selector(click_delete:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.deleteBtn.tag = 1234+indexPath.row;
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    return cell;
    
}

//删除
-(void)click_delete:(UIButton *)btu{
    
     NSDictionary *dict = self.data[btu.tag -1234];
    
    if ([dict[@"stype"] isEqualToString:@"hotel"]) {
        
        [USER_DEFAULT setObject:@"" forKey:@"hotel"];
        
        [USER_DEFAULT setObject:@"" forKey:@"hotelNeirong"];

        
    }else if ([dict[@"stype"] isEqualToString:@"car"]){
        
        [USER_DEFAULT setObject:@"" forKey:@"car"];
        
        [USER_DEFAULT setObject:@"" forKey:@"carNeirong"];
        
        
    }else{
        NSMutableArray *arr = [NSMutableArray arrayWithArray:[USER_DEFAULT objectForKey:@"foodArray"]];

        
        if ([[USER_DEFAULT objectForKey:@"car"] isEqualToString:@"car"]) {
            
            
            [arr removeObjectAtIndex:btu.tag-1234-1];
            
        }else{
            
             [arr removeObjectAtIndex:btu.tag-1234];
        }
        
        if (arr.count ==0) {
            [USER_DEFAULT removeObjectForKey:@"foodArray"];
        }else{
            [USER_DEFAULT setObject:arr forKey:@"foodArray"];
        }
        
        
    }
    
    [self.data removeObjectAtIndex:btu.tag-1234];
    
    [htable reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (90+256)/2;
}
-(void)click_back:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
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
