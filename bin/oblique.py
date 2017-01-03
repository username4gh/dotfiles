#! /usr/bin/env python
# coding=UTF-8

# https://en.wikipedia.org/wiki/Oblique_Strategies
# https://traviscj.com/blog/oblique_programming_strategies.html

import random
import sys

strategies = [
        'Solve the easiest possible problem in the dumbest possible way.',
        'Write a test for it.',
        'Is there a better name for this thing?',
        'Can we move work between query time (when we need the answer) and ingest time (when we see the data that eventually informs the answer)?',
        'Is it easier in a relational data store? A KV Store? A column store? A document store? A graph store?',
        'Can performance be improved by batching many small updates?',
        'Can clarity be improved by transforming a single update to more smaller updates?',
        'Can we more profitably apply a functional or declarative or imperative paradigm to the existing design?',
        'Can we profitably apply a change from synchronous to asynchronous, or vice versa?',
        'Can we profitably apply an inversion of control, moving logic between many individual call sites, a static central definition, and a reflectively defined description of the work to be done?',
        'Is it faster with highly mutable or easier with completely immutable data structures?',
        'Is it easier on the client side or the server side?',
        'List the transitive closure of fields in a data model. Regroup them to make the most sense for your application. Do you have the same data model?',
        'Is it better to estimate it quickly or compute it slowly?',
        'What semantics do you need? Should it be ordered? Transactional? Blocking?',
        'Can you do it with a regex? Do you need to bite the bullet and make a real parser? Can you avoid parsing by using a standardized format? (A few to get you started: s-expressions/XML/protobuf/JSON/yaml/msgpack/capn/avro/edn.)',
        'What is the schema for this data? Is the schema holding you back?',
        'Draw a state diagram according to the spec.',
        'Draw a state diagram according to the data.',
        'Draw a data flow (dX/dydX/dy)',
        'Draw a timeline (dX/dtdX/dt)',
        'How would you do it in Haskell? C? Javascript?',
        'Instead of doing something, emit an object.',
        'Instead of emitting an object, do something.',
        'Store all of it.',
        'Truncate the old stuff.',
        'Write the API you wish existed.',
        'Make an ugly version where all the things work.',
        'Make a gorgeous version that doesn\'t do anything.',
        'Can you codegen the boilerplate?',
        'Enumerate all the cases.',
        'What happens if you do it all offline / precompute everything? What happens if you recompute every time? Can you cache it?',
        'Can you build an audit log?',
        'Think like a tree: ignore the book-keeping details and find the cleanest representation.',
        'Think like a stack: zoom in to the book-keeping details and ignore the structure.',
        'Replace your implementation with an implementation that computes how much work the real implementation does for that problem.',
        'What is the steady state?'
        ]

def main(argv=sys.argv):
    print(strategies[int(round(random.random() * len(strategies)))])


sys.exit(main())
