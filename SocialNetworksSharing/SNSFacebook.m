//
//  SNSFacebook.m
//  SocialNetworksSharing
//
//  Created by Sasha Gypsy on 06.09.14.
//  Copyright (c) 2014 Sasha Gypsy. All rights reserved.
//

#import "SNSFacebook.h"

#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "SNSPostData.h"

@implementation SNSFacebook



- (void) shareText:(NSString *)text image:(UIImage *)image
{
    
    @try {
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        {
            SLComposeViewController *slcontroller = [SLComposeViewController
                                                     composeViewControllerForServiceType:SLServiceTypeFacebook];
            
            NSString* txt = [[SNSPostData sharedPostData] getText];
            UIImage* img = [[SNSPostData sharedPostData] getImage];

            [slcontroller setInitialText: txt];
            //[slcontroller addImage: img];
              

            [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:slcontroller animated:YES completion:nil];
        }else {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error login account!"
                                                            message:@"Please setup user account!"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cansel"
                                                  otherButtonTitles:@"Create new", nil];
            [alert show];
            NSLog(@"The facebook service is not available");
            
        }
    }
    @catch (NSException *exception) {
        NSLog(@"exeption!");
    }
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {}
    else if (buttonIndex == 1)
    {
        //[self setAlertForSettingPage];
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=TWITTER"]];
        //NSURL *fr =[NSURL URLWithString:[@"https://www.facebook.com/" stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"https://www.facebook.com/" stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]]];
        
    }
}



-(void)hello
{
    NSLog(@"Hello");
}
@end
