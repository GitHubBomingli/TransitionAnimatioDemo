//
//  UIImage+Reflection.h
//  TransitionAnimationDemo
//
//  Created by 伯明利 on 16/8/13.
//  Copyright © 2016年 bomingli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Reflection)

- (UIImage *)reflectionWithHeight:(int)height;

- (UIImage *)reflectionWithAlpha:(float)pcnt;

- (UIImage *)reflectionRotatedWithAlpha:(float)pcnt;
@end
