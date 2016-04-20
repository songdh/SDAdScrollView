//
//  SDAdScrollView.h
//  SDAdScrollView
//
//  Created by DHsong on 16/4/20.
//  Copyright © 2016年 DHsong. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 *
 */

@interface SDAdScrollView : UIView
/*
 *显示广告的数据源，可以有三种类型 1:NSString，图片的网络地址，采用SDWebImage加载
                              2:NSString，本地图片文件名
 *                            3:使用UIImage
 *  此属性赋值后会立即开启定时器，需要在下面两个属性设置完后再设置
 */
@property (nonatomic, copy) NSArray *adList;
@property (nonatomic, assign, readonly) NSInteger currentPage;
@property (nonatomic, assign) NSTimeInterval animationDuration;//自动滚动动画时间，默认2s
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic , copy) void (^tapActionBlock)(SDAdScrollView *adScrollView);
@end
