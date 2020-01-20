//
//  PlantView.m
//  FinalProject
//
//  Created by lucky_li on 2019/12/16.
//  Copyright © 2019 lucky_li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlantView.h"

@interface PlantView ()<NSURLSessionDataDelegate>

@end

@implementation PlantView

- (void)viewDidLoad {
    self.apiurl = [NSString stringWithFormat:@"http://localhost:8001/api/user/%@/focus", self.username];
    NSLog(@"url: %@", self.apiurl);
    [super viewDidLoad];
    
    self.active = 1;
    self.width = self.view.bounds.size.width;
    self.height = self.view.bounds.size.height;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.statLabel];
    [self.view addSubview:self.timePicker];
    [self.view addSubview:self.controlButton];
    [self.view addSubview:self.cancelButton];
    [self.view addSubview:self.endButton];
    [self.view addSubview:self.leftQuote];
    [self.view addSubview:self.rightQuote];
    [self.view addSubview:self.quoteText];
    [self.view addSubview:self.waveView];
    [self.view addSubview:self.countDown];
    
    self.focusMinute = 0;
    
    [self loadQuote];
    [self loadFocusTime];
}

- (instancetype)initWithUsername:(NSString *)username {
    self = [super init];
    if (self) {
        self.username = username;
    }
    return self;
}

- (void)loadQuote {
    NSURLSessionConfiguration * defaultConfiguraion = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * delegateFreeSession = [NSURLSession sessionWithConfiguration:defaultConfiguraion delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURL * url = [NSURL URLWithString:@"https://v1.hitokoto.cn/?c=f"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask * dataTask = [delegateFreeSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary * res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            self.quote = res[@"hitokoto"];
            [self.quoteText setText:self.quote];
        } else {
            NSLog(@"***error while loading quote***:\n%@", error);
        }
    }];
    [dataTask resume];
    if (self.active == 1) {
        [self performSelector:@selector(loadQuote) withObject:nil afterDelay:5.0f];
    }
}

- (void)loadFocusTime {
    NSURLSessionConfiguration * defaultConfiguraion = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * delegateFreeSession = [NSURLSession sessionWithConfiguration:defaultConfiguraion delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURL * url = [NSURL URLWithString:self.apiurl];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask * dataTask = [delegateFreeSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary * res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString * str = res[@"total_time"];
            NSLog(@"total time: %@", str);
            self.focusMinute = [str integerValue];
            [self loadStat];
        } else {
            NSLog(@"***error while loading focus time***:\n%@", error);
        }
    }];
    [dataTask resume];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.navigationController setToolbarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    //[self.navigationController setNavigationBarHidden:NO animated:YES];
    //[self.navigationController setToolbarHidden:NO animated:YES];
    self.active = 0;
    if (self.focusCountDownTimer != nil) {
        [self.focusCountDownTimer invalidate];
        self.focusCountDownTimer = nil;
    }
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 200, 100)];
        [_titleLabel setText:@"FOCUS"];
        [_titleLabel setFont:[UIFont fontWithName:@"DINCondensed-Bold" size:60]];
        [_titleLabel setTextColor:[UIColor grayColor]];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}
- (UILabel *)statLabel {
    if (_statLabel == nil) {
        _statLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 140, _width - 40, 100)];
        [_statLabel setFont:[UIFont fontWithName:@"DINCondensed-Bold" size:75]];
        [_statLabel setTextColor:[UIColor darkGrayColor]];
        [_statLabel setTextAlignment:NSTextAlignmentRight];
        [self loadStat];
    }
    return _statLabel;
}
- (void)loadStat {
    NSString * stat = [NSString stringWithFormat:@"%02ldhr %02ldmin", self.focusMinute / 60, self.focusMinute % 60];
    NSMutableAttributedString * attrs = [[NSMutableAttributedString alloc] initWithString:stat];
    [_statLabel setText:stat];
    [attrs addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:100.0f/255.0f green:149.0f/255.0f blue:237.0f/255.0f alpha:1.0f] range:NSMakeRange(0, stat.length - 8)];
    [attrs addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:100.0f/255.0f green:149.0f/255.0f blue:237.0f/255.0f alpha:1.0f] range:NSMakeRange(stat.length - 5, 2)];
    [_statLabel setAttributedText:attrs];
}

