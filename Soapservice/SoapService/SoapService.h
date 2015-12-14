//
//  SoapService.h
//  Soapservice
//
//  Created by taoxanh on 12/4/15.
//  Copyright © 2015 taoxanh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLDictionary.h"
@class SoapService;
@protocol SoapServiceDelegate <NSObject>
-(void)soapServiceResult:(SoapService*)soapService;
@end
@interface SoapService : NSObject<NSURLConnectionDelegate>
@property(nonatomic,retain) NSDictionary *requestResult;
@property (nonatomic, retain) id<SoapServiceDelegate>delegate;
-(void)soapActionWithMethod:(NSString*)method key:(NSString*)key;
-(NSString*)soapObject:(NSMutableDictionary*)dictionary;
-(void)requestWithSoapObject:(NSMutableDictionary*)soapObject URL:(NSString*)URL;
@end
