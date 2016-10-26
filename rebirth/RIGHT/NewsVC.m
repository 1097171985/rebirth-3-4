//
//  NewsVC.m
//  WJF-Drawer
//
//  Created by boom on 16/7/11.
//  Copyright © 2016年 boom. All rights reserved.
//

#import "NewsVC.h"

@interface NewsVC ()

@end

@implementation NewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.view.backgroundColor = [UIColor blueColor];
    
     [self.navigationController setNavigationBarHidden:YES animated:YES];
    // Do any additional setup after loading the view.
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
