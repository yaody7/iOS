//
//  PlantView.h
//  FinalProject
//
//  Created by lucky_li on 2019/12/16.
//  Copyright © 2019 lucky_li. All rights reserved.
//

#ifndef PlantView_h
#define PlantView_h

#import <UIKit/UIKit.h>
#import "DKCircleButton.h"
#import "HWWaveView.h"
#import "ZQCountDownView.h"
@interface PlantView : UIViewController;

- (instancetype)initWithUsername:(NSString *)username;

@property (assign, atomic) NSString * apiurl;

@property (assign, atomic) NSString * username;

@property (assign, atomic) NSInteger active;

@property (assign, atomic) NSInteger width;
@property (assign, atomic) NSInteger height;

@property (assign, atomic) NSInteger focusMinute;
@property (assign, atomic) NSString * quote;
@property (assign, atomic) NSInteger focusDuration;
@property (assign, atomic) NSInteger focusCountDown;
@property (assign, atomic) NSTimer * focusCountDownTimer;

@property (strong, nonatomic) UILabel * titleLabel;
@property (strong, nonatomic) UILabel * statLabel;
@property (strong, nonatomic) UIDatePicker * timePicker;
@property (strong, nonatomic) DKCircleButton * controlButton;
@property (strong, nonatomic) DKCircleButton * endButton;
@property (strong, nonatomic) DKCircleButton * cancelButton;
@property (strong, nonatomic) UILabel * leftQuote;
@property (strong, nonatomic) UILabel * rightQuote;
@property (strong, nonatomic) UILabel * quoteText;
@property (strong, nonatomic) HWWaveView * waveView;
@property (strong, nonatomic) ZQCountDownView * countDown;

@end

#endif /* PlantView_h */
