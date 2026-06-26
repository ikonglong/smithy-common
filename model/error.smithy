$version: "2.0"

namespace common

use smithytranslate#contentType

@error("client")
structure HTTP4xxResp {
    @httpPayload
    @required
    @contentType("application/json")
    body: Error
}

@error("server")
structure HTTP5xxResp {
    @httpPayload
    @required
    @contentType("application/json")
    body: Error
}

/// HttpAPIRespErrors, OperationErrors
@mixin
operation OperationErrors  {
    errors: [
        HTTP4xxResp,
        HTTP5xxResp
    ]
}

structure Error {
    code: ErrorStatusCode
    case: String
    /// A developer-facing error message, which should be in English.
    /// It must not be used as a user-facing error message.
    message: String
    details: Document
}

/// Status code for API users.
/// - 0 OK
///
///     HTTP Mapping: 200 OK
/// - 1 OP_CANCELLED means the operation was cancelled, typically by the caller.
///
///     HTTP Mapping: 499 Client Closed Request
/// - 2 Unknown error. For example, this error may be returned when
///     a 'Status' value received from another address space belongs to
///     an error space that is not known in this address space. Also
///     errors raised by APIs that do not return enough error information
///     may be converted to this error.
///
///     HTTP Mapping: 500 Internal Server Error
/// - 3 ILLEGAL_INPUT means that the client specified an illegal input.
///     Note that this differs from `FAILED_PRECONDITION`. `ILLEGAL_INPUT` indicates
///     arguments that are problematic regardless of the state of the system
///     (e.g., a malformed file name).
///
///     HTTP Mapping: 400 Bad Request
/// - 4 TIMEOUT means the deadline expired before the operation could complete.
///     For operations that change the state of the system, this error may be returned
///     even if the operation has completed successfully. For example, a successful
///     response from a server could have been delayed long enough for the deadline
///     to expire.
///
///     HTTP Mapping: 504 Gateway Timeout
/// - 5 NOT_FOUND means that some requested entity (e.g., file or directory was not found).
///
///     Note to server developers: if a request is denied for an entire class
///     of users, such as gradual feature rollout or undocumented allowlist,
///     `NOT_FOUND` may be used. If a request is denied for some users within
///     a class of users, such as user-based access control, `PermissionDenied`
///     must be used.
///
///     HTTP Mapping: 404 Not Found
/// - 6 ALREADY_EXISTS means that the entity that a client attempted to create
///     (e.g., file or directory already exists).
///
///     HTTP Mapping: 409 Conflict
/// - 7 PERMISSION_DENIED means that the caller does not have permission to execute the specified
///     operation. `PERMISSION_DENIED` must not be used for rejections caused by
///     exhausting some resource (use `RESOURCE_EXHAUSTED` instead for those errors).
///     `PERMISSION_DENIED` must not be used if the caller can not be identified
///     (use `UNAUTHENTICATED` instead for those errors. This error code does not
///     imply the request is valid or the requested entity exists or satisfies
///     other pre-conditions.
///
///     HTTP Mapping: 403 Forbidden
/// - 8  RESOURCE_EXHAUSTED means that some resource has been exhausted, perhaps
///      a per-user quota, or perhaps the entire file system is out of space.
///
///      HTTP Mapping: 429 Too Many Requests
/// - 9  FAILED_PRECONDITION means that the operation was rejected because the system
///      is not in a state required for the operation's execution. For example,
///      the directory to be deleted is non-empty, a rmdir operation is applied to
///      a non-directory, etc.
///
///      Service implementors can use the following guidelines to decide
///      between `FAILED_PRECONDITION`, `OP_ABORTED`, and `UNAVAILABLE`:
///      a) Use `UNAVAILABLE` if the client can retry just the failing call.
///      b) Use `OP_ABORTED` if the client should retry at a higher level. For
///         example, when a client-specified test-and-set fails, indicating the
///         client should restart a read-modify-write sequence.
///      c) Use `FAILED_PRECONDITION` if the client should not retry until
///         the system state has been explicitly fixed. For example, if a "rmdir"
///         fails because the directory is non-empty, `FAILED_PRECONDITION`
///         should be returned since the client should not retry unless
///         the files are deleted from the directory.
///
///      HTTP Mapping: 400 Bad Request
/// - 10 OP_ABORTED means that the operation was aborted, typically due to a concurrency
///      issue such as a sequencer check failure or transaction abort.
///
///      See the guidelines above for deciding between `FAILED_PRECONDITION`,
///      `OP_ABORTED`, and `UNAVAILABLE`.
///
///      HTTP Mapping: 409 Conflict
/// - 11 OUT_OF_RANGE means that the operation was attempted past the valid range.
///      E.g., seeking or reading past end-of-file.
///
///      Unlike `ILLEGAL_INPUT`, this error indicates a problem that may
///      be fixed if the system state changes. For example, a 32-bit file
///      system will generate `ILLEGAL_INPUT` if asked to read at an
///      offset that is not in the range [0,2^32-1], but it will generate
///      `OUT_OF_RANGE` if asked to read from an offset past the current
///      file size.
///
///      There is a fair bit of overlap between `FAILED_PRECONDITION` and
///      `OUT_OF_RANGE`. We recommend using `OUT_OF_RANGE` (the more specific
///      error when it applies so that callers who are iterating through
///      a space can easily look for an `OUT_OF_RANGE` error to detect when
///      they are done.
///
///      HTTP Mapping: 400 Bad Request
/// - 12 OP_UNIMPLEMENTED means that the operation is defined, but not implemented
///      or not supported/enabled in this service.
///
///      HTTP Mapping: 501 Not Implemented
/// - 13 Internal error. This means that some invariants expected by the
///      underlying system have been broken. This error code is reserved
///      for serious errors.
///
///      HTTP Mapping: 500 Internal Server Error
/// - 14 UNAVAILABLE means that the service is currently unavailable. This is
///      most likely a transient condition, which can be corrected by retrying
///      with a backoff. Note that it is not always safe to retry
///      non-idemponent operations.
///
///      See the guidelines above for deciding between `FAILED_PRECONDITION`,
///      `OP_ABORTED`, and `UNAVAILABLE`.
///
///      HTTP Mapping: 503 Service Unavailable
/// - 15 ILLEGAL_STATE means that unrecoverable data loss or corruption.
///
///      HTTP Mapping: 500 Internal Server Error
/// - 16 UNAUTHENTICATED means that the request does not have valid authentication
///      credentials for the operation.
///
///     HTTP Mapping: 401 Unauthorized
/// - 29 ILLEGAL_ARG means that the arguments passed to an operation within the program is illegal. 
///
///      HTTP Mapping: 500 Internal Server Error
/// - 30 AUTHORIZATION_EXPIRED means a user's authorization expired, and it is
///      needed to log-in again and reauthorize.
///
///      HTTP Mapping: 401 Unauthorized
///
enum ErrorStatusCode {
    OK = "0"
    OP_CANCELLED = "1"
    UNKNOWN_ERROR = "2"
    ILLEGAL_INPUT = "3"
    TIMEOUT = "4"
    NOT_FOUND = "5"
    ALREADY_EXISTS = "6"
    PERMISSION_DENIED = "7"
    RESOURCE_EXHAUSTED = "8"
    FAILED_PRECONDITION = "9"
    OP_ABORTED = "10"
    OUT_OF_RANGE = "11"
    OP_UNIMPLEMENTED = "12"
    INTERNAL_ERROR = "13"
    UNAVAILABLE = "14"
    ILLEGAL_STATE = "15"
    UNAUTHENTICATED = "16"
    ILLEGAL_ARG = "29"
    AUTHORIZATION_EXPIRED = "30"
}
