//
//  CouponsCell.m
//  
//
//  Created by WJF on 16/9/28.
//
//

#import "CouponsCell.h"

@implementation CouponsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self loadCellView];
    }
    
    return self;
    
}

-(void)loadCellView{
    
    self.backgroundColor = [NSString colorWithHexString:@"f2f2f2"];
    
    
    UIView  *contView = [[UIView alloc]initWithFrame:CGRectMake(12,12, WIDTH-24,272/2*HEIGHTRATIO)];
    contView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:contView];
    
    self.textView1 = [[textView alloc]init];
    self.textView1.frame = CGRectMake(0,0,8, 272/2*HEIGHTRATIO);
    self.textView1.backgroundColor = [NSString colorWithHexString:@"e5bc53"];
    [contView addSubview:self.textView1];
    
    //150  130
    self.juanImage = [[UIImageView alloc]initWithFrame:CGRectMake((702/2-8-150/2)*WIDTHRATIO,(272/2-130/2)*HEIGHTRATIO, 150/2*WIDTHRATIO,130/2*HEIGHTRATIO)];
    
    self.juanImage.image = [UIImage imageNamed:@"quan_zi"];
    
    [contView addSubview:self.juanImage];
    
    
    self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(12+8,32/2,300, 52/2)];
    // moneyLabel.backgroundColor = [UIColor yellowColor];
    self.moneyLabel.textColor = [NSString colorWithHexString:@"e5bc53"];
    self.moneyLabel.font = [UIFont systemFontOfSize:52/2];
    // [moneyLabel sizeToFit];
    self.moneyLabel.text = @"满5000减666";
    [contView addSubview:self.moneyLabel];
    
    
    self.mudiLabel = [[UILabel alloc]initWithFrame:CGRectMake(12+8,self.moneyLabel.frame.origin.y+self.moneyLabel.frame.size.height+16,300, 52/2)];
    // moneyLabel.backgroundColor = [UIColor yellowColor];
    self.mudiLabel.textColor = [NSString colorWithHexString:@"a6a8ac"];
    self.mudiLabel.font = [UIFont systemFontOfSize:14];
    // [moneyLabel sizeToFit];
    self.mudiLabel.text = @"新用户专享；";
    [contView addSubview:self.mudiLabel];
    
    
    self.youxiaoLabel =[[UILabel alloc]initWithFrame:CGRectMake(12+8,contView.frame.size.height-16-12, 300,12)];
    
    self.youxiaoLabel.textColor = [NSString colorWithHexString:@"cdced0"];
    self.youxiaoLabel.font = [UIFont systemFontOfSize:12];
    self.youxiaoLabel.text = @"有效期：2016.9.24-2016.10.23";
    
    [contView addSubview:self.youxiaoLabel];
    
    
    self.zhangImage = [[UIImageView alloc]initWithFrame:CGRectMake((702/2-56/2-144/2)*WIDTHRATIO, 20*HEIGHTRATIO,144/2*WIDTHRATIO, 144/2*HEIGHTRATIO)];
    
    self.zhangImage.image = [UIImage imageNamed:@"used"];
    
    [contView addSubview:self.zhangImage];
}
@end
