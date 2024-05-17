//
//  RecommendedCoursesViewModel.swift
//  IntelectualPath
//
//  Created by Альпеша on 05.02.2024.
//

import Combine

class RecommendedCoursesViewModel: ObservableObject {
    @Published var courses: [Course] = []
    
    init() {
            loadCourses(for: "Programming") // Load Programming courses by default
        }
    
    func loadCourses(for category: String) {
        switch category {
        case "Programming":
            courses = [
                Course(title: "Introduction to Python", category: "Programming", lessonCount: 10, duration: "30 min", instructor: "Alice Johnson", filesCount: 5, description: """
    Welcome to the "Introduction to Python" course! This beginner-friendly course will guide you through the fundamental concepts of Python programming. Whether you're new to programming or looking to enhance your skills, this course is designed to give you a solid foundation in Python. Let's dive into some key topics that will help you answer common Python-related questions.

    Understanding Variable Types in Python

    In Python, it's important to understand the types of variables and objects you are working with. To find out the type of a variable or object, you can use the `type()` function. The correct syntax to output the type of a variable named `var` is:
    
    print(type(var))
    

    Generating Random Numbers

    Python provides a built-in module called `random` to generate random numbers. To use this module, you need to import it at the beginning of your script:
    
    import random
    
    This module includes various functions to generate random numbers, choose random elements, and perform random sampling.

    Data Types for Numeric Values

    When working with numeric values that do not change, you typically use the `int` (integer) data type. Integers are whole numbers without a decimal point. Here's an example of declaring an integer variable:
    
    my_number = 42
    

    Using the `len()` Function

    The `len()` function in Python is used to return the length of an object. This function can be applied to various data types, such as strings, lists, and tuples. For instance, if you have a list called `my_list`, you can get its length by using:
    
    length = len(my_list)
    
    This will return the number of items in the list.

    Handling Exceptions

    In Python, exceptions are handled using the `try-except` block. This allows you to catch and manage errors gracefully without crashing your program. Here's a basic example of how to handle exceptions:
    
    try:
        # Code that might raise an exception
        result = 10 / 0
    except ZeroDivisionError:
        # Code to handle the exception
        print("You can't divide by zero!")

    In this example, if the code inside the `try` block raises a `ZeroDivisionError`, the `except` block will execute, allowing you to handle the error.

    By understanding these fundamental concepts, you'll be well-equipped to write and debug Python programs effectively. Let's now look at some questions based on these topics.

    With this knowledge, you're on your way to becoming proficient in Python programming. Keep practicing, and don't hesitate to explore more advanced topics as you progress!
    """),
                Course(title: "C++ Fundamentals", category: "Programming", lessonCount: 12, duration: "45 min", instructor: "Bob Smith", filesCount: 7, description: """
Learn the basics of C++ programming.
Welcome to your course on the fundamentals of C++. In this course, we will explore the basic concepts and features of C++ programming that are essential for every beginner to understand. Let's dive into some of the core elements that you'll be tested on in your upcoming quiz.

The std Namespace
In C++, the std namespace is short for the Standard namespace. It is used to encapsulate the standard library's functions and classes, preventing name conflicts. For example, when you use std::cout to output data to the screen, std ensures that cout is recognized as the standard output stream in the standard library, avoiding conflicts with other functions or classes named cout that might be defined in other libraries.

Pointers in C++
Pointers are a fundamental concept in C++. A pointer is a variable that stores the memory address of another variable. To declare a pointer, you use the asterisk (*) symbol before the pointer's name during its declaration. For example, int *ptr; declares a pointer named ptr that will point to an integer value.

Run-time Polymorphism and Virtual Functions
Run-time polymorphism in C++ is achieved using virtual functions and inheritance. A virtual function in a base class is overridden in a derived class to ensure that the correct function is called for an object, regardless of the type of reference or pointer used for the function call. This feature is what allows us to use dynamic dispatch and support late binding in C++.

The delete Keyword
The delete keyword in C++ is used to free dynamically allocated memory, preventing memory leaks. When you allocate memory using the new keyword, such as int* ptr = new int;, you must free it using delete when it's no longer needed: delete ptr;.

Loop Structures in C++
C++ supports several types of loops that are used to execute code repeatedly as long as some condition remains true. The most common loop structures include the for loop, the while loop, and the do-while loop. The for loop is particularly useful for iterating over a range or collection, making it essential for many programming tasks.

Conclusion
Understanding these fundamental aspects of C++ will help you build a solid foundation in programming. Good luck with your quiz and your journey in mastering C++. Remember, practice is key in programming!
"""),
                Course(title: "Swift from Scratch", category: "Programming", lessonCount: 15, duration: "25 min", instructor: "Carol Taylor", filesCount: 9, description: "Develop iOS apps using Swift."),
                Course(title: "Java Essentials", category: "Programming", lessonCount: 8, duration: "35 min", instructor: "Dave Wilson", filesCount: 6, description: "Core concepts of Java programming."),
                Course(title: "JavaScript for Web Development", category: "Programming", lessonCount: 20, duration: "40 min", instructor: "Eve Martinez", filesCount: 12, description: "Interactive web pages with JavaScript.")
            ]
        case "General math":
            courses = [
                Course(title: "Algebra Basics", category: "General math", lessonCount: 10, duration: "40 min", instructor: "Fiona Chen", filesCount: 8, description: "Fundamentals of algebra."),
                Course(title: "Calculus I", category: "General math", lessonCount: 15, duration: "50 min", instructor: "George Davies", filesCount: 10, description: "Introduction to calculus."),
                Course(title: "Statistics 101", category: "General math", lessonCount: 12, duration: "45 min", instructor: "Hannah East", filesCount: 7, description: "Basics of statistical analysis."),
                Course(title: "Geometry Concepts", category: "General math", lessonCount: 8, duration: "30 min", instructor: "Ian Foster", filesCount: 5, description: "Understanding shapes and forms."),
                Course(title: "Trigonometry Introduction", category: "General math", lessonCount: 14, duration: "55 min", instructor: "Julia Grant", filesCount: 9, description: "Study of triangles.")
            ]
        case "Language":
            courses = [
                Course(title: "English for Beginners", category: "Language", lessonCount: 20, duration: "30 min", instructor: "Kevin Hart", filesCount: 10, description: "Start learning English."),
                Course(title: "Spanish Intermediate", category: "Language", lessonCount: 15, duration: "40 min", instructor: "Laura Young", filesCount: 12, description: "Improve your Spanish skills."),
                Course(title: "French Vocabulary", category: "Language", lessonCount: 10, duration: "35 min", instructor: "Mike Brown", filesCount: 6, description: "Expand your French vocabulary."),
                Course(title: "German Grammar", category: "Language", lessonCount: 12, duration: "45 min", instructor: "Nancy White", filesCount: 7, description: "Understand the basics of German grammar."),
                Course(title: "Italian Conversation", category: "Language", lessonCount: 18, duration: "50 min", instructor: "Olivia Lee", filesCount: 11, description: "Practice everyday Italian.")
            ]
        case "Biology":
            courses = [
                Course(title: "Cell Biology", category: "Biology", lessonCount: 12, duration: "35 min", instructor: "Patricia Scott", filesCount: 7, description: "Explore the microscopic world."),
                Course(title: "Genetics for Beginners", category: "Biology", lessonCount: 10, duration: "40 min", instructor: "Quinn Johnson", filesCount: 6, description: "Introduction to genetics."),
                Course(title: "Human Anatomy", category: "Biology", lessonCount: 15, duration: "45 min", instructor: "Rachel Kim", filesCount: 9, description: "Learn about human body structure."),
                Course(title: "Marine Biology", category: "Biology", lessonCount: 8, duration: "30 min", instructor: "Steve Lee", filesCount: 5, description: "Study life in the oceans."),
                Course(title: "Ecology Fundamentals", category: "Biology", lessonCount: 14, duration: "55 min", instructor: "Tina Brown", filesCount: 11, description: "Basics of ecological science.")
            ]
        default:
            courses = []
        }
    }
}
