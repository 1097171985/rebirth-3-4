//
//  GradePrerogativeCell.h
//  rebirth
//
//  Created by WJF on 16/10/8.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradePrerogativeCell : UITableViewCell

@property(nonatomic, strong)UIImageView *gradePrerogativeImage;

@property(nonatomic, strong)UIView  *gradePrerogativeView;

@property(nonatomic, strong)NSArray *gardePrerogativeArray;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withGradePrerogativeData:(NSArray *)gradePrerogativeArray;

-(CGFloat )returnCellHeight;

@end
