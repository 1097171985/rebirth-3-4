//
//  CardsView.h
//  rebirth
//
//  Created by WJF on 16/9/21.
//  Copyright © 2016年 侯帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSLDraggableCardContainer.h"
#import "CardView.h"
typedef NS_OPTIONS(NSInteger, Grade) {
    WJFLowGrade, 
    WJFMiddleGrade,
    WJFHeightGrade
};

@interface CardsView : UIView<YSLDraggableCardContainerDelegate,
YSLDraggableCardContainerDataSource>

@property (nonatomic, strong) YSLDraggableCardContainer *container1;

@property (nonatomic, strong) NSMutableArray *dataSources;

@property(nonatomic, strong)NSMutableArray *totalData;
@property (nonatomic, assign) Grade grade;


@property(nonatomic ,strong) NSString *pricelevel;

@property(nonatomic, strong)NSString *origin;//来源

@property(nonatomic, assign)int  currurtArr;//当前数组到哪了

-(instancetype)initWithFrame:(CGRect)frame arrWithView:(NSMutableArray *)dataArr withOrigin:(NSString *)origin;
@end
