//
//  HSFHMCell.m
//  rebirth
//
//  Created by 侯帅 on 16/7/25.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "HSFHMCell.h"

@implementation HSFHMCell
{
    UIImageView *img;
    UILabel *titlelbl;
    UILabel *namelbl;
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creat];
    }
    return self;
}
-(void)creat{
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
    UIView*line = [[UIView alloc] init];
    line.backgroundColor = [NSString colorWithHexString:@"#27292b"];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(img.mas_bottom);
        make.height.mas_equalTo(2*HEIGHTRATIO);
    }];
    
}
-(void)setHsmodel:(HSHomexiaModel *)hsmodel{
   // img = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@",hsmodel.img]];
    
    
    
    [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",hsmodel.img]] placeholderImage:[UIImage imageNamed:@"default_img_live"]];
    titlelbl.text = hsmodel.title;
    
    namelbl.text = [NSString stringWithFormat:@"%@",hsmodel.author];
//    __block id sdWebImageOperation = [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",hsmodel.img]] options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        NSLog(@"   收到 == %ld,预期 == %ld",(long)receivedSize,(long)expectedSize);
//        
//    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//        UIImage *aImage = image;
//        //  [cell.progressView removeFromSuperview];
//        NSLog(@"成功了:%lu",(unsigned long)UIImageJPEGRepresentation(aImage, 1).length);
//        img.image = aImage;
//        //SDImageCacheType可以显示是从哪里获得的图片
//        //SDImageCacheTypeNone      0
//        //SDImageCacheTypeDisk      1
//        //SDImageCacheTypeMemory    2
//        switch (cacheType) {
//            case 0:
//                NSLog(@"图片从网络加载获得");
//                break;
//            case 1:
//                NSLog(@"图片从设备硬盘获得");
//                break;
//            case 2:
//                NSLog(@"图片从缓存获得");
//                break;
//            default:
//                break;
//        }
//
//        
//    }];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
