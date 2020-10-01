//
//  GifLoopPlayView.m
//  TFRememberHistoryInputContentWithDropList
//
//  Created by Jobs on 2020/9/30.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "GifLoopPlayView.h"

@interface GifLoopPlayView ()

@property(nonatomic,assign)BOOL isOK;
@property(nonatomic,strong)UIImageView *imageView;

@end

@implementation GifLoopPlayView

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        [self setup];
        self.isOK = YES;
    }
}

-(void)setup{
    _duration = 1.5;// 执行一次完整动画所需的时长
    [self.gifMutArr addObject:KBuddleIMG(@"音律跳动", nil, @"1")];;
    _pauseImage = self.gifMutArr[0];
    self.imageView.alpha = 1;
    self.stopped = NO;// YES: 没有播放，NO：正在播放
}

-(void)setStopped:(BOOL)stopped{
    _stopped = stopped;
    if(!stopped) { //  YES - 停止；NO - 播放
        self.imageView.animationImages = (NSArray *)self.gifMutArr; //动画图片数组
        self.imageView.animationDuration = _duration;
        self.imageView.animationRepeatCount = 0;  //动画重复次数，无限循环
        [self.imageView startAnimating];
    }else{
        [self.imageView stopAnimating];
        self.imageView.image = _pauseImage;
    }
}
#pragma mark —— lazyLoad
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = UIImageView.new;
        _imageView.frame = self.bounds;
        _imageView.image = self.pauseImage;
        [self addSubview:_imageView];
    }return _imageView;
}

-(NSMutableArray<UIImage *> *)gifMutArr{
    if (!_gifMutArr) {
        _gifMutArr = NSMutableArray.array;
        [_gifMutArr addObject:KBuddleIMG(@"音律跳动", nil, @"1")];
    }return _gifMutArr;
}


@end
