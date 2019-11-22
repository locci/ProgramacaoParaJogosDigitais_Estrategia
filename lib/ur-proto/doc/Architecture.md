
# The Unlimited Rulebook architecture

<img src="ClassDiagram.png" style="width:100%;">

The central design of the Unlimited Rulebook architecture is to encapsulate
access to the game's economy simulation state behind a rule engine. Code outside
the engine can only access the state through the invocation of **rules**. By
doing so, we guarantee that the dynamic behavior of rules is always executed
correctly, since the engine always adjudicates the invocation.

## The simulation state

The economy simulation state of the game is kept in a @{Record} instance, which
follows a property-centric design for entities in the simulation (or a pure
entity-component pattern, if you prefer). It associates properties to @{Entity}
objects, and the sum of all properties determines the capabilities of a
given entity at runtime. Properties are just plain data tables, where the keys
are **property field names** and the values are any Lua type. An entity can only
have one of each property. See the @{Record} class reference for API details.
Be careful: properties are only shallow-copied.

As explained above, you cannot access the record from outside the engine. Only
rules can. If you want to read or write to the record, you need to use an
existing rule or define a new one.

## Rules

A rule works much like a function: it has a name and a signature. You can invoke
it, pass parameters to it, and collect whatever results it returns. The
difference is how you define its behavior. A rule has one or more **cases**. You
implement each case separately and the @{RuleEngine} assures that the correct
ones will be called when you invoke a rule.

