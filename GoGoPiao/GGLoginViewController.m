//
//  GGLoginViewController.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 14/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGLoginViewController.h"
#import "GGRegisterViewController.h"
#import "GGAccountViewController.h"
#import "GGEventViewController.h"
#import "GGSettingsViewController.h"
#import "GGMainViewController.h"
#import "SVProgressHUD.h"
#import "JSONKit.h"

@interface GGLoginViewController ()

@property (strong, nonatomic) NSMutableData *responseData;

@end

@implementation GGLoginViewController

@synthesize ggAcountVC;
@synthesize ggEventVC;
@synthesize ggSettingsVC;

@synthesize didRememberPw;
@synthesize userTextField;
@synthesize passwordTextField;

@synthesize responseData;

#pragma mark - Life-Cycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.didRememberPw = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"登录/注册";

//设置两个输入框的颜色
    self.userTextField.layer.cornerRadius = 6.0f;
    self.userTextField.layer.masksToBounds = YES;
    self.userTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    self.userTextField.layer.borderWidth = 3.0f;
    
    self.passwordTextField.layer.cornerRadius = 6.0f;
    self.passwordTextField.layer.masksToBounds = YES;
    self.passwordTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    self.passwordTextField.layer.borderWidth = 3.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setLoginButton:nil];
    [self setRegisterButton:nil];
    [self setRememberPwButton:nil];
    [self setUserTextField:nil];
    [self setPasswordTextField:nil];
    [super viewDidUnload];
}

#pragma mark - 按钮处理
- (IBAction)loginButtonPressed:(id)sender
{
//    self.tabBarController = [[UITabBarController alloc] init];
//    self.ggAcountVC = [[GGAccountViewController alloc] initWithNibName:@"GGAccountViewController" bundle:nil];
//    self.ggEventVC = [[GGEventViewController alloc] initWithNibName:@"GGEventViewController" bundle:nil];
//    self.ggSettingsVC = [[GGSettingsViewController alloc] initWithNibName:@"GGSettingsViewController" bundle:nil];
//    UINavigationController *accountNav = [[UINavigationController alloc] initWithRootViewController:self.ggAcountVC];
//    UINavigationController *eventNav = [[UINavigationController alloc] initWithRootViewController:self.ggEventVC];
//    UINavigationController *settingNav = [[UINavigationController alloc] initWithRootViewController:self.ggSettingsVC];
//    
//    NSArray* vcArray = [[NSArray alloc] initWithObjects:accountNav, eventNav, settingNav, nil];
//    [self.tabBarController setViewControllers:vcArray];
//    
//
//    [self presentViewController:self.tabBarController animated:YES completion:nil];
    GGMainViewController *ggMainVC = [[GGMainViewController alloc] initWithNibName:@"GGMainViewController" bundle:nil];
    UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:ggMainVC];
    [self presentViewController:mainNav animated:YES completion:nil];
}

- (IBAction)registerButtonPressed:(id)sender
{
    GGRegisterViewController *ggRegisterVC = [[GGRegisterViewController alloc] initWithNibName:@"GGRegisterViewController" bundle:nil];
    
//    [self.navigationController pushViewController:ggRegisterVC animated:YES];
    [self presentViewController:ggRegisterVC animated:YES completion:nil];
}

- (IBAction)rememberPwButtonPressed:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 0) {
        btn.tag = 1;
        self.didRememberPw = YES;
        [self.rememberPwButton setImage:[UIImage imageNamed:@"cb_dark_on.png"] forState:UIControlStateNormal];
    }
    else {
        btn.tag = 0;
        self.didRememberPw = NO;
        [self.rememberPwButton setImage:[UIImage imageNamed:@"cb_dark_off.png"] forState:UIControlStateNormal];
    }
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //输入的时候变色
    textField.layer.borderColor=[[UIColor orangeColor] CGColor];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    textField.layer.borderColor=[[UIColor grayColor] CGColor];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //点击Return按钮时候触发此method
    if (textField == self.userTextField) {
        [self.passwordTextField becomeFirstResponder];
    }
    else if (textField == self.passwordTextField) {
        //进行登录操作
#warning unfinished - 应该判断是ipad还是iphone来登录
        [self.passwordTextField resignFirstResponder];
        [SVProgressHUD showWithStatus:@"正在登录"];
        NSLog(@"%@ -- %@", self.userTextField.text, self.passwordTextField.text);
        
//登录：网络请求
        NSString *urlString = @"http://42.121.58.78/api/v1/auth/signin.json";
        NSURL *requestURL = [NSURL URLWithString:urlString];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0f];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"Content-Language" forHTTPHeaderField:@"en-US"];
        NSMutableData *postBody = [NSMutableData data];
        NSString *body = [NSString stringWithFormat:@"login=%@&password=%@&platform=%@",self.userTextField.text, self.passwordTextField.text, @"iphone"];
        [postBody appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
        
        [request setHTTPBody:postBody];
        [NSURLConnection connectionWithRequest:request delegate:self];
    }
    return YES;
}

#pragma mark - 网络异步方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Login fail error message: %@", error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *dictData = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
    NSDictionary *returnJSONObject = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingAllowFragments error:nil];
    NSString *token = [returnJSONObject objectForKey:@"token"];
    if (token == nil) {
        [SVProgressHUD showErrorWithStatus:@"用户名或密码错误"];
    }
    else {
        [SVProgressHUD showSuccessWithStatus:@"登录成功"];
    }
}

@end
