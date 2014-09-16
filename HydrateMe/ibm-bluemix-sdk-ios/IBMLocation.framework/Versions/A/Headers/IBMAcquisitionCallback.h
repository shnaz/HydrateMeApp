//-------------------------------------------------------------------------------
// Licensed Materials - Property of IBM
// XXXX-XXX (C) Copyright IBM Corp. 2013. All Rights Reserved.
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//-------------------------------------------------------------------------------
//
//  IBMAcquisitionCallback.h
//  IBMLocation iOS SDK

/**
 The IBMAcquisitionCallback interface defines the methods that acquisition callback classes must implement.

 The IBMAcquisitionCallback class is a provisional API.  APIs that are marked provisional are evolving and might change or be removed in future releases.
 */
@protocol IBMAcquisitionCallback <NSObject>

/**
 The method will be executed when acquisition has completed.
 @param pos the position that was acquired.
 */
- (void) execute : (id) pos ;

@end
