//
//  ViewController.m
//  TransitionAnimationDemo
//
//  Created by 伯明利 on 16/8/12.
//  Copyright © 2016年 bomingli. All rights reserved.
//

#import "ViewController.h"
#import "TraansitionViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
- (IBAction)touchTransition:(UIButton *)sender {
    TraansitionViewController *transitionVC = [[TraansitionViewController alloc] init];
    [self.navigationController pushViewController:transitionVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
