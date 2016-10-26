//
//  HSBindingViewController.m
//  rebirth
//
//  Created by 侯帅 on 16/7/19.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSBindingViewController.h"
#import "HSSesameViewController.h"
#import "CustomIOSAlertView.h"
#import "HSUploadJiazhaoViewController.h"
#import "HSLoginViewController.h"
#import "HSBindingJiazhaoViewController.h"
#import "HSSesameXinxiViewController.h"
#import "HSSesameViewController.h"
@interface HSBindingViewController ()<CustomIOSAlertViewDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation HSBindingViewController
{
    NSMutableArray *_dataArr;
    NSString *phonestr;
    UILabel *lbl;
    UITableView *Htable;
    UITextField *phonetext;
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    [self http];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    self.navigationController.navigationBarHidden = YES;
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
    titlelbl.text = @"绑定";
    titlelbl.font = [UIFont systemFontOfSize:38/2];
    titlelbl.textAlignment = NSTextAlignmentCenter;
    [navi addSubview:titlelbl];
    
}
-(void)click_back:(UIButton *)sender{
   
        
        if ([self.stype isEqualToString:@"login"]) {
            
            NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
            for (UIViewController *vc in marr) {
                if ([vc isKindOfClass:[HSLoginViewController class]]) {
                    [marr removeObject:vc];
                    break;
                }
            }
            self.navigationController.viewControllers = marr;
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    //self.navigationController.navigationBarHidden = NO;
    self.title = @"绑定芝麻信用";
    
    self.view.backgroundColor  = [NSString colorWithHexString:shitudise];
    [self creatNavi];
    [self creatTab];
   
    // Do any additional setup after loading the view.
}
-(void)http{
    /*403 获取紧急联系人电话
     URL：http://www.rempeach.com/rebirth/api/user/getEmergencyContact
     接口描述：获取紧急联系人的联系方式
     请求方式：GET
     上传参数：
     id
     round
     token
     sign
     
     
     特殊返回状态码
     a b c d e f g h i g k l m n o p q r s t u v w x y z
     
     返回参数：state ：200 100 111 101 121 状态码（见附录） 
*/
    NSString *transformId = [USER_DEFAULT objectForKey:@"id"];
    NSString *round = @"12345";
    NSString *token = [USER_DEFAULT objectForKey:@"token"];
    NSArray *nameList = @[@"id",vn(round),vn(token)];
    
    NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(transformId),sv(round),sv(token),nil];
    NSLog(@"%@",parameters1);
    NSString *str = sv(transformId);
    [YkxHttptools get:huoqulianxiren params:parameters1 success:^(id responseObj) {
        NSString *finishStr = [[NSString alloc]initWithData:responseObj encoding:NSUTF8StringEncoding];
        finishStr = [YkxHttptools repTabStr:finishStr];
        NSDictionary *paramDic = [[[SBJsonParser alloc]init] objectWithString:finishStr];
        NSLog(@"%@",paramDic);
        if ([[paramDic objectForKey:@"state"] isEqualToString:@"200"]) {
            NSDictionary *dic = [paramDic objectForKey:@"data"];
            phonestr = [dic objectForKey:@"phone"];
           [Htable reloadData];
        }
    } failure:^(NSError *error){
        
    }];
}
-(void)backpreviousClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)creatTab{
   Htable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT+12, kScreenWidth, kScreenHeight-NAV_BAR_HEIGHT) style:UITableViewStylePlain];
    Htable.delegate =self;
    Htable.dataSource = self;
    [self.view addSubview:Htable];
   
    Htable.scrollEnabled = NO;
    Htable.separatorStyle = UITableViewCellSeparatorStyleNone;
    UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backpreviousClick:)];
    rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [Htable addGestureRecognizer:rightSwipeGestureRecognizer];

    _dataArr = [[NSMutableArray alloc]initWithObjects:@"紧急联系人",@"绑定芝麻分",@"绑定驾驶证", nil];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
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
    if (indexPath.row==0) {
        if (!lbl) {
       lbl = [[UILabel alloc]init];
    }
        lbl.frame =CGRectMake(kScreenWidth-105, 14, 95, 14);
        lbl.textAlignment = NSTextAlignmentCenter;
        if (phonestr.length>10) {
            lbl.text = phonestr;
        }else{
            lbl.text = @"无";
        }
       // lbl.text = phonestr;
        lbl.font = [UIFont systemFontOfSize:14];
        lbl.textColor = [NSString colorWithHexString:@"#7a7e83"];
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
    switch (indexPath.row) {
        case 0:{
            CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
            //        alertView.layer.borderWidth = 0;
            
            
            alertView.backgroundColor = [NSString colorWithHexString:heitizi];
            // Add some custom content to the alert view
            [alertView setContainerView:[self createDemoView:@""]];
            
            // Modify the parameters
            [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"取消", @"确定", nil]];
            [alertView setDelegate:self];
            
            // You may use a Block, rather than a delegate.
            [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
                NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
                if (buttonIndex == 1) {
                    
                    [self httpSettingPhoneNum];
                    
                }
                [alertView close];
            }];
            
            [alertView setUseMotionEffects:true];
            
            // And launch the dialog
            [alertView show];

        }
            
            break;
        case 1:{
            //绑定信用分
//            HSSesameViewController *sesame = [[HSSesameViewController alloc] init];
//            [self.navigationController pushViewController:sesame animated:YES];
            
//
            [self httphuoquzhimafen];
                  }
            break;
        case 2:{
            //上传驾照
            [self httphuoqu];
            
//            
//            HSUploadJiazhaoViewController *upload = [[HSUploadJiazhaoViewController alloc] init];
//            [self.navigationController pushViewController:upload animated:YES];
            
                  }
        default:
            break;
    }
}
-(void)httpSettingPhoneNum{
    /*404 设置紧急联系人电话
     URL：http://www.rempeach.com/rebirth/api/user/setEmergencyContact
     接口描述：获取紧急联系人的联系方式
     请求方式：POST
     上传参数：
     
     
     
     返回参数：state ：210 111 101 121 状态码（见附录）
*/
    NSString *transformId = [USER_DEFAULT objectForKey:@"id"];
   NSString *phone = phonetext.text;
    NSString *token = [USER_DEFAULT objectForKey:@"token"];
    NSArray *nameList = @[@"id",vn(phone),vn(token)];
    
    NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(transformId),sv(phone),sv(token),nil];
    NSLog(@"%@",parameters1);
    NSString *str = sv(transformId);
    [YkxHttptools post:settingPhoneNum params:parameters1 success:^(id responseObj) {
        [Common tipAlert:[responseObj objectForKey:@"message"]];
        if ([[responseObj objectForKey:@"state"] isEqualToString:@"210"]) {
            [self http];
          //  [Htable reloadData];
        }
        
    } failure:^(NSError *error) {
        
    }];
}
- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    [alertView close];
}
- (UIView *)createDemoView:(NSString *)string
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 570/2, 151)];
   // demoView.backgroundColor = [NSString colorWithHexString:viewLightBcgColor];
