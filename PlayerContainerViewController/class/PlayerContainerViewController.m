//
//  PlayerContainerViewController.m
//  ChirdVCRotateDemo
//
//  Created by Mrlu on 28/02/2017.
//  Copyright © 2017 Mrlu. All rights reserved.
//

#import "PlayerContainerViewController.h"
#import "PlayerLandscapeViewController.h"

// PMScreen
#define PMPlayerScreenWidth ([UIScreen mainScreen].bounds.size.width < [UIScreen mainScreen].bounds.size.height ? [UIScreen mainScreen].bounds.size.width:[UIScreen mainScreen].bounds.size.height)
#define PMPlayerScreenHeight ([UIScreen mainScreen].bounds.size.width > [UIScreen mainScreen].bounds.size.height ? [UIScreen mainScreen].bounds.size.width:[UIScreen mainScreen].bounds.size.height)

#define PMFullScreenFrame  CGRectMake(0, 0, PMPlayerScreenHeight, PMPlayerScreenWidth)

@interface PlayerContainerViewController ()

@property (nonatomic, assign) CGRect displayFullRect;
@property (nonatomic, assign) UIDeviceOrientation formOrientation;
@property (nonatomic, assign) UIDeviceOrientation currentOrientation;

@property (nonatomic, strong) UIView *superView;
@property (nonatomic, strong) UIView *playerView;
@property (nonatomic, strong) PlayerLandscapeViewController *landscapeViewController;

@property (nonatomic, assign, readwrite) PlayerDisplayStyle displayStyle;

@end

@implementation PlayerContainerViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.displayStyle = PlayerDisplayStyleNormal;
        self.displayFullRect = PMFullScreenFrame;
    }
    return self;
}

- (instancetype)initWithViewController:(UIViewController *)viewController
{
    return [self initWithView:nil viewController:viewController];
}

- (instancetype)initWithView:(nullable UIView *)view viewController:(UIViewController *)viewController
{
    self = [super init];
    if (self) {
        if (view) {
            self.superView = view;
            self.displayNormalRect = view.bounds;
        }
        self.portraitViewController = viewController;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNotification];
    
    self.view = self.playerView;
    
    switch (self.displayStyle) {
        case PlayerDisplayStyleFull:
            self.view.frame = self.displayFullRect;
            break;
        case PlayerDisplayStyleNormal:
            self.view.frame = self.displayNormalRect;
            break;
        case PlayerDisplayStyleMini:
            self.view.frame = self.displayMiniRect;
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChangeNotification:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)changedUIAnimated:(BOOL)animated
{
    if (self.displayStyle == PlayerDisplayStyleFull) { //全屏
        if ([self.parentViewController isEqual:self.landscapeViewController]) {
            self.formOrientation  = [UIDevice currentDevice].orientation;
            return;
        }
        [self.parentViewController presentViewController:self.landscapeViewController animated:NO completion:^{
            //mvPlayer原先是作为protraitViewController的子UIViewControlle
            [self removeFromParentViewController];
            //改为作为landscapeViewController的子UIViewController
            [self.landscapeViewController addChildViewController:self];
            [self.landscapeViewController.view addSubview:self.view];
            
            //frame
            self.view.frame = self.displayFullRect;
            
            //旋转前
            if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft) {
                CGAffineTransform transform = CGAffineTransformMakeRotation(-M_PI_2);
                self.view.transform = transform;
            } else if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight) {
                CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2);
                self.view.transform = transform;
            }
            
            if (animated) {
                //旋转动画
                [UIView animateWithDuration:[UIApplication sharedApplication].statusBarOrientationAnimationDuration
                                      delay:0
                                    options:UIViewAnimationOptionCurveEaseInOut
                                 animations:^{
                                     self.view.transform = CGAffineTransformIdentity;
                                 }completion:^(BOOL finished){
                                 }];
            } else {
                self.view.transform = CGAffineTransformIdentity;
            }
            self.formOrientation = self.currentOrientation;
        }];
    } else if (self.displayStyle == PlayerDisplayStyleNormal) { //normal
        if ([self.parentViewController isEqual:self.portraitViewController]) {
            return;
        }
        
        //更改mvPlayer的父UIController
        [self.landscapeViewController dismissViewControllerAnimated:NO completion:^{
            
            [self removeFromParentViewController];
            
            [self.portraitViewController addChildViewController:self];
            
            if (self.superView) {
                [self.superView addSubview:self.view];
            } else {
                [self.portraitViewController.view addSubview:self.view];
            }
            
            self.view.frame = self.displayNormalRect;
            
            if (self.formOrientation == UIDeviceOrientationLandscapeLeft) {
                CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2);
                self.view.transform = transform;
            } else if (self.formOrientation == UIDeviceOrientationLandscapeRight) {
                CGAffineTransform transform = CGAffineTransformMakeRotation(-M_PI_2);
                self.view.transform = transform;
            }
            if (animated) {
                [UIView animateWithDuration:[UIApplication sharedApplication].statusBarOrientationAnimationDuration
                                      delay:0
                                    options:UIViewAnimationOptionCurveEaseInOut
                                 animations:^{
                                     self.view.transform = CGAffineTransformIdentity;
                                 }
                                 completion:^(BOOL finished) {
                                     
                                 }];
            } else {
                self.view.transform = CGAffineTransformIdentity;
            }
            self.formOrientation = self.currentOrientation;
            self.landscapeViewController = nil;
        }];
    } else if (self.displayStyle == PlayerDisplayStyleMini) { //mini
        if ([self.parentViewController isEqual:self.landscapeViewController]) {
            return;
        }
        
        [self.portraitViewController.view addSubview:self.view];
        
        //更改mvPlayer的父UIController
        if (animated) {
            [UIView animateWithDuration:[UIApplication sharedApplication].statusBarOrientationAnimationDuration
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 self.view.frame = self.displayMiniRect;
                             }
                             completion:^(BOOL finished) {
                                 self.view.frame = self.displayMiniRect;
                             }];
        } else {
            self.view.frame = self.displayMiniRect;
        }
        self.formOrientation = self.currentOrientation;
    }
}

