//
//  ReplacePinglunCell.m
//  rebirth
//
//  Created by WJF on 16/10/13.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "ReplacePinglunCell.h"

@implementation ReplacePinglunCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.pingLunImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 13,13,12)];
        
        self.pingLunImage.image = [UIImage imageNamed:@"comment@2x"];
        
        [self addSubview:self.pingLunImage];
        
        
       
        
        self.pingLunNumber = [[UILabel alloc]initWithFrame:CGRectMake(self.pingLunImage.frame.origin.x+self.pingLunImage.frame.size.width+8, 12,200,12)];
        self.pingLunNumber.text = @"1200";
        
        self.pingLunNumber.textColor = [NSString colorWithHexString:@"6d7278"];
        
        self.pingLunNumber.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:self.pingLunNumber];
    }
    
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
