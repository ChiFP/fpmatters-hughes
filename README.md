# Functional Programming Chicago
The first presentation to the Functional Programming Chicago meetup of 2018 can be found here.

The 1990 paper of John Hughes, "Why FP (Functional Programming) Matters", was revisited. Dr. Hughes was one of the original members of the committee that defined Haskell. He is also the creator of the Quickcheck property-based testing system for Haskell that has been ported to many languages since. We figured that his thoughts could be a good starting place for discussion.

# What's Here
The presentation itself is contained in the doc directory. The file "HughesFPChi.pdf" contains the slides for the talk.

There are several Haskell files that contain a translation of the code in the original paper into Haskell, found in the "Haskell" directory. They are divided into "glue*" which have higher-order function concepts, and "progglue*" which have lazy evaluation concepts.

# References

The original paper from 1990:

* https://www.cs.kent.ac.uk/people/staff/dat/miranda/whyfp90.pdf

A keynote presentation at Lambda Days 2017 by Hughes and his wife, Mary Sheeran (other versions can be found at YOW, Erlang Days, etc.)

* https://www.youtube.com/watch?v=1qBHf8DrWR8

An interview on the subject with Hughes by Infoq:

* https://www.infoq.com/interviews/john-hughes-fp