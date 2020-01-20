//
//  HWWaveView.m
//  HWProgress
//
//  Created by sxmaps_w on 2017/3/3.
//  Copyright © 2017年 hero_wqb. All rights reserved.
//

#import "HWWaveView.h"

#define KHWWaveFillColor [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:0.85]
#define KHWWaveTopColor [UIColor colorWithRed:100.0f/255.0f green:149.0f/255.0f blue:237.0f/255.0f alpha:1.0f]
#define KHWWaveBottomColor [UIColor colorWithRed:100.0f/255.0f green:149.0f/255.0f blue:237.0f/255.0f alpha:0.5f]

@interface HWWaveView ()

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) CGFloat wave_amplitude;//振幅a（y = asin(wx+φ) + k）
@property (nonatomic, assign) CGFloat wave_cycle;//周期w
@property (nonatomic, assign) CGFloat wave_h_distance;//两个波水平之间偏移
@property (nonatomic, assign) CGFloat wave_v_distance;//两个波竖直之间偏移
@property (nonatomic, assign) CGFloat wave_scale;//水波速率
@property (nonatomic, assign) CGFloat wave_offsety;//波峰所在位置的y坐标
@property (nonatomic, assign) CGFloat wave_move_width;//移动的距离，配合速率设置
@property (nonatomic, assign) CGFloat wave_offsetx;//偏移
@property (nonatomic, assign) CGFloat offsety_scale;//上升的速度

@end

@implementation HWWaveView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self initInfo];
    }
    return self;
}

- (void)initInfo {
    _progress = 0;
    _wave_amplitude = self.frame.size.height / 25;
    _wave_cycle = 2 * M_PI / (self.frame.size.width * 0.9);
    _wave_h_distance = 2 * M_PI / _wave_cycle * 0.6;
    _wave_v_distance = _wave_amplitude * 0.4;
    _wave_move_width = 0.5;
    _wave_scale = 0.4;
    _offsety_scale = 0.1;
    _wave_offsety = (1 - _progress) * (self.frame.size.height + 2 * _wave_amplitude);
    [self addDisplayLinkAction];
}

- (void)addDisplayLinkAction {
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)displayLinkAction {
    _wave_offsetx += _wave_move_width * _wave_scale;
    if (_wave_offsety <= 0.01)  [self removeDisplayLinkAction];
    [self setNeedsDisplay];
}

- (void)removeDisplayLinkAction {
    [_displayLink invalidate];
    _displayLink = nil;
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [KHWWaveFillColor setFill];
    [path fill];
    [path addClip];
    [self drawWaveColor:KHWWaveTopColor offsetx:0 offsety:0];
    [self drawWaveColor:KHWWaveBottomColor offsetx:_wave_h_distance offsety:_wave_v_distance];
}

- (void)drawWaveColor:(UIColor *)color offsetx:(CGFloat)offsetx offsety:(CGFloat)offsety {
    CGFloat end_offY = (1 - _progress) * (self.frame.size.height + 2 * _wave_amplitude);
    if (_wave_offsety != end_offY) {
        if (end_offY < _wave_offsety) {
            _wave_offsety = MAX(_wave_offsety -= (_wave_offsety - end_offY) * _offsety_scale, end_offY);
        }else {
            _wave_offsety = MIN(_wave_offsety += (end_offY - _wave_offsety) * _offsety_scale, end_offY);
        }
    }
    
    UIBezierPath *wavePath = [UIBezierPath bezierPath];
    for (float next_x = 0.f; next_x <= self.frame.size.width; next_x ++) {
        CGFloat next_y = _wave_amplitude * sin(_wave_cycle * next_x + _wave_offsetx + offsetx / self.bounds.size.width * 2 * M_PI) + _wave_offsety + offsety;
        if (next_x == 0) {
            [wavePath moveToPoint:CGPointMake(next_x, next_y - _wave_amplitude)];
        }else {
            [wavePath addLineToPoint:CGPointMake(next_x, next_y - _wave_amplitude)];
        }
    }
    
    [wavePath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    [wavePath addLineToPoint:CGPointMake(0, self.bounds.size.height)];
    [color set];
    [wavePath fill];
}

@end

