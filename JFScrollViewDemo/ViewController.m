//
//  ViewController.m
//  JFScrollViewDemo
//
//  Created by Mac on 15/11/29.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "JFScrollView.h"

@interface ViewController ()<JFScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    JFScrollView *scrollView = [[JFScrollView alloc] initWithFrame:CGRectMake(10, 10, 300, 300)];
    scrollView.delegate = self;
    NSMutableArray *views = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        UIView *view = [[UIView alloc] init];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(100, 100, 200, 30);
        label.text = [NSString stringWithFormat:@"%d",i];
        [view addSubview:label];
        
        view.backgroundColor = [UIColor colorWithRed:(arc4random() % 255) / 255.0 green:(arc4random() % 255) / 255.0 blue:(arc4random() % 255) / 255.0 alpha:1];
        [views addObject:view];
    }
    scrollView.views = views;
//    scrollView.hidePageControl = YES;
    
//    scrollView.hidePageControl = YES;
    
    [self.view addSubview:scrollView];
    
    
}

- (void)scrollViewDidTaped:(UIView *)view currentPage:(NSInteger)currentPage point:(CGPoint)point
{
    NSLog(@"%ld----%@",currentPage,NSStringFromCGPoint(point));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
