//
//  LanguageCell.h
//  HW3
//
//  Created by ydy on 2019/10/6.
//  Copyright © 2019 ydy. All rights reserved.
//

#ifndef LanguageCell_h
#define LanguageCell_h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LanguageCell : UICollectionViewCell
@property (nonatomic,copy) NSString *imageName;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *title;
@end
#endif /* LanguageCell_h */
