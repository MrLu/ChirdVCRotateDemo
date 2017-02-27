//
//  ViewController.m
//  ChirdVCRotateDemo
//
//  Created by Mrlu on 28/02/2017.
//  Copyright © 2017 Mrlu. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn.frame = CGRectMake(0, 0, 80, 40);
    self.btn.center = self.view.center;
    [self.btn setTitle:@"详情" forState:UIControlStateNormal];
    [self.btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnAction:(UIButton *)sender
{
    UIViewController *vc = [DetailViewController new];
    [self.navigationController pushViewController:vc animated:YES];
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
