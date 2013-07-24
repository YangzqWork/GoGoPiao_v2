//
//  GGRegisterViewController.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 19/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGRegisterViewController.h"
#import "SVProgressHUD.h"

@interface GGRegisterViewController ()

@property (strong, nonatomic) NSMutableData *responseData;

@end

@implementation GGRegisterViewController

@synthesize scrollView;
@synthesize responseData;

#pragma mark - Life-Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupTextField];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setUsernameTextField:nil];
    [self setEmailTextField:nil];
    [self setPasswordFirstTextField:nil];
    [self setPasswordAgainTextField:nil];
    [self setSubmitButton:nil];
    [self setBackButton:nil];
    [self setScrollView:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
}

#pragma mark - 自定义绘图
- (void)setupTextField
{
    self.usernameTextField.layer.cornerRadius = 6.0f;
    self.usernameTextField.layer.masksToBounds = YES;
    self.usernameTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    self.usernameTextField.layer.borderWidth = 3.0f;
    
    self.emailTextField.layer.cornerRadius = 6.0f;
    self.emailTextField.layer.masksToBounds = YES;
    self.emailTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    self.emailTextField.layer.borderWidth = 3.0f;
    
    self.passwordFirstTextField.layer.cornerRadius = 6.0f;
    self.passwordFirstTextField.layer.masksToBounds = YES;
    self.passwordFirstTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    self.passwordFirstTextField.layer.borderWidth = 3.0f;
    
    self.passwordAgainTextField.layer.cornerRadius = 6.0f;
    self.passwordAgainTextField.layer.masksToBounds = YES;
    self.passwordAgainTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    self.passwordAgainTextField.layer.borderWidth = 3.0f;
}

#pragma mark - Button点击
- (IBAction)submitButtonPressed:(id)sender
{
#warning unfinished - 需要判断是iphone还是ipad
    NSString *urlString = @"http://42.121.58.78/api/v1/auth/signup.json";
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0f];
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"Content-Language" forHTTPHeaderField:@"en-US"];
    NSMutableData *postBody = [NSMutableData data];
    NSString *body = [NSString stringWithFormat:@"user[name]=%@&user[email]=%@&user[password]=%@",self.usernameTextField.text, self.emailTextField.text, self.passwordFirstTextField.text];
    [postBody appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:postBody];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
//2. pop重新登录/进入UICollection的界面
    [self dismissModalViewControllerAnimated:YES];
    [SVProgressHUD showWithStatus:@"注册成功"];
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.passwordFirstTextField || textField == self.passwordAgainTextField) {
        float y = textField.frame.origin.y;
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, y-120) animated:YES];
    }
    
//输入的时候变色
    textField.layer.borderColor=[[UIColor orangeColor] CGColor];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, 0) animated:YES];
    textField.layer.borderColor=[[UIColor grayColor] CGColor];
    if (textField == self.passwordAgainTextField) {
        if (self.passwordAgainTextField.text != self.passwordFirstTextField.text){
            [SVProgressHUD showErrorWithStatus:@"两次输入密码不一致"];
        }
    }
    
    if (textField == self.passwordAgainTextField) {
        [self becomeFirstResponder];
        
        NSString *urlString = @"http://42.121.58.78/api/v1/auth/signup.json";
        NSURL *url = [NSURL URLWithString:urlString];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0f];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"Content-Language" forHTTPHeaderField:@"en-US"];
        
        NSMutableData *postBody = [NSMutableData data];
        NSString *body = [NSString stringWithFormat:@"user[name]=%@&user[email]=%@&user[password]=%@",self.usernameTextField.text, self.emailTextField.text, self.passwordFirstTextField.text];
        [postBody appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
        
        [request setHTTPBody:postBody];
        [NSURLConnection connectionWithRequest:request delegate:self];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{    
    
    if (textField == self.usernameTextField)
        [self.emailTextField becomeFirstResponder];
    else if (textField == self.emailTextField)
        [self.passwordFirstTextField becomeFirstResponder];
    else if (textField == self.passwordFirstTextField)
        [self.passwordAgainTextField becomeFirstResponder];
    else if (textField == self.passwordAgainTextField)
        [self.passwordAgainTextField resignFirstResponder];
    
    return YES;
}

#pragma mark - 网络请求代理

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    id jsonObject = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@", jsonObject);
}

@end
