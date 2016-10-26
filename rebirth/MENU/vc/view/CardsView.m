//
//  CardsView.m
//  rebirth
//
//  Created by WJF on 16/9/21.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import "CardsView.h"
#import "HSVegetableViewController.h"
@implementation CardsView

-(instancetype)initWithFrame:(CGRect)frame arrWithView:(NSMutableArray *)dataArr  withOrigin:(NSString *)origin{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.origin = origin;
        self.userInteractionEnabled = YES;
        self.layer.masksToBounds = YES;
        self.dataSources = [NSMutableArray array];
        self.totalData = [NSMutableArray arrayWithArray:dataArr];
        if (dataArr.count > 5) {
            
            for (int i = 0; i < 5; i ++) {
                
                [self.dataSources addObject:dataArr[i]];
            }
            self.currurtArr = 5;
            
        }else{
            
            self.dataSources = dataArr;
        }
        
        [self createView:origin];
        
    }
    
    return self;
}


-(void)createView:(NSString *)orign{
    
    self.container1 = [[YSLDraggableCardContainer alloc] initWithFrame:CGRectMake(0, 24*HEIGHTRATIO, WIDTH, 370*HEIGHTRATIO) withOrign:orign];
    self.container1.delegate = self;
    self.container1.dataSource = self;
    self.container1.canDraggableDirection = YSLDraggableDirectionUp|YSLDraggableDirectionDown;
    [self addSubview:self.container1];
    [self.container1 reloadCardContainer];
    
   
}


#pragma mark -- YSLDraggableCardContainer DataSource
- (UIView *)cardContainerViewNextViewWithIndex:(NSInteger)index
{
    
    NSDictionary *dict = _dataSources[index];

    CardView *view = [[CardView alloc]initWithFrame:CGRectMake(20, 17*HEIGHTRATIO, WIDTH - 40, 340*HEIGHTRATIO)];
    
    //选取圆角
    view.imageView.layer.masksToBounds = YES;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.imageView.bounds byRoundingCorners:UIRectCornerTopRight|UIRectCornerTopLeft cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame =view.imageView.bounds;
    maskLayer.path = maskPath.CGPath;
    view.imageView.layer.mask = maskLayer;
    view.backgroundColor = [UIColor whiteColor];
    [view.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dict[@"img"]]] placeholderImage:[UIImage imageNamed:@"default_img_cards"]];
    view.titleLabel.text = [NSString stringWithFormat:@"%@",dict[@"title"]];
    view.subtitleLabel.text = [NSString stringWithFormat:@"%@",dict[@"info"]];
    return view;
}

- (NSInteger)cardContainerViewNumberOfViewInIndex:(NSInteger)index
{
    return _dataSources.count;
}

#pragma mark -- YSLDraggableCardContainer Delegate
- (void)cardContainerView:(YSLDraggableCardContainer *)cardContainerView didEndDraggingAtIndex:(NSInteger)index draggableView:(UIView *)draggableView draggableDirection:(YSLDraggableDirection)draggableDirection
{
    if (draggableDirection == YSLDraggableDirectionLeft) {
        [cardContainerView movePositionWithDirection:draggableDirection
                                         isAutomatic:NO];
    }
    
    if (draggableDirection == YSLDraggableDirectionRight) {
        [cardContainerView movePositionWithDirection:draggableDirection
                                         isAutomatic:NO];
    }
    
    if (draggableDirection == YSLDraggableDirectionUp) {
        [cardContainerView movePositionWithDirection:draggableDirection
                                         isAutomatic:NO];
    }
    if (draggableDirection == YSLDraggableDirectionDown) {
        [cardContainerView movePositionWithDirection:draggableDirection
                                         isAutomatic:NO];
    }
}

- (void)cardContainderView:(YSLDraggableCardContainer *)cardContainderView updatePositionWithDraggableView:(UIView *)draggableView draggableDirection:(YSLDraggableDirection)draggableDirection widthRatio:(CGFloat)widthRatio heightRatio:(CGFloat)heightRatio
{
    
}

- (void)cardContainerViewDidCompleteAll:(YSLDraggableCardContainer *)container;
{

    
    self.dataSources = [NSMutableArray array];
    float number = 0;
    NSLog(@"%d",self.currurtArr);
    if (self.totalData.count > 5) {
        
  
    if (self.currurtArr+5 > self.totalData.count) {
        
        number = self.totalData.count;
        
    }else{
        
        number = self.currurtArr+5;
    }
    
    for (int i = self.currurtArr-1;i < number; i++) {
        
        [self.dataSources addObject:self.totalData[i]];
    }
    self.currurtArr = self.currurtArr+5;
    
    if(self.currurtArr > self.totalData.count){
        
        self.currurtArr = 1;

        
    }
        [container reloadCardContainer];

    }else{
        
        self.dataSources = [NSMutableArray arrayWithArray:self.totalData];
        [container reloadCardContainer];

        
    }
}

- (void)cardContainerView:(YSLDraggableCardContainer *)cardContainerView didSelectAtIndex:(NSInteger)index draggableView:(UIView *)draggableView
{
    
    if([self.origin isEqualToString:@"DingzhiRoute"] ){
        NSDictionary *dict = _dataSources[index];
        HSVegetableViewController *vc = [[HSVegetableViewController alloc]init];
        //vc.pricelevel = self.pricelevel;
        vc.info_id =dict[@"info_id"];
        vc.item_id =dict[@"item_id"];
        vc.image_URL = dict[@"img"];
        //vc.selectTime = dict[@"qucheTime"];
        if (self.grade == 0) {
            vc.caipu = @"car";
        }else if(self.grade == 1){
            vc.caipu = @"caipu";
        }else if(self.grade == 2){
            vc.caipu = @"hotel";
        }
        
        [[self viewController].navigationController pushViewController:vc  animated:YES];
        

        
    }
    NSLog(@"++ index : %ld====%ld",(long)index,(long)self.grade);
    
    
}

- (UIViewController *)viewController
{
    //获取当前view的superView对应的控制器
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
