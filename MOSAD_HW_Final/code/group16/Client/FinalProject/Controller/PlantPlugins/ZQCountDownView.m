//
//  ZQCountDownView.m
//  ZQCountDownView
//
//  Created by aoliday on 15/7/7.
//  Copyright (c) 2015年 aoliday. All rights reserved.
//

#import "ZQCountDownView.h"

@interface ZQCountDownView ()

@property (nonatomic) UILabel *hourLabel;
@property (nonatomic) UILabel *minuteLabel;
@property (nonatomic) UILabel *secondLabel;

@property (nonatomic) NSArray *colonsArray;

@property (nonatomic) NSTimer *timer;
@property (nonatomic, assign) int hour;
@property (nonatomic, assign) int minute;
@property (nonatomic, assign) int second;

@property (nonatomic, assign) BOOL didRegisterNotificaton;

@property (nonatomic, assign) NSTimeInterval endBackgroundTimeInterval;
@property (nonatomic, assign) NSTimeInterval countDownLeftTimeInterval;


- (void)setHourText:(NSString *)hour;

@end

@implementation ZQCountDownView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeValues];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeValues];
    }
    return self;
}

- (void)initializeValues {
    _themeColor = [UIColor whiteColor];
    _colonColor = [UIColor whiteColor];
    _numberColor = [UIColor darkTextColor];
    _textFont = [UIFont fontWithName:@"DINCondensed-Bold" size:45];
    _recoderTimeIntervalDidInBackground = NO;
    _didRegisterNotificaton = NO;
//    self.backgroundColor = [UIColor whiteColor];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self adjustSubViewsWithFrame:frame];
}

- (void)setRecoderTimeIntervalDidInBackground:(BOOL)recoderTimeIntervalDidInBackground {
    _recoderTimeIntervalDidInBackground = recoderTimeIntervalDidInBackground;
    if (recoderTimeIntervalDidInBackground) {
        [self observeNotification];
    }
    
    if (!recoderTimeIntervalDidInBackground && _didRegisterNotificaton) {
        [self removeObservers];
    }
}

- (void)adjustSubViewsWithFrame:(CGRect)frame {
    if (!self.hourLabel.superview) {
        [self addSubview:self.hourLabel];
    }
    
    if (!self.minuteLabel.superview) {
        [self addSubview:self.minuteLabel];
    }
    
    if (!self.secondLabel.superview) {
        [self addSubview:self.secondLabel];
    }
    
    [_hourLabel sizeToFit];
    CGFloat hourLabelWidth = _hourLabel.frame.size.width;
    CGFloat width = frame.size.width;
    CGFloat colonWidth = 8.0;
    CGFloat itemWidth = (width - colonWidth * 2) / 3;
    if (hourLabelWidth < itemWidth) {
        hourLabelWidth = itemWidth;
    }
    itemWidth = (width - hourLabelWidth - colonWidth * 2) / 2;
    CGFloat itemHeight = frame.size.height;
    
    if (_colonsArray.count > 0) {
        for (UIView *subView in _colonsArray) {
            [subView removeFromSuperview];
        }
    }
    
    if (_circularCorner) {
        if (hourLabelWidth > itemWidth) {
            hourLabelWidth = itemWidth;
        }
        if (itemWidth > itemHeight) {
            hourLabelWidth = itemHeight;
            itemWidth = itemHeight;
        } else {
            itemHeight = itemWidth;
        }
        _hourLabel.layer.cornerRadius = itemWidth/2.0;
        _minuteLabel.layer.cornerRadius = itemWidth/2.0;
        _secondLabel.layer.cornerRadius = itemWidth/2.0;
    }
    _hourLabel.frame = CGRectMake(0, 0, hourLabelWidth, itemHeight);
    _minuteLabel.frame = CGRectMake(CGRectGetMaxX(_hourLabel.frame) + colonWidth, 0, itemWidth, itemHeight);
    _secondLabel.frame = CGRectMake(CGRectGetMaxX(_minuteLabel.frame) + colonWidth, 0, itemWidth, itemHeight);
    
    UILabel *colonOne = [[UILabel alloc] initWithFrame:CGRectMake(hourLabelWidth, -10, colonWidth, itemHeight)];
    colonOne.text = @":";
    colonOne.backgroundColor = [UIColor clearColor];
    colonOne.textColor = _colonColor;
    colonOne.font = _textFont;
    colonOne.textAlignment = NSTextAlignmentCenter;
    [self addSubview:colonOne];
    
    UILabel *colonTwo = [[UILabel alloc] initWithFrame:CGRectMake(hourLabelWidth + itemWidth + colonWidth, -10, colonWidth, itemHeight)];
    colonTwo.text = @":";
    colonTwo.backgroundColor = [UIColor clearColor];
    colonTwo.textColor = _colonColor;
    colonTwo.font = _textFont;
    colonTwo.textAlignment = NSTextAlignmentCenter;
    [self addSubview:colonTwo];
    
    _colonsArray = @[colonOne, colonTwo];
    colonOne = nil;
    colonTwo = nil;
}

