//
//  UIPlaceHolderTextView.h
//  UITextView 实现placeholder的方法
//
//  Created by iOS吴 加锋 on 16/5/19.
//  Copyright © 2016年 iOS吴 加锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface UIPlaceHolderTextView : UITextView
{
    
    NSString *placeholder;
    
    UIColor *placeholderColor;
    
    
    
@private
    
    UILabel *placeHolderLabel;
    
}


@property(nonatomic, retain) UILabel *placeHolderLabel;

@property(nonatomic, retain) NSString *placeholder;

@property(nonatomic, retain) UIColor *placeholderColor;



-(void)textChanged:(NSNotification*)notification;


@end
