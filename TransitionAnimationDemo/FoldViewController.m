//
//  FoldViewController.m
//  TransitionAnimationDemo
//
//  Created by 伯明利 on 16/8/19.
//  Copyright © 2016年 bomingli. All rights reserved.
//

#import "FoldViewController.h"

#define IMAGE_PER_HEIGIT kScreenWidth / 5.0 * 3 / 4.f

@interface FoldViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation FoldViewController
{
    UIImageView *_one;
    UIImageView *_two;
    UIImageView *_three;
    UIImageView *_four;
    
    UIView *_oneShadowView;
    UIView *_threeShadowView;
    
    UITableView *_tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self configFourFoldImage];
    
    [self configTableView];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + IMAGE_PER_HEIGIT*4, kScreenWidth, kScreenHeight - 64 - IMAGE_PER_HEIGIT*4) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:_tableView]) {
//        if (CGRectGetMidY(_tableView.frame) > 100 && _tableView.contentOffset.y > 100) {
//            double angle = 90;
//            [self foldWithAngle:angle];
//        } else if (_tableView.contentOffset.y < -100) {
//            [self reset];
//        } else {
//            
//        }
        [self foldWithAngle:_tableView.contentOffset.y];
    }
}

//初始化4个小imageView(contentsRect的运用)
- (void)configFourFoldImage
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, IMAGE_PER_HEIGIT*4)];
    [self.view addSubview:bgView];
    
    // 把kiluya这张图，分成平均分成4个部分的imageview
    _one = [[UIImageView alloc] init];
    _one.image = [UIImage imageNamed:@"huanghun"];
    _one.layer.contentsRect = CGRectMake(0, 0, 1, 0.25);
    _one.layer.anchorPoint = CGPointMake(0.5, 0.0);
    _one.frame = CGRectMake(0, 0, kScreenWidth, IMAGE_PER_HEIGIT);
    
    _two = [[UIImageView alloc] init];
    _two.image = [UIImage imageNamed:@"huanghun"];
    _two.layer.contentsRect = CGRectMake(0, 0.25, 1, 0.25);
    _two.layer.anchorPoint = CGPointMake(0.5, 1.0);
    _two.frame = CGRectMake(0, IMAGE_PER_HEIGIT, kScreenWidth, IMAGE_PER_HEIGIT);
    
    _three = [[UIImageView alloc] init];
    _three.image = [UIImage imageNamed:@"huanghun"];
    _three.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.25);
    _three.layer.anchorPoint = CGPointMake(0.5, 0.0);
    _three.frame = CGRectMake(0, IMAGE_PER_HEIGIT*2, kScreenWidth, IMAGE_PER_HEIGIT);
    
    _four = [[UIImageView alloc] init];
    _four.image = [UIImage imageNamed:@"huanghun"];
    _four.layer.contentsRect = CGRectMake(0, 0.75, 1, 0.25);
    _four.layer.anchorPoint = CGPointMake(0.5, 1.0);
    _four.frame = CGRectMake(0, IMAGE_PER_HEIGIT*3, kScreenWidth, IMAGE_PER_HEIGIT);
    
    [bgView addSubview:_one];
    [bgView addSubview:_two];
    [bgView addSubview:_three];
    [bgView addSubview:_four];
    
    // 给第一张和第三张添加阴影
    _oneShadowView = [[UIView alloc] initWithFrame:_one.bounds];
    _oneShadowView.backgroundColor = [UIColor blackColor];
    _oneShadowView.alpha = 0.0;
    
    _threeShadowView = [[UIView alloc] initWithFrame:_three.bounds];
    _threeShadowView.backgroundColor = [UIColor blackColor];
    
    _threeShadowView.alpha = 0.0;
    [_one addSubview:_oneShadowView];
    [_three addSubview:_threeShadowView];
    
}

