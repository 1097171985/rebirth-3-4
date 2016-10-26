//
//  ReplaceZhengWenVC.h
//  rebirth
//
//  Created by WJF on 16/10/13.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "MenuRootVC.h"
#import "HSShejiaoModel.h"

@protocol backdelegate <NSObject>

-(void)clicksss:(NSString *)stttt;

@end


@interface ReplaceZhengWenVC : MenuRootVC
@property (nonatomic,strong) HSShejiaoModel *model;
@property (nonatomic,strong) NSString *pinglunNum;
@property (weak,nonatomic)id<backdelegate>delegate;
@end
