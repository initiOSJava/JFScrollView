//
//  JFScrollView.m
//  JFScrollViewDemo
//
//  Created by Mac on 15/11/29.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "JFScrollView.h"

@interface JFScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageCtl;

@end

@implementation JFScrollView

#pragma mark - 初始化方法
- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scrollView];
        [self addSubview:self.pageCtl];
    }
    return self;
}

#pragma mark - 初始化滚动视图
- (UIScrollView *)scrollView
{
    // 进行滚动视图的初始化并且设置一些常用的属性
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

#pragma mark - 初始化翻页视图
-(UIPageControl *)pageCtl
{
    if (_pageCtl == nil) {
        _pageCtl = [[UIPageControl alloc] init];
        _pageCtl.userInteractionEnabled = NO;
    }
    return _pageCtl;
}

#pragma mark - 进行要显示的视图的初始化
-(void)setViews:(NSArray *)views
{
    _views = views;
    // 让所有的需要滚动的视图添加到滚动视图上
    for (UIView *view in self.views) {
        [self.scrollView addSubview:view];
        // 添加手势,便于记录当前的点击点
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dealTap:)]];
    }
    
}

#pragma mark - 确定各个视图的大小
-(void)layoutSubviews
{
    // 1.确定滚动视图的frame
    // 1.1 一共有多少张view
    NSInteger viewCount =  self.views.count;
    _scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _scrollView.contentSize = CGSizeMake(self.frame.size.width * viewCount, self.frame.size.height);
    
    // 2.改变滚动视图中需要滚动的图片的大小
    for (NSInteger i = 0; i < viewCount; i++) {
        UIView *view = self.views[i];
        view.frame = CGRectMake(_scrollView.frame.size.width * i, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
    }
    
    // 3.翻页视图控制的frame
    _pageCtl.frame = CGRectMake(0, 0, self.frame.size.width, 20);
    _pageCtl.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height - _pageCtl.frame.size.height - 10);
    _pageCtl.numberOfPages = self.views.count;
}

#pragma mark - 控制翻页控制器
-(void)setHidePageControl:(BOOL)hidePageControl
{
    if (!hidePageControl) return;
    
    _pageCtl.hidden = YES;
}

#pragma mark - 代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 设置当前页
    CGFloat offSetX = scrollView.contentOffset.x;
    NSInteger currentPage = (offSetX + scrollView.frame.size.width * 0.5) / scrollView.frame.size.width;
    _pageCtl.currentPage = currentPage;
}

#pragma mark - 处理点击事件
- (void)dealTap:(UITapGestureRecognizer *)gesture
{
    // 获取当前点击的是哪一个点
    CGPoint point = [gesture locationInView:self];
    // 获取点击的是第几页上的点
    NSInteger currentPage = _pageCtl.currentPage;
    
    if ([self.delegate respondsToSelector:@selector(scrollViewDidTaped:currentPage:point:)]) {
        [self.delegate scrollViewDidTaped:self currentPage:currentPage point:point];
    }
}

@end
