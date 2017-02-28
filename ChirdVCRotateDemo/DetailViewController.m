//
//  DetailViewController.m
//  ChirdVCRotateDemo
//
//  Created by Mrlu on 28/02/2017.
//  Copyright © 2017 Mrlu. All rights reserved.
//

#import "DetailViewController.h"
#import "PlayerContainerViewController.h"

@interface DetailViewController ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIView *movieView;

@property (nonatomic, strong) PlayerContainerViewController *playerContainerVC;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.backgroundImageView.image = [UIImage imageNamed:@"IMG_1271.jpg"];
    self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.backgroundImageView];
    
    CGRect frame = self.view.bounds;
    frame.size.height = self.backgroundImageView.image.size.height*self.backgroundImageView.bounds.size.width/self.backgroundImageView.image.size.width;
    self.backgroundImageView.frame = frame;
    
    self.movieView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 211)];
    [self.view addSubview:self.movieView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [backBtn setFrame:CGRectMake(10, 30, 35, 35)];
    [backBtn setTitle:@"Back" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    //
    self.playerContainerVC = [[PlayerContainerViewController alloc] initWithView:self.movieView viewController:self];
    self.playerContainerVC.view.backgroundColor = [UIColor blackColor];
    [self addChildViewController:self.playerContainerVC]; //增加子容器
    [self.movieView addSubview:self.playerContainerVC.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backBtnAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
