//
//  ImageScrollView.m
//  CheFangTimes
//
//  Created by iOS吴 加锋 on 16/5/10.
//  Copyright © 2016年 ios侯帅. All rights reserved.
//

#import "ImageScrollView.h"
#import "FirstViewController.h"
//设置图片个数
//#define zImageCount 3
//设置宽度
#define zScrollViewSize (self.myScrollView.frame.size)


@implementation ImageScrollView


-(instancetype)initWithFrame:(CGRect)frame{
    
   
    self = [super initWithFrame:frame];
    if (self) {
        
        //[self creatscrollViewImage:3 imageARR:nil];
        }

    return self;
    
}

-(void)creatscrollViewImage:(int)numberImage  imageARR:(NSMutableArray *)imageARR{
    
    NSLog(@"numberImage==%d====%@",numberImage,imageARR);
    self.numberImage = numberImage;
    
    self.array = [NSMutableArray array];
    [self.array addObjectsFromArray:imageARR];
    self.myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 240*HEIGHTRATIO)];
    for (int i=0; i < self.numberImage; i++) {
        CGFloat imageViewX =i * zScrollViewSize.width;
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(imageViewX, 0, zScrollViewSize.width, zScrollViewSize.height)];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageARR[i][@"bannerImage"]] placeholderImage:[UIImage imageNamed:@"1"]];
        imageView.tag = 100 +i;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageViewtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewtapclick:)];
        
        [imageView addGestureRecognizer:imageViewtap];
        
        [self.myScrollView addSubview:imageView];
    }
    
    CGFloat imageViewW=self.numberImage * zScrollViewSize.width;
    
    self.myScrollView.contentSize=CGSizeMake(imageViewW, 0);
    
    self.myScrollView.showsHorizontalScrollIndicator=NO;
    
    self.myScrollView.pagingEnabled=YES;
    
    self.myScrollView.delegate=self;
    [self addSubview:self.myScrollView];
    [self creatPageConVC];

    [self loadTimer];
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    
    CGPoint offset=self.myScrollView.contentOffset;
 
    NSInteger currentPage=offset.x / zScrollViewSize.width;

    self.mypageConView.currentPage=currentPage;
    
}


-(void)creatPageConVC{
    
    
    self.mypageConView = [[UIPageControl alloc]initWithFrame:CGRectMake(0,220*HEIGHTRATIO, kScreenWidth, 10*HEIGHTRATIO)];
    self.mypageConView.backgroundColor = [UIColor clearColor];
    self.mypageConView.numberOfPages = self.numberImage;
    self.mypageConView.currentPage = 0;
    //设置当前页码的颜色
    self.mypageConView.currentPageIndicatorTintColor=[UIColor yellowColor];
    //设置其他页码的颜色
    self.mypageConView.pageIndicatorTintColor=[UIColor grayColor];
    
    [self addSubview:self.mypageConView];
   
}

- (void)changePage:(id)sender
{
  
    NSInteger currentPage=self.mypageConView.currentPage;

    CGPoint offset=self.myScrollView.contentOffset;
    //
    if (currentPage >= self.numberImage - 1) {
        currentPage=0;
        offset.x = 0;
    }else{
        
        
        
      
        currentPage ++;
        //NSLog(@"%f",offset.x);
        offset.x += zScrollViewSize.width;
       
    }
  
    self.mypageConView.currentPage=currentPage;
    [self.myScrollView setContentOffset:offset animated:NO];
}


- (void)loadTimer{
    self.timer=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changePage:) userInfo:nil repeats:YES];
    
    NSRunLoop *mainLoop=[NSRunLoop mainRunLoop];
    [mainLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    [self.timer invalidate];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    [self loadTimer];
}




//图片点击效果
-(void)imageViewtapclick:(UITapGestureRecognizer *)sender{
    
    
    FirstViewController *firstVC = [[FirstViewController alloc] init];
    
    // 2.传存图片的数组
    
    firstVC.firstArray = self.array;
    
    // 3.换个模态的样式
    
    [firstVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    
    UIViewController *view  =   [self  getCurrentViewController:self];
    
    [view presentViewController:firstVC animated:YES completion:^{
        
    }];
    
 
    
 }


- (UIViewController *)getCurrentViewController:(UIView *) currentView
{
    for (UIView* next = [currentView superview]; next; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder;
        }
    }
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
