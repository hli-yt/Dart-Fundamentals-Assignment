## Name: Helina Tesfaye
## Submission date: March 15,2026
## Course: Mobile Application Development
## Title: Dart Fundamentals 


## Overall Learning Experience

This assignment provided a comprehensive introduction to Dart programming fundamentals through two distinct
but complementary tasks. Working on both the Number Analysis App and the Async Calculator App helped me 
understand core programming concepts while also exploring more advanced topics like asynchronous programming 
and object-oriented design.

## Task 1: Number Analysis App - Reflections
## What Went Well
•	Successfully implemented all core requirements including sum, average, min, max, and counting functions

•	Created robust edge case handling for empty lists, which taught me the importance of defensive programming

•	The bonus interactive mode was interesting to implement and made the program more user-friendly

•	Tested with various input types (integers, doubles, negative numbers, zeros)

## Challenges Faced
•	Initially struggled with handling both integers and doubles in the even/odd classification. I learned to use the
`is int` type check to ensure I only classify integers as even/odd.

•	Understanding how to properly initialize variables like max and min when the list might be empty required careful thought.

	Key Takeaway
The most important lesson from Task 1 was the importance of considering edge cases before writing code. A program that
works for normal cases but fails on empty lists or single-element lists is not truly complete.



## Task 2: Async Calculator App - Reflections
## What Went Well
•	Clean separation of concerns between synchronous arithmetic methods and asynchronous wrapper methods

•	Effective exception handling that prevents crashes while providing useful error messages

•	The switch statement in computeAsync() made the code readable and maintainable

•	Successfully implemented all bonus extensions, which deepened my understanding

## Challenges Faced
•	Understanding how exceptions travel from divide() through computeAsync() to displayResult() required tracing the call stack mentally.

•	Keeping track of which functions needed the async keyword and which returned Futures took some practice.

## Connecting the Two Tasks
Interestingly, both tasks reinforced similar fundamental concepts despite their different focuses:

| Concept |	Task 1 Application	| Task 2 Application |
| Loops   | 	Iterating through number lists  | Chained operations |
| Conditionals |	Positive/negative classification	| Switch statement for operations |
| Error Handling	| Input validation | 	Division by zero exceptions |
| Data structure	|  Maps for results	| Class properties and lists |
| Functions |	Analysis  functions	 | Arithmetic methods |

 ## Key Takeaways for Future Projects
•	Considering empty lists, invalid inputs, and error conditions at the beginning leads to more robust code.

•	 Keeping arithmetic logic separate from async wrappers (Task 2) made the code more maintainable and testable.

•	 The parallel execution demo showed why async programming is crucial for responsive applications.

•	 Writing explanations for the conceptual questions forced me to articulate my understanding, revealing gaps in my knowledge.

•	Creating multiple test cases in Task 1 helped me catch bugs early and verify my implementation.

 ## Skills Gained
•	Dart syntax and core libraries

•	Object-oriented programming in Dart

•	Asynchronous programming with Futures, async/await

•	Exception handling and custom exceptions

•	List manipulation and analysis

•	Defensive programming and edge case handling

## Final Thoughts

This assignment successfully bridged theory and practice. The progression from basic list manipulation in Task 1 
to more complex async OOP in Task 2 felt natural and built confidence with each step. The conceptual questions were 
particularly valuable because they forced me to articulate not just what the code does, but why it's designed that way.

The bonus extensions were a bit challenging, but they were worth doing it. The parallel futures implementation was especially 
interesting because it showed how real apps improve performance.

I now feel more prepared to tackle Flutter development, understanding both the synchronous and asynchronous patterns that form 
the foundation of mobile app development.

