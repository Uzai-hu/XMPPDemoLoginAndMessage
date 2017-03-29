//
//  FriendsTableViewController.h
//  XMPPDemo
//
//  Created by hzy on 2016/9/29.
//  Copyright © 2016年 hzy. All rights reserved.
//

#import "LoginViewController.h"
#import "RootViewController.h"
#import "XMPPManager.h"
#import "FriendsTableViewController.h"
@interface LoginViewController ()
@property (nonatomic,strong)UITextField *userNameTextField;
@property (nonatomic,strong)UITextField *userPasswordTextField;
@property (nonatomic,strong)UIButton    *loginBtn;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}


- (void)initView{
    
    self.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.userNameTextField];
    [self.view addSubview:self.userPasswordTextField];
    [self.view addSubview:self.loginBtn];
}

- (void)login{
    __weak typeof(self) ws=self;
    if (self.userNameTextField.text.length > 0 && self.userPasswordTextField.text.length > 0) {
        XMPPManager *xm = [XMPPManager defaultManager];
        [xm loginwithName:self.userNameTextField.text andPassword:self.userPasswordTextField.text success:^{
            FriendsTableViewController *root = [FriendsTableViewController new];
            [ws.navigationController pushViewController:root animated:YES];
        } failure:^(NSString *error) {
            NSLog(@"%@",error);
        }];
    }
    
}



-(UITextField *)userNameTextField{
    if (!_userNameTextField) {
        _userNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(80, 100, 100, 22)];
        _userNameTextField.layer.borderColor= [UIColor blackColor].CGColor;
        _userNameTextField.layer.borderWidth= 1.0f;
        _userNameTextField.placeholder = @"账号";
    }
    return _userNameTextField;
}


-(UITextField *)userPasswordTextField{
    if (!_userPasswordTextField) {
        _userPasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(80, 150, 100, 22)];
        _userPasswordTextField.layer.borderColor= [UIColor blackColor].CGColor;
        _userPasswordTextField.layer.borderWidth= 1.0f;
        _userPasswordTextField.placeholder = @"密码";
    }
    return _userPasswordTextField;
}


-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _loginBtn.frame = CGRectMake(80, 200, 100, 22);
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

@end
