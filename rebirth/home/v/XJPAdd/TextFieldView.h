//
//  TextFieldView.h
//  ReviewTextField
//
//  Created by youme on 16/1/13.
//  Copyright © 2016年 youme. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SendReviewValueDelegate <NSObject>

@optional
- (void)sendReviewValue:(NSString *)text;

@end

@interface TextFieldView : UIView<SendReviewValueDelegate>

@property (nonatomic , strong) id<SendReviewValueDelegate> delegate;

@end
