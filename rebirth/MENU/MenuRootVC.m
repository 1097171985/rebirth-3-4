//
//  MenuRootVC.m
//  WJF-Drawer
//
//  Created by boom on 16/7/11.
//  Copyright © 2016年 boom. All rights reserved.
//

#import "MenuRootVC.h"
#import "HSSementViewController.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "RDVTabBar.h"

#define BTUWIDTH  60
@interface MenuRootVC ()


@end

@implementation MenuRootVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
   
    NSLog(@"DEMOFirstViewController will appear");
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    

    NSLog(@"DEMOFirstViewController will disappear");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.navigationController setNavigationBarHidden:YES];
//   self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Left"
//                                                                             style:UIBarButtonItemStylePlain
//                                                                            target:self
//                                                                            action:@selector(presentLeftMenuViewController:)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Right"
//                                                                              style:UIBarButtonItemStylePlain
//                                                                             target:self
//                                                                             action:@selector(presentRightMenuViewController:)];
//    
//    self.view.backgroundColor = [UIColor redColor];
    
//    [self createView];
    
    [self createNavi];
    
    UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backClick:)];
    rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGestureRecognizer];
}




-(void)createNavi{
    
    
    self.naviView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH,NAV_BAR_HEIGHT)];
    
    self.naviView.backgroundColor = [UIColor whiteColor];
    
    
    
    
    [self.view addSubview:self.naviView];
    
    self.leftBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.leftBtu setImage:[UIImage imageNamed:@"back_arrow@2x"] forState:UIControlStateNormal];
//    self.leftBtu.backgroundColor = [UIColor redColor];
    
    
    [self.naviView addSubview:self.leftBtu];
  //  8, kStatusBarHeight+5, 56/2, 56/2
    
    [self.leftBtu mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.naviView.mas_left).with.offset(8);
        
       //make.top.equalTo(self.naviView.mas_top).with.offset(kStatusBarHeight+5);
        
       // make.height.mas_equalTo(56/2);
        
        make.width.mas_equalTo(56/2);
        
        make.centerY.equalTo(self.naviView.mas_centerY).with.offset(kStatusBarHeight/2);
        
        
    }];
    
    [self.leftBtu addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.menuView = [[UILabel alloc]init];
//    self.menuView.backgroundColor = [UIColor yellowColor];
    
    [self.naviView addSubview:self.menuView];
    
    [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
    
        
         make.top.equalTo(self.naviView.mas_top).with.offset(kStatusBarHeight);
        
         make.height.mas_equalTo(44);
        
         make.centerX.equalTo(self.naviView.mas_centerX);
        
        make.centerY.equalTo(self.naviView.mas_centerY).with.offset(kStatusBarHeight/2);

        
        
    }];
    
    
    CALayer *bottomBorder = [CALayer layer];
    float height=self.naviView.frame.size.height-0.5f;
    float width=self.naviView.frame.size.width;
    bottomBorder.frame = CGRectMake(0.0f, height, width, 0.5f);
    bottomBorder.backgroundColor = [NSString colorWithHexString:@"#bbbbbb"].CGColor;
    [self.naviView.layer addSublayer:bottomBorder];
    
    
}



-(void)backClick:(UIButton *)btu{
//    HSSementViewController *hsse = [[HSSementViewController alloc] init];
//    
//    
    [self.navigationController popViewControllerAnimated:YES];
   // [self.navigationController popToRootViewControllerAnimated:YES];
//    [self.navigationController popToViewController:hsse animated:YES];
    
//    for (UIViewController *temp in self.navigationController.viewControllers) {
//        if ([temp isKindOfClass:[HSSementViewController class]]) {
//            [self.navigationController popToViewController:temp animated:YES];
//        }
//    }
    
    
    
}



-(void)createView{
    
    
    self.totalBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.totalBtu.frame  = CGRectMake(WIDTH/2-BTUWIDTH/2,HEIGHT-100,BTUWIDTH,BTUWIDTH);
    self.totalBtu.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.totalBtu];
    
    
    self.subBtu1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.subBtu1.alpha = 0;
    self.subBtu1.frame = CGRectMake(WIDTH/2-BTUWIDTH/2,HEIGHT -100,BTUWIDTH, BTUWIDTH);
    self.subBtu1.backgroundColor = [UIColor  blackColor];
    
    [self.view addSubview:self.subBtu1];
    
    
    self.subBtu2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.subBtu2.alpha = 0;
    self.subBtu2.frame = CGRectMake(WIDTH/2-BTUWIDTH/2,HEIGHT -100,BTUWIDTH, BTUWIDTH);
    self.subBtu2.backgroundColor = [UIColor  yellowColor];
    
    [self.view addSubview:self.subBtu2];
    
    
  //  [self.totalBtu addTarget:self action:@selector(clickTotalBtu:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //[self.subBtu1 addTarget:self action:@selector(clickSubBtu1:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
   // [self.subBtu2 addTarget:self action:@selector(clickSubBtu2:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.

}

