//
//  InfoCell.h
//  FinalProject
//
//  Created by lucky_li on 2019/12/22.
//  Copyright © 2019 lucky_li. All rights reserved.
//

#ifndef InfoCell_h
#define InfoCell_h

#import <UIKit/UIKit.h>

@interface InfoCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView * userImg;
@property (nonatomic, strong) UILabel * username;
@property (nonatomic, strong) UILabel * email;

@end

#endif /* InfoCell_h */
