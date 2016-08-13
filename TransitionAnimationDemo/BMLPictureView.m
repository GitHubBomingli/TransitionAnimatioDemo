//
//  BMLPictureView.m
//  TransitionAnimationDemo
//
//  Created by 伯明利 on 16/8/13.
//  Copyright © 2016年 bomingli. All rights reserved.
//

#import "BMLPictureView.h"
#define KSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define KSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@implementation BMLPictureView
{
    UIImageView *_imageView;
    UILabel *_countLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        if (!_countLabel) {
            _countLabel = [[UILabel alloc] init];
            _countLabel.backgroundColor = [UIColor clearColor];
            _countLabel.text = [NSString stringWithFormat:@"%ld/%ld",_index + 1,_images.count];
            _countLabel.textColor = [UIColor whiteColor];
            _countLabel.font = [UIFont systemFontOfSize:12];
            _countLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_countLabel];
        }
        
        if (!_imageView) {
            _imageView = [[UIImageView alloc] init];
            _imageView.userInteractionEnabled = YES;
            [self addSubview:_imageView];
//            [self setImage:0];
        }
        
        [self config];
    }
    return self;
}

- (instancetype)initWithImages:(NSArray<UIImage *> *)images {
    _images = images;
    return [self init];
}

- (void)setImage:(NSInteger)index {
    UIImage *image = _images[index];
    CGFloat height = image.size.height * KSCREEN_WIDTH / image.size.width;
    _imageView.frame = CGRectMake(0, 0, KSCREEN_WIDTH, height);
    _imageView.center = self.center;
    _imageView.image = image;
    
    _countLabel.frame = CGRectMake(0, KSCREEN_HEIGHT - 50, KSCREEN_WIDTH, 24);
    _countLabel.text = [NSString stringWithFormat:@"%ld/%ld",_index + 1,_images.count];
}

- (void)config {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [_imageView addGestureRecognizer:leftSwipe];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [_imageView addGestureRecognizer:rightSwipe];
    
}

- (void)tap:(UIGestureRecognizer *)sender {
    [self hide];
}

- (void)swipe:(UISwipeGestureRecognizer *)sender {
    [self transitionWith:sender.direction];
}

- (void)transitionWith:(UISwipeGestureRecognizerDirection )direction {
    CATransition *transition = [[CATransition alloc] init];
    transition.duration = 0.4;
    transition.type = @"push";
    switch (direction) {
        case UISwipeGestureRecognizerDirectionLeft: {
            transition.subtype = kCATransitionFromRight;
            _index = (_index + 1) % _images.count;
        }
            break;
        case UISwipeGestureRecognizerDirectionRight: {
            transition.subtype = kCATransitionFromLeft;
            _index = (_index + _images.count - 1) % _images.count;
        }
            break;
        default:
            break;
    }
    [self setImage:_index];
    [_imageView.layer addAnimation:transition forKey:@"KCTransitionAnimation"];
}

- (void)showWithIndex:(NSInteger)index {
    _index = index;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        self.frame = [UIScreen mainScreen].bounds;
        [self setImage:index];
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        self.frame = CGRectZero;
        _imageView.frame = CGRectZero;
        _countLabel.frame = CGRectZero;
    }];
}

@end