-(void)clickTotalBtu:(UIButton *)btu{
    
    [UIView animateWithDuration:2.0 // 动画时长（设置弹出按钮到设定位置的时间）
     
                          delay:0.0          // 动画延迟 （设置时间以控制弹出按钮先后弹出的顺序）
     
         usingSpringWithDamping:0.3  // 类似弹簧振动效果 0~1 （设定范围从0～1,值越少反弹越厉害
     
     
          initialSpringVelocity:0.0    // 初始速度
     
                        options:UIViewAnimationOptionCurveEaseInOut  // 动画过渡效果
     
                     animations:^{
                         
                         //  这里写要执行的动画
                         
                         //  在这个案例中，在这设置（1）要弹出的三个控件的目的坐标；（2）将弹出控件的透明度设置为1，否则不显示
                         self.subBtu1.frame = CGRectMake(WIDTH/2-100-BTUWIDTH/2,HEIGHT -200,BTUWIDTH, BTUWIDTH);
                         self.subBtu1.alpha  = 1;
                         
                         self.subBtu2.frame = CGRectMake(WIDTH/2+100-BTUWIDTH/2,HEIGHT -200,BTUWIDTH, BTUWIDTH);
                         self.subBtu2.alpha = 1;
                     } completion:^(BOOL finished) {
                         
                         // 动画完成后执行
                         
                     }];
    
    
    
}



-(void)clickSubBtu1:(UIButton *)btu{
    
    
    
    [self rdv_tabBarController].selectedIndex = 0;
    
    
    [UIView animateWithDuration:2.0 // 动画时长（设置弹出按钮到设定位置的时间）
     
                          delay:0.0          // 动画延迟 （设置时间以控制弹出按钮先后弹出的顺序）
     
         usingSpringWithDamping:1  // 类似弹簧振动效果 0~1 （设定范围从0～1,值越少反弹越厉害
     
     
          initialSpringVelocity:0.0    // 初始速度
     
                        options:UIViewAnimationOptionCurveEaseInOut  // 动画过渡效果
     
                     animations:^{
                         
                         //  这里写要执行的动画
                         
                         //  在这个案例中，在这设置（1）要弹出的三个控件的目的坐标；（2）将弹出控件的透明度设置为1，否则不显示
                        self.subBtu1.frame = CGRectMake(WIDTH/2-BTUWIDTH/2,HEIGHT -100,BTUWIDTH, BTUWIDTH);
                         self.subBtu1.alpha  =0;
                         
                         self.subBtu2.frame = CGRectMake(WIDTH/2-BTUWIDTH/2,HEIGHT -100,BTUWIDTH, BTUWIDTH);
                         self.subBtu2.alpha = 0;
                     } completion:^(BOOL finished) {
                         
                         // 动画完成后执行
                         
                     }];
    
    
}





-(void)clickSubBtu2:(UIButton *)btu{
    
    
    [self rdv_tabBarController].selectedIndex = 1;
    
    
    [UIView animateWithDuration:2.0 // 动画时长（设置弹出按钮到设定位置的时间）
     
                          delay:0.0          // 动画延迟 （设置时间以控制弹出按钮先后弹出的顺序）
     
         usingSpringWithDamping:1  // 类似弹簧振动效果 0~1 （设定范围从0～1,值越少反弹越厉害
     
     
          initialSpringVelocity:0.0    // 初始速度
     
                        options:UIViewAnimationOptionCurveEaseInOut  // 动画过渡效果
     
                     animations:^{
                         
                         //  这里写要执行的动画
                         
                         //  在这个案例中，在这设置（1）要弹出的三个控件的目的坐标；（2）将弹出控件的透明度设置为1，否则不显示
                          self.subBtu1.frame = CGRectMake(WIDTH/2-BTUWIDTH/2,HEIGHT -100,BTUWIDTH, BTUWIDTH);
                         self.subBtu1.alpha  =0;
                         
                          self.subBtu2.frame = CGRectMake(WIDTH/2-BTUWIDTH/2,HEIGHT -100,BTUWIDTH, BTUWIDTH);
                         self.subBtu2.alpha = 0;
                     } completion:^(BOOL finished) {
                         
                         // 动画完成后执行
                         
                     }];
    
    
    
}


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
    
    [total setObject:@"true" forKey:@"debug"];
    
    return (NSDictionary *)total;
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
