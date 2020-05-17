# GitHubMarkdown
To store the parser originally developed by K. Osterbye (and to make it independent of RichText and Pillar) and further extended by S. Ducasse.

I am a light parser for github markdown. I'm not fully implementing markdown (far too complex and clumsy). I do not accept lazy definition. I do not accept three different ways to do the same. Except for bulleted list where * and - are accepted. 


My implementation strategy is based on the specification in https://github.github.com/gfm, in particular the parsing strategy in appendix A.

In short, the strategy is that at any point in time, we might have a number of children of the root which are "open". The deepest open in the tree is called "current". All the parents of current are open. 

When a new line is read we do the following:

1. Check if the new line can be consumed by current.
	 - as part of this, a child of current can be made which can consume the new line.
	 for example when consuming ``` the root block node will create, a new code block 
	 that will become current and consume the body of the ``` element then close. 
2. If current cannot consume the new line, we close current, move current to its parent, and repeat 1.
3. The root node can consume anything, for instance by making new nodes for storing the new line.
4. The root node is not closed until input is exhausted.


The spec says:
```
-> document
  -> block_quote
       paragraph
         "Lorem ipsum dolor\nsit amet."
    -> list (type=bullet tight=true bullet_char=-)
         list_item
           paragraph
             "Qui *quodsi iracundia*"
      -> list_item
        -> paragraph
             "aliquando id"
```
Now the implementation for now does not create a paragraph in the list_item element. 

