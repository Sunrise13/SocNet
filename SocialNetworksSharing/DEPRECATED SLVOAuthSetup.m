//
//  SLVOAuthSetup.m
//  SocialSharing
//
//  Created by Ostap R on 19.08.14.
//  Copyright (c) 2014 SoftServe LV-120. All rights reserved.
//

#import <AFNetworking.h>
#import "SNSLinkedInOAuthWebLoginViewController.h"
#import "DEPRECATED SLVOAuthSetup.h"
#import "SLVDBManager.h"
#import "Users.h"

static  NSString * kLinkedInApiKey=@"772ojbop21zpbj";
static  NSString * kLinkedInSecretKey=@"SEFTnXX310DnJtE6";




@interface SLVOAuthSetup() <UIWebViewDelegate>


//@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic) SNSSocialNetworkType serviceType;

@end

@implementation SLVOAuthSetup

- (void) setupWebView
{
    self.UIWebViewController=[SNSLinkedInOAuthWebLoginViewController new];

    [self.webView setFrame:CGRectMake(0, 100, 320, 600)];
    //self.webView.delegate=self;
    self.webView.scalesPageToFit=YES;
    self.UIWebViewController.webView.delegate=self;


    [((UINavigationController *)[[UIApplication sharedApplication] keyWindow].rootViewController) pushViewController:self.UIWebViewController animated:YES];
    
    
    
    
}


-(void)setupWithServiceType:(SNSSocialNetworkType)serviceType
{
    
    self.serviceType=serviceType;
    //[[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:self animated:YES completion:nil];
    
    self.webView=[[UIWebView alloc] init];
    
    //[self viewDidLayoutSubviews];
   
    
    NSMutableString *urlAbsolutePath;
   // NSURLRequest *request;
    
    NSMutableURLRequest * request;
    
    switch (serviceType)
    {
//LinkedIn
//        case SNSSocialNetworkTypeLinkedIn:
//        {
//            //For state value
//            NSDate *data=[NSDate date];
//            NSTimeInterval currentTimestamp=[data timeIntervalSince1970];
//            NSNumber *timestampNumber=[NSNumber numberWithDouble:currentTimestamp];
//            NSString *timestampString=[timestampNumber stringValue];
//            
//            NSDictionary *params=
//            @{@"response_type": @"code",
//              @"client_id": kLinkedInApiKey,
//              @"state":timestampString,
//              @"redirect_uri":@"http://example.com"
//              };
//            
//            request=[[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:@"https://www.linkedin.com/uas/oauth2/authorization" parameters:params error:nil];
//            break;
//        }
//LinkedIn
            
//To Sasha: Move this  code snippet to your object
        case SNSSocialNetworkTypeVkontakte:
        {
           // self.requestOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
            urlAbsolutePath=[[NSMutableString alloc] initWithString:@"https://oauth.vk.com/authorize?client_id=4509556&redirect_uri=http://example.com&display=mobile&v=5.24&response_type=token"];
            request=[[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlAbsolutePath]] mutableCopy];
            break;
        }

    }
    //////////////////
     [self setupWebView]; //To Sasha: you will need seperate class for webViewController look in OAuthWebLogin for implementation details
    
    [self.UIWebViewController.webView loadRequest:request];
    
}
// For DEBUG purposes
//-(void)viewDidAppear:(BOOL)animated
//{
//    NSLog(@"View appeared %@" ,self);
//}
//
//-(void)viewWillAppear:(BOOL)animated
//{
//    NSLog(@"View will appear %@", self);
//}
//-(void) viewWillDisappear:(BOOL)animated
//{
//    NSLog(@" %@View will disapper",self);
//}

//To Sasha: in you class object like MY LinkedInOAuthSetup class you need conform WebViewDelegate
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
//LinkedIn
//            case SNSSocialNetworkTypeLinkedIn:
//                loc=[url rangeOfString:@"code="].location;
//                if(loc!=NSNotFound)
//            {
//                NSString * tempToken=[self getTempTokenFromString:url];
//                [self getToken:tempToken];
//                return NO;
//            }
//            break;
// VK Code
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
//VK Code
        
    }
    
    return YES;
}


#pragma mark - LinkedInAuthorization
//To Sasha: It's for LinkedIn you don't need this
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
    NSDictionary * params;
    
    switch (self.serviceType)
    {
        case SNSSocialNetworkTypeLinkedIn:
            //Parametrs for AFNetworking
            params=
            @{
              @"grant_type":@"authorization_code",
              @"code": tempToken,
              @"redirect_uri":@"http://example.com",
              @"client_id": kLinkedInApiKey,
              @"client_secret": kLinkedInSecretKey
              
              };

        case SNSSocialNetworkTypeVkontakte:
            absolutePath=[[NSMutableString alloc] initWithString:@"https://oauth.vk.com/authorize?client_id=4509556&scope=139286&redirect_uri=http://example.com&display=mobile&v=5.24&response_type=token"];
            break;
    }
    
//AFNetworking request
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    [manager.requestSerializer setValue:@"json" forHTTPHeaderField:@"x-li-format"]; //It's only needed for LinkedIn
    
    [manager POST:@"https://www.linkedin.com/uas/oauth2/accessToken" parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"Success");
        Users *user;
        NSString *accessToken;
        NSDictionary * dic=responseObject;
        switch (self.serviceType)
        {
            case SNSSocialNetworkTypeLinkedIn:
                accessToken=dic[@"access_token"];
                user=[NSEntityDescription insertNewObjectForEntityForName:@"Users" inManagedObjectContext:[[SLVDBManager sharedManager] context]];
                user.serviceType=@"LinkedIn";
                user.token=accessToken;
                [self.delegate userData:user];
                
                [((UINavigationController *)[[UIApplication sharedApplication] keyWindow].rootViewController) popToRootViewControllerAnimated:YES];
        
        }
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"Failure");
    }];

}





@end




