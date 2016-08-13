//
//  PictureViewController.m
//  TransitionAnimationDemo
//
//  Created by 伯明利 on 16/8/13.
//  Copyright © 2016年 bomingli. All rights reserved.
//

#import "PictureViewController.h"
#import "BMLPictureView.h"

@interface PictureViewController ()

@end

@implementation PictureViewController
{
    BMLPictureView *pictureView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSMutableArray *images = [NSMutableArray array];
    for (NSInteger index = 0; index != 6; index ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",index]];
        [images addObject:image];
    }
    
    pictureView = [[BMLPictureView alloc] initWithImages:images];
    [self.navigationController.view addSubview:pictureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if ([touch.view isEqual:self.view]) {
        [pictureView showWithIndex:0];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
