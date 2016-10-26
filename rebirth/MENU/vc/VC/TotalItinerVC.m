//
//  TotalItinerVC.m
//  rebirth
//
//  Created by boom on 16/8/18.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "TotalItinerVC.h"
#import "DoingItinerVC.h"
#import "AllIternVC.h"
#import "HomeViewController.h"
#define Text  @[@"进行中",@"全部"]

@interface TotalItinerVC ()

@end

@implementation TotalItinerVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
        if (!_showNavBar) {
            self.navigationController.navigationBarHidden = NO;
        }
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];

    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   if (!_showNavBar) {
    
            self.navigationController.navigationBarHidden = YES;
        }
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];

}


- (void)setBarStyle:(TYPagerBarStyle)barStyle
{
    [super setBarStyle:barStyle];
}

-(UIImage *)imageWithColor:(UIColor *)color{
    CGFloat imageW = 3;
    CGFloat imageH = 3;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW, imageH), NO, 0);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageW, imageH));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"行程";
    
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[NSString colorWithHexString:@"#27292b"],NSFontAttributeName:[UIFont boldSystemFontOfSize:17]};
    
  
   [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];//设置navigationbar的颜色

    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back_arrow@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(selectLeftAction)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    self.adjustStatusBarHeight = YES;
    self.cellWidth = WIDTH/2;//宽度
    self.cellSpacing = 0;//间距
    self.contentTopEdging = 40;//高度
    
    self.normalTextColor = [NSString colorWithHexString:@"#6d7278"];//平常的颜色
    self.selectedTextColor = [NSString colorWithHexString:@"#27292b"];//选中的颜色
    
    self.normalTextFont = [UIFont systemFontOfSize:14];//平常字体
    
    self.selectedTextFont = [UIFont systemFontOfSize:16];//选中字体
    
    self.progressColor = [NSString colorWithHexString:@"#27292b"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)selectLeftAction{
    
    if ([self.typeBack isEqualToString:@"Pay"]) {
        
        HomeViewController *vc = [[HomeViewController alloc]init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}



#pragma mark - TYPagerControllerDataSource

- (NSInteger)numberOfControllersInPagerController
{
    return 2;
}


- (NSString *)pagerController:(TYPagerController *)pagerController titleForIndex:(NSInteger)index
{
    return Text[index];
}

- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index
{
    if (index == 0) {
        DoingItinerVC *VC = [[DoingItinerVC alloc]init];
        
        return VC;
    }else if(index == 1) {
        AllIternVC *VC = [[AllIternVC alloc]init];
       
        return VC;
    }else {
       return nil;
    } 
}

#pragma mark - override delegate

// configure cell need call super
- (void)pagerController:(TYTabPagerController *)pagerController configreCell:(TYTabTitleViewCell *)cell forItemTitle:(NSString *)title atIndexPath:(NSIndexPath *)indexPath
{
    [super pagerController:pagerController configreCell:cell forItemTitle:title atIndexPath:indexPath];
    // configure cell
}

- (void)pagerController:(TYTabPagerController *)pagerController didSelectAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectAtIndexPath %@",indexPath);
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
