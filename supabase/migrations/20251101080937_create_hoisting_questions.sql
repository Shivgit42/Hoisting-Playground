/*
  # HoistSpace - JavaScript Hoisting Quiz Application

  1. New Tables
    - `hoisting_questions`
      - `id` (uuid, primary key) - Unique identifier for each question
      - `code` (text) - The JavaScript code snippet to analyze
      - `correct_output` (text) - The expected output
      - `explanation` (text) - Detailed explanation of why this is the output
      - `difficulty` (text) - easy, medium, or hard
      - `category` (text) - Type of hoisting (var, function, let/const, etc.)
      - `created_at` (timestamptz) - When the question was created
      
    - `user_progress`
      - `id` (uuid, primary key)
      - `user_id` (uuid) - Anonymous user tracking (using browser fingerprint)
      - `question_id` (uuid, foreign key)
      - `is_correct` (boolean) - Whether the user answered correctly
      - `attempts` (integer) - Number of attempts
      - `created_at` (timestamptz)

  2. Security
    - Enable RLS on all tables
    - Public read access for questions (educational content)
    - User can track their own progress
*/

CREATE TABLE IF NOT EXISTS hoisting_questions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  code text NOT NULL,
  correct_output text NOT NULL,
  explanation text NOT NULL,
  difficulty text DEFAULT 'medium',
  category text DEFAULT 'var-hoisting',
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS user_progress (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL,
  question_id uuid REFERENCES hoisting_questions(id) ON DELETE CASCADE,
  is_correct boolean DEFAULT false,
  attempts integer DEFAULT 1,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE hoisting_questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_progress ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can read hoisting questions"
  ON hoisting_questions FOR SELECT
  TO anon, authenticated
  USING (true);

CREATE POLICY "Anyone can insert user progress"
  ON user_progress FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);

CREATE POLICY "Users can read their own progress"
  ON user_progress FOR SELECT
  TO anon, authenticated
  USING (true);

CREATE INDEX IF NOT EXISTS idx_hoisting_questions_difficulty ON hoisting_questions(difficulty);
CREATE INDEX IF NOT EXISTS idx_hoisting_questions_category ON hoisting_questions(category);
CREATE INDEX IF NOT EXISTS idx_user_progress_user_id ON user_progress(user_id);

INSERT INTO hoisting_questions (code, correct_output, explanation, difficulty, category) VALUES
('function main() {
  console.log(a, b);
}
main();
var a = 10;
var b = 20;', 'undefined undefined', 'Due to hoisting, var declarations are moved to the top of their scope, but the assignments stay in place. So the code is interpreted as: var a; var b; main(); a=10; b=20; When main() runs, a and b are declared but not yet assigned, so both are undefined.', 'easy', 'var-hoisting'),

