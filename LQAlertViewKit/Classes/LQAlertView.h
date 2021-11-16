//
//  LQAlertView.h
//  LQAlertViewKit_Example
//
//  Created by purang on 2021/11/10.
//  Copyright © 2021 qingqiusuomeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQAlertViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LQAlertView : UIView
@property(nonatomic,strong)LQAlertViewModel *model;
@property (nonatomic, copy) void(^alertLeftBtnBlock)(void);
@property (nonatomic, copy) void(^alertRightBtnBlock)(void);
@property (nonatomic, copy) void(^alertRightBtnContentBlock)(NSString *content);
- (instancetype)alertViewWithModel:(LQAlertViewModel *)model;
- (instancetype)alertInputViewWithModel:(LQAlertViewModel *)model;
- (void)showAlertView;

- (void)setTitleColor:(UIColor *)color;
- (void)setMessageColor:(UIColor *)color;
- (void)setCancelColor:(UIColor *)color;
- (void)setSureColor:(UIColor *)color;
- (void)setHLineColor:(UIColor *)color;
- (void)setVLineColor:(UIColor *)color;
- (void)setInputTextColor:(UIColor *)color;
- (void)setInputBorderColor:(UIColor *)color;

- (void)setTitleFont:(UIFont *)font;
- (void)setMessageFont:(UIFont *)font;
- (void)setCancelFont:(UIFont *)font;
- (void)setSureFont:(UIFont *)font;
- (void)setInputTextFont:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
