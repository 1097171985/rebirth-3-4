//
//  HSGRZXCell.m
//  rebirth
//
//  Created by 侯帅 on 16/10/11.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSGRZXCell.h"
#import "Header.h"
#import "NSDate+Category.h"
@implementation HSGRZXCell
{
    UIView *contentView;
    UIView *line;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatCell];
    }
    return self;
}
-(void)creatCell{
    self.lastHeight = 0;
    _timelabel = [[UILabel alloc] init];
    _timelabel.frame =CGRectMake(0, 12, 144/2, 20);
    _timelabel.numberOfLines = 0;
    //_timelabel.lineBreakMode = NSLineBreakByTruncatingTail;
    //[_timelabel sizeToFit];
   // _timelabel.text = @"今天";
//    _timelabel.font = [UIFont systemFontOfSize:20];
    _timelabel.font  =[UIFont systemFontOfSize:18 weight:bold];
    _timelabel.textColor = [NSString colorWithHexString:@"27292b"];
    _timelabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_timelabel];
    _contentLabel = [[UILabel alloc] init];
    
    _contentLabel.numberOfLines =0;
    _contentLabel.textColor = [NSString colorWithHexString:heitizi];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_contentLabel];
   // _contentLabel.text = @"今天今天今天今天今天今天今天今天今天今天今天今天今天今天今天今天今天今天今天今天今天今天今天今天今天今天今天今天今天今天今天今天今天今天今天今天今天今天今天今天今天";
       contentView = [[UIView alloc] init];
    [self addSubview:contentView];
    
    line= [[UIView alloc] init];
    line.backgroundColor = [NSString colorWithHexString:@"e5e5e5"];
    [self addSubview:line];
   
}
-(void)imageViewWithImg:(NSString*)imgName{
    
    NSArray *imgs = [imgName componentsSeparatedByString:@","];
    NSLog(@"%@",imgs);
    if (imgs.count ==2) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, 240, 180)];
        // imageView.image = [UIImage imageNamed:imgs[i]];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imgs[0]]placeholderImage:[UIImage imageNamed:@"default_img_qualityduiwei"]];
        NSLog(@"i=========%@",imgs[0]);
        //  imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.userInteractionEnabled = YES;
        imageView.tag = 0;
        //        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        //        [imageView addGestureRecognizer:tap];
        self.lastHeight = imageView.frame.origin.y+imageView.frame.size.height;
        [contentView addSubview:imageView];
    }else{
    for (NSInteger i=0;i<imgs.count-1;i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((kSpace+imgWidth1)*(i%3),(kSpace+imgWidth1)*(i/3), imgWidth1, imgWidth1)];
       // imageView.image = [UIImage imageNamed:imgs[i]];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imgs[i]]placeholderImage:[UIImage imageNamed:@"default_img_qualityduiwei"]];
        NSLog(@"i=========%@",imgs[i]);
      //  imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
//        [imageView addGestureRecognizer:tap];
         self.lastHeight = imageView.frame.origin.y+imageView.frame.size.height;
        [contentView addSubview:imageView];
      
    }
    }
    
    contentView.frame = CGRectMake(_timelabel.frame.size.width, _contentLabel.frame.size.height+24+12, 240, self.lastHeight);
    
    line.frame =CGRectMake(_timelabel.frame.size.width, contentView.frame.origin.y+contentView .frame.size.height+11, kScreenWidth-_timelabel.frame.size.width, 0.5);
}
-(void)setModel:(HSGRZXModel *)model{
    _contentLabel.text = model.textContent;
    CGSize labelSize  = {0,0};
    labelSize = [_contentLabel.text boundingRectWithSize:CGSizeMake(kScreenWidth-_timelabel.frame.size.width-12, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    _contentLabel.frame =CGRectMake(_timelabel.frame.size.width, 12, kScreenWidth-_timelabel.frame.size.width-12,labelSize.height);
    
    
    NSMutableString *image = [[NSMutableString alloc]init];
    if ([model.category isEqualToString:@"1"]) {
        
        if (model.file_list.count == 1 && [model.file_list[0] isKindOfClass:[NSString class]]) {
            
            NSLog(@"");
            NSLog(@"我是没有的");
             contentView.frame = CGRectMake(0, 0,kScreenWidth,20);
            line.frame =CGRectMake(_timelabel.frame.size.width, contentView.frame.origin.y+contentView .frame.size.height+11, kScreenWidth-_timelabel.frame.size.width, 0.5);
          
            }else{
                for (NSDictionary *imdDict in model.file_list) {
                            
                            if ([imdDict[@"file_category"] isEqualToString:@"2"]) {
                                
                            }else if([imdDict[@"file_category"] isEqualToString:@"0"]){
                                NSLog(@"1111");
                                [image appendString:[NSString stringWithFormat:@"%@,",imdDict[@"file_path"]]];
                                
                            }
                            
                            
                        }
                        NSLog(@"imagestr=====%@",image);
                        
                        [self imageViewWithImg:image];

                   }
       
        
        
      
        
        
    }else if ([model.category isEqualToString:@"2"]){
        
        for (NSDictionary *shipinDict in model.file_list) {
            if ([shipinDict [@"file_category"] isEqualToString:@"2"]) {
                NSString *str = shipinDict[@"file_path"];
                contentView.frame =CGRectMake(144/2,_contentLabel.frame.size.height+_contentLabel.frame.origin.y+8,240,180);
                [self imageViewWithImg1:str];
            }
            
        }
        
        
    }
    
    
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [fmt setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate * datePost = [fmt dateFromString:model.created_date];
       _timelabel.text =[datePost timeIntervalDescription];
 
     self.frame = CGRectMake(0, 0,kScreenWidth,contentView.frame.origin.y+contentView .frame.size.height+24);
}


-(void)imageViewWithImg1:(NSString*)imgName1{
    self.videoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, contentView.frame.size.width, contentView.frame.size.height)];
    // imageView.image = [UIImage imageNamed:imgs[i]];
    [self.videoImage sd_setImageWithURL:[NSURL URLWithString:imgName1] placeholderImage:[UIImage imageNamed:@"default_img_qualityduiwei"]];
    //   imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.videoImage.userInteractionEnabled = YES;
    
    [contentView addSubview:self.videoImage];
   
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
