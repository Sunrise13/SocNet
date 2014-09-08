//
//  SLVOAuthSetup.m
//  SocialSharing
//
//  Created by Ostap R on 19.08.14.
//  Copyright (c) 2014 SoftServe LV-120. All rights reserved.
//

#import "SLVOAuthSetup.h"
#import "SLVDBManager.h"
#import "Users.h"
static  NSString * kLinkedInApiKey=@"772ojbop21zpbj";
static  NSString * kLinkedInSecretKey=@"SEFTnXX310DnJtE6";


static  NSString * kFacebookApiKey=@"1460000980941762";
static  NSString * kFacebookSecretKey=@"7e349e1a9a5ea5b520d69c9d01a1e455";


@interface SLVOAuthSetup() <UIWebViewDelegate>


@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic) SNSSocialNetworkType serviceType;

@end

@implementation SLVOAuthSetup
CGRect rect;

- (void) viewWillLayoutSubviews
{
    if(UIInterfaceOrientationIsLandscape(self.interfaceOrientation))
    {
        rect = CGRectMake(0, 0, 570, 320);
    }
    else
    {
        rect = CGRectMake(0, 0, 320, 600);
    }
    [self ShowWebView];
}



- (void) ShowWebView
{
    [self.webView setFrame:rect];
    self.webView.delegate=self;
    self.webView.scalesPageToFit=YES;
    [self.view addSubview:self.webView];
    
}


-(void)setupWithServiceType:(SNSSocialNetworkType)serviceType
{
    self.serviceType=serviceType;
    [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:self animated:YES completion:nil];
    
    self.webView=[[UIWebView alloc] init];
    
    [self viewDidLayoutSubviews];
    [self ShowWebView];
    
    NSMutableString *urlAbsolutePath;
    NSURLRequest *request;
    
    
    
    switch (serviceType)
    {
        case SNSSocialNetworkTypeLinkedIn:
        {
            urlAbsolutePath=[[NSMutableString alloc] initWithString:@"https://www.linkedin.com/uas/oauth2/authorization?response_type=code&client_id="];
            [urlAbsolutePath appendString:kLinkedInApiKey];
            [urlAbsolutePath appendString:@"&state="];
            
            NSDate *data=[NSDate date];
            NSTimeInterval currentTimestamp=[data timeIntervalSince1970];
            NSNumber *timestampObj=[NSNumber numberWithDouble:currentTimestamp];
            [urlAbsolutePath appendString:[timestampObj stringValue]];
            [urlAbsolutePath appendString:@"&redirect_uri=http://example.com"];
            request=[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlAbsolutePath]];
            break;
        }
        case SNSSocialNetworkTypeVkontakte:
        {
           // self.requestOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
            urlAbsolutePath=[[NSMutableString alloc] initWithString:@"https://oauth.vk.com/authorize?client_id=4509556&redirect_uri=http://example.com&display=mobile&v=5.24&response_type=token"];
            request=[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlAbsolutePath]];
            break;
        }

    }
    
     [self.webView loadRequest:request];
    
}

#pragma mark - WebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url=request.URL.absoluteString;
    NSLog(@"%@\n", url);
    
    if([url rangeOfString:@"http://example.com"].location!=NSNotFound)
    {
        NSInteger loc=NSNotFound;
        NSInteger loc2;
        switch (self.serviceType)
        {
            case SNSSocialNetworkTypeLinkedIn:
                loc=[url rangeOfString:@"code="].location;
                if(loc!=NSNotFound)
            {
                NSString * tempToken=[self getTempTokenFromString:url];
                [self getToken:tempToken];
                return NO;
            }
            break;
            case SNSSocialNetworkTypeVkontakte:
                loc=[url rangeOfString:@"access_token="].location;
                if(loc!=NSNotFound)
                {
                    loc2=[url rangeOfString:@"&expires_in"].location;
                    NSRange range=NSMakeRange(loc+13, loc2-loc-13);
                    NSString *token=[url substringWithRange:range];
                    Users *user=[NSEntityDescription insertNewObjectForEntityForName:@"Users" inManagedObjectContext:[[SLVDBManager sharedManager] context]];
                    user.serviceType=@"Vkontakte";
                    user.token=token;

                    [self.delegate userData:user];
                    return NO;
                }
                break;
        }

        
    }
    
    return YES;
}

#pragma mark - LinkedInAuthorization

-(NSString *)getTempTokenFromString:(NSString *)path
{
    NSInteger locationBegin;
    NSInteger locationEnd;
    switch(self.serviceType)
    {
        case SNSSocialNetworkTypeLinkedIn:
            locationBegin=[path rangeOfString:@"code="].location+5;
            locationEnd=[path rangeOfString:@"&state="].location;
            break;
        case SNSSocialNetworkTypeVkontakte:
            //
            break;
            

            
    }
    
        NSRange range=NSMakeRange(locationBegin, locationEnd-locationBegin);
        NSString *tempToken=[path substringWithRange:range];

        return tempToken;
}

-(void)getToken:(NSString *)tempToken
{
    NSMutableString * absolutePath;
    NSURL * urlAbsolutePath;
    NSMutableURLRequest * request;
    
    switch (self.serviceType)
    {
        case SNSSocialNetworkTypeLinkedIn:
            absolutePath=[[NSMutableString alloc] initWithString:@"https://www.linkedin.com/uas/oauth2/accessToken?grant_type=authorization_code&code="];
            [absolutePath appendString:tempToken];
            [absolutePath appendString:@"&redirect_uri=http://example.com"];
            [absolutePath appendString:@"&client_id="];
            [absolutePath appendString:kLinkedInApiKey];
            [absolutePath appendString:@"&client_secret="];
            [absolutePath appendString:kLinkedInSecretKey];
            break;
        case SNSSocialNetworkTypeVkontakte:
            absolutePath=[[NSMutableString alloc] initWithString:@"https://oauth.vk.com/authorize?client_id=4509556&scope=nohttps&redirect_uri=http://example.com&display=mobile&v=5.24&response_type=token"];
            break;
    }
    

    urlAbsolutePath=[NSURL URLWithString:absolutePath];
    
    request=[[NSMutableURLRequest alloc] initWithURL:urlAbsolutePath];
    [request setHTTPMethod:@"POST"];
    

    [NSURLConnection sendAsynchronousRequest:request
                                      queue:[NSOperationQueue mainQueue]
                            completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {

         NSDictionary * dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
         
         Users *user;
         NSString *accessToken;
         switch (self.serviceType)
         {
             case SNSSocialNetworkTypeLinkedIn:
             
                 accessToken=dic[@"access_token"];
                 user=[NSEntityDescription insertNewObjectForEntityForName:@"Users" inManagedObjectContext:[[SLVDBManager sharedManager] context]];
                 user.serviceType=@"LinkedIn";
                 user.token=accessToken;
                 break;
             
             case SNSSocialNetworkTypeVkontakte:
                 
                 accessToken=dic[@"access_token"];
                 user=[NSEntityDescription insertNewObjectForEntityForName:@"Users" inManagedObjectContext:[[SLVDBManager sharedManager] context]];
                 user.serviceType=@"Vkontakte";
                 user.token=accessToken;
                 break;
                 

         }
        
         [self.delegate userData:user];
         [self.webView removeFromSuperview];
         [[[UIApplication sharedApplication] keyWindow].rootViewController dismissViewControllerAnimated:YES completion:nil];

     }
     ];
    
}





@end




