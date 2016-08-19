//
//  ViewController.m
//  TransitionAnimationDemo
//
//  Created by 伯明利 on 16/8/12.
//  Copyright © 2016年 bomingli. All rights reserved.
//

#import "ViewController.h"
#import "TraansitionViewController.h"
#import "PictureViewController.h"
#import "FoldViewController.h"

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
- (IBAction)touchPictureView:(UIButton *)sender {
    PictureViewController *pictureVC = [[PictureViewController alloc] init];
    [self.navigationController pushViewController:pictureVC animated:YES];
}
- (IBAction)touchFold:(UIButton *)sender {
    FoldViewController *foldVC = [[FoldViewController alloc] init];
    [self.navigationController pushViewController:foldVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
