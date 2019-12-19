//
//  ChoiceCell.m
//  HW5
//
//  Created by ydy on 2019/11/2.
//  Copyright © 2019 ydy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChoiceCell.h"
@interface ChoiceCell()
@property NSInteger test;
@end

@implementation ChoiceCell

- (id)initWithFrame:(CGRect)frame{
    self.test=0;
    self=[super initWithFrame:frame];
    if(self){
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 55)];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.textColor = [UIColor blackColor];
        self.title.font = [UIFont fontWithName:@"Verdana-bold"size:21];
        self.title.backgroundColor =UIColor.whiteColor;
        self.title.layer.cornerRadius=10;
   //     self.title.clipsToBounds=YES;
        self.title.layer.borderWidth=1;
 //       self.title.layer.borderColor=UIColor.blackColor.CGColor;
        [self.contentView addSubview:self.title];
    }
    return self;
}

@end
