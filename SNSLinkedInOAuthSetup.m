//
//  SNSLinkedInOAuthSetup.m
//  SocialNetworksSharing
//
//  Created by Ostap R on 12.09.14.
//  Copyright (c) 2014 Ostap R. All rights reserved.
//

#import "SNSLinkedInOAuthSetup.h"
#import <AFNetworking.h>
#import "SNSLinkedInOAuthWebLoginViewController.h"
#import "SLVDBManager.h"
#import "Users.h"

static  NSString * kLinkedInApiKey=@"772ojbop21zpbj";
static  NSString * kLinkedInSecretKey=@"SEFTnXX310DnJtE6";

@interface SNSLinkedInOAuthSetup() <UIWebViewDelegate>


@end


@implementation SNSLinkedInOAuthSetup

-(void)setupWebView
{
    self.UIWebViewController=[SNSLinkedInOAuthWebLoginViewController new];
    
    [self.webView setFrame:CGRectMake(0, 100, 320, 600)];
    //self.webView.delegate=self;
    self.webView.scalesPageToFit=YES;
    self.UIWebViewController.webView.delegate=self;
    
    
    [((UINavigationController *)[[UIApplication sharedApplication] keyWindow].rootViewController) pushViewController:self.UIWebViewController animated:YES];
    
    
    
    
}

-(void)setup
{
    
    
    self.webView=[[UIWebView alloc] init];
    
    
    NSMutableURLRequest * request;
    
  
    //For state value
    NSDate *data=[NSDate date];
    NSTimeInterval currentTimestamp=[data timeIntervalSince1970];
    NSNumber *timestampNumber=[NSNumber numberWithDouble:currentTimestamp];
    NSString *timestampString=[timestampNumber stringValue];
            
    NSDictionary *params=
    @{
      @"response_type": @"code",
      @"client_id": kLinkedInApiKey,
      @"state":timestampString,
      @"redirect_uri":@"http://example.com"
     };
            
    request=[[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:@"https://www.linkedin.com/uas/oauth2/authorization" parameters:params error:nil];
    [self setupWebView];
    [self.UIWebViewController.webView loadRequest:request];
    
}

#pragma mark - WebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url=request.URL.absoluteString;
    
    if([url rangeOfString:@"http://example.com"].location!=NSNotFound)
    {
        NSInteger loc=NSNotFound;
        
        loc=[url rangeOfString:@"code="].location;
        if(loc!=NSNotFound)
        {
            NSString * tempToken=[self getTempTokenFromString:url];
            [self getToken:tempToken];
            return NO;
        }
        
        
    }
    
    return YES;
}

#pragma mark - LinkedInAuthorization

-(NSString *)getTempTokenFromString:(NSString *)path
{
    NSInteger locationBegin;
    NSInteger locationEnd;


    locationBegin=[path rangeOfString:@"code="].location+5;
    locationEnd=[path rangeOfString:@"&state="].location;

    
    NSRange range=NSMakeRange(locationBegin, locationEnd-locationBegin);
    NSString *tempToken=[path substringWithRange:range];
    
    return tempToken;
}

-(void)getToken:(NSString *)tempToken
{
    NSDictionary * params=
  @{
    @"grant_type":@"authorization_code",
    @"code": tempToken,
    @"redirect_uri":@"http://example.com",
    @"client_id": kLinkedInApiKey,
    @"client_secret": kLinkedInSecretKey
    };

    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    [manager.requestSerializer setValue:@"json" forHTTPHeaderField:@"x-li-format"];
    [manager POST:@"https://www.linkedin.com/uas/oauth2/accessToken" parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Success");
         Users *user;
         NSString *accessToken;
         NSDictionary * dic=responseObject;

        accessToken=dic[@"access_token"];
        user=[NSEntityDescription insertNewObjectForEntityForName:@"Users" inManagedObjectContext:[[SLVDBManager sharedManager] context]];
        user.serviceType=@"LinkedIn";
        user.token=accessToken;
        [self.delegate userData:user];
                 
        [((UINavigationController *)[[UIApplication sharedApplication] keyWindow].rootViewController) popToRootViewControllerAnimated:YES];
                 

     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Failure");
     }];
    
}

@end



