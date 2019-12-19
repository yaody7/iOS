//
//  MyCell.m
//  HW6
//
//  Created by ydy on 2019/11/17.
//  Copyright © 2019 ydy. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "MyCell.h"
@interface MyCell()

@end

@implementation MyCell

- (id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

@end
