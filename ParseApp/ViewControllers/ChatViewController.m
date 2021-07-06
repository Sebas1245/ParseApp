//
//  ChatViewController.m
//  ParseApp
//
//  Created by Sebastian Saldana Cardenas on 06/07/21.
//

#import "ChatViewController.h"
#import <Parse/Parse.h>

@interface ChatViewController ()
@property (weak, nonatomic) IBOutlet UITextField *messageField;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)clickSend:(id)sender {
    PFObject *chatMessage = [PFObject objectWithClassName:@"Message_FBU2021"];
    // Use the name of your outlet to get the text the user typed
    chatMessage[@"text"] = self.messageField.text;
    // save the message
    [chatMessage saveInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (succeeded) {
            NSLog(@"The message was saved!");
            self.messageField.text = @"";
        } else {
            NSLog(@"Problem saving message: %@", error.localizedDescription);
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
