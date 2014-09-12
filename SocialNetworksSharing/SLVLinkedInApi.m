//
//  SLVLinkedInApi.m
//  Social Networks
//
//  Created by Ostap R on 18.08.14.
//  Copyright (c) 2014 SoftServe Lv-120. All rights reserved.
//

#import "SLVLinkedInApi.h"
#import <REComposeViewController.h>

@implementation SLVLinkedInApi

-(void)userData:(Users *)user
{
    self.user=user;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"userData" object:self];
}

-(NSDictionary *)getProfile
{
    NSString * urlOatuh=@"?oauth2_access_token=";
    NSString * urlPeople=@"https://api.linkedin.com/v1/people/~:(first-name,last-name,headline,location:(name),summary,interests,skills,three-current-positions,picture-url)";
    
    NSMutableString *url=[[NSMutableString alloc] initWithString:urlPeople];
    [url appendString:urlOatuh];
    [url appendString:self.user.token];
    
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request addValue:@"json" forHTTPHeaderField:@"x-li-format"];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         NSDictionary * dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
         NSLog(@"%@", dic);
         NSLog(@"%@", dic[@"location"][@"name"]);
         [self.delegate dataOfProfile:dic];
     }];
    
    return nil;
}
-(void)settingDataSource:(id<SNSSocialNetworkDataSource>)dataSource
{
    self.dataSource=dataSource;
}

-(void)share
{
    if(!self.user)
    {
        self.oauth=[SLVTokenSocialManager new];
        self.oauth.delegate=self;
        self.oauth.type=SNSSocialNetworkTypeLinkedIn;
        [self.oauth getUser];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(share) name:@"userData" object:nil];
        return;
    }
    
  
    NSString * urlOatuh=@"?oauth2_access_token=";
    NSString * urlPeople=@"https://api.linkedin.com/v1/people/~/shares";

    NSMutableString *url=[[NSMutableString alloc] initWithString:urlPeople];
    [url appendString:urlOatuh];
    [url appendString:self.user.token];
    
    
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"json" forHTTPHeaderField:@"x-li-format"];
    
    
    NSMutableDictionary * root=[[NSMutableDictionary alloc] init];
    NSMutableDictionary * visibility=[[NSMutableDictionary alloc] init];
    
    
    [root setObject:[_dataSource shareText]  forKey:@"comment"];
    [root setObject:visibility forKey:@"visibility"];
    
    [visibility setObject:@"anyone" forKey:@"code"];
    
   

    
    NSData * json=[NSJSONSerialization dataWithJSONObject:root options:NSJSONWritingPrettyPrinted error:nil];
    [request setHTTPBody:json];
    
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {

    
         NSDictionary * dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
         [self.delegate madeShare:[NSURL URLWithString:dic[@"updateUrl"]]];
     }
     ];

}




@end
