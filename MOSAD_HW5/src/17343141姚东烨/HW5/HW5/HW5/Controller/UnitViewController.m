//
//  UnitViewController.m
//  HW5
//
//  Created by ydy on 2019/11/2.
//  Copyright © 2019 ydy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UnitViewController.h"
#import "QuestionViewController.h"
#import "UnitCell.h"
@interface UnitViewController()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic,copy) NSMutableArray *dataSourceArray;
@end

@implementation UnitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: self.collectionView];
    [self.view addSubview: self.titleLabel];
    self.dataSourceArray=[NSMutableArray arrayWithArray:@[@"Unit1",@"Unit2",@"Unit3",@"Unit4"]];
}
- (UILabel *)titleLabel {
    if(_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _collectionView.frame.origin.y - 50, self.view.frame.size.width, 30)];
        [_titleLabel setText: @"请选择题目"];
        [_titleLabel setFont: [UIFont systemFontOfSize: 20]];
        [_titleLabel setTextColor: [UIColor blackColor]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

- (UICollectionView *)collectionView {
    if(_collectionView==nil){
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        layout.itemSize=CGSizeMake(30,40);
        self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.1,0.3*self.view.frame.size.height,self.view.frame.size.width*0.8,600)collectionViewLayout:layout];
        self.collectionView.backgroundColor=UIColor.whiteColor;
        // 设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        // 注册cell
        [_collectionView registerClass:[UnitCell class] forCellWithReuseIdentifier:@"MyCell"];
    }
    return _collectionView;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UnitCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    cell.backgroundColor=UIColor.whiteColor;
    [cell.title setText:self.dataSourceArray[indexPath.row]];
    [cell.title setTextAlignment:NSTextAlignmentCenter];
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return self.view.frame.size.width*0.06;
}
// 返回cell之间列间隙
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return self.view.frame.size.width*0.3;
}

// 返回cell的尺寸大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width*0.5, 60);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    QuestionViewController *nextController=[[QuestionViewController alloc]init];
    nextController.title=[NSString stringWithFormat:@"%@",_dataSourceArray[indexPath.row]];
    nextController.currentUnit=indexPath.row;
    [self.navigationController pushViewController:nextController animated:YES];
}

@end
