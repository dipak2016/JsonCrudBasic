//
//  UrlClass.h
//  JsonCrudBasic
//
//  Created by Tops on 12/21/15.
//  Copyright (c) 2015 Tops. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol UrlProtocol <NSObject>
@required

@optional
-(void)GetUrlData:(NSArray *)arrget Flag:(NSString *)stflag;
@end

@interface UrlClass : NSObject<NSURLConnectionDelegate,UrlProtocol>
{
    NSMutableData *datamute;
    NSString *st_global_glag;
}
-(void)ConntectWithURL:(NSString *)sturl Flag:(NSString *)stflag;
@property(retain,nonatomic)id delegate;
@end
