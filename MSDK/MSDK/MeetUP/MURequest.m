//
//  MURequest.m
//  MSDK
//
//  Created by Alexander Petrovichev on 4/30/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

#import "MURequest.h"
#import "JSON.h"

static NSString* kUserAgent = @"MUConnect";
//static NSString* kStringBoundary = @"3i2ndDfv2rTHiSisAbouNdArYfORhtTPEefj3q2f";
static const int kGeneralErrorCode = 10000;
static const NSTimeInterval kTimeoutInterval = 180.0;


@interface MURequest ()
@property (nonatomic,readwrite) RequestState state;
@end

@implementation MURequest

@synthesize delegate = _delegate,
                    url = _url,
                    httpMethod = _httpMethod,
                    params = _params,
                    connection = _connection,
                    responseText = _responseText,
                    state = _state,
                    error = _error;

+ (MURequest *)getRequestWithParams:(NSMutableDictionary *) params
                         httpMethod:(NSString *) httpMethod
                           delegate:(id<MURequestDelegate>) delegate
                         requestURL:(NSString *) url
{
    MURequest* request = [[[MURequest alloc] init] autorelease];
    request.delegate = delegate;
    request.url = url;
    request.httpMethod = httpMethod;
    request.params = params;
    request.connection = nil;
    request.responseText = nil;
    
    return request;
}

#pragma mark - Private

/**
 * Generate get URL
 */
+ (NSString*)serializeURL:(NSString *)baseUrl
                   params:(NSDictionary *)params
               httpMethod:(NSString *)httpMethod
{
    NSURL* parsedURL = [NSURL URLWithString:baseUrl];
    NSString* queryPrefix = parsedURL.query ? @"&" : @"?";
    
    NSMutableArray* pairs = [NSMutableArray array];
    for (NSString* key in [params keyEnumerator])
    {
        if (([[params objectForKey:key] isKindOfClass:[UIImage class]])
            ||([[params objectForKey:key] isKindOfClass:[NSData class]]))
        {
            if ([httpMethod isEqualToString:@"GET"])
            {
                NSLog(@"can not use GET to upload a file");
            }
            continue;
        }
        
        NSString* escaped_value = (NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                      NULL, /* allocator */
                                                                                      (CFStringRef)[params objectForKey:key],
                                                                                      NULL, /* charactersToLeaveUnescaped */
                                                                                      (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                      kCFStringEncodingUTF8);
        
        [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, escaped_value]];
        [escaped_value release];
    }
    NSString* query = [pairs componentsJoinedByString:@"&"];
    
    return [NSString stringWithFormat:@"%@%@%@", baseUrl, queryPrefix, query];
}

/**
 * Body append for POST method
 */
- (void)utfAppendBody:(NSMutableData *)body data:(NSString *)data
{
    [body appendData:[data dataUsingEncoding:NSUTF8StringEncoding]];
}

/**
 * Generate body for POST method
 */
- (NSMutableData *)generateRequestBody
{
    NSMutableData *body = [NSMutableData data];
    NSMutableDictionary *dataDictionary = [NSMutableDictionary dictionary];
    NSMutableArray* pairs = [NSMutableArray array];
    for (NSString* key in [_params keyEnumerator])
    {
        if (([[_params objectForKey:key] isKindOfClass:[UIImage class]])
            ||([[_params objectForKey:key] isKindOfClass:[NSData class]]))
        {
            [dataDictionary setObject:[_params objectForKey:key] forKey:key];
            continue;
        }
        
        NSString* escaped_value = (NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                      NULL, /* allocator */
                                                                                      (CFStringRef)[_params objectForKey:key],
                                                                                      NULL, /* charactersToLeaveUnescaped */
                                                                                      (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                      kCFStringEncodingUTF8);
        
        [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, escaped_value]];
        [escaped_value release];
    }
    NSString* query = [pairs componentsJoinedByString:@"&"];
    [self utfAppendBody:body data:query];
    return body;
}

/**
 * Formulate the NSError
 */
- (id)formError:(NSInteger)code userInfo:(NSDictionary *) errorData
{
    return [NSError errorWithDomain:@"meetupErrDomain" code:code userInfo:errorData];
}

