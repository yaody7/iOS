//
//  ViewController.m
//  HW3
//
//  Created by ydy on 2019/9/30.
//  Copyright © 2019 ydy. All rights reserved.
//

#import "FirstViewController.h"
#import "LanguageCell.h"
#import "LearnViewController.h"
#import "UserViewController.h"
#import "MyTabBar.h"
#define CellWidthSpace 10
#define CellWidth (self.view.frame.size.width - (3*CellWidthSpace))/2
#define CellLineSpace 20
@interface FirstViewController ()<UITabBarControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic,copy) NSMutableArray *dataSourceArray;
@property (nonatomic,copy) NSMutableArray *nameSourceArray;
@property (nonatomic,copy) NSString* languagename;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: self.collection];
    [self.view addSubview: self.titleLabel];
    self.dataSourceArray=[NSMutableArray arrayWithArray:@[@"English.png",@"German.png",@"Japanese.png",@"Spanish.png"]];
    self.nameSourceArray=[NSMutableArray arrayWithArray:@[@"英语",@"德语",@"日语",@"西班牙语"]];
}

- (UICollectionView *)collection {
    if(_collectionView==nil){
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        layout.itemSize=CGSizeMake(30,40);
        self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.1,0.3*self.view.frame.size.height,self.view.frame.size.width*0.8,600)collectionViewLayout:layout];
        self.collectionView.backgroundColor=UIColor.whiteColor;
        // 设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        // 注册cell
        [_collectionView registerClass:[LanguageCell class] forCellWithReuseIdentifier:@"MyCell"];
    }
    return _collectionView;
}

- (UILabel *)titleLabel {
    if(_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _collectionView.frame.origin.y - 60, self.view.frame.size.width, 30)];
        [_titleLabel setText: @"请选择语言"];
        [_titleLabel setFont: [UIFont systemFontOfSize: 20]];
        [_titleLabel setTextColor: [UIColor blackColor]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LanguageCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    cell.backgroundColor=UIColor.whiteColor;
    cell.imageName=self.dataSourceArray[indexPath.row];
    cell.imageView.image=[UIImage imageNamed:cell.imageName];
    [cell.title setText:self.nameSourceArray[indexPath.row]];
    [cell.title setTextAlignment:NSTextAlignmentCenter];
    return cell;
}

// 返回cell之间行间隙
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return self.view.frame.size.width*0.05;
}
// 返回cell之间列间隙
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return self.view.frame.size.width*0.02;
}

// 返回cell的尺寸大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width*0.38, self.view.frame.size.width*0.3);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UITabBarController *nextController=[[UITabBarController alloc]init];
    nextController.delegate=self;
    nextController.title=
    [NSString stringWithFormat:@"学习%@",_nameSourceArray[indexPath.row]];
    _languagename=[NSString stringWithFormat:@"学习%@",_nameSourceArray[indexPath.row]];
    
    
    LearnViewController * LearnVC=[[LearnViewController alloc]init];
    LearnVC.tabBarItem.title=@"学习";
    LearnVC.tabBarItem.image=[[UIImage imageNamed:@"learn1.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    LearnVC.tabBarItem.selectedImage=[[UIImage imageNamed:@"learn2.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
    [LearnVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0 green:0 blue:0 alpha:1]} forState:UIControlStateSelected];
    [nextController addChildViewController:LearnVC];
    
    UserViewController * UserVC=[[UserViewController alloc]init];
    UserVC.tabBarItem.title=@"用户";
    UserVC.tabBarItem.image=[[UIImage imageNamed:@"user1.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UserVC.tabBarItem.selectedImage=[[UIImage imageNamed:@"user2.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [UserVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0 green:0 blue:0 alpha:1]} forState:UIControlStateSelected];
    [nextController addChildViewController:UserVC];
    
    [self.navigationController pushViewController:nextController animated:YES];
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    if(tabBarController.title==_languagename){
        tabBarController.title=@"个人档案";
    }
    else
        tabBarController.title=_languagename;
}
@end
