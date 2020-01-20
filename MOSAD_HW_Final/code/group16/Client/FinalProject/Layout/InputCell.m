//
//  InputCell.m
//  FinalProject
//
//  Created by lucky_li on 2019/12/17.
//  Copyright © 2019 lucky_li. All rights reserved.
///Users/lucky_li/Desktop/MOSAD_HW_Final/code/group16/Client/FinalProject/Assets

#import <Foundation/Foundation.h>
#import "InputCell.h"

@implementation InputCell

- (id)initWithFrame:(CGRect)Frame {
    self = [super initWithFrame:Frame];
    if(self) {
        //input
        self.input = [[UITextField alloc] initWithFrame:CGRectMake(self.frame.size.width/6, 0, self.frame.size.width/3*2, 40)];
        self.input.textColor = [UIColor blackColor];
        self.input.font = [UIFont fontWithName:@ "Arial" size:20.0];
        
        //取消自动大写、订正提示
        self.input.autocorrectionType = UITextAutocorrectionTypeNo;
//        self.input.keyboardType = UIKeyboardTypeDefault;
        self.input.autocapitalizationType = UITextAutocapitalizationTypeNone;
        
        //设置下边框样式
        CALayer * bottomBorder = [CALayer layer];
        bottomBorder.backgroundColor = [UIColor orangeColor].CGColor;
        bottomBorder.frame = CGRectMake(0.0f, self.input.frame.size.height - 1, self.input.frame.size.width, 1.0f);
        bottomBorder.backgroundColor = [UIColor blackColor].CGColor;
        [self.input.layer addSublayer:bottomBorder];
        [self.contentView addSubview:self.input];
    }
    return self;
}

@end
