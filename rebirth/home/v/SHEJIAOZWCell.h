//
//  SHEJIAOZWCell.h
//  rebirth
//
//  Created by 侯帅 on 16/10/14.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSShejiaoModel.h"

@interface SHEJIAOZWCell : UITableViewCell
@property (strong,nonatomic) UIImageView *headerImageView;
@property (strong,nonatomic) UILabel *contentLabel;
@property (strong,nonatomic) UILabel *timeLabel;

@property (strong,nonatomic) UILabel *nameLabel;
@property (strong,nonatomic) HSShejiaoModel *hsshejiaomodel;
@property (strong,nonatomic)UIImageView *videoImage;

-(CGFloat )getHeight;

@property (strong, nonatomic) HSShejiaoModel *myModel1;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDisProArray:(NSMutableArray *)disProArray;
@end
