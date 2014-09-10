//
//  SNSTwitter.m
//  SocialNetworksSharing
//
//  Created by Sasha Gypsy on 08.09.14.
//  Copyright (c) 2014 Sasha Gypsy. All rights reserved.
//

#import "SNSTwitter.h"
#import "SNSPostData.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@implementation SNSTwitter


- (void)share
{
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *slcontroller = [SLComposeViewController
                                                 composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        NSString* txt = [[SNSPostData sharedPostData] getText];
        UIImage* img = [[SNSPostData sharedPostData] getImage];
        
        [slcontroller setInitialText: txt];
        [slcontroller addImage: img];
        
        
        [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:slcontroller animated:YES completion:nil];
        
    }else {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error login account!"
                                                        message:@"Please setup user account!"
                                                       delegate:self
                                              cancelButtonTitle:@"Cansel"
                                              otherButtonTitles:@"Create new", nil];

        [alert show];
        NSLog(@"The twitter service is not available");
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {}
    else if (buttonIndex == 1)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"https://www.twitter.com/" stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]]];
    }
}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return YES;
}
@end
