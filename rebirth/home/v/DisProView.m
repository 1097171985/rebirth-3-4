//
//  DisProView.m
//  简单朋友圈
//
//  Created by WJF on 16/10/10.
//  Copyright © 2016年 WJF. All rights reserved.
//

//获取屏幕 宽度、高度
#define WIDTH ([UIScreen mainScreen].bounds.size.width)
#define HEIGHT ([UIScreen mainScreen].bounds.size.height)

#import "DisProView.h"
#import "DisProModel.h"
@implementation DisProView

-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        
    }
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame  withDisPro:(NSMutableArray *)disProArr{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.lastLabelheight = 0.0;
        
        self.disProArray =  [NSMutableArray arrayWithArray:disProArr];
        
    
        [self loadFrame];
    }
    return self;
}




-(void)loadFrame{
    
    for (int i = 0 ; i < self.disProArray.count; i++) {
        
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.lastLabelheight, 566/2, 100)];
        
        DisProModel *model = self.disProArray[i];
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.numberOfLines = 0;
        nameLabel.text = [NSString stringWithFormat:@"%@：%@",model.name1,model.textStr];
        
        CGSize labelSize  = {0,0};
        labelSize = [nameLabel.text boundingRectWithSize:CGSizeMake(566/2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        
        nameLabel.frame = CGRectMake(0,self.lastLabelheight, 566/2, labelSize.height);
        self.lastLabelheight = labelSize.height+nameLabel.frame.origin.y;
        
        [self addSubview:nameLabel];
        
        
    }
    
    
     self.frame = CGRectMake(144/2, self.frame.origin.y, 566/2,self.lastLabelheight);
    
    
    
}



//-(void)tapReply{
//    
//    NSLog(@"4444444");
//    
//    DisProModel *model = [[DisProModel alloc]init];
//    
//    model.name1 = @"瘦子";
//    model.name2 = @"胖子x";
//    model.textStr = @"你是猪吗？？达到欧爱打打打啊大大大的啊的   爱的爱的爱的啊大大大的借记卡就看见啊 啊大大打击";
//    
//    
//    [self.data addObject:model];
//    
//    
//    [self.disProTab reloadData];
//    
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
