//
//  VKRequest.h
//  CoolProject
//
//  Created by Igor Botov on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestState.h"
#import "RequestDelegates.h"

@interface VKRequest : NSObject
{
    id<VKRequestDelegate> _delegate;
    NSString*             _url;
    NSString*             _httpMethod;
    NSMutableDictionary*  _params;
    NSURLConnection*      _connection;
    NSMutableData*        _responseText;
    RequestState          _state;
    NSError*              _error;
    BOOL                  _sessionDidExpire;
}



@property(nonatomic,assign) id<VKRequestDelegate> delegate;

/**
 * The URL which will be contacted to execute the request.
 */
@property(nonatomic,copy) NSString* url;

/**
 * The API method which will be called.
 */
@property(nonatomic,copy) NSString* httpMethod;

/**
 * The dictionary of parameters to pass to the method.
 *
 * These values in the dictionary will be converted to strings using the
 * standard Objective-C object-to-string conversion facilities.
 */
@property(nonatomic,retain) NSMutableDictionary* params;
@property(nonatomic,retain) NSURLConnection*  connection;
@property(nonatomic,retain) NSMutableData* responseText;
@property(nonatomic,readonly) RequestState state;
@property(nonatomic,readonly) BOOL sessionDidExpire;

/**
 * Error returned by the server in case of request's failure (or nil otherwise).
 */
@property(nonatomic,retain) NSError* error;


+ (NSString*)serializeURL:(NSString *)baseUrl
                   params:(NSDictionary *)params;

+ (NSString*)serializeURL:(NSString *)baseUrl
                   params:(NSDictionary *)params
               httpMethod:(NSString *)httpMethod;

+ (VKRequest*)getRequestWithParams:(NSMutableDictionary *) params
                        httpMethod:(NSString *) httpMethod
                          delegate:(id<VKRequestDelegate>)delegate
                        requestURL:(NSString *) url;
- (BOOL) loading;

- (void) connect;

@end
