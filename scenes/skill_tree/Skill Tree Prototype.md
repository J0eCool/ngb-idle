# Design

- Purpose: implement a system for rendering a Skill Tree
- Specific gameplay mechanics are unimportant in this prototype
- Focus: visual polish, interactive juice

# Implementation

- use Paths to lay out Skill Nodes
- [ ] Data layout? Decide between
	- A) root node + recursive child nodes
		- prefer this because it's easier to model visually - optimized data design is for non-prototypes
	- B) flat array of nodes
		- prefer this (LONG TERM) because we can save/load by index# rather than needing bespoke ids per node