- (void)setHourText:(NSString *)hour {
    NSInteger texeLength = _hourLabel.text.length;
    _hourLabel.text = hour;
    if (texeLength != _hourLabel.text.length) {
        [self adjustSubViewsWithFrame:self.frame];
    }
}

- (void)setCircularCorner:(BOOL)circularCorner {
    if (_circularCorner != circularCorner) {
        _circularCorner = circularCorner;
        [self adjustSubViewsWithFrame:self.frame];
    }
}

//#pragma mark init subviews
- (UILabel *)hourLabel {
    if (!_hourLabel) {
        _hourLabel = [UILabel new];
        _hourLabel.textAlignment = NSTextAlignmentCenter;
        _hourLabel.backgroundColor = _themeColor;
        _hourLabel.textColor = _numberColor;
        _hourLabel.font = _textFont;
        _hourLabel.layer.cornerRadius = 4;
        _hourLabel.layer.shouldRasterize = YES;
        _hourLabel.layer.rasterizationScale = [UIScreen mainScreen].scale;
        _hourLabel.clipsToBounds = YES;
        _hourLabel.text = @"00";
    }
    return _hourLabel;
}

- (UILabel *)minuteLabel {
    if (!_minuteLabel) {
        _minuteLabel = [UILabel new];
        _minuteLabel.textAlignment = NSTextAlignmentCenter;
        _minuteLabel.backgroundColor = _themeColor;
        _minuteLabel.textColor = _numberColor;
        _minuteLabel.font = _textFont;
        _minuteLabel.layer.cornerRadius = 4;
        _minuteLabel.layer.shouldRasterize = YES;
        _minuteLabel.layer.rasterizationScale = [UIScreen mainScreen].scale;
        _minuteLabel.clipsToBounds = YES;
        _minuteLabel.text = @"00";
    }
    return _minuteLabel;
}

- (UILabel *)secondLabel {
    if (!_secondLabel) {
        _secondLabel = [UILabel new];
        _secondLabel.textAlignment = NSTextAlignmentCenter;
        _secondLabel.backgroundColor = _themeColor;
        _secondLabel.textColor = _numberColor;
        _secondLabel.font = _textFont;
        _secondLabel.layer.cornerRadius = 4;
        _secondLabel.layer.shouldRasterize = YES;
        _secondLabel.layer.rasterizationScale = [UIScreen mainScreen].scale;
        _secondLabel.clipsToBounds = YES;
        _secondLabel.text = @"00";
    }
    return _secondLabel;
}

#pragma mark set property value
- (void)setThemeColor:(UIColor *)themeColor {
    if (_themeColor != themeColor) {
        _themeColor = themeColor;
        _minuteLabel.backgroundColor = themeColor;
        _secondLabel.backgroundColor = themeColor;
        _hourLabel.backgroundColor = themeColor;
    }
}

