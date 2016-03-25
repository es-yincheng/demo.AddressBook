//
//  ViewController.m
//  demo.AddressBook
//
//  Created by cheng yin on 16/3/23.
//  Copyright © 2016年 cheng yin. All rights reserved.
//

#import "ViewController.h"
#import <AddressBook/AddressBook.h>
#import "YCAddressBook.h"

@interface ViewController ()
{
    ABAddressBookRef addressBookRef;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)getAddressBooks:(UIButton *)sender {
    YCAddressBook *contact = [[YCAddressBook alloc] initWithTarget:self];
    [contact getAllContactSelector:@selector(gotContacts:)];
}

-(IBAction)gotContacts:(NSArray*)arry
{
    NSLog(@"联系人数量：%lu",(unsigned long)arry.count);
}

@end
