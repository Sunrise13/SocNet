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

@implementation SNSFacebook



- (void) shareText:(NSString *)text image:(UIImage *)image
{
    
    @try {
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        {
            SLComposeViewController *slcontroller = [SLComposeViewController
                                                     composeViewControllerForServiceType:SLServiceTypeFacebook];
            if (![((SNSViewController*)self.controller.mainController).shareText.text  isEqual:@""]){
                [slcontroller setInitialText:((SNSViewController*)self.controller.mainController).shareText.text];
            }
            if ((((SNSViewController*)self.controller.mainController).shareImage.image.size.height>1) && (((SNSViewController*)self.controller.mainController).shareImage.image.size.height>1)){
                [slcontroller addImage:((SNSViewController*)self.controller.mainController).shareImage.image];
            }
            //[slcontroller addURL:[NSURL URLWithString:@"www.google.com.ua/"]];
            slcontroller.completionHandler = ^(SLComposeViewControllerResult result){
                NSLog(@"Completed");
            };
            [((SNSViewController*)self.controller.mainController) presentViewController:slcontroller animated:YES completion:nil];
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
