//
//  SNSVkontakteApi.m
//  SocialNetworksSharing
//
//  Created by Sasha Gypsy on 08.09.14.
//  Copyright (c) 2014 Sasha Gypsy. All rights reserved.
//

#import "SNSVkontakteApi.h"

@implementation SNSVkontakteApi


-(instancetype)init
{
    self=[super init];
    //_user=[[SLVOAuthSetup new]getUser];
    
    return self;
}

-(void)userData:(Users *)user
{
    self.user=user;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"userData" object:self];
}


-(void)settingDataSource:(id<SNSSocialNetworkDataSource>)dataSource
{
    self.dataSource=dataSource;
}

-(void)share
{
    self.setOauth=[SLVOAuthSetup new];
    [self.setOauth setupWithServiceType:SNSSocialNetworkTypeVkontakte];
    
    UIImage *image = [UIImage imageNamed:@"default.jpg"];
    
    NSString *user_id = @"13058851";
    
//    NSString *getWallUploadServer = [NSString stringWithFormat:@"https://api.vk.com/method/photos.getWallUploadServer?owner_id=%@&access_token=%@", user_id, accessToken];
//    if(!self.user)
//    {self.oauth=[SLVTokenSocialManager new];
//        self.oauth.delegate=self;
//        self.oauth.type=SNSSocialNetworkTypeLinkedIn;
//        [self.oauth getUser];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(share) name:@"userData" object:nil];
//        return;
//    }
//    
//    NSString * urlOatuh=@"?oauth2_access_token=";
//    NSString * urlPeople=@"https://api.linkedin.com/v1/people/~/shares";
//    
//    NSMutableString *url=[[NSMutableString alloc] initWithString:urlPeople];
//    [url appendString:urlOatuh];
//    [url appendString:self.user.token];
//    
//    NSLog(@"%@", url);
//    
//    
//    NSMutableURLRequest * request=[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
//    [request setHTTPMethod:@"POST"];
//    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [request addValue:@"json" forHTTPHeaderField:@"x-li-format"];
//    
//    //Formatting data for POST request
//    
//    //    {
//    //        "share": {
//    //            "comment": "Check out the LinkedIn Share API!",
//    //            "content": {
//    //                "title": "LinkedIn Developers Documentation On Using the Share API",
//    //                "description": "Leverage the Share API to maximize engagement on user-generated content on LinkedIn",
//    //                "submitted-url": "https://developer.linkedin.com/documents/share-api",
//    //                "submitted-image-url": "https://m3.licdn.com/media/p/3/000/124/1a6/089a29a.png"
//    //            },
//    //            "visibility": { "code": "anyone" }
//    //        }
//    //    }
//    
//    
//    NSMutableDictionary * root=[[NSMutableDictionary alloc] init];
//    //NSMutableDictionary * share=[[NSMutableDictionary alloc] init];
//    NSMutableDictionary * content=[[NSMutableDictionary alloc] init];
//    NSMutableDictionary * visibility=[[NSMutableDictionary alloc] init];
//    
//    //[root setObject:share forKey:@"share"];
//    
//    
//    [root setObject:[_dataSource shareText]  forKey:@"comment"];
//    //[root setObject:content forKey:@"content"];
//    // [content setObject:@"Mr. Cat go crazy" forKey:@"title"];
//    //[content setObject:@"http://google.com.ua" forKey:@"submitted-url"];
//    [root setObject:visibility forKey:@"visibility"];
//    
//    [visibility setObject:@"anyone" forKey:@"code"]; //For now we without content but with visibility
//    
//    NSLog(@"%@",root);
//    
//    
//    
//    NSData * json=[NSJSONSerialization dataWithJSONObject:root options:NSJSONWritingPrettyPrinted error:nil];
//    
//    
//    [request setHTTPBody:json];
//    NSError *error;
//    
//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:[NSOperationQueue mainQueue]
//                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
//     {
//         
//         
//         NSDictionary * dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//         NSLog(@"%@", dic);
//         NSLog(@"%@", error);
//         NSLog(@"%@", dic[@"updateUrl"]);
//         [self.delegate madeShare:[NSURL URLWithString:dic[@"updateUrl"]]];
//     }
//     ];
//    
}




@end

