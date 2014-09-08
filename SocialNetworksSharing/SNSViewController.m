//
//  SNSViewController.m
//  SocialNetworksSharing
//
//  Created by Sasha Gypsy on 06.09.14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "SNSViewController.h"
#import "SNSNetworksViewController.h"
#import "SNSPostData.h"

@interface SNSViewController ()

@end

@implementation SNSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [SNSPostData sharedPostData]; //maybe it's not needed
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 2 /*Use existing*/)
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:NULL];
        
    }
}


- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [_shareImage setImage:image];
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_shareText resignFirstResponder];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"Button"])
    {
        SNSNetworksViewController * dController = segue.destinationViewController;
        dController.mainController = self;
    }
    
    
    if (![self.shareText.text isEqual:@""])
    {
        [[SNSPostData sharedPostData] setWithText:self.shareText.text];
    }
    if ((_shareImage.image.size.height>1)&&(_shareImage.image.size.width>1))
    {
        [[SNSPostData sharedPostData] setWithImage:self.shareImage.image];
    }
    
}

@end
