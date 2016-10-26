//
//  HSXiangqingCell.m
//  rebirth
//
//  Created by 侯帅 on 16/7/19.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSXiangqingCell.h"
#import "FirstViewController.h"
@implementation HSXiangqingCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style WithArray:(NSMutableArray *)imageArr reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.imageArr = [NSMutableArray array];
        
        self.imageArr = imageArr;
        
        self.backgroundColor = [NSString colorWithHexString:@"f6f6f6"];
        self.imageScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0,kScreenWidth, 240) delegate:self placeholderImage:[UIImage imageNamed:@"default_img_xiangqing"]];
        
        self.imageScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        
        self.imageScrollView.pageControlRightOffset = 0;
        // self.imageScrollView.titlesGroup = titles;
        self.imageScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        
        self.imageScrollView.pageDotColor = [[UIColor whiteColor]colorWithAlphaComponent:0.44];
        self.imageScrollView.imageURLStringsGroup = imageArr;
        self.imageScrollView.autoScrollTimeInterval = 4.0;
        
        self.imageScrollView.pageControlDotSize = CGSizeMake(8,8);
       // NSLog(@"imageArr=%@",imageArr);
        [self.contentView addSubview: self.imageScrollView];

    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
