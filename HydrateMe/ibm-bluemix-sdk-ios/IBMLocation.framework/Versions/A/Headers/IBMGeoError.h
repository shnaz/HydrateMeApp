//-------------------------------------------------------------------------------
// Licensed Materials - Property of IBM
// XXXX-XXX (C) Copyright IBM Corp. 2013. All Rights Reserved.
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//-------------------------------------------------------------------------------
//
//  IBMGeoError.h
//  IBMLocation iOS SDK

/**
 Predefined error codes used for IBMGeoError objects.
 */
typedef NS_ENUM(NSInteger, IBMGeoErrorCodes) {
    /** Indicates that the application does not have permission to acquire the geo position */
	PERMISSION_DENIED,
    /** Indicates that the geo position was unavailable during acquisition */
	POSITION_UNAVAILABLE,
    /** Indicates that a timeout occured while waiting for the next geo position to be acquired */
	TIMEOUT
};

/**
 An error that occurred during Geo acquisition
 
 The IBMGeoError class is a provisional API.  APIs that are marked provisional are evolving and might change or be removed in future releases.
 */
@interface IBMGeoError : NSObject

/** 
 The geo error code associated with this error. Read only.
 */
@property (nonatomic,readonly) IBMGeoErrorCodes errorCode;
/**
 The message for the geo error. Read only.
 */
@property (nonatomic,readonly) NSString *message;

/**
 Constructor that creates the IBMGeoError object
 
 @param errorCode The error code, defined using IBMGeoErrorCodes
 @param message The geo error's message
 */
- (id)initWithErrorCode:(IBMGeoErrorCodes)errorCode message:(NSString*)message;

@end

