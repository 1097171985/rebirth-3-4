//
//  HThreeViewCell.h
//  rebirth
//
//  Created by 侯帅 on 16/7/18.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSHomeModel.h"

@interface HThreeViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *jiayu;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *chexing;
@property (nonatomic,strong) HSHomeModel *homeModel;
-(void)setModel:(HSHomeModel *)model;
@end
