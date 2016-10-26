//
//  HSManCell.h
//  rebirth
//
//  Created by 侯帅 on 16/7/25.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSHomexiaModel.h"
#import "BaseCell.h"

@interface HSManCell : BaseCell

@property(nonatomic,weak)NSString *name;

@property(nonatomic,weak)NSString *image;




@property (nonatomic,strong)HSHomexiaModel *xiamodel;
-(void)setXiamodel:(HSHomexiaModel *)xiamodel;

@end
