//
//  BMLPictureView.h
//  TransitionAnimationDemo
//
//  Created by 伯明利 on 16/8/13.
//  Copyright © 2016年 bomingli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMLPictureView : UIView

- (instancetype)initWithImages:(NSArray <UIImage*>*)images;

- (void)showWithIndex:(NSInteger)index;

- (void)hide;

@property (assign ,nonatomic) NSInteger index;

@property (strong ,nonatomic ,readonly) NSArray *images;

@end
