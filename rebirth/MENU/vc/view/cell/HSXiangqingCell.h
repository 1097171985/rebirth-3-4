//
//  HSXiangqingCell.h
//  rebirth
//
//  Created by 侯帅 on 16/7/19.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageScrollView.h"
#import "SDCycleScrollView.h"
@interface HSXiangqingCell : UITableViewCell<SDCycleScrollViewDelegate>

@property(nonatomic,strong)NSMutableArray *imageArr;

@property (nonatomic,strong)SDCycleScrollView *imageScrollView;

-(instancetype)initWithStyle:(UITableViewCellStyle)style WithArray:(NSMutableArray *)imageArr reuseIdentifier:(NSString *)reuseIdentifier;
@end