//生成折叠动效需要的CATransform3D
- (CATransform3D)config3DTransformWithRotateAngle:(double)angle andPositionY:(double)y
{
    CATransform3D transform = CATransform3DIdentity;
    // 立体
    transform.m34 = -1/1000.0;
    // 旋转
    CATransform3D rotateTransform = CATransform3DRotate(transform, M_PI*angle/180, 1, 0, 0);
    // 移动(这里的y坐标是平面移动的的距离,我们要把他转换成3D移动的距离.这是关键,没有它,图片就没办法很好地对接。)
    CATransform3D moveTransform = CATransform3DMakeAffineTransform(CGAffineTransformMakeTranslation(0, y));
    // 合并
    CATransform3D concatTransform = CATransform3DConcat(rotateTransform, moveTransform);
    return concatTransform;
}

//动效是否执行中
static bool isFolding = NO;

//折叠
- (void)foldWithAngle:(double)angle {
    if(!isFolding) {
        isFolding = YES;
        
        angle = angle * (90.f / IMAGE_PER_HEIGIT * 4);
        
        if (angle > 90) {
            angle = 90;
        }
        
        // 阴影显示
        _oneShadowView.alpha = 1 / 90.f * angle;
        _threeShadowView.alpha = 1 / 90.f *angle;
        
        // 折叠
        _one.layer.transform = [self config3DTransformWithRotateAngle:-angle andPositionY:0];
        _two.layer.transform = [self config3DTransformWithRotateAngle:angle andPositionY:-(IMAGE_PER_HEIGIT * 2)+2*_one.frame.size.height];
        _three.layer.transform = [self config3DTransformWithRotateAngle:-angle andPositionY:-(IMAGE_PER_HEIGIT * 2)+2*_one.frame.size.height];
        _four.layer.transform = [self config3DTransformWithRotateAngle:angle andPositionY:-(IMAGE_PER_HEIGIT * 4)+4*_one.frame.size.height];
        
        _tableView.frame = CGRectMake(0, 64 + 4*_one.frame.size.height, kScreenWidth, kScreenHeight - 64 - 4*_one.frame.size.height);
        
        isFolding = NO;
        
//        [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
//            // 阴影显示
//            _oneShadowView.alpha = 1;
//            _threeShadowView.alpha = 1;
//            
//            // 折叠
//            _one.layer.transform = [self config3DTransformWithRotateAngle:-angle andPositionY:0];
//            _two.layer.transform = [self config3DTransformWithRotateAngle:angle andPositionY:-(IMAGE_PER_HEIGIT * 2)+2*_one.frame.size.height];
//            _three.layer.transform = [self config3DTransformWithRotateAngle:-angle andPositionY:-(IMAGE_PER_HEIGIT * 2)+2*_one.frame.size.height];
//            _four.layer.transform = [self config3DTransformWithRotateAngle:angle andPositionY:-(IMAGE_PER_HEIGIT * 4)+4*_one.frame.size.height];
//            
//            _tableView.frame = CGRectMake(0, 64 , kScreenWidth, kScreenHeight - 64 );
//            
//        } completion:^(BOOL finished) {
//            _tableView.contentOffset = CGPointMake(0, 0);
//            if(finished)
//            {
//                isFolding = NO;
//            }
//        }];
    }
}
//复原
- (void)reset {
    isFolding = NO;
    
    _tableView.contentOffset = CGPointMake(0, 0);
    
    [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        // 阴影隐藏
        _oneShadowView.alpha = 0.0;
        _threeShadowView.alpha = 0.0;
        
        // 图片恢复原样
        _one.layer.transform = CATransform3DIdentity;
        _two.layer.transform = CATransform3DIdentity;
        _three.layer.transform = CATransform3DIdentity;
        _four.layer.transform = CATransform3DIdentity;
        
        _tableView.frame = CGRectMake(0, 64 + IMAGE_PER_HEIGIT*4, kScreenWidth, kScreenHeight - 64 - IMAGE_PER_HEIGIT*4);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (IBAction)touchBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self foldWithAngle:90];
    } else {
        [self reset];
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
