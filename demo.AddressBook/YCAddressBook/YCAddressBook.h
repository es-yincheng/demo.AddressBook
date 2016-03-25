//
//  YCAddressBook.h
//  demo.AddressBook
//
//  Created by cheng yin on 16/3/23.
//  Copyright © 2016年 cheng yin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface YCAddressBook : NSObject

@property (nonatomic, strong) UIViewController* target;
@property (nonatomic, strong) NSArray *contacts;

-(id)initWithTarget:(id)target;

/**
 *  新增联系人
 *
 *  @param contact 联系人 ABRecordRef
 *
 *  @return 是否新增成功
 */
+(BOOL)addContact:(ABRecordRef*)contact;

/**
 *  删除联系人
 *
 *  @return 是否删除成功
 */
+(BOOL)deleteContact;

/**
 *  修改联系人信息
 *
 *  @return 是否修改成功
 */
+(BOOL)changeContact;

/**
 *  获取联系人
 *
 *  @return 联系人 ABRecordRef
 */
-(ABRecordRef*)getContact;

/**
 *   *  获取所有联系人后执行aSelector动作
 *
 *  @param aSelector 获取联系人数组后执行的动作
 *
 */
-(void)getAllContactSelector:(SEL)aSelector;

@end
