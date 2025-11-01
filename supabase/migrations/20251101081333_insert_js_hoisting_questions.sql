/*
  # Insert Pure JavaScript Hoisting Questions
  
  This migration inserts 100+ pure JavaScript code snippets focused on hoisting concepts.
  No HTML, CSS, or framework-specific code - only core JavaScript.
*/

INSERT INTO hoisting_questions (code, correct_output, explanation, difficulty, category) VALUES
('console.log(a);
var a = 5;', 'undefined', 'The variable declaration is hoisted to the top, but the assignment stays in place. So a is declared but undefined when logged.', 'easy', 'var-hoisting'),

('function test() {
  console.log(x);
  var x = 10;
}
test();', 'undefined', 'var x is hoisted to the top of the function. It is declared but not assigned, so it logs undefined.', 'easy', 'var-hoisting'),

('console.log(foo());
function foo() {
  return 42;
}', '42', 'Function declarations are fully hoisted. The entire function definition is available before the call.', 'easy', 'function-declaration'),

('console.log(bar);
var bar = function() {
  return "hello";
};', 'undefined', 'Function expressions are not hoisted. Only the var declaration is hoisted as undefined.', 'easy', 'function-expression'),

('a = 5;
console.log(a);
var a;', '5', 'The var declaration is hoisted. Assignment happens before the log, so 5 is printed.', 'easy', 'var-hoisting'),

('console.log(b);
let b = 10;', 'ReferenceError', 'let variables are hoisted but in the temporal dead zone. Accessing them throws a ReferenceError.', 'medium', 'let-const'),

('console.log(c);
const c = 20;', 'ReferenceError', 'const variables are hoisted but in the temporal dead zone like let. Accessing before declaration throws ReferenceError.', 'medium', 'let-const'),

('var x = 1;
function outer() {
  console.log(x);
  var x = 2;
}
outer();', 'undefined', 'var x inside outer is hoisted, creating a local scope. It shadows the global x and is undefined when logged.', 'medium', 'scope-hoisting'),

('sayHello();
function sayHello() {
  console.log("Hello");
}', 'Hello', 'Function declarations are fully hoisted and can be called before their definition.', 'easy', 'function-declaration'),

('console.log(typeof undeclared);', 'undefined', 'typeof on undeclared variables returns "undefined" without throwing an error.', 'easy', 'typeof-check'),

('test();
var test = function() {
  console.log("test");
};', 'TypeError', 'var test is hoisted as undefined. Calling undefined as a function throws TypeError.', 'medium', 'function-expression'),

('var a = 10;
function foo() {
  a = 5;
  console.log(a);
  var a;
}
foo();
console.log(a);', '5 10', 'Inside foo, var a is hoisted creating local scope. The assignment a = 5 is local. Outside, global a remains 10.', 'medium', 'scope-hoisting'),

('console.log(x);
var x = 10;
console.log(x);', 'undefined 10', 'First log: undefined (hoisted but not assigned). Second log: 10 (after assignment).', 'easy', 'var-hoisting'),

('function test() {
  return y;
  var y = 20;
}
console.log(test());', 'undefined', 'var y is hoisted. Return happens before the assignment, so undefined is returned.', 'medium', 'return-before-assignment'),

('var func;
console.log(typeof func);
func = function() {};', 'undefined', 'func is declared but not assigned when typeof runs, so it returns "undefined".', 'easy', 'typeof-check'),

('var x = 1;
(function() {
  console.log(x);
  var x = 2;
})();', 'undefined', 'Inside the IIFE, var x is hoisted creating local scope. It shadows the global x and is undefined.', 'medium', 'iife-hoisting'),

('function foo() {
  console.log(bar);
  function bar() {}
}
foo();', 'function', 'Function declarations inside functions are also fully hoisted. bar is a function when logged.', 'easy', 'nested-function'),

('var n = 5;
if (true) {
  var n = 10;
}
console.log(n);', '10', 'var has function scope, not block scope. The assignment inside the if block affects the outer n.', 'medium', 'block-scope'),

('console.log(getName());
var getName = function() {
  return "John";
};
function getName() {
  return "Jane";
}', 'Jane', 'Function declaration is hoisted. When getName() is called, the function expression assignment has not occurred yet.', 'hard', 'declaration-precedence'),

('var data = 100;
function process() {
  data = 50;
  return;
  var data = 25;
}
process();
console.log(data);', '100', 'var data inside process creates local scope despite being after a return. Global data remains 100.', 'medium', 'scope-hoisting'),

('console.log(x);
x = 10;', 'ReferenceError', 'x is not declared, so accessing it throws a ReferenceError (in strict mode behavior expected).', 'easy', 'undeclared-variable'),

('function outer() {
  console.log(a);
  var a = 1;
  function inner() {
    console.log(a);
    var a = 2;
  }
  inner();
}
outer();', 'undefined undefined', 'In outer: a is hoisted, logs undefined. In inner: a is hoisted locally, also logs undefined.', 'hard', 'nested-scope'),

('var a = 1;
function test() {
  var a = 2;
  console.log(a);
}
test();
console.log(a);', '2 1', 'Local a shadows global a inside test. Inside: 2, Outside: 1.', 'medium', 'scope-hoisting'),

('greet();
function greet() {
  console.log(message);
  var message = "Hi";
}', 'undefined', 'Function declaration is hoisted. Inside, var message is hoisted but not assigned, so undefined.', 'easy', 'function-and-var'),

('var x = 10;
function foo() {
  if (false) {
    var x = 20;
  }
  console.log(x);
}
foo();', 'undefined', 'var x in the dead code is still hoisted to function scope. It shadows global x and is undefined.', 'medium', 'dead-code-hoisting'),

('console.log(add(2, 3));
function add(a, b) {
  return a + b;
}', '5', 'Function declarations are fully hoisted. add(2, 3) returns 5.', 'easy', 'function-declaration'),

('function foo() {
  var a = b = 5;
}
foo();
console.log(typeof a);
console.log(typeof b);', 'undefined number', 'Only var a is local. b = 5 creates a global variable. a is undefined outside, b is a number.', 'hard', 'implicit-global'),

('console.log(typeof x);
var x;', 'undefined', 'var x is hoisted without assignment. typeof returns "undefined" for uninitialized variables.', 'easy', 'typeof-check'),

('function test() {
  console.log(x);
  var x = 5;
  console.log(x);
}
test();', 'undefined 5', 'x is hoisted at function scope. First log: undefined. Second log: 5 (after assignment).', 'easy', 'var-hoisting'),

('var foo = 1;
function bar() {
  if (!foo) {
    var foo = 10;
  }
  console.log(foo);
}
bar();', '10', 'var foo inside bar is hoisted locally. foo is initially undefined (falsy), so the assignment happens. Logs 10.', 'medium', 'conditional-hoisting'),

('execute();
function execute() {
  console.log(val);
  var val = "ready";
}', 'undefined', 'Function declaration is hoisted. Inside, var val is hoisted but logs undefined.', 'easy', 'function-and-var'),

('var num = 5;
(function() {
  console.log(num);
  var num = 10;
})();', 'undefined', 'Inside IIFE, var num is hoisted locally, shadowing outer num. Logs undefined.', 'medium', 'iife-hoisting'),

('var result;
function compute() {
  result = 10 * 2;
  var result;
  console.log(result);
}
compute();
console.log(result);', '20 undefined', 'result in compute is local. Local: 20. Global result outside was never assigned.', 'medium', 'scope-hoisting'),

('console.log(multiply(3, 4));
function multiply(x, y) {
  return x * y;
}', '12', 'Function declarations are fully hoisted. multiply(3, 4) returns 12.', 'easy', 'function-declaration'),

('var x = 100;
function test() {
  x = 50;
  console.log(x);
  var x;
}
test();
console.log(x);', '50 100', 'var x in test creates local scope. Assignment x = 50 is local. Global x remains 100.', 'medium', 'scope-hoisting'),

('console.log(a);
console.log(b);
var a = 1;
let b = 2;', 'undefined ReferenceError', 'var a is hoisted as undefined. let b is in temporal dead zone, throws ReferenceError.', 'medium', 'var-vs-let'),

('hello();
var hello = function() {
  console.log("Hello");
};', 'TypeError', 'var hello is hoisted as undefined. Calling undefined throws TypeError.', 'medium', 'function-expression'),

('function outer() {
  console.log(a);
}
function inner() {
  var a = 5;
}
inner();
outer();', 'ReferenceError', 'outer has no access to a. a is only declared in inner function scope. Logs ReferenceError.', 'medium', 'scope-hoisting'),

('var x = 1;
if (true) {
  console.log(x);
  var x = 2;
  console.log(x);
}
console.log(x);', 'undefined 2 2', 'var has function scope. x is hoisted to function scope. First: undefined, Second: 2, Third: 2.', 'medium', 'block-scope'),

('function test() {
  return;
  var x = 10;
}
console.log(typeof test());', 'undefined', 'test() returns undefined before var x = 10. typeof undefined returns "undefined".', 'easy', 'return-before-assignment'),

('var price = 50;
function discount() {
  price = price * 0.9;
  console.log(price);
  var price = 100;
}
discount();', 'NaN', 'var price in function is hoisted as undefined. undefined * 0.9 = NaN.', 'hard', 'scope-hoisting'),

('console.log(getName);
var getName = "John";
function getName() {
  return "Function";
}', 'function', 'Function declaration is hoisted first. getName is the function, not the string.', 'hard', 'declaration-precedence'),

('var count = 0;
function increment() {
  console.log(count);
  count++;
  var count = 10;
}
increment();', 'undefined', 'var count inside increment is hoisted locally. It shadows global count and logs undefined.', 'medium', 'scope-hoisting'),

('display();
function display() {
  console.log("Displayed");
}', 'Displayed', 'Function declarations are fully hoisted and can be called before definition.', 'easy', 'function-declaration'),

('var x;
console.log(x);
x = 7;', 'undefined', 'x is declared but not assigned when logged, so undefined.', 'easy', 'var-hoisting'),

('function test() {
  var a = b = 10;
  console.log(a);
}
test();
console.log(typeof b);', '10 number', 'Only var a is local. b = 10 creates a global variable. a is 10 local, b is a global number.', 'hard', 'implicit-global'),

('var value = 5;
function modify() {
  console.log(value);
  value = 10;
}
modify();
console.log(value);', '5 10', 'No local value, so global value is used. Logs 5, then modified to 10.', 'easy', 'global-scope'),

('(function() {
  console.log(x);
  var x = 20;
})();', 'undefined', 'var x inside IIFE is hoisted locally. Logs undefined.', 'easy', 'iife-hoisting'),

('function outer() {
  function inner() {
    console.log(inner);
  }
  inner();
}
outer();', 'function', 'Function declarations are hoisted within their scope. inner is a function.', 'easy', 'nested-function'),

('var flag = true;
function toggle() {
  if (flag) {
    var flag = false;
    console.log("Changed");
  } else {
    console.log("Not changed");
  }
}
toggle();', 'Not changed', 'var flag inside toggle is hoisted as undefined (falsy). else block executes.', 'hard', 'conditional-hoisting'),

('console.log(greet());
function greet() {
  return "Hello";
}', 'Hello', 'Function declarations are fully hoisted. greet() returns "Hello".', 'easy', 'function-declaration'),

('var msg = "Hi";
function show() {
  if (false) {
    var msg = "Bye";
  }
  console.log(msg);
}
show();', 'undefined', 'var msg inside show is hoisted despite dead code. It shadows global msg and logs undefined.', 'medium', 'dead-code-hoisting'),

('var x = 1;
function foo() {
  console.log(x);
  var x = 2;
}
foo();
console.log(x);', 'undefined 1', 'Inside foo: var x hoisted, logs undefined. Outside: global x is 1.', 'easy', 'scope-hoisting'),

('var obj = { val: 1 };
function change() {
  console.log(obj);
  var obj = { val: 2 };
}
change();', 'undefined', 'var obj inside change is hoisted locally, shadowing global. Logs undefined.', 'medium', 'scope-hoisting'),

('function outer() {
  var x = 10;
  function inner() {
    console.log(x);
  }
  inner();
}
outer();', '10', 'inner accesses x from outer scope through closure. x is 10.', 'easy', 'closure'),

('console.log(typeof func);
var func = function() {};', 'undefined', 'var func is hoisted but not assigned. typeof returns "undefined".', 'easy', 'typeof-check'),

('var a = 10;
function test() {
  a = 20;
}
test();
console.log(a);', '20', 'No var a in test, so it modifies global a. Global a becomes 20.', 'easy', 'global-scope'),

('helper();
var helper = function() {
  console.log("Helper");
};
function helper() {
  console.log("Function");
}', 'Function', 'Function declaration is hoisted. When helper() is called, it executes the function.', 'hard', 'declaration-precedence'),

('var i = 0;
function test() {
  var i = 5;
  console.log(i);
}
test();
console.log(i);', '5 0', 'Inside test: local i is 5. Outside: global i is 0.', 'easy', 'scope-hoisting'),

('console.log(check());
function check() {
  return true;
}', 'true', 'Function declarations are fully hoisted. check() returns true.', 'easy', 'function-declaration'),

('var str = "Global";
function rename() {
  str = "Local";
  console.log(str);
  function str() {}
}
rename();
console.log(str);', 'Local Global', 'Function declaration str is hoisted in rename creating local scope. Local: Local, Global: Global.', 'hard', 'function-declaration'),

('function test() {
  return value;
  var value = 42;
}
console.log(test());', 'undefined', 'var value is hoisted. Return happens before assignment, returns undefined.', 'medium', 'return-before-assignment'),

('(function() {
  console.log(a);
  var a = 5;
})();', 'undefined', 'var a is hoisted in IIFE scope. Logs undefined.', 'easy', 'iife-hoisting'),

('var x = 1;
function outer() {
  var x = 2;
  function inner() {
    console.log(x);
  }
  inner();
}
outer();', '2', 'inner accesses x from outer through closure. x in outer is 2.', 'medium', 'closure'),

('console.log(add);
var add = 10;
function add(a, b) {
  return a + b;
}', 'function', 'Function declaration is hoisted. add is a function before var assignment.', 'hard', 'declaration-precedence'),

('function show() {
  console.log(val);
}
show();
var val = "test";', 'undefined', 'var val is hoisted globally but not assigned before show() call. Logs undefined.', 'easy', 'var-hoisting'),

('var count = 0;
function increment() {
  count++;
  console.log(count);
  var count = 5;
}
increment();', 'NaN', 'var count inside is hoisted as undefined. undefined++ = NaN.', 'hard', 'scope-hoisting'),

('function outer() {
  console.log(a);
  var a = 1;
  function middle() {
    console.log(a);
    var a = 2;
    function inner() {
      console.log(a);
    }
    inner();
  }
  middle();
}
outer();', 'undefined undefined 2', 'outer: a hoisted, undefined. middle: a hoisted, undefined. inner: accesses a=2 from middle.', 'hard', 'nested-scope'),

('var x = 10;
(function() {
  x = 5;
  console.log(x);
  var x;
})();
console.log(x);', '5 10', 'var x in IIFE creates local scope. Local: 5, Global: 10.', 'medium', 'iife-hoisting'),

('console.log(process());
var process = function() {
  return 42;
};
function process() {
  return 0;
}', '0', 'Function declaration is hoisted. When process() is called, it executes the function.', 'hard', 'declaration-precedence'),

('var level = 1;
function game() {
  level = 2;
  return;
  var level = 3;
}
game();
console.log(level);', '1', 'var level in game creates local scope. Global level remains 1.', 'medium', 'scope-hoisting'),

('function test() {
  console.log(a);
  {
    var a = 10;
  }
  console.log(a);
}
test();', 'undefined 10', 'var a is function-scoped. First: undefined. Second: 10 (after block assignment).', 'medium', 'block-scope'),

('var total = 10;
(function() {
  console.log(total);
  total = 20;
})();
console.log(total);', '10 20', 'No local total, so global is accessed. Inside: 10, modified to 20. Outside: 20.', 'easy', 'global-scope'),

('function outer() {
  return function inner() {
    console.log(x);
    var x = 2;
  };
}
outer()();', 'undefined', 'var x in inner is hoisted locally. Logs undefined.', 'hard', 'closure-hoisting'),

('console.log(a);
var a;
console.log(a);
a = 5;
console.log(a);', 'undefined undefined 5', 'a is hoisted. First: undefined. Second: undefined (no assignment yet). Third: 5.', 'easy', 'var-hoisting'),

('var result;
function compute() {
  result = 42;
  return;
  var result;
}
compute();
console.log(result);', 'undefined', 'var result inside compute creates local scope. Global result is never assigned.', 'medium', 'scope-hoisting'),

('function test() {
  var x;
  console.log(x);
  x = 100;
  console.log(x);
}
test();', 'undefined 100', 'x is declared. First: undefined. Second: 100 (after assignment).', 'easy', 'var-hoisting'),

('var name = "Alice";
function rename() {
  name = "Bob";
  console.log(name);
  function name() {}
}
rename();
console.log(name);', 'Bob Alice', 'Function name is hoisted in rename creating local scope. Local: Bob, Global: Alice.', 'hard', 'function-declaration'),

('console.log(getData());
var getData = function() {
  return "data";
};', 'TypeError', 'var getData is hoisted as undefined. Calling undefined throws TypeError.', 'medium', 'function-expression');

INSERT INTO hoisting_questions (code, correct_output, explanation, difficulty, category) VALUES
('function start() {
  console.log(value);
  var value = 100;
}
start();', 'undefined', 'var value is hoisted in start scope. Logs undefined before assignment.', 'easy', 'var-hoisting'),

('var x = 5;
function test() {
  console.log(x);
  x = 10;
}
test();
console.log(x);', '5 10', 'No local x, so global x is used. Inside: 5, then modified to 10. Outside: 10.', 'easy', 'global-scope'),

('function outer() {
  var x = 1;
  (function inner() {
    console.log(x);
  })();
}
outer();', '1', 'inner accesses x from outer through closure. x is 1.', 'easy', 'closure'),

('console.log(b);
let b = 5;
console.log(b);', 'ReferenceError', 'let b is hoisted but in temporal dead zone. First access throws ReferenceError.', 'medium', 'let-const'),

('var data = 1;
(function() {
  console.log(data);
  data = 2;
  var data = 3;
})();
console.log(data);', 'undefined 1', 'Inside IIFE: data hoisted locally, logs undefined, modified to 2 (local). Outside: global data is 1.', 'hard', 'iife-hoisting'),

('function foo() {
  console.log(x);
  if (true) {
    var x = 5;
  }
}
foo();', 'undefined', 'var x is function-scoped, hoisted to top. Logs undefined despite assignment inside if.', 'medium', 'block-scope'),

('var a = 1;
function foo() {
  a = 2;
  console.log(a);
}
foo();
console.log(a);', '2 2', 'No local a, so global a is accessed and modified. Both log 2.', 'easy', 'global-scope'),

('console.log(typeof x);
var x = 10;', 'undefined', 'var x is hoisted. typeof returns "undefined" for uninitialized variable.', 'easy', 'typeof-check'),

('(function() {
  console.log(x);
  var x = 1;
  console.log(x);
})();', 'undefined 1', 'x is hoisted in IIFE. First: undefined. Second: 1 (after assignment).', 'easy', 'iife-hoisting'),

('var x;
function test() {
  x = 5;
  console.log(x);
  var x;
}
test();', '5', 'var x is hoisted in test, creating local scope. x is assigned 5. Logs 5.', 'medium', 'scope-hoisting'),

('function foo() {
  return bar;
  var bar = 10;
}
console.log(foo());', 'undefined', 'var bar is hoisted. Return happens before assignment, returns undefined.', 'medium', 'return-before-assignment'),

('var x = 1;
if (true) {
  var x = 2;
  console.log(x);
}
console.log(x);', '2 2', 'var x has function scope, not block scope. Both log 2.', 'easy', 'block-scope'),

('function test() {
  console.log(x);
  console.log(y);
  var x = 1;
  var y = 2;
}
test();', 'undefined undefined', 'Both x and y are hoisted. Both log undefined.', 'easy', 'var-hoisting'),

('var foo = 1;
(function() {
  var foo = 2;
  console.log(foo);
})();
console.log(foo);', '2 1', 'Inside IIFE: local foo is 2. Outside: global foo is 1.', 'easy', 'scope-hoisting'),

('function helper() {
  console.log(result);
  var result = "done";
}
helper();', 'undefined', 'var result is hoisted in helper. Logs undefined.', 'easy', 'var-hoisting'),

('var x = 10;
(function() {
  console.log(x);
})();', '10', 'No local x, so global x is accessed. Logs 10.', 'easy', 'closure'),

('function test() {
  var a = 1;
  var a = 2;
  console.log(a);
}
test();', '2', 'a is declared twice but only one variable. Second assignment is 2. Logs 2.', 'easy', 'var-hoisting'),

('console.log(getVal());
var getVal = function() {
  return 100;
};
function getVal() {
  return 200;
}', '200', 'Function declaration is hoisted. When called, it executes the function.', 'hard', 'declaration-precedence'),

('var x = 1;
function outer() {
  console.log(x);
  x = 2;
}
outer();
console.log(x);', '1 2', 'No local x, so global x is accessed. Logs 1, then modified to 2. Outside: 2.', 'easy', 'global-scope'),

('(function() {
  var x;
  console.log(x);
})();', 'undefined', 'var x is declared but not assigned in IIFE. Logs undefined.', 'easy', 'iife-hoisting');
