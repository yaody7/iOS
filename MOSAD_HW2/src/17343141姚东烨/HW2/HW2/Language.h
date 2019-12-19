//
//  Language.h
//  HW222
//
//  Created by ydy on 2019/9/2.
//  Copyright © 2019 ydy. All rights reserved.
//

#ifndef Language_h
#define Language_h
#import <Foundation/Foundation.h>
@interface Language: NSObject
{
    NSString *mytype;
}
-(NSString *)mytype;
@end

@interface English: Language
-(NSString *)mytype;
@end

@interface Japanese: Language
-(NSString *)mytype;
@end

@interface Germany: Language
-(NSString *)mytype;
@end

@interface Spanish: Language
-(NSString *)mytype;
@end
#endif /* Language_h */
