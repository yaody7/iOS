//
//  main.m
//  HW2
//
//  Created by ydy on 2019/9/2.
//  Copyright © 2019 ydy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <Foundation/Foundation.h>
#import "Language.h"
#import "Person.h"
int main(int argc, char * argv[]) {
    @autoreleasepool {
        zhangsan * z=[zhangsan new];
        lisi * l=[lisi new];
        wangwu* w=[wangwu new];
        English *e=[English new];
        Germany *g=[Germany new];
        Japanese*j=[Japanese new];
        Spanish * s=[Spanish new];
        NSArray *per=[NSArray arrayWithObjects:z,l,w, nil];
        NSArray *lan=[NSArray arrayWithObjects:e,g,j,s, nil];
        
        int perposition=arc4random()%3;
        int lanposition=arc4random()%4;
        
        NSDate*date=[NSDate date];
        NSDateFormatter*dateFormatter=[NSDateFormatter new];
        [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
        for(NSInteger i=1;i<=8;i++){
            for(NSInteger j=1;j<=4;j++){
                if(i!=1||j!=1)
                    date = [NSDate dateWithTimeInterval:24 * (arc4random()%5+1) * 60 * 60 sinceDate:date];
                NSString *dateString=[dateFormatter stringFromDate:date];
                NSLog(@"%@ %@ 学习%@ tour %zd unit %zd",[per[perposition] name],dateString,[lan[lanposition] mytype],i,j);
            }
        }
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
