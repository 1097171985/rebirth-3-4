//
//  GradePrerogativeView.h
//  rebirth
//
//  Created by WJF on 16/10/8.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradePrerogativeView : UIView

@property(nonatomic, strong)NSString *textStr;

@property(nonatomic, strong)UILabel  *textLabel;
-(instancetype)initWithFrame:(CGRect)frame  withGradeprerogateData:(NSString *)gradeperoteStr;

-(CGFloat)returnGradePrerogativeView;
@end
