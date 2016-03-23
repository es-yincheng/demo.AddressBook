//
//  YCAddressBook.m
//  demo.AddressBook
//
//  Created by cheng yin on 16/3/23.
//  Copyright © 2016年 cheng yin. All rights reserved.
//

#import "YCAddressBook.h"
#import "YCContact.h"

@implementation YCAddressBook

-(id)initWithTarget:(id)target{
    self = [super init];
    self.target = target;
    return self;
}

+(BOOL)addContact:(ABRecordRef *)contact
{
    return YES;
}

+(BOOL)deleteContact
{
    return YES;
}

+(BOOL)changeContact
{
    return YES;
}

-(ABRecordRef *)getContact
{
    return nil;
}

-(NSArray *)getAllContact:(^(){})
{
    ABAddressBookRef *addressBookRef =  ABAddressBookCreate();
    NSArray *contacts = [[NSArray alloc] init];
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error){
            
            CFErrorRef *error1 = NULL;
            ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error1);
           self.contacts = [self copyAddressBook:addressBook];
        });
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        
        CFErrorRef *error = NULL;
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
        contacts = [self copyAddressBook:addressBook];
    }
    else {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            // 更新界面
//            //            [hud turnToError:@"没有获取通讯录权限"];
//            NSLog(@"没有获取通讯录权限");
//        });
        contacts = nil;
    }
    return contacts;
}


#pragma mark -- 
- (NSArray*)copyAddressBook:(ABAddressBookRef)addressBook
{
    CFIndex numberOfPeople = ABAddressBookGetPersonCount(addressBook);
    CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(addressBook);
    NSMutableArray *contacts = [[NSMutableArray alloc] initWithCapacity:numberOfPeople];
    
    NSLog(@"该手机共有联系人：%ld",numberOfPeople);
    for ( int i = 0; i < numberOfPeople; i++){
        ABRecordRef person = CFArrayGetValueAtIndex(people, i);
        YCContact *contact = [[YCContact alloc] initWithABRecordRef:person];
        [contacts addObject:contact];
    }
    
    return contacts;
}


@end
