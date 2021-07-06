//
//  LoginViewController.m
//  ParseApp
//
//  Created by Sebastian Saldana Cardenas on 06/07/21.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
}
- (IBAction)clickSignUp:(id)sender {
    [self validateFields];
    // initialize a user object
    PFUser *newUser = [PFUser user];
        
    // set user properties
    newUser.username = self.usernameField.text;
//    newUser.email = self.emailField.text;
    newUser.password = self.passwordField.text;
        
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
            [self createAlert:@"User sign up failed! Please try another username or check your internet connection."];
        } else {
            NSLog(@"User registered successfully");
            
            // manually segue to logged in view
        }
    }];
}
- (IBAction)clickLogIn:(id)sender {
    [self validateFields];
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
       if (error != nil) {
           NSLog(@"User log in failed: %@", error.localizedDescription);
           [self createAlert:@"User login failed! Please check your credentials or your internet connection."];
       } else {
           NSLog(@"User logged in successfully");
           
           // display view controller that needs to shown after successful login
       }
    }];
}

-(void)validateFields {
    if([self.usernameField.text isEqual:@""] || [self.passwordField.text isEqual:@""]) {
        [self createAlert:@"Username or password cannot be blank!"];
    }
}

-(void)createAlert: (NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                               message:message
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];

    // create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Try again"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle response here.
                                                     }];
    // add the OK action to the alert controller
    [alert addAction:okAction];
    
    // show alert
    [self presentViewController:alert animated:YES completion:^{
        // optional code for what happens after the alert controller has finished presenting
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
