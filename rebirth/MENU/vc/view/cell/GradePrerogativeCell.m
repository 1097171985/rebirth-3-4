//
//  GradePrerogativeCell.m
//  rebirth
//
//  Created by WJF on 16/10/8.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "GradePrerogativeCell.h"
#import "GradePrerogativeView.h"
@implementation GradePrerogativeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withGradePrerogativeData:(NSArray *)gradePrerogativeArray{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        lastViewHeight = 16;
        
        self.gardePrerogativeArray = gradePrerogativeArray;
        
        [self loadGradePrerogative];
        
        //CGFloat cellheight =  [self returnCellHeight];
        
        
        
        
    }

    return self;
}

static float lastViewHeight = 16;

-(void)loadGradePrerogative{
    
    
    self.gradePrerogativeImage = [[UIImageView alloc]init];
    [self addSubview:self.gradePrerogativeImage];
    if (self.gardePrerogativeArray.count == 1) {
        
        self.gradePrerogativeImage.image = [UIImage imageNamed:@"vip_1"];
        
    }else if (self.gardePrerogativeArray.count == 3 && [self.gardePrerogativeArray[2] isEqualToString:@"生日当天预定套餐赠送哈根达斯蛋糕劵"]){
        
         self.gradePrerogativeImage.image = [UIImage imageNamed:@"vip_2"];
        
    }else if (self.gardePrerogativeArray.count == 3){
         self.gradePrerogativeImage.image = [UIImage imageNamed:@"vip_3"];
        
    }else if (self.gardePrerogativeArray.count == 4){
         self.gradePrerogativeImage.image = [UIImage imageNamed:@"vip_4"];
        
    }else if (self.gardePrerogativeArray.count == 5){
        
         self.gradePrerogativeImage.image = [UIImage imageNamed:@"vip_5"];
    }
    [self.gradePrerogativeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).with.offset(20);
        
        make.centerY.equalTo(self.mas_centerY);
        
        make.width.mas_equalTo(56/2);
        
        make.height.mas_equalTo(56/2);
        
        
    }];
    
    
    self.gradePrerogativeView = [[UIView alloc]init];
    
    [self addSubview:self.gradePrerogativeView];
    
    
    for (int i = 0; i < self.gardePrerogativeArray.count; i++) {
        
        GradePrerogativeView *gardeview = [[GradePrerogativeView alloc]initWithFrame:CGRectMake(0, 0, 510/2,12) withGradeprerogateData:self.gardePrerogativeArray[i]];
        
        CGFloat height = [gardeview returnGradePrerogativeView];
        
        //NSLog(@"height==%f",height);
        
        gardeview.frame = CGRectMake(0,lastViewHeight,510/2,height);
        
        lastViewHeight = gardeview.frame.origin.y+gardeview.frame.size.height+12;
    
        [self.gradePrerogativeView addSubview:gardeview];
        
        
        
        
    }
    
    [self.gradePrerogativeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.gradePrerogativeImage.mas_right).with.offset(40);
        
        make.top.equalTo(self.mas_top).with.offset(0);
        
        make.height.mas_equalTo(24*(self.gardePrerogativeArray.count));
        
        make.width.mas_equalTo(510/2);
        
    }];
    
    UILabel *henxian = [[UILabel alloc]init];
    
    henxian.backgroundColor = [NSString colorWithHexString:@"27292b"];
    
    [self addSubview:henxian];
    [henxian mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.mas_left).with.offset(0);
        
        make.bottom.equalTo(self.mas_bottom).with.offset(-0.5);
        
        make.height.mas_equalTo(0.5);
        
        make.width.mas_equalTo(WIDTH);
    }];

    
    self.frame = CGRectMake(0, 0, WIDTH, lastViewHeight+4);
    
}


-(CGFloat )returnCellHeight{
    
    return self.gradePrerogativeView.frame.origin.y+self.gradePrerogativeView.frame.size.height;
    
}
 
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
