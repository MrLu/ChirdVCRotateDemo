//
//  NavViewController.m
//  ChirdVCRotateDemo
//
//  Created by Mrlu on 28/02/2017.
//  Copyright © 2017 Mrlu. All rights reserved.
//

#import "NavViewController.h"

@implementation NavViewController

- (BOOL)shouldAutorotate
{
    return [self.viewControllers.lastObject shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}

@end
