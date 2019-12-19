//
//  LanguageCell.m
//  HW3
//
//  Created by ydy on 2019/10/6.
//  Copyright © 2019 ydy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LanguageCell.h"
@interface LanguageCell()

@end

@implementation LanguageCell

- (id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.1*self.frame.size.width, 30, self.frame.size.width*0.8, self.frame.size.width*0.6)];
        self.imageView.layer.masksToBounds = YES;
        self.imageView.layer.cornerRadius = 20;
        self.imageView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.imageView];
        
        
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.textColor = [UIColor blackColor];
        self.title.font = [UIFont fontWithName:@"Verdana-Bold"size:19];
        [self.contentView addSubview:self.title];
        

    }
    return self;
}
- (void)setImageName:(NSString *)imageName{
    _imageName=imageName;
//    _imageView=[[UIImageView alloc]initWithFrame:self.bounds];
//    [self addSubview:_imageView];
}
@end
