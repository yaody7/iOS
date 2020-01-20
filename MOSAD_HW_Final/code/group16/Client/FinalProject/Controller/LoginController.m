//
//  LoginController.m
//  FinalProject
//
//  Created by lucky_li on 2019/12/16.
//  Copyright © 2019 lucky_li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginController.h"
#import "UserInfo.h"
#import "InputCell.h"

@interface LoginController()
@property (nonatomic, strong) UIView * banner;
@property (nonatomic, strong) UIButton * LoginButton;    //登录按钮
@property (nonatomic, strong) UIButton * RegisterButton; //注册按钮
@property (nonatomic, strong) NSArray * RegisterInfo;
@property (nonatomic, strong) NSArray * subTitle;

@property (nonatomic, strong) InputCell * username;
@property (nonatomic, strong) InputCell * password;
@property (nonatomic, strong) InputCell * email;

@property (nonatomic, strong) UserInfoView * userInfo;

@property(nonatomic, strong) NSDictionary * GetDict;
@property(nonatomic, strong) NSMutableArray * tempresult;

//切换按钮
@property (nonatomic, strong) UIButton * goSignin;
@property (nonatomic, strong) UIButton * goSignup;

@end

@implementation LoginController

- (void) viewDidLoad {
    self.RegisterInfo = @[@"Username", @"Password", @"Email"];
    
    self.subTitle = @[@"register",@"login"];

    [self.view addSubview:self.banner];
    
    [self.view addSubview:self.username];
    [self.view addSubview:self.password];
    [self.view addSubview:self.email];

    [self.view addSubview:self.LoginButton];
    [self.view addSubview:self.RegisterButton];
    
    [self.view addSubview:self.goSignup];
    [self.view addSubview:self.goSignin];
    self.goSignup.hidden = YES;
    self.LoginButton.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
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

/** 点击空白处回收键盘 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    [textField resignFirstResponder];
    return true;
}

#pragma mark - 懒加载
- (UIButton *)goSignin {
    if (_goSignin == nil) {
        _goSignin = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/10*8, self.view.frame.size.width, 30)];
        
        NSMutableAttributedString * title = [[NSMutableAttributedString alloc] initWithString:@"go to sign in"];
        NSRange titleRange = {0,[title length]};
        [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
        [title addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:100.0f/255.0f green:149.0f/255.0f blue:237.0f/255.0f alpha:1.0f] range:titleRange];
        [_goSignin setAttributedTitle:title
                             forState:UIControlStateNormal];
        [_goSignin addTarget:self action:@selector(goSigninEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goSignin;
}

- (UIButton *)goSignup {
    if (_goSignup == nil) {
        _goSignup = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/10*8, self.view.frame.size.width, 30)];
        NSMutableAttributedString * title = [[NSMutableAttributedString alloc] initWithString:@"New user? create an account"];
        NSRange titleRange = {0,[title length]};
        [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
        [title addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:100.0f/255.0f green:149.0f/255.0f blue:237.0f/255.0f alpha:1.0f] range:titleRange];
        [_goSignup setAttributedTitle:title
                             forState:UIControlStateNormal];
        [_goSignup addTarget:self action:@selector(goSignupEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goSignup;
}

- (UIButton *)LoginButton {
    if (_LoginButton == nil) {
        _LoginButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/6, self.view.frame.size.height/4*3, self.view.frame.size.width/3*2, 40)];
        _LoginButton.titleLabel.font = [UIFont fontWithName:@"DINCondensed-Bold" size:30];
        _LoginButton.layer.borderColor = [UIColor colorWithRed:100.0f/255.0f green:149.0f/255.0f blue:237.0f/255.0f alpha:1.0f].CGColor;
        _LoginButton.layer.borderWidth = 1;
        _LoginButton.layer.cornerRadius = 5;
        _LoginButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_LoginButton setTitleColor:[UIColor colorWithRed:100.0f/255.0f green:149.0f/255.0f blue:237.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [_LoginButton setTitle:@"Sign in" forState:UIControlStateNormal];
        [_LoginButton addTarget:self action:@selector(loginEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _LoginButton;
}

- (UIButton *)RegisterButton {
    if (_RegisterButton == nil) {
        _RegisterButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/6, self.view.frame.size.height/4*3, self.view.frame.size.width/3*2, 40)];
        _RegisterButton.titleLabel.font = [UIFont fontWithName:@"DINCondensed-Bold" size:30];
        _RegisterButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _RegisterButton.layer.borderColor = [UIColor colorWithRed:100.0f/255.0f green:149.0f/255.0f blue:237.0f/255.0f alpha:1.0f].CGColor;
        _RegisterButton.layer.borderWidth = 1;
        _RegisterButton.layer.cornerRadius = 5;
        [_RegisterButton setTitleColor:[UIColor colorWithRed:100.0f/255.0f green:149.0f/255.0f blue:237.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [_RegisterButton setTitle:@"Sign up" forState:UIControlStateNormal];
        [_RegisterButton addTarget:self action:@selector(registerEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _RegisterButton;
}

- (InputCell *)username {
    if (_username == nil) {
        _username = [[InputCell alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/2, self.view.bounds.size.width, 50)];
        _username.input.placeholder = _RegisterInfo[0];
    }
    return _username;
}

- (InputCell *)password {
    if (_password == nil) {
        _password = [[InputCell alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/2+60, self.view.bounds.size.width, 50)];
        _password.input.placeholder = _RegisterInfo[1];
        _password.input.secureTextEntry = YES; //隐藏密码
    }
    return _password;
}

- (InputCell *)email {
    if (_email == nil) {
        _email = [[InputCell alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/2+120, self.view.bounds.size.width, 50)];
        _email.input.placeholder = _RegisterInfo[2];
    }
    return _email;
}


#pragma mark - 辅助函数
-(void)goSigninEvent:(UIButton*)btn {
    NSLog(@"go to sign in");
    _username.input.text = @"";
    _password.input.text = @"";
    _email.input.text = @"";
    _email.hidden = YES;
    _LoginButton.hidden = NO;
    _RegisterButton.hidden = YES;
    _goSignin.hidden = YES;
    _goSignup.hidden = NO;
}

-(void)goSignupEvent:(UIButton*)btn {
    NSLog(@"go to sign up");
    _username.input.text = @"";
    _password.input.text = @"";
    _email.input.text = @"";
    _email.hidden = NO;
    _LoginButton.hidden = YES;
    _RegisterButton.hidden = NO;
    _goSignin.hidden = NO;
    _goSignup.hidden = YES;
}

-(void)loginEvent:(UIButton*)btn {
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);

    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    NSURL * url = [NSURL URLWithString:@"http://localhost:8001/api/login"];

    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];

    NSString * newuser = [NSString stringWithFormat:@"%@", self.username.input.text];
    NSLog(@"username: %@", self.username.input.text);
    NSString * newpawd = [NSString stringWithFormat:@"%@", self.password.input.text];
    NSLog(@"password: %@", self.password.input.text);
    NSDictionary *dic = @{@"username": newuser, @"password": newpawd};

    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [urlRequest setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];

    NSURLSessionDataTask * dataTask =[delegateFreeSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error == nil) {
            NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            self.GetDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"Data = %@", text);
        }
        dispatch_group_leave(group);
    }];
    [dataTask resume];

    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"status: %@", self.GetDict[@"status"]);
        if([self.GetDict[@"status"] isEqualToString:@"success"]) {
            self.userInfo = [[UserInfoView alloc] init];
            NSLog(@"stupid dict: %@", self.GetDict);
            NSString * newemail = [NSString stringWithFormat:@"%@", self.GetDict[@"email"]];
            NSString * newnum = [NSString stringWithFormat:@"%@", self.GetDict[@"todo_num"]];
            NSInteger focusTime = [self.GetDict[@"focus_time"] integerValue];
            NSArray * temp = @[newuser, newemail, @(focusTime), newnum];
//            NSArray * temp = @[newuser, newemail, self.GetDict[@"focus_time"], newnum];
            self.tempresult = [NSMutableArray arrayWithArray:temp];
            self.userInfo.info = self.tempresult;
            NSLog(@"login success");
            [self.navigationController pushViewController:self.userInfo animated:NO];
        }
        else {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:self.GetDict[@"err_msg"] preferredStyle:UIAlertControllerStyleAlert];

            NSString * newmessage = [NSString stringWithFormat:@"%@", self.GetDict[@"err_msg"]];
            NSRange messageRange = {0,[newmessage length]};
            NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:newmessage];
            [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"DINCondensed-Bold" size:20] range:messageRange];
            [alert setValue:alertControllerMessageStr forKey:@"attributedMessage"];

            UIAlertAction *conform = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"点击了确认按钮");
            }];
            [alert addAction:conform];
            NSLog(@"login fail");
            [self presentViewController:alert animated:YES completion:nil];
        }
    });
    _username.input.text = @"";
    _password.input.text = @"";
    _email.input.text = @"";
}

-(void)registerEvent:(UIButton*)btn {
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    
    NSURLSessionConfiguration * defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:@"http://localhost:8001/api/register"];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    
    NSString * newuser = [NSString stringWithFormat:@"%@", self.username.input.text];
    NSString * newpawd = [NSString stringWithFormat:@"%@", self.password.input.text];
    NSString * newemail = [NSString stringWithFormat:@"%@", self.email.input.text];
    NSDictionary *dic = @{@"username": newuser, @"password": newpawd, @"email":newemail};
    
    if ([newuser isEqualToString:@""]) {
        NSString * newmessage = @"Username should not be empty";
        
        //设置弹框
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:newmessage preferredStyle:UIAlertControllerStyleAlert];
        
        NSRange messageRange = {0,[newmessage length]};
        NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:newmessage];
        [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"DINCondensed-Bold" size:20] range:messageRange];
        [alert setValue:alertControllerMessageStr forKey:@"attributedMessage"];
        
        //弹框下方按钮
        UIAlertAction *conform = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:conform];
        [self presentViewController:alert animated:YES completion:nil];
        
        _username.input.text = @"";
        _password.input.text = @"";
        _email.input.text = @"";
        return;
    } else if ([newpawd isEqualToString:@""]) {
        NSString * newmessage = @"Password should not be empty";
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:newmessage preferredStyle:UIAlertControllerStyleAlert];
        
        NSRange messageRange = {0,[newmessage length]};
        NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:newmessage];
        [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"DINCondensed-Bold" size:20] range:messageRange];
        //通过kvc赋值
        [alert setValue:alertControllerMessageStr forKey:@"attributedMessage"];
        
        UIAlertAction *conform = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:conform];
        [self presentViewController:alert animated:YES completion:nil];
        
        _username.input.text = @"";
        _password.input.text = @"";
        _email.input.text = @"";
        return;
    } else if ([newemail isEqualToString:@""]) {
        NSString * newmessage = @"Email should not be empty";
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:newmessage preferredStyle:UIAlertControllerStyleAlert];
        
        NSRange messageRange = {0,[newmessage length]};
        NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:newmessage];
        [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"DINCondensed-Bold" size:20] range:messageRange];
        //通过kvc赋值
        [alert setValue:alertControllerMessageStr forKey:@"attributedMessage"];
        
        UIAlertAction *conform = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:conform];
        [self presentViewController:alert animated:YES completion:nil];
        
        _username.input.text = @"";
        _password.input.text = @"";
        _email.input.text = @"";
        return;
    }
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [urlRequest setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[delegateFreeSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error == nil) {
            NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            NSLog(@"Data = %@",text);
            self.GetDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        }
        dispatch_group_leave(group);
    }];
    [dataTask resume];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"%@", self.GetDict[@"status"]);
        if([self.GetDict[@"status"] isEqualToString:@"success"]) {
            NSLog(@"register successfully");
            NSString * newmessage = @"register successfully";
            
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:newmessage preferredStyle:UIAlertControllerStyleAlert];
            
            
            NSRange messageRange = {0,[newmessage length]};
            NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:newmessage];
            [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"DINCondensed-Bold" size:20] range:messageRange];
            //通过kvc赋值
            [alert setValue:alertControllerMessageStr forKey:@"attributedMessage"];
            
            UIAlertAction *conform = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            //Sign in按钮可以直接跳转到登录界面
            UIAlertAction *gonext = [UIAlertAction actionWithTitle:@"Sign in" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.email.hidden = YES;
                self.LoginButton.hidden = NO;
                self.RegisterButton.hidden = YES;
                self.goSignin.hidden = YES;
                self.goSignup.hidden = NO;
            }];
            
            //设置OK按钮的颜色
            [conform setValue:[UIColor blackColor] forKey:@"titleTextColor"];
            [alert addAction:conform];
            [alert addAction:gonext];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            NSLog(@"register fail");
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:self.GetDict[@"err_msg"] preferredStyle:UIAlertControllerStyleAlert];
            
            NSString * newmessage = [NSString stringWithFormat:@"%@", self.GetDict[@"err_msg"]];
            NSRange messageRange = {0,[newmessage length]};
            NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:newmessage];
            [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"DINCondensed-Bold" size:20] range:messageRange];
            //通过kvc赋值
            [alert setValue:alertControllerMessageStr forKey:@"attributedMessage"];
            
            UIAlertAction *conform = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:conform];
            [self presentViewController:alert animated:YES completion:nil];
        }
    });
    _username.input.text = @"";
    _password.input.text = @"";
    _email.input.text = @"";
}

@end
