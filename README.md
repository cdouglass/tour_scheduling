# About

An API for a hypothetical river tour company, written as a coding challenge.

## Setup

This is a Rails app with nothing extra. [Railsbridge](http://docs.railsbridge.org/installfest/) should have all the setup information you need.

## Complexity etc.

The spec does not require a booking to be tied to an individual boat, but a booking may not be split between multiple boats. When a new booking is added to a timeslot, reshuffling pre-existing bookings to other boats can allow for a larger maximum availability. Therefore a timeslot's availability must be recalculated from scratch after any event that could change it.

Finding the configuration which permits the largest possible new booking is a combinatorial problem I expect is NP-complete. Therefore it probably cannot be done with complexity better than exponential in the number of bookings in the timeslot. With a large enough operation, this could be a problem and we could do some combination of the following:

* Adding an `availability` column to the `timeslots` table and recalculating availability only when a new booking or boat is assigned to the timeslot. This way, while `create` actions might still be slow, `index` need not be.

* Accepting inexact answers: while it's almost certainly not OK to create bookings that can't be accommodated, occasional false negatives may not be a big problem. There are polynomial-time techniques that will usually give a reasonable lower bound on availability.

Here, I use a branch-and-bound approach: modified depth-first search over booking-to-boat assignments. Within a given branch, bookings are added but not removed, so availability can never increase. This lets many branches be ruled out early, saving substantial time over an exhaustive search.

## Conflicting assignments

While the spec requires conflicting assignments to be allowed, it does not mention the creation of new conflicting assignments when there is already a booking.

Allowing boats to be shuffled between timeslots similarly to how bookings are already shuffled between boats could improve availability a bit further. However this could be confusing and I don't think the benefit is compelling, so I'm not going to implement it.

Before saving an assignment, or using it to determine a timeslot's availability, I validate that its boat is not committed elsewhere, ie that none of its conflicting assignments has any bookings.