- (UIDatePicker *)timePicker {
    if (_timePicker == nil) {
        _timePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 180, _width, 400)];
        [_timePicker setLocale:[NSLocale localeWithLocaleIdentifier:@"zh"]];
        [_timePicker setDatePickerMode:UIDatePickerModeCountDownTimer];
        [_timePicker setMinuteInterval:1];
    }
    return _timePicker;
}

- (DKCircleButton *)controlButton {
    if (_controlButton == nil) {
        _controlButton = [[DKCircleButton alloc] initWithFrame:CGRectMake(_width - 120, 550, 100, 100)];
        [_controlButton setCenter:CGPointMake(_width - 70, 600)];
        [_controlButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [_controlButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_controlButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
        [_controlButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        [_controlButton setTitle:NSLocalizedString(@"Start", nil) forState:UIControlStateNormal];
        [_controlButton setTitle:NSLocalizedString(@"Start", nil) forState:UIControlStateSelected];
        [_controlButton setTitle:NSLocalizedString(@"Start", nil) forState:UIControlStateHighlighted];
        [_controlButton addTarget:self action:@selector(clickStart) forControlEvents:UIControlEventTouchUpInside];
    }
    return _controlButton;
}
- (void)clickStart {
    //NSLog(@"%f", self.timePicker.countDownDuration);
    self.focusDuration = self.timePicker.countDownDuration;
    [self.countDown setCountDownTimeInterval:self.focusDuration];
    self.focusCountDown = self.focusDuration;
    self.focusCountDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(focusCountDownFunc) userInfo:nil repeats:YES];
    [UIView animateWithDuration:1 animations:^{
        [self.timePicker setFrame:CGRectMake(-self.width, 180, self.width, 400)];
        [self.waveView setFrame:CGRectMake(self.width / 2 - 150, 230, 300, 300)];
        [self.countDown setFrame:CGRectMake(self.width / 2 - 125, 350, 250, 150)];
        [self.cancelButton setFrame:CGRectMake(-100, 550, 100, 100)];
        [self.controlButton setFrame:CGRectMake(self->_width, 550, 100, 100)];
        [self.endButton setFrame:CGRectMake(self->_width / 2 - 50, 550, 100, 100)];
    }];
}
- (void)focusCountDownFunc{
    self.focusCountDown -= 1;
    self.waveView.progress = (CGFloat)(self.focusDuration - self.focusCountDown) / self.focusDuration;
    //NSLog(@"%f", self.waveView.progress);
    if (self.focusCountDown == 0) {
        if (self.focusCountDownTimer != nil) {
            [self.focusCountDownTimer invalidate];
            self.focusCountDownTimer = nil;
        }
        [self refreshFocus];
    }
}
- (void)refreshFocus {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"You've done a FOCUS!" message:[NSString stringWithFormat:@"This time, you have focused for %ld minute(s)!", self.focusDuration / 60] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Bravo!" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    
    // post request
    NSURLSessionConfiguration * defaultConfiguraion = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * delegateFreeSession = [NSURLSession sessionWithConfiguration:defaultConfiguraion delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURL * url = [NSURL URLWithString:self.apiurl];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSDictionary * dict = @{@"focus": @(self.focusDuration / 60)};
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSessionDataTask * dataTask = [delegateFreeSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary * res = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if ([res[@"status"] isEqual: @"success"]) {
                NSString * str = res[@"total_time"];
                self.focusMinute = [str integerValue];
                [self loadStat];
            } else {
                NSLog(@"***error while refreshing focus***:\n%@", error);
            }
            [self reset];
            self.focusMinute = 0;
            self.focusDuration = 0;
        } else {
            NSLog(@"*** error while submitting focus ***:\n%@", error);
        }
    }];
    [dataTask resume];
}

- (void)reset {
    [UIView animateWithDuration:1 animations:^{
        [self.cancelButton setFrame:CGRectMake(30, 550, 100, 100)];
        [self.controlButton setFrame:CGRectMake(self->_width - 120, 550, 100, 100)];
        [self.endButton setFrame:CGRectMake(self->_width, 600, 0, 0)];
        [self.timePicker setFrame:CGRectMake(0, 180, self->_width, 400)];
        [self.waveView setFrame:CGRectMake(self->_width, 230, 300, 300)];
        [self.countDown setFrame:CGRectMake(self->_width, 350, 250, 150)];
        if (self.focusCountDownTimer != nil) {
            [self.focusCountDownTimer invalidate];
            self.focusCountDownTimer = nil;
        }
        self.focusDuration = 0;
        self.focusCountDown = 0;
        self.waveView.progress = 0;
    }];
}

- (DKCircleButton *)endButton {
    if (_endButton == nil) {
        _endButton = [[DKCircleButton alloc] initWithFrame:CGRectMake(_width, 600, 0, 0)];
        [_endButton setCenter:CGPointMake(_width / 2, 600)];
        [_endButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [_endButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_endButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
        [_endButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        [_endButton setTitle:NSLocalizedString(@"Quit", nil) forState:UIControlStateNormal];
        [_endButton setTitle:NSLocalizedString(@"Quit", nil) forState:UIControlStateSelected];
        [_endButton setTitle:NSLocalizedString(@"Quit", nil) forState:UIControlStateHighlighted];
        [_endButton setAnimateTap:NO];
        [_endButton addTarget:self action:@selector(clickEnd) forControlEvents:UIControlEventTouchUpInside];
    }
    return _endButton;
}
- (void)clickEnd {
    [self reset];
}

- (HWWaveView *)waveView {
    if (_waveView == nil) {
        _waveView = [[HWWaveView alloc] initWithFrame:CGRectMake(_width, 230, 300, 300)];
        _waveView.progress = 0;
    }
    return _waveView;
}

- (ZQCountDownView *)countDown {
    if (_countDown == nil) {
        _countDown = [[ZQCountDownView alloc] initWithFrame:CGRectMake(_width, 350, 250, 150)];
        [_countDown setCircularCorner:YES];
        [_countDown setNumberColor:[UIColor whiteColor]];
        [_countDown setThemeColor:[UIColor colorWithWhite:1 alpha:0]];
        [_countDown setTextFont:[UIFont fontWithName:@"DINCondensed-Bold" size:60]];
    }
    return _countDown;
}

- (DKCircleButton *)cancelButton {
    if (_cancelButton == nil) {
        _cancelButton = [[DKCircleButton alloc] initWithFrame:CGRectMake(30, 550, 100, 100)];
        [_cancelButton setCenter:CGPointMake(80, 600)];
        [_cancelButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [_cancelButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
        [_cancelButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        [_cancelButton setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
        [_cancelButton setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateSelected];
        [_cancelButton setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateHighlighted];
        [_cancelButton setAnimateTap:NO];
        [_cancelButton addTarget:self action:@selector(clickCancel) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}
- (void)clickCancel {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UILabel *)leftQuote {
    if (_leftQuote == nil) {
        _leftQuote = [[UILabel alloc] initWithFrame:CGRectMake(50, 700, 50, 50)];
        [_leftQuote setText:@"”"];
        [_leftQuote setFont:[UIFont systemFontOfSize:40]];
        [_leftQuote setTextColor:[UIColor grayColor]];
        [_leftQuote setTextAlignment:NSTextAlignmentLeft];
    }
    return _leftQuote;
}

- (UILabel *)rightQuote {
    if (_rightQuote == nil) {
        _rightQuote = [[UILabel alloc] initWithFrame:CGRectMake(_width - 100, 780, 50, 50)];
        [_rightQuote setText:@"”"];
        [_rightQuote setFont:[UIFont systemFontOfSize:40]];
        [_rightQuote setTextColor:[UIColor grayColor]];
        [_rightQuote setTextAlignment:NSTextAlignmentRight];
    }
    return _rightQuote;
}

- (UILabel *)quoteText {
    if (_quoteText == nil) {
        _quoteText = [[UILabel alloc] initWithFrame:CGRectMake(80, 700, _width - 160, 120)];
        [_quoteText setText:@"loading quote......"];
        [_quoteText setFont:[UIFont fontWithName:@"DINCondensed-Bold" size:15]];
        [_quoteText setTextColor:[UIColor darkGrayColor]];
        [_quoteText setTextAlignment:NSTextAlignmentCenter];
        [_quoteText setNumberOfLines:0];
        [_quoteText setLineBreakMode:NSLineBreakByWordWrapping];
    }
    return _quoteText;
}

@end
