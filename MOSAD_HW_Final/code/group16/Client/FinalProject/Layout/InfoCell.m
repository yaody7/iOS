//
//  InfoCell.m
//  FinalProject
//
//  Created by lucky_li on 2019/12/22.
//  Copyright © 2019 lucky_li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InfoCell.h"

@implementation InfoCell

- (id)initWithFrame:(CGRect)Frame {
    self = [super initWithFrame:Frame];
    if(self) {
        self.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1];
        
        //image
        NSLog(@"%lf", self.frame.size.width);
        NSLog(@"%lf", self.frame.size.height);
        self.userImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-50, self.frame.size.height/8, self.frame.size.width/4, self.frame.size.width/4)];
        self.userImg.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.userImg];
        
        // username
        self.username = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.width/4 + self.frame.size.height/8, self.frame.size.width, 35)];
        self.username.textColor = [UIColor blackColor];
        self.username.font = [UIFont fontWithName:@ "Arial" size:30.0];
        self.username.textAlignment = NSTextAlignmentCenter;
        self.username.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.username];
        
        //email
        self.email = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height/8 + self.frame.size.width/4 + 35, self.frame.size.width, 30)];
        self.email.textAlignment = NSTextAlignmentCenter;
        self.email.textColor = [UIColor lightGrayColor];
        self.email.font = [UIFont fontWithName:@ "Arial" size:15.0];
        self.email.textColor = [UIColor blackColor];
        
        [self.contentView addSubview:self.email];
    }
    return self;
}

@end
