//
//  AnnularProgress.m
//  smallVideo
//
//  Created by WJF on 16/9/22.
//  Copyright © 2016年 WJF. All rights reserved.
//

#import "AnnularProgress.h"

#define SELF_WIDTH CGRectGetWidth(self.bounds)
#define SELF_HEIGHT CGRectGetHeight(self.bounds)
#define DEGREES_TO_RADOANS(x) (M_PI * (x) / 180.0) // 将角度转为弧度

@interface AnnularProgress ()

@property (strong, nonatomic) CAShapeLayer *colorMaskLayer; // 渐变色遮罩
@property (strong, nonatomic) CAShapeLayer *colorLayer; // 渐变色
@property (strong, nonatomic) CAShapeLayer *blueMaskLayer; // 蓝色背景遮罩

@end

@implementation AnnularProgress

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [AnnularProgress backgroundColor];
        
        [self setupColorLayer];
        [self setupColorMaskLayer];
        [self setupBlueMaskLayer];
    }
    return self;
}
- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.backgroundColor = [AnnularProgress backgroundColor];
    
    [self setupColorLayer];
    [self setupColorMaskLayer];
    [self setupBlueMaskLayer];
}

/**
 *  设置整个蓝色view的遮罩
 */
- (void)setupBlueMaskLayer {
    
    CAShapeLayer *layer = [self generateMaskLayer];
    self.layer.mask = layer;
    self.blueMaskLayer = layer;
}

/**
 *  设置渐变色，渐变色由左右两个部分组成，左边部分由黄到绿，右边部分由黄到红
 */
- (void)setupColorLayer {
    
    self.colorLayer = [CAShapeLayer layer];
    self.colorLayer.frame = self.bounds;
    [self.layer addSublayer:self.colorLayer];
    
    CAGradientLayer *leftLayer = [CAGradientLayer layer];
    leftLayer.frame = CGRectMake(0, 0, SELF_WIDTH / 2, SELF_HEIGHT);
    // 分段设置渐变色
    leftLayer.locations = @[@0.3, @0.9, @1];
    leftLayer.colors = @[(id)[AnnularProgress centerColor].CGColor, (id)[AnnularProgress startColor].CGColor];
    [self.colorLayer addSublayer:leftLayer];
    
    CAGradientLayer *rightLayer = [CAGradientLayer layer];
    rightLayer.frame = CGRectMake(SELF_WIDTH / 2, 0, SELF_WIDTH / 2, SELF_HEIGHT);
    rightLayer.locations = @[@0.3, @0.9, @1];
    rightLayer.colors = @[(id)[AnnularProgress centerColor].CGColor, (id)[AnnularProgress endColor].CGColor];
    [self.colorLayer addSublayer:rightLayer];
}

/**
 *  设置渐变色的遮罩
 */
- (void)setupColorMaskLayer {
    
    CAShapeLayer *layer = [self generateMaskLayer];
    layer.lineWidth = [AnnularProgress lineWidth] + 0.5; // 渐变遮罩线宽较大，防止蓝色遮罩有边露出来
    self.colorLayer.mask = layer;
    self.colorMaskLayer = layer;
}

/**
 *  生成一个圆环形的遮罩层
 *  因为蓝色遮罩与渐变遮罩的配置都相同，所以封装出来
 *
 *  @return 环形遮罩
 */
- (CAShapeLayer *)generateMaskLayer {
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.bounds;
    
    // 创建一个圆心为父视图中点的圆，半径为父视图宽的2/5
    UIBezierPath *path = nil;
    if ([AnnularProgress clockWiseType]) {
        path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(SELF_WIDTH / 2, SELF_HEIGHT / 2) radius:SELF_WIDTH / 2.5 startAngle:[AnnularProgress startAngle] endAngle:[AnnularProgress endAngle] clockwise:YES];
    } else {
        path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(SELF_WIDTH / 2, SELF_HEIGHT / 2) radius:SELF_WIDTH / 2.5 startAngle:[AnnularProgress endAngle] endAngle:[AnnularProgress startAngle] clockwise:NO];
    }
    
    layer.lineWidth = [AnnularProgress lineWidth];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor; // 填充色为透明（不设置为黑色）
    layer.strokeColor = [UIColor blackColor].CGColor; // 随便设置一个边框颜色
    layer.lineCap = kCALineCapRound; // 设置线为圆角
    return layer;
    
}

/**
 *  在修改百分比的时候，修改彩色遮罩的大小
 *
 *  @param persentage 百分比
 */
- (void)setPersentage:(CGFloat)persentage {
    
    _persentage = persentage;
    self.colorMaskLayer.strokeEnd = persentage;
}


+ (UIColor *)startColor {
    
    return [UIColor whiteColor];
}

+ (UIColor *)centerColor {
    
    return [UIColor whiteColor];
}

+ (UIColor *)endColor {
    
    return [UIColor whiteColor];
}

+ (UIColor *)backgroundColor {
    
    return [UIColor grayColor];
}

+ (CGFloat)lineWidth {
    
    return 10;
}

+ (CGFloat)startAngle {
    
    return DEGREES_TO_RADOANS(-90);
}

+ (CGFloat)endAngle {
    
    return DEGREES_TO_RADOANS(270);
}

+ (STClockWiseType)clockWiseType {
    return STClockWiseNo;
}



@end