#pragma mark - property Getter/Setter
- (UIView *)playerView
{
    if (!_playerView) {
        _playerView = [UIView new];
    }
    return _playerView;
}

- (PlayerLandscapeViewController *)landscapeViewController
{
    if (!_landscapeViewController) {
        _landscapeViewController = [PlayerLandscapeViewController new];
    }
    return _landscapeViewController;
}

- (void)setDisplayNormalRect:(CGRect)displayNormalRect
{
    _displayNormalRect = displayNormalRect;
    if (self.displayStyle == PlayerDisplayStyleNormal) {
        self.view.frame = _displayNormalRect;
    }
}

#pragma mark - Public Interface
- (void)showDisplayNormalInView:(UIView *)view {
    self.displayStyle = PlayerDisplayStyleNormal;
    self.displayNormalRect = view.bounds;
    self.view.frame = self.displayNormalRect;
    self.superView = view;
    [self.superView addSubview:self.view];
}

- (void)showMiniDisplay:(BOOL)ainimated {
    self.displayStyle = PlayerDisplayStyleMini;
    [self changedUIAnimated:ainimated];
}

- (void)changePlayerDisplayStyle:(PlayerDisplayStyle)disPlayStyle {
    if (self.displayStyle != disPlayStyle) {
        // 旋转后统一根据旋转后的方向设定type
        if (disPlayStyle == PlayerDisplayStyleFull) {
            [[UIDevice currentDevice] setValue: [NSNumber numberWithInteger: UIInterfaceOrientationLandscapeRight] forKey:@"orientation"];
        } else {
            [[UIDevice currentDevice] setValue: [NSNumber numberWithInteger: UIDeviceOrientationPortrait] forKey:@"orientation"];
        }
    }
}

#pragma mark - notification
- (void)deviceOrientationDidChangeNotification:(NSNotification *)notification {
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if (orientation >= UIDeviceOrientationFaceUp || orientation == self.currentOrientation || orientation == UIDeviceOrientationUnknown || orientation == UIDeviceOrientationPortraitUpsideDown) {
        return;
    } else {
        self.currentOrientation = orientation;
        if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight) {
            self.displayStyle = PlayerDisplayStyleFull;
        } else if (orientation == UIDeviceOrientationPortrait) {
            self.displayStyle = PlayerDisplayStyleNormal;
        }
        [self changedUIAnimated:YES];
    }
}


@end
