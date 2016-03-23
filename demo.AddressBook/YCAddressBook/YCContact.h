//
//  YCContact.h
//  demo.AddressBook
//
//  Created by cheng yin on 16/3/23.
//  Copyright © 2016年 cheng yin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

typedef enum : NSUInteger {
    YCContactTypePerson,
    YCContactTypeCompany,
    YCContactTypeGroup,
    YCContactTypeOther,
} YCContactType;

@interface YCContact : NSObject
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
/**
 *  读取middlename
 */
@property (nonatomic, copy) NSString *middlename;
/**
 *  读取prefix前缀
 */
@property (nonatomic, copy) NSString *prefix;
/**
 *  读取suffix后缀
 */
@property (nonatomic, copy) NSString *suffix;
/**
 *  读取nickname呢称
 */
@property (nonatomic, copy) NSString *nickname;
/**
 *  读取firstname拼音音标
 */
@property (nonatomic, copy) NSString *firstnamePhonetic;
/**
 *  读取lastname拼音音标
 */
@property (nonatomic, copy) NSString *lastnamePhonetic;
/**
 *  读取middlename拼音音标
 */
@property (nonatomic, copy) NSString *middlenamePhonetic;
/**
 *  读取organization公司
 */
@property (nonatomic, copy) NSString *organization;
/**
 *  读取jobtitle工作
 */
@property (nonatomic, copy) NSString *jobtitle;
/**
 *  读取department部门
 */
@property (nonatomic, copy) NSString *department;
/**
 *  读取birthday生日
 */
@property (nonatomic, strong) NSDate *birthday;
/**
 *  读取note备忘录
 */
@property (nonatomic, copy) NSString *note;
/**
 *  第一次添加该条记录的时间
 */
@property (nonatomic, copy) NSString *firstknow;
/**
 *  最后一次修改該条记录的时间
 */
@property (nonatomic, copy) NSString *lastknow;
/**
 *  获取email多值
 *  格式
 *      @[@{@"emailLabel":@"",@"emailContent":@""},……]
 */
@property (nonatomic, strong) NSArray *emails;
/**
 *  地址多值
 *  格式
 *      @[@{@"addressLabel":@"",@"country":@"",@"city":@"",@"state":@"",@"street":@"",@"zip":@""，@"coutntrycode":@""},……]
 */
@property (nonatomic, strong) NSArray *addresses;
/**
 *  获取dates多值
 *  格式
 *      @[@{@"datesLabel":@"",@"datesContent":@""},……]
 */
@property (nonatomic, strong) NSArray *dates;
/**
 *  联系人类型（公司，个人，群组，其他）
 */
@property (nonatomic, assign) YCContactType recordType;
/**
 *  IM多值
 *  格式
 *      @[@{@"username":@"",@"service":@""},……]
 */
@property (nonatomic, strong) NSArray *instantMessages;
/**
 *  电话多值
 *  格式
 *      @[@{@"personPhoneLabel":@"",@"personPhone":@""},……]
 */
@property (nonatomic, strong) NSArray *phones;

/**
 *  URL多值
 *  格式
 *      @[@{@"urlLabel":@"",@"urlContent":@""},……]
 */
@property (nonatomic, strong) NSArray *urls;

/**
 *  照片
 */
@property (nonatomic, strong) NSData *image;

/**
 *  根据person（ABRecordRef）初始化联系人
 *
 *  @param person 传入的person对象
 *
 *  @return 初始化的实例
 */
-(instancetype)initWithABRecordRef:(ABRecordRef*)person;
@end
