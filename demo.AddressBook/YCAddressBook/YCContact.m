//
//  YCContact.m
//  demo.AddressBook
//
//  Created by cheng yin on 16/3/23.
//  Copyright © 2016年 cheng yin. All rights reserved.
//

#import "YCContact.h"

@implementation YCContact
-(instancetype)initWithABRecordRef:(ABRecordRef*)person
{
    if (!self) {
        self = [super init];
        
        
        [self setInfosWithABRecordRef:person];
    }
    
    return self;
}

-(void)setInfosWithABRecordRef:(ABRecordRef*)person
{
    self.firstName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));
    self.lastName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));
    //读取middlename
    self.middlename = (__bridge NSString*)ABRecordCopyValue(person, kABPersonMiddleNameProperty);
    //读取prefix前缀
    self.prefix = (__bridge NSString*)ABRecordCopyValue(person, kABPersonPrefixProperty);
    //读取suffix后缀
    self.suffix = (__bridge NSString*)ABRecordCopyValue(person, kABPersonSuffixProperty);
    //读取nickname呢称
    self.nickname = (__bridge NSString*)ABRecordCopyValue(person, kABPersonNicknameProperty);
    //读取firstname拼音音标
    self.firstnamePhonetic = (__bridge NSString*)ABRecordCopyValue(person, kABPersonFirstNamePhoneticProperty);
    //读取lastname拼音音标
    self.lastnamePhonetic = (__bridge NSString*)ABRecordCopyValue(person, kABPersonLastNamePhoneticProperty);
    //读取middlename拼音音标
    self.middlenamePhonetic = (__bridge NSString*)ABRecordCopyValue(person, kABPersonMiddleNamePhoneticProperty);
    //读取organization公司
    self.organization = (__bridge NSString*)ABRecordCopyValue(person, kABPersonOrganizationProperty);
    //读取jobtitle工作
    self.jobtitle = (__bridge NSString*)ABRecordCopyValue(person, kABPersonJobTitleProperty);
    //读取department部门
    self.department = (__bridge NSString*)ABRecordCopyValue(person, kABPersonDepartmentProperty);
    //读取birthday生日
    self.birthday = (__bridge NSDate*)ABRecordCopyValue(person, kABPersonBirthdayProperty);
    //读取note备忘录
    self.note = (__bridge NSString*)ABRecordCopyValue(person, kABPersonNoteProperty);
    //第一次添加该条记录的时间
    self.firstknow = (__bridge NSString*)ABRecordCopyValue(person, kABPersonCreationDateProperty);
    //        NSLog(@"第一次添加该条记录的时间%@\n",firstknow);
    //最后一次修改該条记录的时间
    self.lastknow = (__bridge NSString*)ABRecordCopyValue(person, kABPersonModificationDateProperty);
    //        NSLog(@"最后一次修改該条记录的时间%@\n",lastknow);
    
    //获取email多值
    ABMultiValueRef email = ABRecordCopyValue(person, kABPersonEmailProperty);
    int emailcount = ABMultiValueGetCount(email);
    NSMutableArray *personEmail = [[NSMutableArray alloc] initWithCapacity:emailcount];
    for (int x = 0; x < emailcount; x++)
    {
        //获取email Label
        NSString* emailLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(email, x));
        //获取email值
        NSString* emailContent = (__bridge NSString*)ABMultiValueCopyValueAtIndex(email, x);
        NSMutableDictionary *tempEmail = [[NSMutableDictionary alloc] init];
        [tempEmail setValue:emailLabel forKey:@"emailLabel"];
        [tempEmail setValue:emailContent forKey:@"emailContent"];
        [personEmail addObject:tempEmail];
    }
    self.emails = personEmail;
    
    //读取地址多值
    ABMultiValueRef address = ABRecordCopyValue(person, kABPersonAddressProperty);
    int count = ABMultiValueGetCount(address);
    NSMutableArray *personAddress = [[NSMutableArray alloc] initWithCapacity:count];
    for(int j = 0; j < count; j++)
    {
        //获取地址Label
        NSString* addressLabel = (__bridge NSString*)ABMultiValueCopyLabelAtIndex(address, j);
        //获取該label下的地址6属性
        NSDictionary* personaddress =(__bridge NSDictionary*) ABMultiValueCopyValueAtIndex(address, j);
        NSString* country = [personaddress valueForKey:(NSString *)kABPersonAddressCountryKey];
        NSString* city = [personaddress valueForKey:(NSString *)kABPersonAddressCityKey];
        NSString* state = [personaddress valueForKey:(NSString *)kABPersonAddressStateKey];
        NSString* street = [personaddress valueForKey:(NSString *)kABPersonAddressStreetKey];
        NSString* zip = [personaddress valueForKey:(NSString *)kABPersonAddressZIPKey];
        NSString* coutntrycode = [personaddress valueForKey:(NSString *)kABPersonAddressCountryCodeKey];
        NSMutableDictionary *tempAddress = [[NSMutableDictionary alloc] init];
        [tempAddress setValue:addressLabel forKey:@"addressLabel"];
        [tempAddress setValue:country forKey:@"country"];
        [tempAddress setValue:city forKey:@"city"];
        [tempAddress setValue:state forKey:@"state"];
        [tempAddress setValue:street forKey:@"street"];
        [tempAddress setValue:zip forKey:@"zip"];
        [tempAddress setValue:coutntrycode forKey:@"coutntrycode"];
        [personAddress addObject:tempAddress];
    }
    self.addresses = personAddress;
    
    //获取dates多值
    ABMultiValueRef dates = ABRecordCopyValue(person, kABPersonDateProperty);
    int datescount = ABMultiValueGetCount(dates);
    NSMutableArray *personDates = [[NSMutableArray alloc] initWithCapacity:datescount];
    for (int y = 0; y < datescount; y++)
    {
        //获取dates Label
        NSString* datesLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(dates, y));
        //获取dates值
        NSString* datesContent = (__bridge NSString*)ABMultiValueCopyValueAtIndex(dates, y);
        NSMutableDictionary *tempDate = [[NSMutableDictionary alloc] init];
        [tempDate setValue:datesLabel forKey:@"datesLabel"];
        [tempDate setValue:datesContent forKey:@"datesContent"];
        [personDates addObject:tempDate];
    }
    self.dates = personDates;
    
    //获取kind值
    CFNumberRef recordType = ABRecordCopyValue(person, kABPersonKindProperty);
    if (recordType == kABPersonKindOrganization) {
        self.recordType = YCContactTypeCompany;
    } else if(recordType == kABPersonType || recordType == kABPersonKindPerson){
        self.recordType = YCContactTypePerson;
    } else if(recordType == kABGroupType) {
        self.recordType = YCContactTypeGroup;
    } else {
        self.recordType = YCContactTypeOther;
    }
    
    //获取IM多值
    ABMultiValueRef instantMessage = ABRecordCopyValue(person, kABPersonInstantMessageProperty);
    NSMutableArray *personIMs = [[NSMutableArray alloc] initWithCapacity:ABMultiValueGetCount(instantMessage)];
    for (int l = 1; l < ABMultiValueGetCount(instantMessage); l++)
    {
        //获取IM Label
        NSString* instantMessageLabel = (__bridge NSString*)ABMultiValueCopyLabelAtIndex(instantMessage, l);
        //获取該label下的2属性
        NSDictionary* instantMessageContent =(__bridge NSDictionary*) ABMultiValueCopyValueAtIndex(instantMessage, l);
        NSString* username = [instantMessageContent valueForKey:(NSString *)kABPersonInstantMessageUsernameKey];
        NSString* service = [instantMessageContent valueForKey:(NSString *)kABPersonInstantMessageServiceKey];
        NSMutableDictionary *tempIM = [[NSMutableDictionary alloc] init];
        [tempIM setValue:username forKey:@"username"];
        [tempIM setValue:service forKey:@"service"];
        [personIMs addObject:tempIM];
    }
    self.instantMessages = personIMs;
    
    //读取电话多值
    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    NSMutableArray *personPhones = [[NSMutableArray alloc] initWithCapacity:ABMultiValueGetCount(phone)];
    for (int k = 0; k<ABMultiValueGetCount(phone); k++)
    {
        //获取电话Label
        NSString * personPhoneLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phone, k));
        //获取該Label下的电话值
        NSString * personPhone = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phone, k);
        NSMutableDictionary *tempPhone = [[NSMutableDictionary alloc] init];
        [tempPhone setValue:personPhoneLabel forKey:@"personPhoneLabel"];
        [tempPhone setValue:personPhone forKey:@"personPhone"];
        [personPhones addObject:tempPhone];
    }
    self.phones = personPhones;
    
    //获取URL多值
    ABMultiValueRef url = ABRecordCopyValue(person, kABPersonURLProperty);
     NSMutableArray *personUrls = [[NSMutableArray alloc] initWithCapacity:ABMultiValueGetCount(url)];
    for (int m = 0; m < ABMultiValueGetCount(url); m++)
    {
        //获取电话Label
        NSString * urlLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(url, m));
        //获取該Label下的电话值
        NSString * urlContent = (__bridge NSString*)ABMultiValueCopyValueAtIndex(url,m);
        NSMutableDictionary *tempUrl = [[NSMutableDictionary alloc] init];
        [tempUrl setValue:urlLabel forKey:@"urlLabel"];
        [tempUrl setValue:urlContent forKey:@"urlContent"];
        [personUrls addObject:tempUrl];
    }
    self.phones = personUrls;

    
    //读取照片
    self.image = (__bridge NSData*)ABPersonCopyImageData(person);
}
@end
