  

What ?

When ?  
  
Example & Real usecase ?  
  
Relate concepts ?  

  

Function nằm trong một function khác.  
  
Ví dụ:  

```JavaScript
function outerFunction(x) {
  // Inner function defined within the outer function
  function innerFunction(y) {
    return x + y; // innerFunction has access to the 'x' variable from the outer scope
  }

  return innerFunction;
}

const closureExample = outerFunction(10);
console.log(closureExample(5)); // Output: 15
```

  

URL: Link by GPT  
  
  
[https://chat.openai.com/share/d4f98129-e10b-4cc7-a6dc-e520ecaacf61](https://chat.openai.com/share/d4f98129-e10b-4cc7-a6dc-e520ecaacf61)