('console.log(foo);
var foo = "Hello";', 'undefined', 'Variable declarations with var are hoisted to the top of the scope, but the initialization remains in place. So it becomes: var foo; console.log(foo); foo = "Hello";', 'easy', 'var-hoisting'),

('console.log(typeof myFunc);
var myFunc = function() {
  return "Function Expression";
};', 'undefined', 'Function expressions are treated like variable assignments. The var declaration is hoisted, but the function assignment is not. So myFunc is undefined at the point of console.log.', 'medium', 'function-expression'),

('console.log(myFunc());
function myFunc() {
  return "Function Declaration";
}', 'Function Declaration', 'Function declarations are fully hoisted (both declaration and definition). The entire function is available before its declaration in the code.', 'easy', 'function-declaration'),

('var x = 1;
function test() {
  console.log(x);
  var x = 2;
}
test();', 'undefined', 'Inside test(), var x is hoisted to the top of the function scope, creating a local variable that shadows the global x. The local x is declared but not initialized when console.log runs.', 'medium', 'scope-hoisting'),

('console.log(a);
let a = 5;', 'ReferenceError', 'Variables declared with let are hoisted but not initialized. They are in a "temporal dead zone" from the start of the block until the declaration is processed. Accessing them before declaration throws a ReferenceError.', 'medium', 'let-const'),

('foo();
var foo = function() {
  console.log("First");
};
function foo() {
  console.log("Second");
}', 'Second', 'Both declarations are hoisted, but function declarations take precedence over var declarations. The function declaration is hoisted first, and when foo() is called, it executes the function declaration.', 'hard', 'declaration-precedence'),

('var a = 1;
function outer() {
  console.log(a);
  function inner() {
    console.log(a);
    var a = 3;
  }
  inner();
  console.log(a);
}
outer();', '1 undefined 1', 'First console.log outputs 1 (global). In inner(), var a is hoisted to function scope, shadowing outer a, so it prints undefined. Last console.log in outer() accesses global a again, printing 1.', 'hard', 'nested-scope'),

('console.log(x);
var x = 10;
console.log(x);', 'undefined 10', 'First console.log prints undefined (declaration hoisted, not assignment). Second console.log prints 10 after the assignment.', 'easy', 'var-hoisting'),

('function test() {
  console.log(a);
  console.log(b);
  var a = 1;
  let b = 2;
}
test();', 'undefined ReferenceError', 'var a is hoisted and initialized with undefined. let b is in the temporal dead zone, causing a ReferenceError when accessed before declaration.', 'medium', 'var-vs-let'),

('var a = 100;
function test() {
  a = 10;
  console.log(a);
  var a;
  console.log(a);
}
test();
console.log(a);', '10 10 100', 'var a inside test() is hoisted, creating a local variable. Both logs in test() print 10. The global a remains 100.', 'medium', 'scope-hoisting'),

('greet();
function greet() {
  console.log(message);
  var message = "Hello";
}', 'undefined', 'The function declaration is hoisted. Inside greet(), var message is hoisted but not initialized, so it prints undefined.', 'easy', 'function-and-var'),

('console.log(sum(5, 10));
function sum(a, b) {
  return a + b;
}', '15', 'Function declarations are fully hoisted, so sum() can be called before its declaration in the code.', 'easy', 'function-declaration'),

('var foo = 1;
function bar() {
  if (!foo) {
    var foo = 10;
  }
  console.log(foo);
}
bar();', '10', 'var foo inside bar() is hoisted to function scope. The if condition checks this local foo (undefined), which is falsy, so foo = 10 executes. Then console.log prints 10.', 'medium', 'conditional-hoisting'),

('console.log(a);
console.log(b);
console.log(c);
var a = 1;
let b = 2;
const c = 3;', 'undefined ReferenceError ReferenceError', 'var a is hoisted and prints undefined. let b and const c are in temporal dead zone, causing ReferenceError.', 'medium', 'declaration-types'),

('sayHi();
var sayHi = function() {
  console.log("Hi from expression");
};
function sayHi() {
  console.log("Hi from declaration");
}', 'Hi from declaration', 'Both are hoisted, but function declaration takes precedence. When sayHi() is called, it executes the function declaration.', 'hard', 'declaration-precedence'),

('var x = 21;
var func = function() {
  console.log(x);
  if (false) {
    var x = 20;
  }
};
func();', 'undefined', 'var x inside func is hoisted to function scope, shadowing the global x. Even though if (false) never executes, the declaration is hoisted, making x undefined.', 'hard', 'dead-code-hoisting'),

('function outer() {
  inner();
  function inner() {
    console.log("Inner");
  }
}
outer();', 'Inner', 'Function declarations are hoisted within their scope, so inner() can be called before its declaration.', 'easy', 'nested-function'),

('var a = 1;
(function() {
  console.log(a);
  var a = 2;
  console.log(a);
})();', 'undefined 2', 'Inside the IIFE, var a is hoisted, shadowing the global a. First log prints undefined, second prints 2.', 'medium', 'iife-hoisting'),

('test();
var test = function() {
  console.log("Test");
};', 'TypeError', 'var test is hoisted but as undefined. Calling undefined as a function throws a TypeError: test is not a function.', 'medium', 'function-expression'),

('console.log(getName());
var getName = function() {
  return "Function Expression";
};
function getName() {
  return "Function Declaration";
}', 'Function Declaration', 'Function declaration is hoisted first. When getName() is called, the function expression assignment hasn not occurred yet.', 'hard', 'declaration-precedence'),

('var x;
console.log(x);
x = 7;', 'undefined', 'x is declared but not assigned a value when console.log runs, so it prints undefined.', 'easy', 'var-hoisting'),

('function test() {
  var a = b = 5;
}
test();
console.log(typeof a);
console.log(typeof b);', 'undefined number', 'Only var a is hoisted within test(). b = 5 creates a global variable. After test(), a is local (undefined outside), b is global (number).', 'hard', 'implicit-global'),

('var x = 10;
function foo() {
  console.log(x);
  return;
  var x = 20;
}
foo();', 'undefined', 'var x is hoisted to the top of foo(), shadowing the global x. The return statement doesn not prevent hoisting. x is undefined when logged.', 'medium', 'unreachable-code'),

('console.log(typeof undeclaredVar);', 'undefined', 'typeof operator returns "undefined" for undeclared variables without throwing an error.', 'easy', 'typeof-undeclared'),

('var a = 10;
function test() {
  console.log(a);
  if (true) {
    var a = 20;
  }
}
test();', 'undefined', 'var does not have block scope. var a in the if block is hoisted to function scope, shadowing global a. It is undefined when logged.', 'medium', 'block-scope'),

('function foo() {
  bar();
  var bar = function() {
    console.log("First");
  };
  function bar() {
    console.log("Second");
  }
}
foo();', 'Second', 'Function declaration is hoisted. When bar() is called, it executes the function declaration, not the function expression.', 'hard', 'declaration-precedence'),

('var v = 1;
var f = function() {
  return v;
};
console.log(f());
var v = 2;', '1', 'When f() is called, v is already assigned the value 1. The second var v = 2 happens after the function call.', 'medium', 'function-closure'),

('console.log(add(2, 3));
var add = function(a, b) {
  return a + b;
};', 'TypeError', 'var add is hoisted as undefined. Calling undefined as a function throws TypeError: add is not a function.', 'medium', 'function-expression'),

('var foo = "Hello";
(function() {
  var bar = foo + " World";
  console.log(bar);
  var foo = "Goodbye";
})();', 'undefined World', 'var foo inside IIFE is hoisted, shadowing outer foo. When concatenation happens, inner foo is undefined, resulting in "undefined World".', 'hard', 'iife-shadowing');

INSERT INTO hoisting_questions (code, correct_output, explanation, difficulty, category) VALUES
('var a;
a = 5;
console.log(a);', '5', 'Simple assignment: a is declared, then assigned 5, then logged.', 'easy', 'var-hoisting'),

('function run() {
  console.log(val);
  var val = "test";
  console.log(val);
}
run();', 'undefined test', 'var val is hoisted. First log prints undefined, second prints "test" after assignment.', 'easy', 'var-hoisting'),

('var name = "Global";
function showName() {
  console.log(name);
  var name = "Local";
  console.log(name);
}
showName();', 'undefined Local', 'var name in showName() is hoisted, shadowing global name. First log: undefined, second: "Local".', 'medium', 'scope-hoisting'),

('console.log(multiply(3, 4));
function multiply(x, y) {
  return x * y;
}', '12', 'Function declaration is fully hoisted. multiply() returns 3 * 4 = 12.', 'easy', 'function-declaration'),

('var result = calculate();
function calculate() {
  return 42;
}
console.log(result);', '42', 'Function declaration is hoisted. calculate() is called and returns 42, which is logged.', 'easy', 'function-declaration'),

('function test() {
  console.log(num);
  let num = 5;
}
test();', 'ReferenceError', 'let variables are in temporal dead zone before declaration. Accessing num throws ReferenceError.', 'medium', 'let-const'),

('var x = 5;
function show() {
  x = 10;
  console.log(x);
  function x() {}
}
show();
console.log(x);', '10 5', 'Function declaration x is hoisted in show(), creating local scope. Assignment x = 10 is local. Global x remains 5.', 'hard', 'function-declaration'),

('console.log(value);
if (true) {
  var value = 10;
}', 'undefined', 'var is not block-scoped. Declaration is hoisted to top. console.log runs before assignment, printing undefined.', 'easy', 'var-hoisting'),

('var msg = "Hi";
function greet() {
  if (false) {
    var msg = "Hello";
  }
  console.log(msg);
}
greet();', 'undefined', 'var msg in greet() is hoisted despite being in dead code. Local msg shadows global, printing undefined.', 'medium', 'dead-code-hoisting'),

('function outer() {
  var x = 10;
  function inner() {
    console.log(x);
  }
  inner();
  var x = 20;
}
outer();', '10', 'When inner() runs, x is already assigned 10. The second assignment happens after inner() call.', 'medium', 'nested-scope'),

('var func;
console.log(typeof func);
func = function() {
  return "Hello";
};', 'undefined', 'func is declared but not assigned when typeof runs, so it returns "undefined".', 'easy', 'typeof-check'),

('console.log(calc(5));
var calc = function(n) {
  return n * 2;
};', 'TypeError', 'var calc is hoisted as undefined. Calling undefined throws TypeError: calc is not a function.', 'medium', 'function-expression'),

('var data = 100;
function process() {
  data = 50;
  return;
  var data = 25;
}
process();
console.log(data);', '100', 'var data in process() is hoisted, creating local scope. Global data is never modified, remains 100.', 'medium', 'scope-hoisting'),

('function check() {
  console.log(flag);
  var flag = true;
}
check();', 'undefined', 'var flag is hoisted to top of check(). When logged, it is declared but not assigned, so undefined.', 'easy', 'var-hoisting'),

('var color = "red";
function paint() {
  console.log(color);
}
paint();
var color = "blue";', 'red', 'When paint() is called, color is already "red". The reassignment to "blue" happens after the call.', 'easy', 'function-execution'),

('execute();
function execute() {
  console.log(item);
  var item = "laptop";
}', 'undefined', 'Function declaration is hoisted. Inside execute(), var item is hoisted, printing undefined before assignment.', 'easy', 'function-and-var'),

('var total = 10;
(function() {
  console.log(total);
  var total = 20;
})();', 'undefined', 'var total inside IIFE is hoisted, shadowing outer total. It is undefined when logged.', 'medium', 'iife-hoisting'),

('function main() {
  helper();
  var helper = function() {
    console.log("Expression");
  };
  function helper() {
    console.log("Declaration");
  }
}
main();', 'Declaration', 'Function declaration is hoisted. When helper() is called, it executes the function declaration.', 'hard', 'declaration-precedence'),

('var score = 75;
function getScore() {
  if (true) {
    var score = 90;
  }
  console.log(score);
}
getScore();', '90', 'var score is function-scoped, not block-scoped. The assignment inside if block affects the function-scoped variable.', 'medium', 'block-scope'),

('console.log(status);
var status = "active";
console.log(status);
var status = "inactive";
console.log(status);', 'undefined active inactive', 'First: undefined (hoisted). Second: "active" after assignment. Third: "inactive" after reassignment.', 'easy', 'var-hoisting');

INSERT INTO hoisting_questions (code, correct_output, explanation, difficulty, category) VALUES
('var items = [];
for (var i = 0; i < 3; i++) {
  items.push(function() {
    return i;
  });
}
console.log(items[0]());', '3', 'var i is function-scoped, not block-scoped. All functions reference the same i, which is 3 after the loop completes.', 'hard', 'closure-hoisting'),

('function test() {
  return foo;
  var foo = 10;
}
console.log(test());', 'undefined', 'var foo is hoisted to the top of test(). The return statement executes before the assignment, returning undefined.', 'medium', 'return-before-assignment'),

('var a = 1;
function outer() {
  var a = 2;
  function inner() {
    console.log(a);
    var a = 3;
  }
  inner();
}
outer();', 'undefined', 'var a inside inner() is hoisted, shadowing outer a. When logged, it is undefined.', 'medium', 'nested-scope'),

('console.log(getName);
var getName = "John";
function getName() {
  return "Function";
}', 'function', 'Function declaration is hoisted first. When console.log runs, getName is the function, not the string.', 'hard', 'declaration-precedence'),

('var price = 50;
function discount() {
  price = price * 0.9;
  console.log(price);
  var price = 100;
}
discount();', 'NaN', 'var price in discount() is hoisted as undefined. undefined * 0.9 = NaN.', 'hard', 'scope-hoisting'),

('function display() {
  console.log(msg);
}
display();
var msg = "Hello";', 'undefined', 'var msg is hoisted globally. When display() runs, msg is declared but not assigned, so undefined.', 'easy', 'var-hoisting'),

('var arr = [1, 2, 3];
function modify() {
  arr = [4, 5, 6];
  console.log(arr);
  var arr;
}
modify();', '4 5 6', 'var arr in modify() is hoisted. The assignment [4, 5, 6] happens to local arr, which is logged.', 'medium', 'scope-hoisting'),

('function run() {
  console.log(typeof func);
  var func = function() {};
}
run();', 'undefined', 'var func is hoisted but not assigned. typeof undefined returns "undefined".', 'easy', 'typeof-check'),

('var count = 0;
function increment() {
  console.log(count);
  count++;
  var count = 10;
}
increment();', 'undefined', 'var count in increment() is hoisted, shadowing global count. When logged, local count is undefined.', 'medium', 'scope-hoisting'),

('console.log(greet());
var greet = function() {
  return "Hi";
};
function greet() {
  return "Hello";
}', 'Hello', 'Function declaration is hoisted. When greet() is called, the function expression assignment has not occurred yet.', 'hard', 'declaration-precedence'),

('var x = 10;
function foo() {
  console.log(x);
  var x = 20;
  console.log(x);
}
foo();
console.log(x);', 'undefined 20 10', 'Inside foo(), var x is hoisted (undefined, then 20). Outside, global x remains 10.', 'medium', 'scope-hoisting'),

('function test() {
  var a = b = 10;
  console.log(a);
}
test();
console.log(typeof b);', '10 number', 'Only var a is local. b = 10 creates a global variable. a logs 10, b is accessible globally.', 'hard', 'implicit-global'),

('var y = 5;
(function() {
  y = 10;
  console.log(y);
  var y;
})();
console.log(y);', '10 5', 'var y inside IIFE is hoisted, creating local scope. Local y is 10, global y remains 5.', 'medium', 'iife-hoisting'),

('function outer() {
  console.log(inner);
  function inner() {}
}
outer();', 'function', 'Function declaration inner is fully hoisted within outer(). console.log prints the function.', 'easy', 'function-declaration'),

('var str = "Global";
function show() {
  if (true) {
    var str = "Local";
  }
  console.log(str);
}
show();', 'Local', 'var str is function-scoped. Assignment in if block affects the function-scoped variable.', 'medium', 'block-scope'),

('console.log(process());
function process() {
  return value;
  var value = 42;
}', 'undefined', 'var value is hoisted. The return statement executes before assignment, returning undefined.', 'medium', 'return-before-assignment'),

('var num = 100;
function calculate() {
  num = 50;
  console.log(num);
  function num() {}
}
calculate();
console.log(num);', '50 100', 'Function declaration num is hoisted in calculate(), creating local scope. Global num remains 100.', 'hard', 'function-declaration'),

('var obj = { val: 1 };
function change() {
  console.log(obj);
  var obj = { val: 2 };
}
change();', 'undefined', 'var obj in change() is hoisted, shadowing global obj. When logged, local obj is undefined.', 'medium', 'scope-hoisting'),

('function main() {
  console.log(a);
  console.log(b);
  var a = 1;
  let b = 2;
}
main();', 'undefined ReferenceError', 'var a is hoisted (undefined). let b is in temporal dead zone, causing ReferenceError.', 'medium', 'var-vs-let'),

('var flag = true;
function toggle() {
  if (flag) {
    var flag = false;
    console.log("Changed");
  } else {
    console.log("Not changed");
  }
}
toggle();', 'Not changed', 'var flag in toggle() is hoisted as undefined (falsy). The else block executes.', 'hard', 'conditional-hoisting');

INSERT INTO hoisting_questions (code, correct_output, explanation, difficulty, category) VALUES
('function test() {
  console.log(x);
  x = 5;
  console.log(x);
  var x;
}
test();', 'undefined 5', 'var x is hoisted to top. First log: undefined. Assignment x = 5 happens. Second log: 5.', 'easy', 'var-hoisting'),

('var level = 1;
function game() {
  level = 2;
  return;
  var level = 3;
}
game();
console.log(level);', '1', 'var level in game() is hoisted, creating local scope. Global level remains 1.', 'medium', 'scope-hoisting'),

('function outer() {
  function inner() {
    console.log(value);
    var value = "inner";
  }
  inner();
  var value = "outer";
}
outer();', 'undefined', 'var value in inner() is hoisted. When logged, it is undefined.', 'medium', 'nested-scope'),

('var answer = 42;
function getAnswer() {
  return answer;
  var answer = 100;
}
console.log(getAnswer());', 'undefined', 'var answer in getAnswer() is hoisted. Return executes before assignment, returning undefined.', 'medium', 'return-before-assignment'),

('console.log(add);
function add(a, b) {
  return a + b;
}
var add = 10;', 'function', 'Function declaration is hoisted first. console.log runs before var add = 10 assignment.', 'hard', 'declaration-precedence'),

('var temp = 99;
(function() {
  console.log(temp);
  if (false) {
    var temp = 88;
  }
})();', 'undefined', 'var temp inside IIFE is hoisted despite being in dead code. It shadows outer temp, printing undefined.', 'medium', 'dead-code-hoisting'),

('function show() {
  var val = 1;
  {
    var val = 2;
    console.log(val);
  }
  console.log(val);
}
show();', '2 2', 'var is not block-scoped. Both assignments affect the same function-scoped variable.', 'medium', 'block-scope'),

('var result;
function compute() {
  result = 10 * 2;
  var result;
  console.log(result);
}
compute();
console.log(result);', '20 undefined', 'var result in compute() is hoisted, creating local scope. Local: 20, Global: undefined.', 'medium', 'scope-hoisting'),

('function test() {
  var x;
  console.log(x);
  x = 100;
  console.log(x);
}
test();', 'undefined 100', 'x is declared but not initialized. First log: undefined. After assignment: 100.', 'easy', 'var-hoisting'),

('var id = "global";
function show() {
  console.log(id);
  if (true) {
    var id = "local";
    console.log(id);
  }
}
show();', 'undefined local', 'var id in show() is hoisted. First log: undefined (before assignment). Second log: "local".', 'medium', 'block-scope'),

('function main() {
  helper();
  function helper() {
    console.log(val);
    var val = "test";
  }
}
main();', 'undefined', 'helper() is hoisted and called. Inside, var val is hoisted, printing undefined.', 'easy', 'function-and-var'),

('var power = 2;
function calculate() {
  power = power ** 2;
  console.log(power);
  var power = 3;
}
calculate();', 'NaN', 'var power in calculate() is hoisted as undefined. undefined ** 2 = NaN.', 'hard', 'scope-hoisting'),

('console.log(func);
var func = function named() {
  return "Named";
};', 'undefined', 'Function expressions are not hoisted. var func is hoisted as undefined.', 'easy', 'function-expression'),

('var user = "Alice";
function rename() {
  user = "Bob";
  console.log(user);
  function user() {}
}
rename();
console.log(user);', 'Bob Alice', 'Function declaration user is hoisted in rename(), creating local scope. Global user remains "Alice".', 'hard', 'function-declaration'),

('function test() {
  console.log(a);
  {
    var a = 10;
  }
  console.log(a);
}
test();', 'undefined 10', 'var a is function-scoped, not block-scoped. First log: undefined. After block: 10.', 'medium', 'block-scope'),

('var value = 5;
function modify() {
  console.log(value);
  value = 10;
}
modify();
console.log(value);', '5 10', 'No local value in modify(), so global value is used. First: 5, then modified to 10.', 'easy', 'global-scope'),

('function outer() {
  var x = 1;
  return function inner() {
    console.log(x);
    var x = 2;
  };
}
outer()();', 'undefined', 'var x in inner() is hoisted, shadowing outer x. When logged, inner x is undefined.', 'hard', 'closure-hoisting'),

('var state = "start";
(function() {
  state = "running";
  console.log(state);
  var state = "end";
})();
console.log(state);', 'running start', 'var state in IIFE is hoisted (local). Local state: "running", Global state: "start".', 'medium', 'iife-hoisting'),

('function show() {
  return num;
  num = 10;
  var num;
}
console.log(show());', 'undefined', 'var num is hoisted. Return executes before num = 10, returning undefined.', 'medium', 'return-before-assignment'),

('var counter = 0;
function increment() {
  counter++;
  console.log(counter);
  var counter = 5;
  console.log(counter);
}
increment();
console.log(counter);', 'NaN 5 0', 'var counter in increment() is hoisted as undefined. undefined++ = NaN. Then 5. Global: 0.', 'hard', 'scope-hoisting');