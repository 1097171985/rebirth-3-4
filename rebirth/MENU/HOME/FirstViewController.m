//
//  FirstViewController.m
//  rebirth
//
//  Created by boom on 16/7/27.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
   // self.view.backgroundColor = [UIColor redColor];
    
    // 1.创建轮播图的UIScrollView
    
    UIScrollView *myScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    
    myScrollV.backgroundColor = [UIColor blackColor];
    
    // 2.设置是否按页滑动
    
    myScrollV.pagingEnabled = YES;
    
    // 3.设置关闭边界反弹
    
    myScrollV.bounces = NO;
    
    
    [self.view addSubview:myScrollV];
    
    
    myScrollV.contentSize = CGSizeMake(WIDTH * self.firstArray.count, HEIGHT);
    

    for (int i = 0; i < self.firstArray.count; i++) {
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH * i + 10, 0, WIDTH-20, HEIGHT)];
        
       // NSLog(@"%@",self.firstArray[0]);
        
        
       [img sd_setImageWithURL:[NSURL URLWithString:self.firstArray[i]] placeholderImage:[UIImage imageNamed:@"1"]];
        
        [myScrollV addSubview:img];
        
        // 7.自动适应图片的大小
        
        img.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    
    // 创建轻拍手势
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    
    [myScrollV addGestureRecognizer:tap];
    
    [myScrollV setContentOffset:CGPointMake(WIDTH*self.selecteIndex, 0) animated:YES];
}

- (void)tapAction:(UITapGestureRecognizer *)tap

{ [USER_DEFAULT setObject:@"photo" forKey:@"photo"];

    
    [self dismissViewControllerAnimated:YES completion:^{
        
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
