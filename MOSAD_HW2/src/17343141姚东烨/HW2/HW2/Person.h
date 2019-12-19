//
//  Person.h
//  HW222
//
//  Created by ydy on 2019/9/2.
//  Copyright © 2019 ydy. All rights reserved.
//

#ifndef Person_h
#define Person_h
#import <Foundation/Foundation.h>
@interface Person: NSObject
{
    NSString *name;
}
-(NSString *)name;
@end

@interface zhangsan: Person
-(NSString *)name;
@end

@interface lisi: Person
-(NSString *)name;
@end

@interface wangwu: Person
-(NSString *)name;
@end


#endif /* Person_h */
