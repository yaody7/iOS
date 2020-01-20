//
//  ZQCountDownView.h
//  ZQCountDownView
//
//  Created by aoliday on 15/7/7.
//  Copyright (c) 2015年 aoliday. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZQCountDownViewDelegate;
@interface ZQCountDownView : UIView

@property (assign, nonatomic) NSTimeInterval countDownTimeInterval;
@property (assign, nonatomic) UIColor *numberColor;

@property (assign, nonatomic) UIColor *themeColor;
@property (assign, nonatomic) UIColor *colonColor;
@property (assign, nonatomic) UIFont *textFont;

@property (assign, nonatomic) UIColor *labelBorderColor;
@property (nonatomic) BOOL circularCorner;

@property (nonatomic, weak) id <ZQCountDownViewDelegate> delegate;

@property (nonatomic, assign) BOOL recoderTimeIntervalDidInBackground;

- (void)stopCountDown;

@end

@protocol ZQCountDownViewDelegate <NSObject>

- (void)countDownDidFinished;

@end
