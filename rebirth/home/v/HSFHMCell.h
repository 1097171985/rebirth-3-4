//
//  HSFHMCell.h
//  rebirth
//
//  Created by 侯帅 on 16/7/25.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSHomexiaModel.h"
#import "SDImageCache.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
@interface HSFHMCell : UITableViewCell
@property (nonatomic,strong) HSHomexiaModel *hsmodel;
-(void)setHsmodel:(HSHomexiaModel *)hsmodel;
@end
