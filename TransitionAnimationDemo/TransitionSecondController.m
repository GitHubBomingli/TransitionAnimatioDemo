//
//  TransitionSecondController.m
//  TransitionAnimationDemo
//
//  Created by 伯明利 on 16/9/5.
//  Copyright © 2016年 bomingli. All rights reserved.
//

#import "TransitionSecondController.h"

@interface TransitionSecondController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation TransitionSecondController
{
    NSMutableArray *dataSource;
    NSInteger index;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    dataSource = [NSMutableArray arrayWithObjects:@"",@"",@"", nil];
    
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [_tableView addGestureRecognizer:leftSwipe];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [_tableView addGestureRecognizer:rightSwipe];
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
            index ++;
        }
            break;
        case UISwipeGestureRecognizerDirectionRight: {
            transition.subtype = kCATransitionFromLeft;
            index --;
        }
            break;
        default:
            break;
    }
    
    [_tableView.layer addAnimation:transition forKey:@"KCTransitionAnimation"];
    
    [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReusableCellWithUITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ReusableCellWithUITableViewCell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"*******    index: %ld cell: %ld    *******",index,indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
