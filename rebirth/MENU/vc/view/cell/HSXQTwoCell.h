//
//  HSXQTwoCell.h
//  rebirth
//
//  Created by 侯帅 on 16/7/19.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InsetLabel.h"

@interface HSXQTwoCell : UITableViewCell

@property (strong, nonatomic)  UILabel *mealName;

@property (strong, nonatomic)  UILabel *money;


@property (strong, nonatomic)  InsetLabel *styleName;

@property (strong, nonatomic)  UILabel *detailName;


@property(strong,nonatomic) UIButton *serviceBtu;


@end
