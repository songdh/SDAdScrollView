# SDAdScrollView
无限轮播广告栏 支持本地图片 网络图片只有单张图片时不再滚动

使用方法

    //本地图片
    SDAdScrollView *adView = [[SDAdScrollView alloc]initWithFrame:CGRectMake(10, 30, 200, 400)];
    adView.backgroundColor = [UIColor blackColor];
    adView.adList = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg"];
    adView.tapActionBlock = ^(SDAdScrollView *adScrollView) {
        NSString *message = [NSString stringWithFormat:@"点击第%ld个广告",adScrollView.currentPage];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提醒" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    };
    [self.view addSubview:adView];
    
    //网络图片
    SDAdScrollView *adView1 = [[SDAdScrollView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(adView.frame)+10, CGRectGetWidth(self.view.bounds)-20, 200)];
    adView1.backgroundColor = [UIColor blackColor];
    adView1.adList = @[@"http://img.stuhui.com/d7d59fe933408a5f8a848fb3cc2d58b4",
                       @"http://pic31.nipic.com/20130624/8821914_104949466000_2.jpg",
                       @"http://pic42.nipic.com/20140624/18433693_111807225000_2.jpg",
                       @"http://pic8.nipic.com/20100709/4752803_210430061441_2.jpg",
                       @"http://pic37.nipic.com/20131230/7810872_091821315193_2.jpg",
                       @"http://pic31.nipic.com/20130629/8821914_111532606000_2.jpg"];
    adView1.tapActionBlock = ^(SDAdScrollView *adScrollView) {
        NSString *message = [NSString stringWithFormat:@"点击第%ld个广告",adScrollView.currentPage];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提醒" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    };
    [self.view addSubview:adView1];
    
    
    //只有一张图像
    SDAdScrollView *adView2 = [[SDAdScrollView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(adView.frame)+10, 30, CGRectGetWidth(self.view.bounds)-CGRectGetMaxX(adView.frame)-20, 200)];
    adView2.backgroundColor = [UIColor blackColor];
    adView2.adList = @[@"http://pic42.nipic.com/20140624/18433693_111807225000_2.jpg"];
    adView2.tapActionBlock = ^(SDAdScrollView *adScrollView) {
        NSString *message = [NSString stringWithFormat:@"点击第%ld个广告",adScrollView.currentPage];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提醒" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    };
    [self.view addSubview:adView2];
