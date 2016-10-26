//
//  ReplaceZhengWenCell.m
//  rebirth
//
//  Created by WJF on 16/10/13.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "ReplaceZhengWenCell.h"


@implementation ReplaceZhengWenCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier  withbool:(BOOL)replaceBool withreplaceArr:(ReplaceModel *)replaceModel{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        [self loadCellwithbool:replaceBool  withreplaceArr:replaceModel];
    }
    
    return self;
    
}
-(void)clickBtn{
    
    [self.delegate clickbbb];
    
}
-(void)loadCellwithbool:(BOOL)replaceBool withreplaceArr:(ReplaceModel *)replaceModel{
    
        
        UIImageView *subOneImage = [[UIImageView alloc]initWithFrame:CGRectMake(20,8, 40, 40)];
        
        [subOneImage sd_setImageWithURL:[NSURL URLWithString:replaceModel.head_img] placeholderImage:nil];
    subOneImage.layer.cornerRadius = 20;
    subOneImage.layer.masksToBounds = YES;
        [self addSubview:subOneImage];
        
        
        UILabel  *subOneName = [[UILabel alloc]initWithFrame:CGRectMake(subOneImage.frame.origin.x+subOneImage.frame.size.width+12,16,WIDTH-(subOneImage.frame.origin.x+subOneImage.frame.size.width+12)-20-40,14)];
        
        subOneName.text = replaceModel.nick;
        
        subOneName.font = [UIFont systemFontOfSize:12];
        
        subOneName.textColor = [NSString colorWithHexString:@"6D7278"];
        
        [self addSubview:subOneName];
    
    if([USER_DEFAULT objectForKey:@"id"] && [[USER_DEFAULT objectForKey:@"id"] isEqualToString:replaceModel.user_id]){
        self.delectBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        
        self.delectBtu.frame = CGRectMake(WIDTH-20-12,15,12, 12);
        [self.delectBtu setImage:[UIImage imageNamed:@"delete_small"] forState:UIControlStateNormal];
        
        [self addSubview:self.delectBtu];
    }
    
        UILabel *subOneTime = [[UILabel alloc]initWithFrame:CGRectMake(subOneImage.frame.origin.x+subOneImage.frame.size.width+12,subOneName.frame.origin.y+subOneName.frame.size.height+8,WIDTH-(subOneImage.frame.origin.x+subOneImage.frame.size.width+12)-20,10)];
        
        subOneTime.text = replaceModel.date;
        subOneTime.font  = [UIFont systemFontOfSize:10];
        
        subOneTime.textColor = [NSString colorWithHexString:@"a2aab2"];
        
        [self addSubview:subOneTime];
        
        
        NSString *str = replaceModel.content;
        CGSize labelSize  = {0,0};
        labelSize = [str boundingRectWithSize:CGSizeMake(WIDTH-(subOneImage.frame.origin.x+subOneImage.frame.size.width+12)-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
        
        self.subOneContent = [[UILabel alloc]initWithFrame:CGRectMake(subOneImage.frame.origin.x+subOneImage.frame.size.width+12, subOneTime.frame.origin.y+subOneTime.frame.size.height+12,WIDTH-(subOneImage.frame.origin.x+subOneImage.frame.size.width+12)-20,labelSize.height)];
        
         self.subOneContent .text = replaceModel.content;
    
         self.subOneContent .numberOfLines = 0;
        
         self.subOneContent .textColor = [NSString colorWithHexString:@"27292b"];
        
         self.subOneContent .font = [UIFont systemFontOfSize:12];
        
        [self addSubview: self.subOneContent ];
    
   
        self.totalSunTwView  = [[UIView alloc]init];
        self.totalSunTwView.backgroundColor = [NSString colorWithHexString:@"edf0f2"];
        [self addSubview:self.totalSunTwView];
        
    if (replaceBool == NO) {
        
         self.totalSunTwView.frame = CGRectMake(20,  self.subOneContent .frame.origin.y+ self.subOneContent .frame.size.height+12,336,0);
    }else{
        
        if(!replaceModel.child_list){
            
            self.totalSunTwView.frame = CGRectMake(20,  self.subOneContent .frame.origin.y+ self.subOneContent .frame.size.height+12,336,0);
            
            
        }else{
            
           
            for (int i = 0 ; i < replaceModel.child_list.count; i++) {
                
                ReplaceView *peplace = [[ReplaceView alloc]initWithFrame:CGRectMake(12,self.replaceHeight+8,300,100) withReplace:replaceModel.child_list[i]];
                peplace.repdelegate =self;
                [self.totalSunTwView addSubview:peplace];
                
                self.replaceHeight = peplace.frame.origin.y + peplace.frame.size.height;
                
                
            }
            self.moreLabel = [UIButton buttonWithType:UIButtonTypeCustom ];
            [self.totalSunTwView addSubview:self.moreLabel];

            if (replaceModel.child_list.count == 1) {
                
                 self.moreLabel.frame  = CGRectMake(104/2, self.replaceHeight+16,50,0);
                
            }else{
            
            self.moreLabel.frame  = CGRectMake(104/2, self.replaceHeight+16,50,10);
            
            [self.moreLabel setTitle:@"查看更多>" forState:UIControlStateNormal];
            [self.moreLabel setTitleColor:[NSString colorWithHexString:@"2a4f73"] forState:UIControlStateNormal];
            self.moreLabel.titleLabel.font = [UIFont systemFontOfSize:10];
            }
            
            self.totalSunTwView.frame = CGRectMake(20,  self.subOneContent .frame.origin.y+ self.subOneContent .frame.size.height+12,336,self.moreLabel.frame.origin.y+self.moreLabel.frame.size.height+12);
            

        }
       
    }
    
    
     self.frame = CGRectMake(0,0,WIDTH ,self.totalSunTwView.frame.origin.y+self.totalSunTwView.frame.size.height+24);
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