//    demoView.layer.cornerRadius = 5;
//    demoView.layer.masksToBounds = YES;
    //头
    UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 570/2, 40)];
    titleLb.backgroundColor = [UIColor whiteColor];
    titleLb.text =@"修改紧急联系人";
    titleLb.font = [UIFont systemFontOfSize:16];
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.textColor = [NSString colorWithHexString:heitizi];
    [demoView addSubview:titleLb];
    UIView *line = [[UIView alloc] init];
    line.frame =CGRectMake(0, 40, 570/2, 0.5);
    line.backgroundColor = [UIColor grayColor];
    [demoView addSubview:line];
   
    phonetext = [[UITextField alloc] init];
    phonetext.frame =CGRectMake(80, 100, 160, 16);
    phonetext.placeholder = @"请输入新的手机号";
    phonetext.font = [UIFont systemFontOfSize:14];
    [demoView addSubview:phonetext];
    
    return demoView;
}
-(void)httphuoqu{
    /*410 获取驾驶证相关信息
     URL：http://www.rempeach.com/rebirth/api/user/getAuth_info
     接口描述：获取驾驶证是否设置及相关信息
     请求方式：GET
     上传参数：
     id     
     round
     token
     sign
     
     
     特殊返回状态码
     100
     
     返回参数：state ：200 100 111 101 121 状态码（见附录） 
     a b c d e f g h i g k l m n o p q r s t u v w x y z
*/
    NSString *category = @"card_flag";
    NSString *transformId = [USER_DEFAULT objectForKey:@"id"];
    NSString *round = @"47563";
    NSString *token = [USER_DEFAULT objectForKey:@"token"];
    NSArray *nameList = @[vn(category),@"id",vn(round),vn(token)];
    
    NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(category),sv(transformId),sv(round),sv(token),nil];
    NSLog(@"%@",parameters1);
    NSString *str = sv(transformId);
    [YkxHttptools get:huoqu params:parameters1 success:^(id responseObj) {
        NSString *finishStr = [[NSString alloc]initWithData:responseObj encoding:NSUTF8StringEncoding];
        finishStr = [YkxHttptools repTabStr:finishStr];
        NSDictionary *paramDic = [[[SBJsonParser alloc]init] objectWithString:finishStr];
        NSLog(@"%@",paramDic);
        NSLog(@"%@2323",[paramDic objectForKey:@"tip"]);
        if ([[paramDic objectForKey:@"state"] isEqualToString:@"200"]) {
            NSDictionary *dic = [paramDic objectForKey:@"data"];
            NSDictionary *dicc = [dic objectForKey:@"drive_info"];
            NSString *card_flag =[dic objectForKey:@"card_flag"];
           
            NSString *card_id = [dicc objectForKey:@"card_id"];
            NSString *drive_card_img = [dicc objectForKey:@"drive_card_img"];
            NSString *end_date  =[dicc objectForKey:@"end_date"];
            NSString *name = [dicc objectForKey:@"name"];
            NSString *start_date= [dicc objectForKey:@"start_date"];
            NSString *vehicle_type = [dicc objectForKey:@"vehicle_type"];
            HSBindingJiazhaoViewController *hsbdjz = [[HSBindingJiazhaoViewController alloc] init];
            hsbdjz.name = name;
            hsbdjz.vehicle_type = vehicle_type;
            hsbdjz.start_date = start_date;
            hsbdjz.end_date = end_date;
            hsbdjz.cardId = card_id;
            hsbdjz.from = @"bangding";
            hsbdjz.img = drive_card_img;
        
            
            [self.navigationController pushViewController:hsbdjz animated:YES];
        }else if ([[paramDic objectForKey:@"state"] isEqualToString:@"100"]){
            HSUploadJiazhaoViewController *upload = [[HSUploadJiazhaoViewController alloc] init];
            [self.navigationController pushViewController:upload animated:YES];
        }
    } failure:^(NSError *error) {
        
    }];
    
}
-(void)httphuoquzhimafen{
    /*410 获取驾驶证相关信息
     URL：http://www.rempeach.com/rebirth/api/user/getAuth_info
     接口描述：获取驾驶证是否设置及相关信息
     请求方式：GET
     上传参数：
     id
     round
     token
     sign
     
     
     特殊返回状态码
     100
     
     返回参数：state ：200 100 111 101 121 状态码（见附录）
     a b c d e f g h i g k l m n o p q r s t u v w x y z
     */
    NSString *category = @"zm_flag";
    NSString *transformId = [USER_DEFAULT objectForKey:@"id"];
    NSString *round = @"47563";
    NSString *token = [USER_DEFAULT objectForKey:@"token"];
    NSArray *nameList = @[vn(category),@"id",vn(round),vn(token)];
    
    NSDictionary *parameters1 = [HSNetworkHelper lf_requestParamsWithNameList:nameList param:sv(category),sv(transformId),sv(round),sv(token),nil];
    NSLog(@"%@",parameters1);
    NSString *str = sv(transformId);
    [YkxHttptools get:huoqu params:parameters1 success:^(id responseObj) {
        NSString *finishStr = [[NSString alloc]initWithData:responseObj encoding:NSUTF8StringEncoding];
        finishStr = [YkxHttptools repTabStr:finishStr];
        NSDictionary *paramDic = [[[SBJsonParser alloc]init] objectWithString:finishStr];
        NSLog(@"%@",paramDic);
        NSLog(@"%@2323",[paramDic objectForKey:@"tip"]);
        if ([[paramDic objectForKey:@"state"] isEqualToString:@"200"]) {
            NSDictionary *dic = [paramDic objectForKey:@"data"];
            NSDictionary *dicc = [dic objectForKey:@"zhima_info"];
            HSSesameViewController *hsse = [[HSSesameViewController alloc] init];
            hsse.num = [dicc objectForKey:@"zm_score"];
            [self.navigationController pushViewController:hsse animated:YES];
           
            
        }else if ([[paramDic objectForKey:@"state"] isEqualToString:@"100"]){
            HSSesameXinxiViewController *hss = [[HSSesameXinxiViewController alloc] init];
            [self.navigationController pushViewController:hss animated:YES];

        }
    } failure:^(NSError *error) {
        
    }];
    
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
