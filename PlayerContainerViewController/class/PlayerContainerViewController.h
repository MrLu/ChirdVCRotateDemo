//
//  PlayerContainerViewController.h
//  ChirdVCRotateDemo
//
//  Created by Mrlu on 28/02/2017.
//  Copyright © 2017 Mrlu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PlayerDisplayStyle) {
    PlayerDisplayStyleMini,  //小屏幕
    PlayerDisplayStyleNormal, //正常屏幕
    PlayerDisplayStyleFull //大屏幕
};

NS_ASSUME_NONNULL_BEGIN

@interface PlayerContainerViewController : UIViewController

@property (nonatomic, strong, nonnull) UIViewController *portraitViewController;
@property (nonatomic, assign, readonly) PlayerDisplayStyle displayStyle;
@property (nonatomic, assign) BOOL displayMiniEnable;
@property (nonatomic, assign) CGRect displayMiniRect;
@property (nonatomic, assign) CGRect displayNormalRect;

- (instancetype)initWithViewController:(UIViewController *)viewController;

- (instancetype)initWithView:(nullable UIView *)view viewController:(UIViewController *)viewController;

- (void)showDisplayNormalInView:(UIView *)view;

- (void)showMiniDisplay:(BOOL)ainimated;

- (void)changePlayerDisplayStyle:(PlayerDisplayStyle)disPlayStyle;

@end

NS_ASSUME_NONNULL_END
