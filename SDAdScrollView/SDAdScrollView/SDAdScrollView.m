//
//  SDAdScrollView.m
//  SDAdScrollView
//
//  Created by DHsong on 16/4/20.
//  Copyright © 2016年 DHsong. All rights reserved.
//

#import "SDAdScrollView.h"
#import "UIImageView+WebCache.h"
#import "NSTimer+Addition.h"

@interface SDAdScrollView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *currentImageView;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@end


@implementation SDAdScrollView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _animationDuration = 2.0f;
        _currentImageView = [[UIImageView alloc]init];
        [self.scrollView addSubview:_currentImageView];
        
        _leftImageView = [[UIImageView alloc]init];
        [self.scrollView addSubview:_leftImageView];
        
        _rightImageView = [[UIImageView alloc]init];
        [self.scrollView addSubview:_rightImageView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onGesture:)];
        [self.scrollView addGestureRecognizer:tapGesture];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _leftImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds));
    
    _currentImageView.frame = CGRectOffset(_leftImageView.frame, CGRectGetWidth(_leftImageView.frame), 0);
    
    _rightImageView.frame = CGRectOffset(_currentImageView.frame, CGRectGetWidth(_currentImageView.frame), 0);
}

-(void)setScrollViewEdge:(UIEdgeInsets)scrollViewEdge
{
    _scrollViewEdge = scrollViewEdge;
    CGRect rect = self.scrollView.frame;
    
    self.scrollView.frame = CGRectMake(CGRectGetMinX(rect)+_scrollViewEdge.left,
                                       CGRectGetMinY(rect)+_scrollViewEdge.top,
                                       CGRectGetWidth(rect)-_scrollViewEdge.left-_scrollViewEdge.right,
                                       CGRectGetHeight(rect)-_scrollViewEdge.top-_scrollViewEdge.bottom);
}
#pragma mark - Action

-(void)onTimer:(NSTimer*)timer
{
    NSLog(@"adScrollView onTimer");
    [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.bounds)*2, 0) animated:YES];
}

-(void)onGesture:(UITapGestureRecognizer*)tapGesture
{
    if (self.tapActionBlock) {
        self.tapActionBlock(self);
    }
}

#pragma mark - setter

-(void)setAdList:(NSArray *)adList
{
    _adList = adList;
    self.pageControl.numberOfPages = _adList.count;
    self.pageControl.currentPage = 0;
    _currentPage = 0;
    
    if (![_timer isValid]) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_animationDuration target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
        [_timer pauseTimer];
    }
    
    
    if (_adList.count <= 1) {
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds), 0);
    }else{
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds)*3, 0);
        [_timer resumeTimerAfterTimeInterval:_animationDuration];
    }
    
    [self refreshImageView];
}


//根据当前的index，重置当前显示的图片，并且使currentImageView永远保持在中间
-(void)refreshImageView
{
    NSInteger index = _currentPage;
    
    [self formatImageView:_currentImageView imageData:self.adList[index]];
    
    index = _currentPage-1<0?self.adList.count-1:_currentPage-1;
    [self formatImageView:_leftImageView imageData:self.adList[index]];
    
    index = _currentPage+1>=self.adList.count?0:_currentPage+1;
    [self formatImageView:_rightImageView imageData:self.adList[index]];
    
    self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.bounds), 0);
}

//根据数组中类型判断如何展示图片
-(void)formatImageView:(UIImageView*)imageView imageData:(id)data
{
    if ([data isKindOfClass:[UIImage class]]) {
        imageView.image = (UIImage*)data;
    }else if ([data isKindOfClass:[NSString class]]) {
        NSString *imageName = (NSString*)data;
        if ([imageName hasPrefix:@"http"]) {
            //网络图片
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:_placeHolderImage];
        }else{
            //本地图片
            imageView.image = [UIImage imageNamed:imageName];
        }
    }
}


-(void)refreshCurrentPage
{
    if (self.scrollView.contentOffset.x >= CGRectGetWidth(self.bounds)*1.5) {
        
        _currentPage ++;
        
        if (_currentPage > self.adList.count-1) {
            _currentPage = 0;
        }
    }else if (self.scrollView.contentOffset.x <= CGRectGetWidth(self.bounds)/2) {
        _currentPage--;
        
        if (_currentPage < 0) {
            _currentPage = self.adList.count-1;
        }
    }
}


#pragma mark - UI
-(UIPageControl*)pageControl
{
    if (!_pageControl) {
        CGRect rect = CGRectMake(40, CGRectGetHeight(self.bounds)-20, CGRectGetWidth(self.bounds)-40*2, 10);
        _pageControl = [[UIPageControl alloc]initWithFrame:rect];
        _pageControl.hidesForSinglePage = YES;
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

-(UIScrollView*)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollsToTop = NO;
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds)*3, 0);
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //开始滚动时暂停定时器
    [self.timer pauseTimer];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self refreshCurrentPage];
    
    if (self.pageControl.currentPage != _currentPage) {
        self.pageControl.currentPage = _currentPage;
        [self refreshImageView];
    }
    //滚动结束回复定时器
    [self.timer resumeTimerAfterTimeInterval:_animationDuration];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self refreshCurrentPage];
    
    if (self.pageControl.currentPage != _currentPage) {
        self.pageControl.currentPage = _currentPage;
        [self refreshImageView];
    }
}

@end
