//
//  TraansitionViewController.m
//  TransitionAnimationDemo
//
//  Created by 伯明利 on 16/8/12.
//  Copyright © 2016年 bomingli. All rights reserved.
//

#import "TraansitionViewController.h"

@interface TraansitionViewController ()
@property (strong, nonatomic) IBOutlet UISegmentedControl *segment;

@end

@implementation TraansitionViewController
{
    UIImageView *_imageView;
    NSInteger _currentImage;
    UIImageView *_secondImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self config];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)config {
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, kScreenWidth)];
    [_imageView setImage:[UIImage imageNamed:@"0"]];
    _imageView.userInteractionEnabled = YES;
    [self.view addSubview:_imageView];
    
    _secondImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageView.frame), kScreenWidth, kScreenHeight - kScreenWidth - 100)];
    [_secondImageView setImage:[[[UIImage imageNamed:@"0"] reflectionRotatedWithAlpha:1] reflectionWithAlpha:1]];
    [self.view addSubview:_secondImageView];
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [_imageView addGestureRecognizer:leftSwipe];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [_imageView addGestureRecognizer:rightSwipe];
    
    UISwipeGestureRecognizer *upSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    upSwipe.direction = UISwipeGestureRecognizerDirectionUp;
    [_imageView addGestureRecognizer:upSwipe];
    
    UISwipeGestureRecognizer *downSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    downSwipe.direction = UISwipeGestureRecognizerDirectionDown;
    [_imageView addGestureRecognizer:downSwipe];
}

- (void)swipe:(UISwipeGestureRecognizer *)sender {
    [self transitionWith:sender.direction];
}

- (void)transitionWith:(UISwipeGestureRecognizerDirection )direction {
    CATransition *transition = [[CATransition alloc] init];
    transition.duration = 1.f;
    transition.type = [_segment titleForSegmentAtIndex:_segment.selectedSegmentIndex];
    switch (direction) {
        case UISwipeGestureRecognizerDirectionLeft:
            transition.subtype = kCATransitionFromRight;
            break;
        case UISwipeGestureRecognizerDirectionRight:
            transition.subtype = kCATransitionFromLeft;
            break;
        case UISwipeGestureRecognizerDirectionUp:
            transition.subtype = kCATransitionFromTop;
            break;
        case UISwipeGestureRecognizerDirectionDown:
            transition.subtype = kCATransitionFromBottom;
            break;
        default:
            break;
    }
    UIImage *image = [self getImageWithCurrentImage:_currentImage direction:direction];
    _imageView.image = image;
    [_imageView.layer addAnimation:transition forKey:@"KCTransitionAnimation"];

    
    image = [[image reflectionRotatedWithAlpha:1] reflectionWithAlpha:1];
    [_secondImageView setImage:image];
    [_secondImageView.layer addAnimation:[self transitionForRippleEffect] forKey:@"KCTransitionAnimation"];

}

- (CATransition *)transitionForRippleEffect {
    CATransition *transition = [[CATransition alloc] init];
    transition.duration = 1.f;
    transition.type = [_segment titleForSegmentAtIndex:1];
    return transition;
}

- (UIImage *)getImageWithCurrentImage:(NSInteger)current direction:(UISwipeGestureRecognizerDirection )direction {
    NSInteger imageName = current;
    if (current >= 0 && current <= 3) {
        if (direction == UISwipeGestureRecognizerDirectionRight) {
            imageName = (imageName + 1) % 4;
        } else if (direction == UISwipeGestureRecognizerDirectionLeft) {
            imageName = (imageName + 4 - 1) % 4;
        } else if (direction == UISwipeGestureRecognizerDirectionUp) {
            imageName = 4;
        } else {
            imageName = 5;
        }
    } else if (current == 4){
        if (direction == UISwipeGestureRecognizerDirectionRight) {
            imageName = 1;
        } else if (direction == UISwipeGestureRecognizerDirectionLeft) {
            imageName = 3;
        } else if (direction == UISwipeGestureRecognizerDirectionUp) {
            imageName = 2;
        } else {
            imageName = 0;
        }
    } else {
        if (direction == UISwipeGestureRecognizerDirectionRight) {
            imageName = 1;
        } else if (direction == UISwipeGestureRecognizerDirectionLeft) {
            imageName = 3;
        } else if (direction == UISwipeGestureRecognizerDirectionUp) {
            imageName = 0;
        } else {
            imageName = 2;
        }
    }
    _currentImage = imageName;
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",imageName]];
    
    return image;
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
