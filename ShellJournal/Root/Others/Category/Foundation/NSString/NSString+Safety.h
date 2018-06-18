//
//  NSString+Safety.h
//  DBZY
//
//  Created by 刘勇 on 2016/11/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Safety)

/**
 *  字符串md5加密
 */
- (NSString *) stringWithMD5;

/**
 *  字符串sha1加密
 */
- (NSString *) stringWithSha1;



@end
