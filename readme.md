# Supermarket Pricing domain exercise

This programming task involves creating a domain model for Supermarket Pricing.

In this programming task, the concept of a product and an associated price comes into play.  The domain is loosely modeled with a product and a price.  I've made no assumption as to the association type, e.g. containment, associative, single association, multiple association etc..  That is entirely up to you.  

Though the idea of a price associated with a product may seem trivial, there can be many subtle concepts that come into play in this context.  Consider the following features or requirements.  Your solution should be flexible enough to encompass the following pricing concepts:

* Three for a $1.  What happens if I buy 1 or 4?
* Price per pound, e.g. $4.99/pound.  What then would 4oz cost?
* buy 2 get one free.  Does the third item have a price?  What happens when I buy 5?

This domain is made challenging by the fact that 'price' is somewhat contextual and somewhat fluid.  

Some things to consider as you build out your solution:
* Is there a concept of fractional money?
* Does rounding prices occur?  If so, when?
* How do you keep an audit trail of pricing decsions?  
* How is inventory valued from an accounting perspective if for example you have 100 cans of beans that are on a buy 2, get 1 special?

## Directions:
1. Fork this repository
2. Analyze this domain challenge and use TDD (rspec) to document your decisions and drive your solution.
3. Commit changes to your forked repository.
4. Submit a pull request for review.