/**
 * parse the response data
 */
- (id)parseJsonResponse:(NSData *)data error:(NSError **)error
{
    NSString* responseString = [[[NSString alloc] initWithData:data
                                                      encoding:NSUTF8StringEncoding]
                                autorelease];

    if ([responseString length] == 0)
    {
        if (error != nil)
        {
            *error = [self formError:kGeneralErrorCode
                            userInfo:[NSDictionary
                                      dictionaryWithObject:@"Server returns nothing"
                                      forKey:@"error_msg"]];
        }
        return nil;
    }
    
    
    SBJSON *jsonParser = [[SBJSON alloc] init];
    id result = [jsonParser objectWithString:responseString];
    [jsonParser release];
    
    if (result == nil)
    {
        return responseString;
    }
    
    if ([result isKindOfClass:[NSDictionary class]])
    {
        if ([result objectForKey:@"code"] != nil && [[result objectForKey:@"code"] intValue] == 1)
        {
            //to do: parse error and pass parsed object
            if (error != nil)
            {
                *error = [self formError:kGeneralErrorCode
                                userInfo:result];
            }
            return nil;
        }
    }
    
    return result;
}

/*
 * private helper function: call the delegate function when the request
 *                          fails with error
 */
- (void)failWithError:(NSError *)error
{
    if ([_delegate respondsToSelector:@selector(request:didFailWithError:)])
    {
        [_delegate request:self didFailWithError:error];
    }
}

/*
 * private helper function: handle the response data
 */
- (void)handleResponseData:(NSData *)data
{
    if ([_delegate respondsToSelector:
         @selector(request:didLoadRawResponse:)])
    {
        [_delegate request:self didLoadRawResponse:data];
    }
    
    NSError* error = nil;
    id result = [self parseJsonResponse:data error:&error];
    self.error = error;  
    
    if ([_delegate respondsToSelector:@selector(request:didLoad:)] ||
        [_delegate respondsToSelector:
         @selector(request:didFailWithError:)])
    {
            
        if (error)
        {
            [self failWithError:error];
        }
        else if ([_delegate respondsToSelector:
                    @selector(request:didLoad:)])
        {
            [_delegate request:self didLoad:result];
        }
    }
}



#pragma mark - Public

/**
 * @return boolean - whether this request is processing
 */
- (BOOL)loading
{
    return !!_connection;
}

/**
 * make the MeetUP request
 */
- (void)connect
{
    if ([_delegate respondsToSelector:@selector(requestLoading:)])
    {
        [_delegate requestLoading:self];
    }
    
    NSString* url = [[self class] serializeURL:_url params:_params httpMethod:_httpMethod];
    NSMutableURLRequest* request =
    [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                            cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                        timeoutInterval:kTimeoutInterval];
    [request setValue:kUserAgent forHTTPHeaderField:@"User-Agent"];
    
    
    [request setHTTPMethod:self.httpMethod];
    if ([self.httpMethod isEqualToString: @"POST"] || [self.httpMethod isEqualToString: @"DELETE"]|| [self.httpMethod isEqualToString: @"PUT"])
    {
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        NSData* postData = [self generateRequestBody];
        [request setHTTPBody:postData];
        [request setValue:[NSString stringWithFormat:@"%d", postData.length] forHTTPHeaderField:@"Content-Length"];
    }
    NSLog(@"request %@", request);
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    self.state = kRequestStateLoading;
}

/**
 * Free internal structure
 */
- (void)dealloc
{
    [_connection cancel];
    [_connection release];
    [_responseText release];
    [_url release];
    [_httpMethod release];
    [_params release];
    [super dealloc];
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _responseText = [[NSMutableData alloc] init];
    
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    if ([_delegate respondsToSelector:
         @selector(request:didReceiveResponse:)])
    {
        [_delegate request:self didReceiveResponse:httpResponse];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_responseText appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse
{
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self handleResponseData:_responseText];
    
    self.responseText = nil;
    self.connection = nil;
    self.state = kRequestStateComplete;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self failWithError:error];
    
    self.responseText = nil;
    self.connection = nil;
    self.state = kRequestStateError;
}

@end
