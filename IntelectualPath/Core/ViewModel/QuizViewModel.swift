//
//  QuizViewModel.swift
//  IntelectualPath
//
//  Created by Альпеша on 30.12.2023.
//

import Foundation
import SwiftUI
import Firebase

class QuizViewModel: ObservableObject {
    @Published var questions: [Question] = []
        @Published var currentQuestionIndex = 0
        @Published var selectedOptionIndex: Int? = nil
        @Published var score = 0
        @Published var isCorrect: Bool? = nil
        @Published var optionColor: Color = .primary
    

    func loadQuestions(for topic: String) {
        switch topic {
        case "Introduction to Python":
                questions = [
                    Question(text: "What is the correct syntax to output the type of a variable or object in Python?", options: ["print(type(var))", "print(typeof var)", "typeOf(var)", "type(var)"], correctAnswer: 0),
                    Question(text: "How can you generate random numbers in Python?", options: ["import random", "import rand", "library(random)", "module(random)"], correctAnswer: 0),
                    Question(text: "Which data type would you use to store a numeric value that does not change?", options: ["float", "variable", "constant", "int"], correctAnswer: 3),
                    Question(text: "What does the len() function in Python return?", options: ["The length of an object", "The size of a file", "The type of a variable", "The first element of a list"], correctAnswer: 0),
                    Question(text: "In Python, how do you handle exceptions?", options: ["try-catch", "if-else", "try-except", "check-exception"], correctAnswer: 2)
                ]
            case "C++ Fundamentals":
                questions = [
                    Question(text: "What does the 'std' namespace refer to in C++?", options: ["Standard library", "Static library", "Standard loop", "String data"], correctAnswer: 0),
                    Question(text: "What is a correct way to declare a pointer in C++?", options: ["int ptr;", "int *ptr;", "ptr int;", "*ptr int;"], correctAnswer: 1),
                    Question(text: "Which feature in C++ is used for run-time polymorphism?", options: ["Encapsulation", "Abstraction", "Inheritance", "Virtual functions"], correctAnswer: 3),
                    Question(text: "What does the 'delete' keyword do in C++?", options: ["Deletes variables from memory", "Frees dynamically allocated memory", "Removes file data", "Exits the program"], correctAnswer: 1),
                    Question(text: "Which of the following is a loop structure in C++?", options: ["For", "Case", "Select", "Check"], correctAnswer: 0)
                ]
            case "Swift from Scratch":
                questions = [
                    Question(text: "What keyword is used to declare a constant in Swift?", options: ["var", "let", "const", "fix"], correctAnswer: 1),
                    Question(text: "Which of the following data types does not exist in Swift?", options: ["Int", "Float", "String", "Pointer"], correctAnswer: 3),
                    Question(text: "How do you handle errors in Swift?", options: ["try-catch", "do-try-catch", "error-catch", "try-error"], correctAnswer: 1),
                    Question(text: "What is the correct way to declare a dictionary in Swift?", options: ["[Key: Value]", "{Key: Value}", "(Key, Value)", "<Key, Value>"], correctAnswer: 0),
                    Question(text: "Which of the following is a control flow structure in Swift?", options: ["Switch", "Select", "Do", "Repeat"], correctAnswer: 0)
                ]
            case "Java Essentials":
                questions = [
                    Question(text: "In Java, which keyword is used to inherit a class?", options: ["extends", "inherits", "implements", "derives"], correctAnswer: 0),
                    Question(text: "Which of the following is an interface and not a class in Java?", options: ["ArrayList", "Map", "LinkedList", "Math"], correctAnswer: 1),
                    Question(text: "What does the 'final' keyword signify in Java?", options: ["The value can be changed", "The value cannot be changed after initialization", "It is used to finalize objects", "It is used for final classes only"], correctAnswer: 1),
                    Question(text: "How are Java objects typically created?", options: ["Using the 'new' keyword", "Using the 'create' keyword", "Using the 'init' keyword", "Using the 'build' keyword"], correctAnswer: 0),
                    Question(text: "What is encapsulation in Java?", options: ["Hiding the internal state and requiring all interactions to be done through methods", "A type of inheritance", "A type of polymorphism", "A method for data transport"], correctAnswer: 0)
                ]
            case "JavaScript for Web Development":
                questions = [
                    Question(text: "What is the purpose of the `addEventListener` method in JavaScript?", options: ["To convert JSON to a JavaScript object", "To attach an event handler to an element", "To find HTML elements", "To perform an action at specified times"], correctAnswer: 1),
                    Question(text: "What is 'this' keyword in JavaScript?", options: ["Refers to the current object", "Refers to the previous object", "Is a variable name", "Is a function declaration"], correctAnswer: 0),
                    Question(text: "What method is used to create new HTML elements in JavaScript?", options: ["createElement()", "createNode()", "newElement()", "newNode()"], correctAnswer: 0),
                    Question(text: "Which of the following is not a valid JavaScript data type?", options: ["Undefined", "Number", "Boolean", "Integer"], correctAnswer: 3),
                    Question(text: "What is JSON in JavaScript?", options: ["A programming language", "A data interchange format", "A function", "A method"], correctAnswer: 1)
                ]
        case "Algebra Basics":
            questions = [
                Question(text: "What is the result of the expression x^2 - 2x + 1 when x = 0?", options: ["0", "1", "-1", "2"], correctAnswer: 1),
                Question(text: "Which property describes a + b = b + a?", options: ["Associative", "Commutative", "Distributive", "Identity"], correctAnswer: 1),
                Question(text: "What is the factorization of x^2 - 9?", options: ["(x - 3)(x + 3)", "(x - 9)(x + 1)", "(x - 3)^2", "None of the above"], correctAnswer: 0),
                Question(text: "What is the solution to the equation 3x - 7 = 5?", options: ["x = 4", "x = 2", "x = -2", "x = 12"], correctAnswer: 1),
                Question(text: "Which graph represents a linear equation?", options: ["Straight line", "Parabola", "Hyperbola", "Circle"], correctAnswer: 0)
            ]
        case "Calculus I":
            questions = [
                Question(text: "What is the derivative of x^2?", options: ["2x", "x^3", "2", "x/2"], correctAnswer: 0),
                Question(text: "What is the integral of dx?", options: ["x", "x^2 + C", "1/x", "C"], correctAnswer: 0),
                Question(text: "What is the derivative of cos(x)?", options: ["-sin(x)", "sin(x)", "tan(x)", "-cos(x)"], correctAnswer: 0),
                Question(text: "What rule is used to differentiate (uv)?", options: ["Chain rule", "Product rule", "Quotient rule", "Power rule"], correctAnswer: 1),
                Question(text: "What is the limit of (1/x) as x approaches infinity?", options: ["0", "1", "Infinity", "-1"], correctAnswer: 0)
            ]
        case "Statistics 101":
            questions = [
                Question(text: "What does a p-value indicate in statistical tests?", options: ["The probability of the null hypothesis being false", "The likelihood of observing the test result if the null hypothesis is true", "The correlation between variables", "The regression line slope"], correctAnswer: 1),
                Question(text: "Which measure describes the spread of data in a dataset?", options: ["Mean", "Median", "Standard deviation", "Mode"], correctAnswer: 2),
                Question(text: "What is a type I error in hypothesis testing?", options: ["Rejecting a true null hypothesis", "Failing to reject a false null hypothesis", "Accepting a true alternative hypothesis", "None of the above"], correctAnswer: 0),
                Question(text: "What is correlation?", options: ["A measure of the central tendency of data", "A measure of how two variables move in relation to each other", "A statistical test", "A type of regression analysis"], correctAnswer: 1),
                Question(text: "Which graph is used to represent categorical data?", options: ["Histogram", "Pie chart", "Scatter plot", "Box plot"], correctAnswer: 1)
            ]
        case "Geometry Concepts":
            questions = [
                Question(text: "What is the sum of the angles in a triangle?", options: ["180 degrees", "360 degrees", "90 degrees", "270 degrees"], correctAnswer: 0),
                Question(text: "What is the Pythagorean Theorem?", options: ["a^2 + b^2 = c^2", "a^2 - b^2 = c^2", "a^2 * b^2 = c^2", "a/b + b/a = c"], correctAnswer: 0),
                Question(text: "What geometric shape has exactly three sides?", options: ["Triangle", "Rectangle", "Square", "Circle"], correctAnswer: 0),
                Question(text: "Which formula represents the area of a circle?", options: ["pi*r^2", "2*pi*r", "pi*r", "2*r^2"], correctAnswer: 0),
                Question(text: "What is a tangent to a circle?", options: ["A line perpendicular to the radius at the point of contact", "A line parallel to the radius", "A line that intersects the circle at one point", "A line that intersects the circle at two points"], correctAnswer: 2)
            ]
        case "Trigonometry Introduction":
            questions = [
                Question(text: "What is the sine of 90 degrees?", options: ["0", "1", "0.5", "sqrt(2)/2"], correctAnswer: 1),
                Question(text: "Which trigonometric ratio represents the opposite side over the hypotenuse?", options: ["Sine", "Cosine", "Tangent", "Cotangent"], correctAnswer: 0),
                Question(text: "What is the tangent of 45 degrees?", options: ["1", "0", "sqrt(2)", "2"], correctAnswer: 0),
                Question(text: "Which function is used to find the angle given a sine value?", options: ["sin", "cos", "tan", "asin"], correctAnswer: 3),
                Question(text: "What is the cosine of 0 degrees?", options: ["1", "0", "0.5", "-1"], correctAnswer: 0)
            ]
        case "English for Beginners":
            questions = [
                Question(text: "Which is a past tense form of the verb 'go'?", options: ["Went", "Goes", "Gone", "Goed"], correctAnswer: 0),
                Question(text: "Which word is an adjective?", options: ["Quickly", "Run", "Fast", "Runner"], correctAnswer: 2),
                Question(text: "What is the plural form of 'child'?", options: ["Childs", "Children", "Childes", "Child"], correctAnswer: 1),
                Question(text: "Which word is a conjunction?", options: ["And", "Walk", "Can", "He"], correctAnswer: 0),
                Question(text: "What does 'synonym' mean?", options: ["A word that sounds like another", "A word that means the opposite of another", "A word that means the same as another", "A word used in the past"], correctAnswer: 2)
            ]
        case "Spanish Intermediate":
            questions = [
                Question(text: "How do you say 'Good morning' in Spanish?", options: ["Buenas noches", "Buenas tardes", "Buenos días", "Buen día"], correctAnswer: 2),
                Question(text: "What is the Spanish word for 'table'?", options: ["Mesa", "Cama", "Silla", "Puerta"], correctAnswer: 0),
                Question(text: "What is the past tense of 'eat' in Spanish?", options: ["Come", "Comió", "Comerá", "Comiendo"], correctAnswer: 1),
                Question(text: "Which verb form is used to express actions in the future in Spanish?", options: ["Infinitivo", "Participio", "Gerundio", "Futuro"], correctAnswer: 3),
                Question(text: "How do you form the plural of 'luz' in Spanish?", options: ["Luces", "Luzes", "Luzs", "Luz"], correctAnswer: 0)
            ]
        case "French Vocabulary":
            questions = [
                Question(text: "What is the French word for 'apple'?", options: ["Pomme", "Poire", "Peche", "Prune"], correctAnswer: 0),
                Question(text: "What is 'thank you' in French?", options: ["Merci", "Bonjour", "Au revoir", "S'il vous plaît"], correctAnswer: 0),
                Question(text: "What is the French word for 'book'?", options: ["Livre", "Libro", "Buch", "Kniga"], correctAnswer: 0),
                Question(text: "How do you say 'Where is the bathroom?' in French?", options: ["Où est la salle de bain?", "Où est la cuisine?", "Où est le salon?", "Où est la chambre?"], correctAnswer: 0),
                Question(text: "What does 'bleu' mean in French?", options: ["Blue", "Red", "Green", "Yellow"], correctAnswer: 0)
            ]
        case "German Grammar":
            questions = [
                Question(text: "What is the plural form of 'das Buch' in German?", options: ["Die Bücher", "Der Bücher", "Das Buchs", "Die Buchen"], correctAnswer: 0),
                Question(text: "What is 'thank you' in German?", options: ["Danke", "Bitte", "Hallo", "Tschüss"], correctAnswer: 0),
                Question(text: "Which case is used for the direct object in German?", options: ["Nominativ", "Genitiv", "Dativ", "Akkusativ"], correctAnswer: 3),
                Question(text: "What is the German word for 'apple'?", options: ["Apfel", "Banane", "Pfirsich", "Birne"], correctAnswer: 0),
                Question(text: "What does 'Guten Tag' mean?", options: ["Good morning", "Good evening", "Good day", "Good night"], correctAnswer: 2)
            ]
        case "Italian Conversation":
            questions = [
                Question(text: "How do you ask 'What is your name?' in Italian?", options: ["Come ti chiami?", "Quanti anni hai?", "Dove vivi?", "Che cosa fai?"], correctAnswer: 0),
                Question(text: "How do you say 'Goodbye' in Italian?", options: ["Ciao", "Arrivederci", "Buongiorno", "Buonasera"], correctAnswer: 1),
                Question(text: "What is 'please' in Italian?", options: ["Per favore", "Grazie", "Scusi", "Prego"], correctAnswer: 0),
                Question(text: "What is the Italian word for 'city'?", options: ["Città", "Paese", "Nazione", "Villaggio"], correctAnswer: 0),
                Question(text: "How do you say 'I love you' in Italian?", options: ["Ti amo", "Ti voglio bene", "Mi piaci", "Ti adoro"], correctAnswer: 0)
            ]
        case "Cell Biology":
            questions = [
                Question(text: "What organelle is known as the powerhouse of the cell?", options: ["Mitochondria", "Nucleus", "Ribosome", "Endoplasmic Reticulum"], correctAnswer: 0),
                Question(text: "What structure in the cell is responsible for protein synthesis?", options: ["Golgi apparatus", "Lysosome", "Ribosome", "Nucleolus"], correctAnswer: 2),
                Question(text: "What is the primary function of the cell membrane?", options: ["Energy production", "Protein storage", "Selective permeability", "DNA replication"], correctAnswer: 2),
                Question(text: "What are chromosomes made of?", options: ["Proteins and lipids", "DNA and proteins", "Carbohydrates and lipids", "RNA and proteins"], correctAnswer: 1),
                Question(text: "What process involves the division of a cell into two daughter cells?", options: ["Mitosis", "Meiosis", "Fermentation", "Photosynthesis"], correctAnswer: 0)
            ]
        case "Genetics for Beginners":
            questions = [
                Question(text: "What is the term for a segment of DNA that codes for a protein?", options: ["Gene", "Chromosome", "Nucleotide", "Allele"], correctAnswer: 0),
                Question(text: "What is the basic unit of heredity?", options: ["Gene", "Protein", "Cell", "Nucleus"], correctAnswer: 0),
                Question(text: "What process describes the creation of mRNA from DNA?", options: ["Translation", "Transcription", "Replication", "Mitosis"], correctAnswer: 1),
                Question(text: "What are the building blocks of DNA?", options: ["Amino acids", "Nucleotides", "Fatty acids", "Proteins"], correctAnswer: 1),
                Question(text: "What pattern of inheritance did Gregor Mendel discover?", options: ["Codominance", "Incomplete dominance", "Mendelian inheritance", "Polygenic inheritance"], correctAnswer: 2)
            ]
        case "Human Anatomy":
            questions = [
                Question(text: "What bone is commonly known as the collarbone?", options: ["Clavicle", "Scapula", "Sternum", "Coccyx"], correctAnswer: 0),
                Question(text: "Which organ is responsible for pumping blood throughout the body?", options: ["Liver", "Heart", "Kidney", "Lung"], correctAnswer: 1),
                Question(text: "What is the primary function of the respiratory system?", options: ["Digest food", "Circulate blood", "Breathe", "Filter waste"], correctAnswer: 2),
                Question(text: "What part of the brain regulates balance and coordination?", options: ["Cerebrum", "Cerebellum", "Brainstem", "Hypothalamus"], correctAnswer: 1),
                Question(text: "What type of joint is found in the elbow?", options: ["Ball and socket", "Hinge", "Pivot", "Saddle"], correctAnswer: 1)
            ]
        case "Marine Biology":
            questions = [
                Question(text: "What is the largest mammal in the ocean?", options: ["Blue Whale", "Great White Shark", "Dolphin", "Orca"], correctAnswer: 0),
                Question(text: "What process do marine plants use to convert sunlight into energy?", options: ["Photosynthesis", "Chemosynthesis", "Respiration", "Osmosis"], correctAnswer: 0),
                Question(text: "What is coral primarily composed of?", options: ["Fish", "Plankton", "Calcium carbonate", "Salt"], correctAnswer: 2),
                Question(text: "Which ocean layer is known for its abundant marine life near the surface?", options: ["Abyssal zone", "Bathyal zone", "Epipelagic zone", "Mesopelagic zone"], correctAnswer: 2),
                Question(text: "What characteristic feature do all fish have?", options: ["Scales", "Gills", "Fins", "All of the above"], correctAnswer: 3)
            ]
        case "Ecology Fundamentals":
            questions = [
                Question(text: "What is the process by which plants make their food?", options: ["Photosynthesis", "Respiration", "Digestion", "Transpiration"], correctAnswer: 0),
                Question(text: "What is a food chain?", options: ["A store where food is sold", "A sequence of events in an ecosystem, where organisms transfer energy by eating and being eaten", "A process of breaking down food into energy", "None of the above"], correctAnswer: 1),
                Question(text: "What is biodiversity?", options: ["The destruction of forests", "The variety of life in the world or in a particular habitat or ecosystem", "The study of living organisms", "A type of biofuel"], correctAnswer: 1),
                Question(text: "What role do decomposers play in an ecosystem?", options: ["They produce oxygen", "They break down dead material and waste into simpler substances", "They capture sunlight", "They pollinate plants"], correctAnswer: 1),
                Question(text: "What is an ecosystem?", options: ["A community of living organisms and their physical environment", "A type of bacteria", "A controlled environment for plant growth", "A large area of water"], correctAnswer: 0)
            ]
        default:
            questions = []
        }
    }

    func selectOption(_ index: Int) {
        selectedOptionIndex = index
        isCorrect = index == questions[currentQuestionIndex].correctAnswer
    }

    func submitAnswer() {
        if let selectedIndex = selectedOptionIndex {
            if questions[currentQuestionIndex].correctAnswer == selectedIndex {
                score += 1
            }
            isCorrect = nil
            selectedOptionIndex = nil
            currentQuestionIndex += 1
        }
    }

    func isLastQuestion() -> Bool {
        return currentQuestionIndex == questions.count - 1
    }
}

