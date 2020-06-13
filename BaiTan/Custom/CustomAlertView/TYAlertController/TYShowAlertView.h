//
//  TYShowAlertView.h
//  TYAlertControllerDemo
//
//  Created by tanyang on 15/3/16.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYShowAlertView : UIView

@property (nonatomic, weak, readonly) UIView *alertView;
@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, assign) BOOL backgoundTapDismissEnable;  // default NO
@property (nonatomic, assign) CGFloat alertViewOriginY;  // default center Y
@property (nonatomic, assign) CGFloat alertViewEdging;   // default 15
@property (nonatomic, assign) CGFloat backgroundOpacity;   // default 0.2

+(void)showAlertViewWithView:(UIView *)alertView;

+ (void)showAlertViewWithView:(UIView *)alertView backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable backgroundOpacity:(CGFloat)opacity;

+ (void)showAlertViewWithView:(UIView *)alertView backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable;

+(void)showAlertViewWithView:(UIView *)alertView originY:(CGFloat)originY;

+(void)showAlertViewWithView:(UIView *)alertView originY:(CGFloat)originY backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable;

+ (instancetype)alertViewWithView:(UIView *)alertView;

- (void)show;

- (void)hide:(BOOL) ifSendNot;
@end
