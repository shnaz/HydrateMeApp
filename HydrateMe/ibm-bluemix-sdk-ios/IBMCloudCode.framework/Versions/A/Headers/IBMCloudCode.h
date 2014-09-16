//-------------------------------------------------------------------------------
// Licensed Materials - Property of IBM
// (C) Copyright IBM Corp. 2013,2014. All Rights Reserved.
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//-------------------------------------------------------------------------------

#import <IBMBluemix/IBMBluemixService.h>
#import <IBMBluemix/BFTask.h>

/** 
 The IBMCloudCode class is a provisional API.  APIs that are marked provisional are evolving and might change or be removed in future releases. 
 
 IBMCloudCode provides the ability to call cloud code functions defined in the mobile backend
 */
@interface IBMCloudCode : IBMBluemixService

/**
 A property that allows targeting a local Node installation while still leveraging other Mobile Cloud Services (e.g. IBM Data Service or IBM Push).  This makes 
 testing Cloud Code easier as it can be done while targeting a local Node server.
 */
@property (nonatomic, copy) NSString* baseUrl;

/**
 Initializes the IBMCloudCode service.  This method must be called prior to using any IBMCloudCode function.
 
 @return The instance of the initialized Cloud Code Service
 */
+(instancetype) initializeService;

/**
 A convenience method to obtain the IBMCloudCode singleton
 
 @return The instance of the Cloud Code Service; if initialized
 */
+(instancetype) service;

/**
 Used to make an HTTP GET request to IBM Cloud Code
@param uri The URI for the Cloud Code that will be invoked.
@return BFTask containing the IBMHttpResponse as the BFTask result.
 */
-(BFTask*) get: (NSString*) uri;

/**
 Used to make an HTTP GET request to IBM Cloud Code
 @param uri The URI for the Cloud Code that will be invoked.
 @param headers A NSDictionary of headers that need to be set for the IBM Cloud Code Request. Headers are expected to be a NSDictionary with the format 'NSDictionary<NSString, NSString>'. Any other format will be ignored and logged
 @return BFTask containing the IBMHttpResponse as the BFTask result.
 */
-(BFTask*) get: (NSString*) uri withHeaders: (NSDictionary*) headers;

/**
 Used to make an HTTP PUT request to IBM Cloud Code
 @param uri The URI for the Cloud Code that will be invoked.
 @param json The JSON payload to send with the request.
 @return BFTask containing the IBMHttpResponse as the BFTask result.
 */
-(BFTask*) put: (NSString*) uri withJsonPayload: (NSDictionary*) json;

/**
 Used to make an HTTP PUT request to IBM Cloud Code
 @param uri The URI for the Cloud Code that will be invoked.
 @param json The JSON payload to send with the request.
 @param headers A NSDictionary of headers that need to be set for the IBM Cloud Code Request. Headers are expected to be a NSDictionary with the format 'NSDictionary<NSString, NSString>'. Any other format will be ignored and logged
 @return BFTask containing the IBMHttpResponse as the BFTask result.
 */
-(BFTask*) put: (NSString*) uri withJsonPayload: (NSDictionary*) json withHeaders: (NSDictionary*) headers;

/**
 Used to make an HTTP PUT request to IBM Cloud Code
 @param uri The URI for the Cloud Code that will be invoked.
 @param data The data payload to send with the request.
 @param headers A NSDictionary of headers that need to be set for the IBM Cloud Code Request. Headers are expected to be a NSDictionary with the format 'NSDictionary<NSString, NSString>'. Any other format will be ignored and logged
 @return BFTask containing the IBMHttpResponse as the BFTask result.
 */
-(BFTask*) put: (NSString*) uri withDataPayload: (NSData*) data withHeaders: (NSDictionary*) headers;

/**
 Used to make an HTTP POST request to IBM Cloud Code
 @param uri The URI for the Cloud Code that will be invoked.
 @param json The JSON payload to send with the request.
 @return BFTask containing the IBMHttpResponse as the BFTask result.
 */
-(BFTask*) post: (NSString*) uri withJsonPayload: (NSDictionary*) json;

/**
 Used to make an HTTP POST request to IBM Cloud Code
 @param uri The URI for the Cloud Code that will be invoked.
 @param json The JSON payload to send with the request.
 @param headers A NSDictionary of headers that need to be set for the IBM Cloud Code Request. Headers are expected to be a NSDictionary with the format 'NSDictionary<NSString, NSString>'. Any other format will be ignored and logged
 @return BFTask containing the IBMHttpResponse as the BFTask result.
 */
-(BFTask*) post: (NSString*) uri withJsonPayload: (NSDictionary*) json withHeaders: (NSDictionary*) headers;

/**
 Used to make an HTTP POST request to IBM Cloud Code
 @param uri The URI for the Cloud Code that will be invoked.
 @param data The data payload to send with the request.
 @param headers A NSDictionary of headers that need to be set for the IBM Cloud Code Request. Headers are expected to be a NSDictionary with the format 'NSDictionary<NSString, NSString>'. Any other format will be ignored and logged
 @return BFTask containing the IBMHttpResponse as the BFTask result.
 */
-(BFTask*) post: (NSString*) uri withDataPayload: (NSData*) data withHeaders: (NSDictionary*) headers;

/**
 Used to make an HTTP DELETE request to IBM Cloud Code
 @param uri The URI for the Cloud Code that will be invoked.
 @return BFTask containing the IBMHttpResponse as the BFTask result.
 */
-(BFTask*) delete: (NSString*) uri;

/**
 Used to make an HTTP DELETE request to IBM Cloud Code
 @param uri The URI for the Cloud Code that will be invoked.
 @param headers A NSDictionary of headers that need to be set for the IBM Cloud Code Request. Headers are expected to be a NSDictionary with the format 'NSDictionary<NSString, NSString>'. Any other format will be ignored and logged
 @return BFTask containing the IBMHttpResponse as the BFTask result.
 */
-(BFTask*) delete: (NSString*) uri withHeaders: (NSDictionary*) headers;

@end