- (void)setNumberColor:(UIColor *)numberColor {
    if (_numberColor != numberColor) {
        _numberColor = numberColor;
        _minuteLabel.textColor = numberColor;
        _secondLabel.textColor = numberColor;
        _hourLabel.textColor = numberColor;
    }
}

- (void)setTextFont:(UIFont *)textFont {
    if (_textFont != textFont) {
        _textFont = textFont;
        _secondLabel.font = textFont;
        _minuteLabel.font = textFont;
        _hourLabel.font = textFont;
        if (_colonsArray.count > 0) {
            for (UILabel *label in _colonsArray) {
                label.font = textFont;
            }
        }
    }
}

- (void)setColonColor:(UIColor *)colonColor {
    if (_colonColor != colonColor) {
        _colonColor = colonColor;
        if (_colonsArray.count > 0) {
            for (UILabel *label in _colonsArray) {
                label.textColor = colonColor;
            }
        }
    }
}

- (void)setCountDownTimeInterval:(NSTimeInterval)countDownTimeInterval {
    _countDownTimeInterval = countDownTimeInterval;
    if (_countDownTimeInterval < 0) {
        _countDownTimeInterval = 0;
    }
    _second = (int)_countDownTimeInterval % 60;
    _minute = ((int)_countDownTimeInterval / 60) % 60;
    _hour = _countDownTimeInterval / 3600;
     [self setHourText:[NSString stringWithFormat:@"%02d", _hour]];
    _minuteLabel.text = [NSString stringWithFormat:@"%02d", _minute];
    _secondLabel.text = [NSString stringWithFormat:@"%02d", _second];
    if (_countDownTimeInterval > 0 && !_timer) {
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
//        [self.timer fire];
    }
}

- (void)setLabelBorderColor:(UIColor *)labelBorderColor {
    _hourLabel.layer.borderColor = _minuteLabel.layer.borderColor = _secondLabel.layer.borderColor = labelBorderColor.CGColor;
    _hourLabel.layer.borderWidth = _minuteLabel.layer.borderWidth = _secondLabel.layer.borderWidth = 0.5;
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(adjustCoundDownTimer:) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)adjustCoundDownTimer:(NSTimer *)timer {
    _countDownTimeInterval --;
    if (_minute == 0 && _hour > 0) {
        _hour -= 1;
        _minute = 60;
        [self setHourText:[NSString stringWithFormat:@"%02d", _hour]];
    }

    if (_second == 0 && _minute > 0) {
        _second = 60;
        if (_minute > 0) {
            _minute -= 1;
            _minuteLabel.text = [NSString stringWithFormat:@"%02d", _minute];
        }
    }
    
    if (_second > 0) {
        _second -= 1;
        _secondLabel.text = [NSString stringWithFormat:@"%02d", _second];
    }
    
    if (_second <= 0 && _minute <= 0 && _hour <= 0) {
        [_timer invalidate];
        _timer = nil;
        if (_delegate && [_delegate respondsToSelector:@selector(countDownDidFinished)]) {
            [_delegate countDownDidFinished];
        }
    }
}

- (void)stopCountDown {
    [self removeObservers];
    [_timer invalidate];
    _timer = nil;
}

#pragma mark Observers and methods

- (void)observeNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didInBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willEnterForground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    _didRegisterNotificaton = YES;
}

- (void)removeObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _didRegisterNotificaton = NO;
}

- (void)didInBackground:(NSNotification *)notification {
    _endBackgroundTimeInterval = [[NSDate date] timeIntervalSince1970];
    _countDownLeftTimeInterval = _countDownTimeInterval;
}

- (void)willEnterForground:(NSNotification *)notification {
    NSTimeInterval currentTimeInterval = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval diff = currentTimeInterval - _endBackgroundTimeInterval;
    [self setCountDownTimeInterval:_countDownLeftTimeInterval - diff];
}

- (void)dealloc {
    [self removeObservers];
    _numberColor = nil;
    _textFont = nil;
    _themeColor = nil;
    _textFont = nil;
    _colonsArray = nil;
    _hourLabel = nil;
    _minuteLabel = nil;
    _secondLabel = nil;
}

@end
