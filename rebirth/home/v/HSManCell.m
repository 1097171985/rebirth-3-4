//
//  HSManCell.m
//  rebirth
//
//  Created by 侯帅 on 16/7/25.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSManCell.h"

@interface HSManCell ()


@end

@implementation HSManCell
{
    UIImageView *img;
    UILabel *titlelbl;
    UILabel *namelbl;
    HSHomexiaModel *model;
    UIView *line;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creat];
    }
    return self;
}
-(void)creat
{
    img = [[UIImageView alloc] init];
    [self addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self);
        make.height.mas_equalTo(180*HEIGHTRATIO);
    }];
    titlelbl = [[UILabel alloc] init];
    titlelbl.textColor = [UIColor whiteColor];
    titlelbl.textAlignment = NSTextAlignmentCenter;
    titlelbl.font = [UIFont systemFontOfSize:16];
    
    [img addSubview:titlelbl];
    [titlelbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(img);
        make.top.mas_equalTo(70*HEIGHTRATIO);
        make.height.equalTo(@16);
        
    }];
    namelbl = [[UILabel alloc] init];
    namelbl.textColor = [UIColor whiteColor];
    namelbl.textAlignment = NSTextAlignmentCenter;
    namelbl.font = [UIFont systemFontOfSize:12];
    [img addSubview:namelbl];
    [namelbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(img);
        make.top.equalTo(titlelbl.mas_bottom).offset(12);
        make.height.mas_equalTo(12*HEIGHTRATIO);
    }];
    line = [[UIView alloc] init];
    line.backgroundColor = [NSString colorWithHexString:@"#27292b"];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(img);
        make.top.equalTo(img.mas_bottom);
        make.height.mas_equalTo(2*HEIGHTRATIO);
    }];
    
}

-(void)setXiamodel:(HSHomexiaModel *)xiamodel
{
    model = xiamodel;
    if (_name != model.title) {
        _name  = model.title;
    }
    if (_image != model.img) {
        
        _image = model.img;
    }
    [self setNeedsDisplay];
}
#pragma mark xjp 添加
- (void)drawContentView:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect cellRect = self.frame;
    
    if (self.highlighted || self.selected)
    {
        CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);
        CGContextFillRect(context, CGRectMake(0, 0, cellRect.size.width, cellRect.size.height));
    }
    else
    {
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextFillRect(context, CGRectMake(0, 0, cellRect.size.width, cellRect.size.height));
    }
    
    [self creat];
    
    // [self mydarw];
    
    [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.img]] placeholderImage:[UIImage imageNamed:@"default_img_live"]];
    titlelbl.text = model.title;
    
    namelbl.text = [NSString stringWithFormat:@"%@",model.author];
}


//-(void)mydarw{
//    
//    img = [[UIImageView alloc] init];
//    [self addSubview:img];
//    [img mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self);
//        make.top.equalTo(self);
//        make.height.equalTo(@180);
//    }];
////    titlelbl = [[UILabel alloc] init];
////    titlelbl.textColor = [UIColor whiteColor];
////    titlelbl.textAlignment = NSTextAlignmentCenter;
////    titlelbl.font = [UIFont systemFontOfSize:16];
//    
//    
//    
////    SDWebImageManager *manager = [SDWebImageManager sharedManager];
//////    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.img]];
////    [manager downloadImageWithURL:[NSURL URLWithString:model.img] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
////        
////    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
////        
////        [image drawInRect:CGRectMake(0, 0, WIDTH, 180)];
////
////    } ];
//    
//    
//    
//    UIColor *nameColor = [UIColor redColor];
//    [nameColor set];
//    
//    [_name drawInRect:CGRectMake(0, 70, WIDTH,16) withFont:[UIFont systemFontOfSize:14] lineBreakMode:NSLineBreakByCharWrapping alignment:UIBaselineAdjustmentAlignCenters];
//    
////    [img addSubview:titlelbl];
////    [titlelbl mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.left.right.equalTo(img);
////        make.top.equalTo(@70);
////        make.height.equalTo(@16);
////        
////    }];
////    namelbl = [[UILabel alloc] init];
////    namelbl.textColor = [UIColor whiteColor];
////    namelbl.textAlignment = NSTextAlignmentCenter;
////    namelbl.font = [UIFont systemFontOfSize:12];
////    [img addSubview:namelbl];
////    [namelbl mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.left.right.equalTo(img);
////        make.top.equalTo(img.mas_bottom).offset(12);
////        make.height.equalTo(@12);
////    }];
//    
//    
//    
//}
//
//
//+ (void)toDrawTextWithRect:(CGRect)rect1 str:(NSString*)str1 context:(CGContextRef)context{
//    if( str1 == nil || context == nil)
//        return;
//    
//    CGContextSetLineWidth(context, 1.0);
//    CGContextSetRGBFillColor (context, 0.01, 0.01, 0.01, 1);
//    
//    //段落格式
//    NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
//    textStyle.lineBreakMode = NSLineBreakByWordWrapping;
//    textStyle.alignment = NSTextAlignmentCenter;//水平居中
//    //字体
//    UIFont  *font = [UIFont boldSystemFontOfSize:22.0];
//    //构建属性集合
//    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:textStyle};
//    //获得size
//    CGSize strSize = [str1 sizeWithAttributes:attributes];
//    CGFloat marginTop = (rect1.size.height - strSize.height)/2;
//    //垂直居中要自己计算
//    CGRect r = CGRectMake(rect1.origin.x, rect1.origin.y + marginTop,rect1.size.width, strSize.height);
//    [str1 drawInRect:r withAttributes:attributes];
//}
@end





























