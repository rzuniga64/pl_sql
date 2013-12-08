REM if you modify code in the package body, the status of
REM dependent objects isn't changed to INVALID, as with 
REM stand-alone program units.  Only modifications to the
REM package specification (program unit header) result in 
REM chaning dependent objects' status to INVALID. 

REM a stand-alone package, PKG_DEPTEST_SP, calls the 
REM procedure in the ORDER_INFO_PKG package, so it's 
REM dependent on the package.

SELECT status
FROM user_objects
WHERE object_name = 'PKG_DEPTEST_SP';