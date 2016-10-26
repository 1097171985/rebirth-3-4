//
//  HSSementViewController.h
//  rebirth
//
//  Created by 侯帅 on 16/9/21.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSHomexiaModel.h"
#import "HSShejiaoModel.h"
@interface HSSementViewController : UIViewController
@property (nonatomic,strong) HSHomexiaModel *hsmodel;
@property (nonatomic,strong) HSShejiaoModel *hsshejiaomodel;
@property (nonatomic,strong) NSString *frrr; //判断从哪里跳回

@property(nonnull, strong)NSString *stype;
@end
