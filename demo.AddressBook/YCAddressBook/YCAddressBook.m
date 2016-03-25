//
//  YCAddressBook.m
//  demo.AddressBook
//
//  Created by cheng yin on 16/3/23.
//  Copyright © 2016年 cheng yin. All rights reserved.
//

#import "YCAddressBook.h"
#import "YCContact.h"
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)
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

-(void)getAllContactSelector:(SEL)aSelector
{
    ABAddressBookRef *addressBookRef =  ABAddressBookCreate();
    NSArray *contacts = [[NSArray alloc] init];
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error){
            NSLog(@"1");
            CFErrorRef *error1 = NULL;
            ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error1);
            SuppressPerformSelectorLeakWarning(
                                               [self.target performSelector:aSelector withObject:[self copyAddressBook:addressBook]];
                                               );
        });
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        NSLog(@"2");
        CFErrorRef *error = NULL;
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
        contacts = [self copyAddressBook:addressBook];
        SuppressPerformSelectorLeakWarning(
                                           [self.target performSelector:aSelector withObject:contacts];
                                           );
        
    }
    else {
        NSLog(@"3");
        SuppressPerformSelectorLeakWarning(
                                           [self.target performSelector:aSelector withObject:nil];
                                           );
    }
}


#pragma mark --
- (NSArray*)copyAddressBook:(ABAddressBookRef)addressBook
{
    CFIndex numberOfPeople = ABAddressBookGetPersonCount(addressBook);
    CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(addressBook);
    NSMutableArray *contacts = [[NSMutableArray alloc] initWithCapacity:numberOfPeople];
    
//    NSLog(@"该手机共有联系人：%ld",numberOfPeople);
    for ( int i = 0; i < numberOfPeople; i++){
        ABRecordRef person = CFArrayGetValueAtIndex(people, i);
        YCContact *contact = [[YCContact alloc] initWithABRecordRef:person];
        [contacts addObject:contact];
    }
    
    return contacts;
}


@end
