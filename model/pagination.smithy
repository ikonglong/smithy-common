$version: "2.0"

namespace common

enum SortOrder {
    /// Ascending
    ASC = "asc"
    /// Descending
    DESC = "desc"
}

/// Common pagination parameters for list operations
@mixin
structure PagingParams {
    /// This specifies a limit on the number of objects to return, ranging
    /// between 1 and 100.
    @httpQuery("limit")
    @range(min: 1, max: 100)
    limit: Integer

    /// A cursor to use in pagination. starting_after is an object ID that
    /// defines your place in the list. For example, if you make a list
    /// request and receive 100 objects, ending with obj_foo, your subsequent
    /// call can include starting_after=obj_foo to fetch the next page of
    /// the list.
    @httpQuery("starting_after")
    starting_after: String

    /// A cursor to use in pagination. ending_before is an object ID that
    /// defines your place in the list. For example, if you make a list
    /// request and receive 100 objects, starting with obj_bar, your
    /// subsequent call can include ending_before=obj_bar to fetch the
    /// previous page of the list.
    @httpQuery("ending_before")
    ending_before: String

    /// Default sort order.
    /// Note: Regardless of this parameter, **the returned list is always
    /// sorted in ascending order by time/ID (oldest to newest)** for a
    /// natural reading experience.
    /// This parameter only determines **the entry point of the initial
    /// request** (when neither starting_after nor ending_before is
    /// provided):
    /// - asc: Start from the beginning of the timeline (oldest). The first
    ///   request returns the oldest N items (e.g. [1, 2, 3]).
    /// - desc: Start from the end of the timeline (newest). The first
    ///   request returns the newest N items (e.g. [4, 5, 6]).
    /// Different endpoints may have different default strategies.
    @httpQuery("order")
    order: SortOrder
}

/// Common pagination response fields
@mixin
structure PageMetadata {
    /// Whether or not there are more elements available after this set. If
    /// false, this set comprises the end of the list.
    @required
    has_more: Boolean

    /// Cursor for the next page: the object ID of the last item in this page.
    /// Pass it as the `starting_after` query parameter on a subsequent request
    /// to fetch the following page. Present when `has_more` is true; omitted
    /// when this page is the end of the list.
    next_page_cursor: String
}
