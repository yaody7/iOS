//
//  MyTabBar.m
//  HW3
//
//  Created by ydy on 2019/10/7.
//  Copyright © 2019 ydy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyTabBar.h"
@interface MyTabBar()<UITabBarDelegate>
@end

@implementation MyTabBar

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSLog(@"item name = %@", item.title);
    if(item.title=@"用户"){
        self.title=@"个人档案";
    }
}

@end
