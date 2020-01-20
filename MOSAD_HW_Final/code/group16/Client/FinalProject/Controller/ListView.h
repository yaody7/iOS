//
//  ListView.h
//  FinalProject
//
//  Created by lucky_li on 2019/12/16.
//  Copyright © 2019 lucky_li. All rights reserved.
//

#ifndef ListView_h
#define ListView_h

#import <UIKit/UIKit.h>
@interface ListView : UIViewController;
@property (strong,atomic) UITableView *ut;
@property (strong,atomic) NSNumber *mytotal;
@property (strong,atomic) NSMutableArray *data1;
@property (strong,atomic) NSMutableArray *data2;
@property (strong,atomic) NSMutableArray *myids;
@property (strong,atomic) NSMutableArray *heightcollection;
@property (strong,atomic) UITextField *input1;
@property (strong,atomic) UITextField *input2;
@property (strong,atomic) NSString *username;
@end

#endif /* ListView_h */
