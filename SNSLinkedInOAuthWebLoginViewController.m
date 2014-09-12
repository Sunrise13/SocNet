//
//  SNSLinkedInOAuthWebLoginViewController.m
//  SocialNetworksSharing
//
//  Created by Ostap R on 11.09.14.
//  Copyright (c) 2014 Ostap R. All rights reserved.
//

#import "SNSLinkedInOAuthWebLoginViewController.h"

@interface SNSLinkedInOAuthWebLoginViewController ()

@end

@implementation SNSLinkedInOAuthWebLoginViewController

-(instancetype)init
{
    self=[super init];
    self.webView=[[UIWebView alloc]init];
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.webView setFrame:self.view.bounds];
    self.webView.scalesPageToFit=YES;
    [self.view addSubview:_webView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
