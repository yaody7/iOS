//
//  UserInfo.m
//  FinalProject
//
//  Created by lucky_li on 2019/12/16.
//  Copyright © 2019 lucky_li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
#import "InfoCell.h"
#import "ListView.h"
#import "PlantView.h"

@interface UserInfoView()
@property (nonatomic, strong) UIView * banner;
@property (nonatomic, strong) UIButton * tree;
@property (nonatomic, strong) UIButton * list;
@property (nonatomic, strong) ListView * listView;
@property (nonatomic, strong) PlantView * plantView;

@property (nonatomic, strong) InfoCell * basicInfo;
@property (nonatomic, strong) UITableView * myTableView;

@property (nonatomic, strong) UILabel * presentTitle;
@property (nonatomic, strong) UILabel * presentUsername;
@property (nonatomic, strong) UILabel * presentEmail;
@property (nonatomic, strong) UILabel * presentTime;
@property (nonatomic, strong) UILabel * presentList;
@property (nonatomic, strong) UILabel * times;
@property (nonatomic, strong) UILabel * lists;

@property (nonatomic, strong) UIImage * userImage;

@property (nonatomic, strong) UIButton * LogoutButton;

@property (nonatomic, strong) NSArray * titles;

@end

@implementation UserInfoView

- (void) viewDidLoad {
    
    self.userImage = [UIImage imageNamed:@"user.png"];
    [self.navigationController setNavigationBarHidden:YES];
    
    self.titles = @[@"Username", @"Email", @"Time focus on learning", @"Unfinished events"];
    
    NSString * changeToHour = self.info[2];
    int allMinutes = [changeToHour intValue];
    int allHours = allMinutes / 60;
    allMinutes = allMinutes - allHours * 60;
    NSString * hour = [NSString stringWithFormat:@"%d",allHours];
    NSString * min = [NSString stringWithFormat:@"%d",allMinutes];
    
    NSString *newString = [NSString stringWithFormat:@"%@%@%@%@",hour,@"h ", min, @"min"];
    NSLog(@"%@", newString);
    [self.info replaceObjectAtIndex:2 withObject:newString];

    [self.view addSubview:self.banner];
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.basicInfo];
    [self.view addSubview:self.LogoutButton];
    NSLog(@"finish loading");
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController setToolbarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController setToolbarHidden:NO];
}

- (UIView *)banner {
    if (_banner == nil) {
        _banner = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2 - 200, 100, 400, 200)];
        UIGraphicsBeginImageContext(_banner.bounds.size);
        [[UIImage imageNamed:@"banner.png"] drawInRect:CGRectMake(10, 0, 400, 200)];
        UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [_banner setBackgroundColor:[UIColor colorWithPatternImage:image]];
    }
    return _banner;
}

#pragma mark - 懒加载
- (InfoCell *)basicInfo {
    if (_basicInfo == nil) {
        _basicInfo = [[InfoCell alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/5*2, self.view.frame.size.width, self.view.frame.size.height/4)];
        _basicInfo.userImg.image = _userImage;
        _basicInfo.username.text = _info[0];
        _basicInfo.username.font = [UIFont fontWithName:@"DINCondensed-Bold" size:30];
        _basicInfo.email.text = _info[1];
        _basicInfo.email.font = [UIFont fontWithName:@"DINCondensed-Bold" size:20];
        _basicInfo.backgroundColor = [UIColor whiteColor];
    }
    return _basicInfo;
}

- (UITableView *)myTableView {
    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/20*13, self.view.frame.size.width, 120) style:UITableViewStyleGrouped];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.backgroundColor = [UIColor whiteColor];
    }
    return _myTableView;
}

- (UIButton *)LogoutButton {
    if (_LogoutButton == nil) {
        _LogoutButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/6, self.view.frame.size.height/20*17, self.view.frame.size.width/3*2, 40)];
        
        _LogoutButton.titleLabel.font = [UIFont fontWithName:@"DINCondensed-Bold" size:30];
        _LogoutButton.layer.borderColor = [UIColor redColor].CGColor;
        _LogoutButton.layer.borderWidth = 1;
        _LogoutButton.layer.cornerRadius = 5;
        _LogoutButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_LogoutButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_LogoutButton setTitle:@"Sign out" forState:UIControlStateNormal];
        [_LogoutButton addTarget:self action:@selector(logoutEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _LogoutButton;
}

#pragma mark - 数据代理
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
//        _plantView = [[PlantView alloc] init];
        _plantView = [[PlantView alloc] initWithUsername:_basicInfo.username.text];
        NSLog(@"go to time");
        [self.navigationController pushViewController:_plantView animated:NO];
    } else if (indexPath.row == 1) {
        _listView = [[ListView alloc] init];
        _listView.username = _basicInfo.username.text;
        
        NSLog(@"go to list");
        [self.navigationController pushViewController:_listView animated:NO];
    }
    [self.myTableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (nullable NSString *)tableView:(UITableView *) tableView titleForHeaderInSection:(NSInteger)section {
//    return _info[0];
    return nil;
}

-(UITableViewCell *)tableView:(UITableView * ) tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell"];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"tableCell"];
    }

    cell.textLabel.text = _titles[indexPath.row + 2];
    cell.textLabel.font = [UIFont fontWithName:@"DINCondensed-Bold" size:25];

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.detailTextLabel.text = _info[indexPath.row + 2];
    cell.detailTextLabel.font = [UIFont fontWithName:@"DINCondensed-Bold" size:18];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return 44;
}

#pragma mark - 辅助函数
-(void)logoutEvent:(UIButton*)btn {
    [self.navigationController popToRootViewControllerAnimated:true];
}

@end
