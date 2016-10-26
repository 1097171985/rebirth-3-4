//
//  HSGRZXCell.h
//  rebirth
//
//  Created by 侯帅 on 16/10/11.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSGRZXModel.h"
@interface HSGRZXCell : UITableViewCell
@property (nonatomic,strong)UILabel *timelabel;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)UIImageView *videoImage;
@property (nonatomic,strong)HSGRZXModel *model;
@property(nonatomic, assign)CGFloat lastHeight;
-(void)setModel:(HSGRZXModel *)model;
@end
