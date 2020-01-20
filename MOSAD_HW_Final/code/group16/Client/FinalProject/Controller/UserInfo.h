//
//  UserInfo.h
//  FinalProject
//
//  Created by lucky_li on 2019/12/16.
//  Copyright © 2019 lucky_li. All rights reserved.
//

#ifndef UserInfo_h
#define UserInfo_h

#import <UIKit/UIKit.h>
@interface UserInfoView : UIViewController<UITableViewDelegate, UITableViewDataSource>;

@property(nonatomic, strong) NSMutableArray * info;

@end

#endif /* UserInfo_h */
