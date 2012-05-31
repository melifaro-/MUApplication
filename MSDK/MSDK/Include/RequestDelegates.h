//
//  RequestDelegates.h
//  MSDK
//
//  Created by Alexander Petrovichev on 5/3/12.
//  Copyright (c) 2012 apetrovichev@me.com. All rights reserved.
//

@class MURequest;
@class VKRequest;

/*
 *Your application should implement this delegate
 */
@protocol MURequestDelegate <NSObject>

@optional

/**
 * Called just before the request is sent to the server.
 */
- (void)requestLoading:(MURequest *)request;

/**
 * Called when the API request has returned a response.
 *
 * This callback gives you access to the raw response. It's called before
 * (void)request:(MURequest *)request didLoad:(id)result,
 * which is passed the parsed response object.
 */
- (void)request:(MURequest *)request didReceiveResponse:(NSURLResponse *)response;

/**
 * Called when an error prevents the request from completing successfully.
 */
- (void)request:(MURequest *)request didFailWithError:(NSError *)error;

/**
 * Called when a request returns and its response has been parsed into
 * an object.
 *
 * The resulting object may be a dictionary, an array or a string, depending
 * on the format of the API response. If you need access to the raw response,
 * use:
 *
 * (void)request:(MURequest *)request
 *      didReceiveResponse:(NSURLResponse *)response
 */
- (void)request:(MURequest *)request didLoad:(id)result;

/**
 * Called when a request returns a response.
 *
 * The result object is the raw response from the server of type NSData
 */
- (void)request:(MURequest *)request didLoadRawResponse:(NSData *)data;

@end

////////////////////////////////////////////////////////////////////////////////

/*
 *Your application should implement this delegate
 */
@protocol VKRequestDelegate <NSObject>

@optional

/**
 * Called just before the request is sent to the server.
 */
- (void)requestLoading:(VKRequest *)request;

/**
 * Called when the Facebook API request has returned a response.
 *
 * This callback gives you access to the raw response. It's called before
 * (void)request:(FBRequest *)request didLoad:(id)result,
 * which is passed the parsed response object.
 */
- (void)request:(VKRequest *)request didReceiveResponse:(NSURLResponse *)response;

/**
 * Called when an error prevents the request from completing successfully.
 */
- (void)request:(VKRequest *)request didFailWithError:(NSError *)error;

/**
 * Called when a request returns and its response has been parsed into
 * an object.
 *
 * The resulting object may be a dictionary, an array or a string, depending
 * on the format of the API response. If you need access to the raw response,
 * use:
 *
 * (void)request:(FBRequest *)request
 *      didReceiveResponse:(NSURLResponse *)response
 */
- (void)request:(VKRequest *)request didLoad:(id)result;

/**
 * Called when a request returns a response.
 *
 * The result object is the raw response from the server of type NSData
 */
- (void)request:(VKRequest *)request didLoadRawResponse:(NSData *)data;

@end
