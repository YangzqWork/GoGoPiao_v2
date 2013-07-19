//
//  GGMainViewController.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 19/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGMainViewController.h"
#import "GGEventViewController.h"

@interface GGMainViewController ()

@end

@implementation GGMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"主页";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UITapGestureRecognizer * recognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap1)];
    [self.imageView1 addGestureRecognizer:recognizer1];
    
    UITapGestureRecognizer * recognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap2)];
    [self.imageView2 addGestureRecognizer:recognizer2];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setImageView1:nil];
    [self setImageView2:nil];
    [self setImageView1:nil];
    [self setImageView2:nil];
    [self setImageView3:nil];
    [super viewDidUnload];
}

#pragma mark - TapGesture Handling
- (void)handleTap1
{
    NSLog(@"tap1");
    GGEventViewController *ggEventVC = [[GGEventViewController alloc] initWithNibName:@"GGEventViewController" bundle:nil];
    [self presentViewController:ggEventVC animated:YES completion:nil];
}

- (void)handleTap2
{
    NSLog(@"tap2");
}

@end
