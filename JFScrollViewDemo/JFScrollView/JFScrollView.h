//
//  JFScrollView.h
//  JFScrollViewDemo
//
//  Created by Mac on 15/11/29.
//  Copyright © 2015年 Mac. All rights reserved.
//  用于实现多张图片的循环滚动

#import <UIKit/UIKit.h>

@protocol JFScrollViewDelegate <NSObject>

@optional

- (void)scrollViewDidTaped:(UIView *)view currentPage:(NSInteger)currentPage point:(CGPoint)point;

@end

@interface JFScrollView : UIView

/**
 *  需要进行滚动的所有的视图
 */
@property (nonatomic, copy) NSArray *views;

/**
 *  是否需要进行显示翻页控制器
 */
@property (nonatomic, assign) BOOL hidePageControl;

@property (nonatomic, weak) id<JFScrollViewDelegate> delegate;

@end
