//
//  UnitCell.m
//  HW5
//
//  Created by ydy on 2019/11/2.
//  Copyright © 2019 ydy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UnitCell.h"
@interface UnitCell()

@end

@implementation UnitCell

- (id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 60)];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.textColor = [UIColor whiteColor];
        self.title.font = [UIFont fontWithName:@"Verdana-bold"size:21];
      //  self.title.backgroundColor =UIColor.blueColor;
        self.title.layer.cornerRadius=10;
        self.title.clipsToBounds=YES;
        CAGradientLayer *layer=[CAGradientLayer layer];
        [layer setColors:@[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor blueColor].CGColor]];
        layer.locations=@[@0.2,@0.8];
        layer.startPoint=CGPointMake(0, 0);
        layer.endPoint=CGPointMake(1.0, 1.0);
        layer.frame=self.bounds;
        layer.cornerRadius=10;
        [self.layer insertSublayer:layer atIndex:0];
        [self.contentView addSubview:self.title];
    }
    return self;
}

@end
